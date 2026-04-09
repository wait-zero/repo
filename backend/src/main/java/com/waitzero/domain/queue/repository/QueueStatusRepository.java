package com.waitzero.domain.queue.repository;

import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.queue.entity.QueueStatus;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface QueueStatusRepository extends JpaRepository<QueueStatus, Long> {

    Optional<QueueStatus> findByOfficeId(Long officeId);

    Optional<QueueStatus> findByOfficeAndTaskNo(CivilServiceOffice office, String taskNo);

    List<QueueStatus> findAllByOffice(CivilServiceOffice office);

    List<QueueStatus> findAllByOfficeId(Long officeId);

    void deleteAllByOffice(CivilServiceOffice office);
}
