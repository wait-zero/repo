package com.waitzero.global.config;

import com.waitzero.domain.category.entity.CivilServiceCategory;
import com.waitzero.domain.category.repository.CategoryRepository;
import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.office.repository.OfficeRepository;
import com.waitzero.domain.queue.entity.CongestionLevel;
import com.waitzero.domain.queue.entity.QueueStatusHistory;
import com.waitzero.domain.queue.repository.QueueStatusHistoryRepository;
import com.waitzero.domain.user.entity.User;
import com.waitzero.domain.user.repository.UserRepository;
import com.waitzero.infra.publicdata.service.PublicDataSyncService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

@Slf4j
@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final OfficeRepository officeRepository;
    private final CategoryRepository categoryRepository;
    private final UserRepository userRepository;
    private final PublicDataSyncService publicDataSyncService;
    private final PasswordEncoder passwordEncoder;
    private final QueueStatusHistoryRepository queueStatusHistoryRepository;

    @Override
    @Transactional
    public void run(String... args) {
        initCategories();
        initUsers();
        syncPublicData();
        initQueueHistory();
    }

    private void initCategories() {
        if (categoryRepository.count() > 0) return;
        log.info("카테고리 초기화");
        categoryRepository.saveAll(List.of(
                CivilServiceCategory.builder()
                        .name("주민등록").description("주민등록 등·초본 발급, 주소 변경 등")
                        .requiredDocuments("[\"신분증\", \"위임장(대리 시)\"]").estimatedProcessMinutes(10).build(),
                CivilServiceCategory.builder()
                        .name("전입신고").description("주소 이전에 따른 전입신고")
                        .requiredDocuments("[\"신분증\", \"임대차계약서\"]").estimatedProcessMinutes(15).build(),
                CivilServiceCategory.builder()
                        .name("인감증명").description("인감증명서 발급 및 인감 등록")
                        .requiredDocuments("[\"신분증\", \"인감도장\"]").estimatedProcessMinutes(10).build(),
                CivilServiceCategory.builder()
                        .name("차량등록").description("자동차 등록, 이전, 말소 등")
                        .requiredDocuments("[\"신분증\", \"자동차매매계약서\", \"자동차등록증\"]").estimatedProcessMinutes(20).build(),
                CivilServiceCategory.builder()
                        .name("여권").description("여권 발급, 재발급, 기간연장")
                        .requiredDocuments("[\"신분증\", \"여권발급신청서\", \"사진\"]").estimatedProcessMinutes(15).build(),
                CivilServiceCategory.builder()
                        .name("세무").description("지방세 납부, 증명서 발급 등")
                        .requiredDocuments("[\"신분증\"]").estimatedProcessMinutes(10).build(),
                CivilServiceCategory.builder()
                        .name("기타").description("기타 민원 사항")
                        .requiredDocuments("[\"신분증\"]").estimatedProcessMinutes(15).build()
        ));
    }

    private void initUsers() {
        if (userRepository.count() > 0) return;
        log.info("데모 사용자 초기화");
        userRepository.saveAll(List.of(
                User.builder().name("홍길동").phone("010-1234-5678")
                        .password(passwordEncoder.encode("1234")).build(),
                User.builder().name("김철수").phone("010-9876-5432")
                        .password(passwordEncoder.encode("1234")).build()
        ));
    }

    private void syncPublicData() {
        if (officeRepository.count() > 0) {
            log.info("민원실 데이터가 이미 존재합니다. 공공데이터 동기화를 건너뜁니다.");
            return;
        }
        try {
            log.info("공공데이터 민원실 정보 동기화 시작");
            var officeResult = publicDataSyncService.syncOffices();
            log.info("민원실 동기화: {}", officeResult.message());

            log.info("실시간 대기현황은 API 직접 호출 방식으로 운영됩니다.");
        } catch (Exception e) {
            log.warn("공공데이터 동기화 실패 (서버는 정상 기동됩니다): {}", e.getMessage());
        }
    }

    private void initQueueHistory() {
        if (queueStatusHistoryRepository.count() > 0) {
            log.info("대기 이력 데이터가 이미 존재합니다. 시딩을 건너뜁니다.");
            return;
        }

        List<CivilServiceOffice> offices = officeRepository.findAll();
        if (offices.isEmpty()) {
            log.info("민원실 데이터가 없어 대기 이력 시딩을 건너뜁니다.");
            return;
        }

        log.info("데모 대기 이력 데이터 시딩 시작 (최근 4주)");
        Random random = new Random(42);
        LocalDateTime now = LocalDateTime.now();
        List<QueueStatusHistory> histories = new ArrayList<>();

        for (CivilServiceOffice office : offices) {
            for (int weekOffset = 0; weekOffset < 4; weekOffset++) {
                for (int day = 1; day <= 7; day++) { // 1=월 ~ 7=일
                    for (int hour = 9; hour <= 18; hour++) {
                        int waitingCount;

                        if (day >= 6) {
                            // 주말: 대기인원 0 또는 매우 적음
                            waitingCount = random.nextInt(3);
                        } else {
                            // 평일 패턴
                            waitingCount = getWeekdayPattern(hour, random);
                        }

                        // 기관별 약간의 변동
                        waitingCount = Math.max(0, waitingCount + random.nextInt(5) - 2);

                        CongestionLevel level;
                        if (waitingCount <= 5) level = CongestionLevel.LOW;
                        else if (waitingCount <= 15) level = CongestionLevel.MEDIUM;
                        else level = CongestionLevel.HIGH;

                        int activeWindows = Math.max(1, 2 + random.nextInt(3));

                        LocalDateTime recordedAt = now
                                .minusWeeks(weekOffset)
                                .with(java.time.DayOfWeek.of(day))
                                .withHour(hour)
                                .withMinute(0)
                                .withSecond(0)
                                .withNano(0);

                        histories.add(QueueStatusHistory.builder()
                                .office(office)
                                .totalWaitingCount(waitingCount)
                                .activeWindows(activeWindows)
                                .congestionLevel(level)
                                .recordedAt(recordedAt)
                                .dayOfWeek(day)
                                .hourOfDay(hour)
                                .build());
                    }
                }
            }
        }

        queueStatusHistoryRepository.saveAll(histories);
        log.info("데모 대기 이력 데이터 시딩 완료: {}건", histories.size());
    }

    /**
     * 평일 시간대별 대기인원 패턴:
     * - 오전 10~11시: 가장 혼잡 (15~25명)
     * - 점심 12~13시: 감소 (5~10명)
     * - 오후 14~15시: 다시 증가 (12~20명)
     * - 나머지: 보통 (3~12명)
     */
    private int getWeekdayPattern(int hour, Random random) {
        return switch (hour) {
            case 9 -> 5 + random.nextInt(8);          // 5~12
            case 10, 11 -> 15 + random.nextInt(11);   // 15~25 (피크)
            case 12, 13 -> 5 + random.nextInt(6);     // 5~10 (점심)
            case 14, 15 -> 12 + random.nextInt(9);    // 12~20 (오후 피크)
            case 16 -> 8 + random.nextInt(7);          // 8~14
            case 17 -> 4 + random.nextInt(6);          // 4~9
            case 18 -> 1 + random.nextInt(4);          // 1~4
            default -> 3 + random.nextInt(10);         // 3~12
        };
    }
}
