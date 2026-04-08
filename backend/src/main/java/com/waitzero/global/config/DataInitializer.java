package com.waitzero.global.config;

import com.waitzero.domain.category.entity.CivilServiceCategory;
import com.waitzero.domain.category.repository.CategoryRepository;
import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.office.repository.OfficeRepository;
import com.waitzero.domain.queue.entity.CongestionLevel;
import com.waitzero.domain.queue.entity.QueueStatus;
import com.waitzero.domain.queue.repository.QueueStatusRepository;
import com.waitzero.domain.user.entity.User;
import com.waitzero.domain.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final OfficeRepository officeRepository;
    private final CategoryRepository categoryRepository;
    private final QueueStatusRepository queueStatusRepository;
    private final UserRepository userRepository;

    @Override
    @Transactional
    public void run(String... args) {
        if (officeRepository.count() > 0) {
            log.info("데이터가 이미 존재합니다. 초기화를 건너뜁니다.");
            return;
        }

        log.info("데모 데이터 초기화 시작");

        // 민원실 5개
        CivilServiceOffice office1 = officeRepository.save(CivilServiceOffice.builder()
                .name("서울시청 민원실")
                .address("서울특별시 중구 세종대로 110")
                .detailAddress("1층 민원실")
                .latitude(37.5666)
                .longitude(126.9784)
                .phone("02-120")
                .operatingHours("09:00-18:00")
                .regionCode("11")
                .build());

        CivilServiceOffice office2 = officeRepository.save(CivilServiceOffice.builder()
                .name("강남구청 민원실")
                .address("서울특별시 강남구 학동로 426")
                .detailAddress("1층")
                .latitude(37.5172)
                .longitude(127.0473)
                .phone("02-3423-5114")
                .operatingHours("09:00-18:00")
                .regionCode("11")
                .build());

        CivilServiceOffice office3 = officeRepository.save(CivilServiceOffice.builder()
                .name("수원시청 민원실")
                .address("경기도 수원시 팔달구 효원로 241")
                .detailAddress("1층 민원봉사과")
                .latitude(37.2636)
                .longitude(127.0286)
                .phone("031-228-2114")
                .operatingHours("09:00-18:00")
                .regionCode("41")
                .build());

        CivilServiceOffice office4 = officeRepository.save(CivilServiceOffice.builder()
                .name("부산시청 민원실")
                .address("부산광역시 연제구 중앙대로 1001")
                .detailAddress("1층")
                .latitude(35.1796)
                .longitude(129.0756)
                .phone("051-120")
                .operatingHours("09:00-18:00")
                .regionCode("26")
                .build());

        CivilServiceOffice office5 = officeRepository.save(CivilServiceOffice.builder()
                .name("대전시청 민원실")
                .address("대전광역시 서구 둔산로 100")
                .detailAddress("1층 민원실")
                .latitude(36.3504)
                .longitude(127.3845)
                .phone("042-120")
                .operatingHours("09:00-18:00")
                .regionCode("30")
                .build());

        // 카테고리 7개
        categoryRepository.saveAll(List.of(
                CivilServiceCategory.builder()
                        .name("주민등록")
                        .description("주민등록 등·초본 발급, 주소 변경 등")
                        .requiredDocuments("[\"신분증\", \"위임장(대리 시)\"]")
                        .estimatedProcessMinutes(10)
                        .build(),
                CivilServiceCategory.builder()
                        .name("전입신고")
                        .description("주소 이전에 따른 전입신고")
                        .requiredDocuments("[\"신분증\", \"임대차계약서\"]")
                        .estimatedProcessMinutes(15)
                        .build(),
                CivilServiceCategory.builder()
                        .name("인감증명")
                        .description("인감증명서 발급 및 인감 등록")
                        .requiredDocuments("[\"신분증\", \"인감도장\"]")
                        .estimatedProcessMinutes(10)
                        .build(),
                CivilServiceCategory.builder()
                        .name("차량등록")
                        .description("자동차 등록, 이전, 말소 등")
                        .requiredDocuments("[\"신분증\", \"자동차매매계약서\", \"자동차등록증\"]")
                        .estimatedProcessMinutes(20)
                        .build(),
                CivilServiceCategory.builder()
                        .name("건축허가")
                        .description("건축물 신축, 증축, 개축 허가 신청")
                        .requiredDocuments("[\"신분증\", \"건축허가신청서\", \"설계도서\"]")
                        .estimatedProcessMinutes(30)
                        .build(),
                CivilServiceCategory.builder()
                        .name("사업자등록")
                        .description("개인/법인 사업자등록 관련 민원")
                        .requiredDocuments("[\"신분증\", \"사업자등록신청서\", \"임대차계약서\"]")
                        .estimatedProcessMinutes(20)
                        .build(),
                CivilServiceCategory.builder()
                        .name("기타")
                        .description("기타 민원 사항")
                        .requiredDocuments("[\"신분증\"]")
                        .estimatedProcessMinutes(15)
                        .build()
        ));

        // 대기 현황
        queueStatusRepository.saveAll(List.of(
                QueueStatus.builder()
                        .office(office1)
                        .waitingCount(12)
                        .estimatedWaitMinutes(25)
                        .congestionLevel(CongestionLevel.MEDIUM)
                        .activeWindows(3)
                        .build(),
                QueueStatus.builder()
                        .office(office2)
                        .waitingCount(5)
                        .estimatedWaitMinutes(10)
                        .congestionLevel(CongestionLevel.LOW)
                        .activeWindows(4)
                        .build(),
                QueueStatus.builder()
                        .office(office3)
                        .waitingCount(20)
                        .estimatedWaitMinutes(40)
                        .congestionLevel(CongestionLevel.HIGH)
                        .activeWindows(2)
                        .build(),
                QueueStatus.builder()
                        .office(office4)
                        .waitingCount(8)
                        .estimatedWaitMinutes(15)
                        .congestionLevel(CongestionLevel.LOW)
                        .activeWindows(5)
                        .build(),
                QueueStatus.builder()
                        .office(office5)
                        .waitingCount(15)
                        .estimatedWaitMinutes(30)
                        .congestionLevel(CongestionLevel.MEDIUM)
                        .activeWindows(3)
                        .build()
        ));

        // 데모 사용자
        userRepository.saveAll(List.of(
                User.builder().name("홍길동").phone("010-1234-5678").build(),
                User.builder().name("김철수").phone("010-9876-5432").build(),
                User.builder().name("이영희").phone("010-5555-1234").build()
        ));

        log.info("데모 데이터 초기화 완료");
    }
}
