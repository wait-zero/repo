package com.waitzero.domain.queue.dto;

import java.util.List;

public record QueueTrendResponse(
        Long officeId,
        List<TrendDataPoint> dataPoints
) {
    public record TrendDataPoint(
            int dayOfWeek,
            String dayLabel,  // "월", "화", "수", "목", "금", "토", "일"
            int hourOfDay,
            double averageWaitingCount
    ) {}
}
