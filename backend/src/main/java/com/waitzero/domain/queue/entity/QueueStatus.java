package com.waitzero.domain.queue.entity;

import com.waitzero.domain.office.entity.CivilServiceOffice;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Entity
@Table(name = "queue_status")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@EntityListeners(AuditingEntityListener.class)
public class QueueStatus {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "office_id", nullable = false)
    private CivilServiceOffice office;

    @Column(nullable = false)
    private int waitingCount;

    @Column(nullable = false)
    private int estimatedWaitMinutes;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private CongestionLevel congestionLevel;

    @Column(nullable = false)
    private int activeWindows = 1;

    @LastModifiedDate
    @Column(nullable = false)
    private LocalDateTime updatedAt;

    @Builder
    public QueueStatus(CivilServiceOffice office, int waitingCount, int estimatedWaitMinutes,
                       CongestionLevel congestionLevel, int activeWindows) {
        this.office = office;
        this.waitingCount = waitingCount;
        this.estimatedWaitMinutes = estimatedWaitMinutes;
        this.congestionLevel = congestionLevel;
        this.activeWindows = activeWindows;
    }

    public void updateStatus(int waitingCount, int estimatedWaitMinutes,
                             CongestionLevel congestionLevel, int activeWindows) {
        this.waitingCount = waitingCount;
        this.estimatedWaitMinutes = estimatedWaitMinutes;
        this.congestionLevel = congestionLevel;
        this.activeWindows = activeWindows;
    }
}
