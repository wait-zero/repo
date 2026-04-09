package com.waitzero.domain.queue.repository;

import com.waitzero.domain.queue.entity.QueueStatusHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface QueueStatusHistoryRepository extends JpaRepository<QueueStatusHistory, Long> {

    @Query("SELECT h.dayOfWeek, h.hourOfDay, AVG(h.totalWaitingCount) " +
           "FROM QueueStatusHistory h " +
           "WHERE h.office.id = :officeId " +
           "GROUP BY h.dayOfWeek, h.hourOfDay " +
           "ORDER BY h.dayOfWeek, h.hourOfDay")
    List<Object[]> findAverageByDayAndHour(@Param("officeId") Long officeId);
}
