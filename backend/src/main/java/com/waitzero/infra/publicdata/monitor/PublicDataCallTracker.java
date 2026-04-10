package com.waitzero.infra.publicdata.monitor;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;

/**
 * 공공데이터 API 일일 호출 카운터.
 *
 * 일 5,000회 한도를 모니터링하고 임계치 도달 시 경고 로그를 남긴다.
 * 메모리 상태라 서버 재시작 시 초기화되지만, 캐시 TTL(3분) 내에 그날의 호출이 모두
 * 다시 축적되는 패턴이므로 관측 목적으로는 충분하다.
 */
@Slf4j
@Component
public class PublicDataCallTracker {

    /** 공공데이터포털 일일 트래픽 제한 */
    public static final int DAILY_LIMIT = 5_000;

    /** 경고 임계치 (80%) */
    private static final int WARN_THRESHOLD = (int) (DAILY_LIMIT * 0.8);

    /** 위험 임계치 (95%) */
    private static final int DANGER_THRESHOLD = (int) (DAILY_LIMIT * 0.95);

    /** 날짜별 엔드포인트별 호출 카운터 — LocalDate → Map<endpoint, count> */
    private final Map<LocalDate, Map<String, AtomicInteger>> daily = new ConcurrentHashMap<>();

    /**
     * API 호출 1건을 기록하고, 임계치 초과 시 경고 로그를 남긴다.
     *
     * @param endpoint 호출한 경로 (예: /cso_realtime_v2)
     */
    public void record(String endpoint) {
        LocalDate today = LocalDate.now();
        Map<String, AtomicInteger> counters = daily.computeIfAbsent(today,
                k -> new ConcurrentHashMap<>());
        int count = counters.computeIfAbsent(endpoint, k -> new AtomicInteger(0))
                .incrementAndGet();

        int total = counters.values().stream().mapToInt(AtomicInteger::get).sum();

        if (total == WARN_THRESHOLD) {
            log.warn("[공공데이터 API] 일일 호출 {}건 도달 (80% 임계치) — 한도 {}회",
                    total, DAILY_LIMIT);
        } else if (total == DANGER_THRESHOLD) {
            log.error("[공공데이터 API] 일일 호출 {}건 도달 (95% 위험치) — 한도 {}회. " +
                            "캐시 TTL 연장을 고려하세요.",
                    total, DAILY_LIMIT);
        } else if (total > DAILY_LIMIT) {
            log.error("[공공데이터 API] 일일 한도 초과! 호출={}, 한도={}",
                    total, DAILY_LIMIT);
        }

        log.debug("[공공데이터 API] call endpoint={} total={} today={}",
                endpoint, count, total);
    }

    /**
     * 오늘 날짜 기준 통계 스냅샷을 반환한다.
     */
    public CallStats todayStats() {
        LocalDate today = LocalDate.now();
        Map<String, AtomicInteger> counters = daily.get(today);
        if (counters == null) {
            return new CallStats(today, 0, Map.of(), DAILY_LIMIT);
        }
        Map<String, Integer> byEndpoint = new ConcurrentHashMap<>();
        counters.forEach((k, v) -> byEndpoint.put(k, v.get()));
        int total = byEndpoint.values().stream().mapToInt(Integer::intValue).sum();
        return new CallStats(today, total, byEndpoint, DAILY_LIMIT);
    }

    public record CallStats(
            LocalDate date,
            int totalCalls,
            Map<String, Integer> byEndpoint,
            int dailyLimit
    ) {
        public double usageRate() {
            return dailyLimit == 0 ? 0 : (double) totalCalls / dailyLimit;
        }

        public int remaining() {
            return Math.max(0, dailyLimit - totalCalls);
        }
    }
}
