package com.waitzero.domain.queue.repository;

import com.waitzero.domain.queue.entity.QueueStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface QueueStatusRepository extends JpaRepository<QueueStatus, Long> {

    Optional<QueueStatus> findByOfficeId(Long officeId);
}
