package com.waitzero.domain.queue.entity;

import com.waitzero.domain.office.entity.CivilServiceOffice;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Entity
@Table(name = "queue_status_history", indexes = {
        @Index(name = "idx_history_office_recorded", columnList = "office_id, recorded_at")
})
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class QueueStatusHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "office_id", nullable = false)
    private CivilServiceOffice office;

    private int totalWaitingCount;

    private int activeWindows;

    @Enumerated(EnumType.STRING)
    @Column(length = 10)
    private CongestionLevel congestionLevel;

    @Column(nullable = false)
    private LocalDateTime recordedAt;

    private int dayOfWeek;  // 1(월)~7(일) ISO

    private int hourOfDay;  // 0~23

    @Builder
    public QueueStatusHistory(CivilServiceOffice office, int totalWaitingCount,
                              int activeWindows, CongestionLevel congestionLevel,
                              LocalDateTime recordedAt, int dayOfWeek, int hourOfDay) {
        this.office = office;
        this.totalWaitingCount = totalWaitingCount;
        this.activeWindows = activeWindows;
        this.congestionLevel = congestionLevel;
        this.recordedAt = recordedAt;
        this.dayOfWeek = dayOfWeek;
        this.hourOfDay = hourOfDay;
    }
}
