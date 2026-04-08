package com.waitzero.domain.office.dto;

import com.waitzero.domain.office.entity.CivilServiceOffice;

public record OfficeResponse(
        Long id,
        String name,
        String address,
        Double latitude,
        Double longitude,
        String phone,
        String operatingHours
) {
    public static OfficeResponse from(CivilServiceOffice office) {
        return new OfficeResponse(
                office.getId(),
                office.getName(),
                office.getAddress(),
                office.getLatitude(),
                office.getLongitude(),
                office.getPhone(),
                office.getOperatingHours()
        );
    }
}
