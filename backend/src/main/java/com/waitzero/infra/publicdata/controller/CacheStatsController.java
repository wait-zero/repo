package com.waitzero.infra.publicdata.controller;

import com.github.benmanes.caffeine.cache.stats.CacheStats;
import com.waitzero.infra.publicdata.monitor.PublicDataCallTracker;
import com.waitzero.infra.publicdata.service.RealtimeStatusService;
import lombok.RequiredArgsConstructor;
import org.springframework.cache.CacheManager;
import org.springframework.cache.caffeine.CaffeineCache;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * 캐시 운영용 관리 엔드포인트.
 * - GET  /api/admin/cache/stats          → 전체 캐시 통계
 * - DELETE /api/admin/cache/realtime     → 실시간 캐시 전체 무효화
 * - DELETE /api/admin/cache/realtime/{stdgCd} → 특정 지역 캐시 무효화
 */
@RestController
@RequestMapping("/api/admin/cache")
@RequiredArgsConstructor
public class CacheStatsController {

    private final CacheManager cacheManager;
    private final RealtimeStatusService realtimeStatusService;
    private final PublicDataCallTracker callTracker;

    @GetMapping("/stats")
    public Map<String, Object> stats() {
        Map<String, Object> result = new LinkedHashMap<>();
        for (String cacheName : cacheManager.getCacheNames()) {
            var cache = cacheManager.getCache(cacheName);
            if (cache instanceof CaffeineCache caffeineCache) {
                CacheStats s = caffeineCache.getNativeCache().stats();
                Map<String, Object> detail = new HashMap<>();
                detail.put("size", caffeineCache.getNativeCache().estimatedSize());
                detail.put("hitCount", s.hitCount());
                detail.put("missCount", s.missCount());
                detail.put("hitRate", String.format("%.2f%%", s.hitRate() * 100));
                detail.put("loadSuccessCount", s.loadSuccessCount());
                detail.put("loadFailureCount", s.loadFailureCount());
                detail.put("averageLoadPenaltyMs",
                        String.format("%.2f", s.averageLoadPenalty() / 1_000_000.0));
                detail.put("evictionCount", s.evictionCount());
                result.put(cacheName, detail);
            }
        }
        return result;
    }

    @GetMapping("/api-usage")
    public Map<String, Object> apiUsage() {
        var stats = callTracker.todayStats();
        Map<String, Object> result = new LinkedHashMap<>();
        result.put("date", stats.date().toString());
        result.put("totalCalls", stats.totalCalls());
        result.put("dailyLimit", stats.dailyLimit());
        result.put("remaining", stats.remaining());
        result.put("usageRate", String.format("%.1f%%", stats.usageRate() * 100));
        result.put("byEndpoint", stats.byEndpoint());
        return result;
    }

    @DeleteMapping("/realtime")
    public Map<String, String> evictAllRealtime() {
        realtimeStatusService.evictAll();
        return Map.of("message", "실시간 캐시 전체 무효화 완료");
    }

    @DeleteMapping("/realtime/{stdgCd}")
    public Map<String, String> evictRegion(@PathVariable String stdgCd) {
        realtimeStatusService.evictRegion(stdgCd);
        return Map.of("message", "캐시 무효화 완료: " + stdgCd);
    }
}
