package com.waitzero.domain.queue.service;

import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.office.repository.OfficeRepository;
import com.waitzero.domain.queue.dto.QueueStatusResponse;
import com.waitzero.domain.queue.entity.CongestionLevel;
import com.waitzero.domain.queue.entity.QueueStatusHistory;
import com.waitzero.domain.queue.repository.QueueStatusHistoryRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Slf4j
@Component
@RequiredArgsConstructor
public class QueueHistoryScheduler {

    private final OfficeRepository officeRepository;
    private final QueueStatusService queueStatusService;
    private final QueueStatusHistoryRepository historyRepository;

    @Scheduled(fixedRate = 1800000) // 30분마다
    public void recordQueueHistory() {
        log.info("대기현황 이력 기록 시작");

        var offices = officeRepository.findAll();
        int recorded = 0;

        for (CivilServiceOffice office : offices) {
            try {
                QueueStatusResponse status = queueStatusService.getStatusByOfficeId(office.getId());
                if (status == null) continue;

                LocalDateTime now = LocalDateTime.now();

                CongestionLevel level;
                try {
                    level = CongestionLevel.valueOf(status.congestionLevel());
                } catch (Exception e) {
                    level = CongestionLevel.LOW;
                }

                QueueStatusHistory history = QueueStatusHistory.builder()
                        .office(office)
                        .totalWaitingCount(status.totalWaitingCount())
                        .activeWindows(status.activeWindows())
                        .congestionLevel(level)
                        .recordedAt(now)
                        .dayOfWeek(now.getDayOfWeek().getValue())
                        .hourOfDay(now.getHour())
                        .build();

                historyRepository.save(history);
                recorded++;
            } catch (Exception e) {
                log.warn("이력 기록 실패 (officeId={}): {}", office.getId(), e.getMessage());
            }
        }

        log.info("대기현황 이력 기록 완료: {}개 기관", recorded);
    }
}
