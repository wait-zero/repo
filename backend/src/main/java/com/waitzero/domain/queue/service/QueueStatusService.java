package com.waitzero.domain.queue.service;

import com.waitzero.domain.queue.dto.QueueStatusResponse;
import com.waitzero.domain.queue.repository.QueueStatusRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class QueueStatusService {

    private final QueueStatusRepository queueStatusRepository;

    public QueueStatusResponse getStatusByOfficeId(Long officeId) {
        return queueStatusRepository.findByOfficeId(officeId)
                .map(QueueStatusResponse::from)
                .orElse(null);
    }
}
