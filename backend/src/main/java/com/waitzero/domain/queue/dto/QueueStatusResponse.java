package com.waitzero.domain.queue.dto;

import com.waitzero.domain.queue.entity.QueueStatus;

import java.time.LocalDateTime;

public record QueueStatusResponse(
        Long officeId,
        int waitingCount,
        int estimatedWaitMinutes,
        String congestionLevel,
        int activeWindows,
        LocalDateTime updatedAt
) {
    public static QueueStatusResponse from(QueueStatus status) {
        return new QueueStatusResponse(
                status.getOffice().getId(),
                status.getWaitingCount(),
                status.getEstimatedWaitMinutes(),
                status.getCongestionLevel().name(),
                status.getActiveWindows(),
                status.getUpdatedAt()
        );
    }
}
