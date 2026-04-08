package com.waitzero.domain.registration.entity;

import com.waitzero.domain.category.entity.CivilServiceCategory;
import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.user.entity.User;
import com.waitzero.global.entity.BaseTimeEntity;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table(name = "pre_registration")
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class PreRegistration extends BaseTimeEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "office_id", nullable = false)
    private CivilServiceOffice office;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", nullable = false)
    private CivilServiceCategory category;

    @Column(columnDefinition = "TEXT")
    private String content;

    @Column(columnDefinition = "TEXT")
    private String voiceText;

    @Column(columnDefinition = "TEXT")
    private String aiSummary;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private RegistrationStatus status = RegistrationStatus.PENDING;

    @Column(nullable = false)
    private LocalDate visitDate;

    private LocalTime visitTime;

    @Builder
    public PreRegistration(User user, CivilServiceOffice office, CivilServiceCategory category,
                           String content, String voiceText, String aiSummary,
                           LocalDate visitDate, LocalTime visitTime) {
        this.user = user;
        this.office = office;
        this.category = category;
        this.content = content;
        this.voiceText = voiceText;
        this.aiSummary = aiSummary;
        this.visitDate = visitDate;
        this.visitTime = visitTime;
        this.status = RegistrationStatus.PENDING;
    }

    public void updateStatus(RegistrationStatus status) {
        this.status = status;
    }

    public void updateAiSummary(String aiSummary) {
        this.aiSummary = aiSummary;
    }
}
