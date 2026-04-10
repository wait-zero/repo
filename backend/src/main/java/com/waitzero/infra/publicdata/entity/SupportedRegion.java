package com.waitzero.infra.publicdata.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * 공공데이터 API가 호출 가능한 지자체(법정동) 코드 화이트리스트.
 * NODATA 에러가 발생하는 코드는 포함하지 않는다.
 */
@Entity
@Table(name = "supported_region")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class SupportedRegion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /** 법정동 코드 (10자리) */
    @Column(name = "stdg_cd", nullable = false, unique = true, length = 10)
    private String stdgCd;

    /** 지역명 (예: 광주 서구) */
    @Column(name = "region_name", nullable = false, length = 100)
    private String regionName;

    /** 사용 가능 여부 — API 응답이 사라진 경우 false로 전환 */
    @Column(nullable = false)
    private boolean enabled;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt;

    @Builder
    private SupportedRegion(String stdgCd, String regionName, boolean enabled) {
        this.stdgCd = stdgCd;
        this.regionName = regionName;
        this.enabled = enabled;
        this.createdAt = LocalDateTime.now();
    }
}
