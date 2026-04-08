package com.waitzero.domain.registration.dto;

import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;
import java.time.LocalTime;

public record PreRegistrationRequest(
        @NotNull(message = "사용자 ID는 필수입니다.")
        Long userId,

        @NotNull(message = "민원실 ID는 필수입니다.")
        Long officeId,

        @NotNull(message = "카테고리 ID는 필수입니다.")
        Long categoryId,

        String content,

        String voiceText,

        @NotNull(message = "방문 예정일은 필수입니다.")
        LocalDate visitDate,

        LocalTime visitTime
) {
}
