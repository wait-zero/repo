package com.waitzero.infra.publicdata.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public record CsoRealtimeItem(
        String totDt,
        String stdgCd,
        String csoSn,
        String taskNo,
        String taskNm,
        String clotNo,
        String wtngCnt,
        String clotCnterNo,
        String csoNm
) {}
