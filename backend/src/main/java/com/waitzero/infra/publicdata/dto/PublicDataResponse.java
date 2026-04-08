package com.waitzero.infra.publicdata.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public record PublicDataResponse(
        int currentCount,
        List<PublicDataItem> data,
        int matchCount,
        int page,
        int perPage,
        int totalCount
) {
    @JsonIgnoreProperties(ignoreUnknown = true)
    public record PublicDataItem(
            String name,
            String address,
            String detailAddress,
            Double latitude,
            Double longitude,
            String phone,
            String operatingHours,
            String regionCode
    ) {
    }
}
