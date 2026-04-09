package com.waitzero.infra.publicdata.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public record PublicDataApiResponse<T>(
        Header header,
        Body<T> body
) {
    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Header(String resultCode, String resultMsg) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Body<T>(Items<T> items, String pageNo, String numOfRows, String totalCount) {}

    @JsonIgnoreProperties(ignoreUnknown = true)
    public record Items<T>(List<T> item) {}
}
