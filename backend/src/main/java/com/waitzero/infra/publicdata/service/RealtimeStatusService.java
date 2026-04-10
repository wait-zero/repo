package com.waitzero.infra.publicdata.service;

import com.waitzero.global.config.CacheConfig;
import com.waitzero.infra.publicdata.client.PublicDataClient;
import com.waitzero.infra.publicdata.dto.CsoRealtimeItem;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 실시간 대기현황 조회 서비스 (캐시 + Lazy Refresh).
 *
 * 동작:
 *  1) 최초 요청: 해당 지자체 전체를 API로 한 번에 조회 → csoSn 기준 Map으로 변환 → 캐시 저장
 *  2) 이후 3분 내 요청: 캐시에서 즉시 반환 (API 호출 없음)
 *  3) 3분 경과: 캐시 만료 → 다음 요청에서 재조회
 *
 * 인기 지역만 자동으로 자주 갱신되고, 조회되지 않는 지역은 API 호출이 발생하지 않는다.
 * (5,000 회/일 한도를 효율적으로 사용하기 위한 전략)
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class RealtimeStatusService {

    private final PublicDataClient publicDataClient;

    /**
     * 지자체 단위로 실시간 대기현황을 조회한다.
     * csoSn(민원실 일련번호)을 키로 하는 Map으로 반환 — 개별 민원실 조회 시 O(1) lookup.
     *
     * @param stdgCd 법정동 코드 (예: 2914000000 = 광주 서구)
     * @return csoSn → 업무 리스트 맵 (조회 실패 시 빈 Map)
     */
    @Cacheable(value = CacheConfig.REALTIME_BY_REGION, key = "#stdgCd", sync = true)
    public Map<String, List<CsoRealtimeItem>> getRealtimeByRegion(String stdgCd) {
        log.info("실시간 대기현황 API 호출 [stdgCd={}]", stdgCd);
        List<CsoRealtimeItem> items = publicDataClient.fetchRealtimeByRegion(stdgCd);
        if (items.isEmpty()) return Collections.emptyMap();

        return items.stream()
                .filter(item -> item.csoSn() != null && !item.csoSn().isBlank())
                .collect(Collectors.groupingBy(CsoRealtimeItem::csoSn));
    }

    /**
     * 특정 민원실의 업무 리스트만 캐시에서 꺼내 반환한다.
     */
    public List<CsoRealtimeItem> getByOffice(String stdgCd, String csoSn) {
        Map<String, List<CsoRealtimeItem>> byRegion = getRealtimeByRegion(stdgCd);
        return byRegion.getOrDefault(csoSn, Collections.emptyList());
    }

    /**
     * 특정 지자체의 캐시를 수동으로 무효화한다. (관리 API 용)
     */
    @CacheEvict(value = CacheConfig.REALTIME_BY_REGION, key = "#stdgCd")
    public void evictRegion(String stdgCd) {
        log.info("실시간 캐시 수동 무효화 [stdgCd={}]", stdgCd);
    }

    /**
     * 전체 캐시를 무효화한다.
     */
    @CacheEvict(value = CacheConfig.REALTIME_BY_REGION, allEntries = true)
    public void evictAll() {
        log.info("실시간 캐시 전체 무효화");
    }
}
