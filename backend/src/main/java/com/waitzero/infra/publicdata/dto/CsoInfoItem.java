package com.waitzero.infra.publicdata.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

@JsonIgnoreProperties(ignoreUnknown = true)
public record CsoInfoItem(
        String totCrtrYmd,
        String csoNm,
        String lotnoAddr,
        String roadNmAddr,
        String lat,
        String lot,
        String wkdyOperBgngTm,
        String wkdyOperEndTm,
        String nghtOperYn,
        String nghtDowExpln,
        String wkndOperYn,
        String wkndDowExpln,
        String stdgCd,
        String csoSn
) {}
