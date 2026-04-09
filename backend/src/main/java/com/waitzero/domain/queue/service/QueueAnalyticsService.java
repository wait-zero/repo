package com.waitzero.domain.queue.service;

import com.waitzero.domain.queue.dto.QueueTrendResponse;
import com.waitzero.domain.queue.dto.QueueTrendResponse.TrendDataPoint;
import com.waitzero.domain.queue.repository.QueueStatusHistoryRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class QueueAnalyticsService {

    private final QueueStatusHistoryRepository historyRepository;

    private static final String[] DAY_LABELS = {"", "월", "화", "수", "목", "금", "토", "일"};

    public QueueTrendResponse getAverageTrendByOffice(Long officeId) {
        List<Object[]> results = historyRepository.findAverageByDayAndHour(officeId);

        List<TrendDataPoint> dataPoints = results.stream()
                .map(row -> new TrendDataPoint(
                        ((Number) row[0]).intValue(),
                        toDayLabel(((Number) row[0]).intValue()),
                        ((Number) row[1]).intValue(),
                        ((Number) row[2]).doubleValue()
                ))
                .toList();

        return new QueueTrendResponse(officeId, dataPoints);
    }

    private String toDayLabel(int dayOfWeek) {
        if (dayOfWeek >= 1 && dayOfWeek <= 7) {
            return DAY_LABELS[dayOfWeek];
        }
        return String.valueOf(dayOfWeek);
    }
}
