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

    @Column(length = 10)
    private String taskNo;

    @Column(length = 100)
    private String taskName;

    @Column(nullable = false)
    private int waitingCount;

    @Column(nullable = false)
    private int estimatedWaitMinutes;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 10)
    private CongestionLevel congestionLevel;

    @Column(nullable = false)
    private int activeWindows = 1;

    @Column(length = 20)
    private String callNumber;

    @Column(length = 20)
    private String callCounterNo;

    @Column(length = 20)
    private String dataTimestamp;

    @LastModifiedDate
    @Column(nullable = false)
    private LocalDateTime updatedAt;

    @Builder
    public QueueStatus(CivilServiceOffice office, String taskNo, String taskName,
                       int waitingCount, int estimatedWaitMinutes,
                       CongestionLevel congestionLevel, int activeWindows,
                       String callNumber, String callCounterNo, String dataTimestamp) {
        this.office = office;
        this.taskNo = taskNo;
        this.taskName = taskName;
        this.waitingCount = waitingCount;
        this.estimatedWaitMinutes = estimatedWaitMinutes;
        this.congestionLevel = congestionLevel;
        this.activeWindows = activeWindows;
        this.callNumber = callNumber;
        this.callCounterNo = callCounterNo;
        this.dataTimestamp = dataTimestamp;
    }

    public void updateStatus(int waitingCount, int estimatedWaitMinutes,
                             CongestionLevel congestionLevel, int activeWindows) {
        this.waitingCount = waitingCount;
        this.estimatedWaitMinutes = estimatedWaitMinutes;
        this.congestionLevel = congestionLevel;
        this.activeWindows = activeWindows;
    }

    public void updateFromRealtimeApi(int waitingCount, String callNumber,
                                       String callCounterNo, String dataTimestamp) {
        this.waitingCount = waitingCount;
        this.estimatedWaitMinutes = waitingCount * 5;
        this.congestionLevel = calculateCongestion(waitingCount);
        this.callNumber = callNumber;
        this.callCounterNo = callCounterNo;
        this.dataTimestamp = dataTimestamp;
        this.activeWindows = (callCounterNo != null && !callCounterNo.isBlank()) ? 1 : 0;
    }

    private CongestionLevel calculateCongestion(int count) {
        if (count <= 5) return CongestionLevel.LOW;
        if (count <= 15) return CongestionLevel.MEDIUM;
        return CongestionLevel.HIGH;
    }
}
