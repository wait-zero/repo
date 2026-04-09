package com.waitzero.global.config;

import com.waitzero.domain.category.entity.CivilServiceCategory;
import com.waitzero.domain.category.repository.CategoryRepository;
import com.waitzero.domain.office.repository.OfficeRepository;
import com.waitzero.domain.user.entity.User;
import com.waitzero.domain.user.repository.UserRepository;
import com.waitzero.infra.publicdata.service.PublicDataSyncService;
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
    private final UserRepository userRepository;
    private final PublicDataSyncService publicDataSyncService;

    @Override
    @Transactional
    public void run(String... args) {
        initCategories();
        initUsers();
        syncPublicData();
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
                User.builder().name("홍길동").phone("010-1234-5678").build(),
                User.builder().name("김철수").phone("010-9876-5432").build()
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
}
