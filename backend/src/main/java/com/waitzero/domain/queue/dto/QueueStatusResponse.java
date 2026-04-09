package com.waitzero.domain.queue.dto;

import com.waitzero.domain.queue.entity.QueueStatus;
import com.waitzero.infra.publicdata.dto.CsoRealtimeItem;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

public record QueueStatusResponse(
        Long officeId,
        int totalWaitingCount,
        int estimatedWaitMinutes,
        String congestionLevel,
        int activeWindows,
        LocalDateTime updatedAt,
        List<TaskStatus> tasks
) {
    public record TaskStatus(
            String taskNo,
            String taskName,
            int waitingCount,
            String callNumber,
            String callCounterNo
    ) {
        public static TaskStatus from(QueueStatus status) {
            return new TaskStatus(
                    status.getTaskNo(),
                    status.getTaskName(),
                    status.getWaitingCount(),
                    status.getCallNumber(),
                    status.getCallCounterNo()
            );
        }

        public static TaskStatus fromRealtimeItem(CsoRealtimeItem item) {
            return new TaskStatus(
                    item.taskNo(),
                    item.taskNm(),
                    parseInt(item.wtngCnt()),
                    item.clotNo(),
                    item.clotCnterNo()
            );
        }
    }

    public static QueueStatusResponse from(QueueStatus status) {
        return new QueueStatusResponse(
                status.getOffice().getId(),
                status.getWaitingCount(),
                status.getEstimatedWaitMinutes(),
                status.getCongestionLevel().name(),
                status.getActiveWindows(),
                status.getUpdatedAt(),
                null
        );
    }

    public static QueueStatusResponse fromList(Long officeId, List<QueueStatus> statuses) {
        if (statuses == null || statuses.isEmpty()) return null;

        int totalWaiting = statuses.stream().mapToInt(QueueStatus::getWaitingCount).sum();
        int totalWindows = (int) statuses.stream()
                .filter(s -> s.getCallCounterNo() != null && !s.getCallCounterNo().isBlank())
                .count();
        String congestion = calcCongestion(totalWaiting);

        LocalDateTime latestUpdate = statuses.stream()
                .map(QueueStatus::getUpdatedAt)
                .filter(Objects::nonNull)
                .max(LocalDateTime::compareTo)
                .orElse(null);

        List<TaskStatus> tasks = statuses.stream()
                .map(TaskStatus::from)
                .toList();

        return new QueueStatusResponse(officeId, totalWaiting, totalWaiting * 5,
                congestion, Math.max(totalWindows, 1), latestUpdate, tasks);
    }

    public static QueueStatusResponse fromRealtimeItems(Long officeId, List<CsoRealtimeItem> items) {
        if (items == null || items.isEmpty()) return null;

        int totalWaiting = items.stream().mapToInt(i -> parseInt(i.wtngCnt())).sum();
        int totalWindows = (int) items.stream()
                .filter(i -> i.clotCnterNo() != null && !i.clotCnterNo().isBlank())
                .count();
        String congestion = calcCongestion(totalWaiting);

        List<TaskStatus> tasks = items.stream()
                .map(TaskStatus::fromRealtimeItem)
                .toList();

        return new QueueStatusResponse(officeId, totalWaiting, totalWaiting * 5,
                congestion, Math.max(totalWindows, 1), LocalDateTime.now(), tasks);
    }

    private static String calcCongestion(int totalWaiting) {
        if (totalWaiting <= 5) return "LOW";
        if (totalWaiting <= 15) return "MEDIUM";
        return "HIGH";
    }

    private static int parseInt(String value) {
        if (value == null || value.isBlank()) return 0;
        try { return Integer.parseInt(value); }
        catch (NumberFormatException e) { return 0; }
    }
}
