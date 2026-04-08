package com.waitzero.domain.office.dto;

import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.queue.dto.QueueStatusResponse;

public record OfficeDetailResponse(
        Long id,
        String name,
        String address,
        String detailAddress,
        Double latitude,
        Double longitude,
        String phone,
        String operatingHours,
        String regionCode,
        QueueStatusResponse queueStatus
) {
    public static OfficeDetailResponse from(CivilServiceOffice office, QueueStatusResponse queueStatus) {
        return new OfficeDetailResponse(
                office.getId(),
                office.getName(),
                office.getAddress(),
                office.getDetailAddress(),
                office.getLatitude(),
                office.getLongitude(),
                office.getPhone(),
                office.getOperatingHours(),
                office.getRegionCode(),
                queueStatus
        );
    }
}
