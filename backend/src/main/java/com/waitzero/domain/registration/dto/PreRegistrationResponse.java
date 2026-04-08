package com.waitzero.domain.registration.dto;

import com.waitzero.domain.registration.entity.PreRegistration;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

public record PreRegistrationResponse(
        Long id,
        Long userId,
        Long officeId,
        String officeName,
        Long categoryId,
        String categoryName,
        String content,
        String voiceText,
        String aiSummary,
        String status,
        LocalDate visitDate,
        LocalTime visitTime,
        LocalDateTime createdAt
) {
    public static PreRegistrationResponse from(PreRegistration reg) {
        return new PreRegistrationResponse(
                reg.getId(),
                reg.getUser().getId(),
                reg.getOffice().getId(),
                reg.getOffice().getName(),
                reg.getCategory().getId(),
                reg.getCategory().getName(),
                reg.getContent(),
                reg.getVoiceText(),
                reg.getAiSummary(),
                reg.getStatus().name(),
                reg.getVisitDate(),
                reg.getVisitTime(),
                reg.getCreatedAt()
        );
    }
}
