package com.waitzero.domain.office.entity;

import com.waitzero.global.entity.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "civil_service_office")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class CivilServiceOffice extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, length = 100)
    private String name;

    @Column(nullable = false, length = 255)
    private String address;

    @Column(length = 255)
    private String detailAddress;

    private Double latitude;

    private Double longitude;

    @Column(length = 20)
    private String phone;

    @Column(length = 100)
    private String operatingHours;

    @Column(length = 10)
    private String regionCode;

    @Builder
    public CivilServiceOffice(String name, String address, String detailAddress,
                              Double latitude, Double longitude, String phone,
                              String operatingHours, String regionCode) {
        this.name = name;
        this.address = address;
        this.detailAddress = detailAddress;
        this.latitude = latitude;
        this.longitude = longitude;
        this.phone = phone;
        this.operatingHours = operatingHours;
        this.regionCode = regionCode;
    }
}
