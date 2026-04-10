package com.waitzero.global.config;

import com.waitzero.domain.office.repository.OfficeRepository;
import com.waitzero.domain.user.entity.User;
import com.waitzero.domain.user.repository.UserRepository;
import com.waitzero.infra.publicdata.service.PublicDataSyncService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 최초 기동 시 필요한 데이터만 초기화한다.
 *  - 데모 사용자 (로그인 테스트용)
 *  - 민원실 기본정보 (공공데이터 API에서 지원 지역만 동기화)
 *
 * 카테고리/대기이력 데모 데이터는 제거됨 (실시간 API + Caffeine 캐시 기반으로 전환).
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class DataInitializer implements CommandLineRunner {

    private final OfficeRepository officeRepository;
    private final UserRepository userRepository;
    private final PublicDataSyncService publicDataSyncService;
    private final PasswordEncoder passwordEncoder;

    @Override
    @Transactional
    public void run(String... args) {
        initUsers();
        syncPublicData();
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
            var result = publicDataSyncService.syncOffices();
            log.info("민원실 동기화: {}", result.message());
            log.info("실시간 대기현황은 RealtimeStatusService가 캐시 기반으로 제공합니다.");
        } catch (Exception e) {
            log.warn("공공데이터 동기화 실패 (서버는 정상 기동됩니다): {}", e.getMessage());
        }
    }
}
