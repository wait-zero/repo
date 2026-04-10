package com.waitzero.global.config;

import com.github.benmanes.caffeine.cache.Caffeine;
import org.springframework.cache.CacheManager;
import org.springframework.cache.caffeine.CaffeineCacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.TimeUnit;

/**
 * Caffeine 기반 캐시 설정.
 *
 * 캐시 종류:
 *  - realtimeByRegion : 지자체(stdgCd)별 실시간 대기현황 Map  (TTL 3분)
 *  - officeList       : 민원실 목록/검색 결과               (TTL 1시간)
 *  - officeDetail     : 민원실 상세                         (TTL 1시간)
 */
@Configuration
public class CacheConfig {

    public static final String REALTIME_BY_REGION = "realtimeByRegion";
    public static final String OFFICE_LIST = "officeList";
    public static final String OFFICE_DETAIL = "officeDetail";

    @Bean
    public CacheManager cacheManager() {
        CaffeineCacheManager manager = new CaffeineCacheManager();

        manager.registerCustomCache(REALTIME_BY_REGION,
                Caffeine.newBuilder()
                        .expireAfterWrite(3, TimeUnit.MINUTES)
                        .maximumSize(50)
                        .recordStats()
                        .build());

        manager.registerCustomCache(OFFICE_LIST,
                Caffeine.newBuilder()
                        .expireAfterWrite(1, TimeUnit.HOURS)
                        .maximumSize(200)
                        .recordStats()
                        .build());

        manager.registerCustomCache(OFFICE_DETAIL,
                Caffeine.newBuilder()
                        .expireAfterWrite(1, TimeUnit.HOURS)
                        .maximumSize(500)
                        .recordStats()
                        .build());

        return manager;
    }
}
