package com.waitzero.infra.publicdata.config;

import com.waitzero.infra.publicdata.entity.SupportedRegion;
import com.waitzero.infra.publicdata.repository.SupportedRegionRepository;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 공공데이터 API 호출이 가능한 지자체 코드 초기 시딩.
 * 정상 응답 확인된 22개 지역을 DB에 적재한다.
 * (이미 존재하면 건너뜀 — 운영 중 enabled 플래그 변경은 유지됨)
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class SupportedRegionSeeder {

    private final SupportedRegionRepository supportedRegionRepository;

    private static final List<RegionSeed> INITIAL_REGIONS = List.of(
            new RegionSeed("1121500000", "서울 광진구"),
            new RegionSeed("2729000000", "대구 달서구"),
            new RegionSeed("2914000000", "광주 서구"),
            new RegionSeed("2915500000", "광주 남구"),
            new RegionSeed("4129000000", "경기 과천시"),
            new RegionSeed("1156000000", "서울 영등포구"),
            new RegionSeed("4161000000", "경기 광주시"),
            new RegionSeed("4141000000", "경기 군포시"),
            new RegionSeed("4159000000", "경기 화성시"),
            new RegionSeed("4413000000", "충남 천안시"),
            new RegionSeed("1165000000", "서울 서초구"),
            new RegionSeed("2723000000", "대구 북구"),
            new RegionSeed("2726000000", "대구 수성구"),
            new RegionSeed("4127000000", "경기 안산시"),
            new RegionSeed("4719000000", "경북 구미시"),
            new RegionSeed("2600000000", "부산광역시"),
            new RegionSeed("2900000000", "광주광역시"),
            new RegionSeed("5000000000", "제주특별자치도"),
            new RegionSeed("1174000000", "서울 강동구"),
            new RegionSeed("2629000000", "부산 남구"),
            new RegionSeed("4111000000", "경기 수원시"),
            new RegionSeed("4113000000", "경기 성남시"),
            new RegionSeed("4115000000", "경기 의정부시"),
            new RegionSeed("4119000000", "경기 부천시")
    );

    @PostConstruct
    @Transactional
    public void seed() {
        int inserted = 0;
        for (RegionSeed region : INITIAL_REGIONS) {
            if (supportedRegionRepository.existsByStdgCd(region.stdgCd())) continue;
            supportedRegionRepository.save(SupportedRegion.builder()
                    .stdgCd(region.stdgCd())
                    .regionName(region.regionName())
                    .enabled(true)
                    .build());
            inserted++;
        }
        if (inserted > 0) {
            log.info("SupportedRegion 시딩 완료: {}건 추가 (전체 {}건)",
                    inserted, INITIAL_REGIONS.size());
        } else {
            log.info("SupportedRegion 시딩 건너뜀 (이미 존재)");
        }
    }

    private record RegionSeed(String stdgCd, String regionName) {
    }
}
