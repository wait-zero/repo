package com.waitzero.domain.registration.service;

import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.office.repository.OfficeRepository;
import com.waitzero.domain.registration.dto.PreRegistrationRequest;
import com.waitzero.domain.registration.dto.PreRegistrationResponse;
import com.waitzero.domain.registration.dto.StatusUpdateRequest;
import com.waitzero.domain.registration.entity.PreRegistration;
import com.waitzero.domain.registration.entity.RegistrationStatus;
import com.waitzero.domain.registration.repository.PreRegistrationRepository;
import com.waitzero.domain.user.entity.User;
import com.waitzero.domain.user.repository.UserRepository;
import com.waitzero.global.exception.CustomException;
import com.waitzero.global.exception.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class PreRegistrationService {

    private final PreRegistrationRepository preRegistrationRepository;
    private final UserRepository userRepository;
    private final OfficeRepository officeRepository;

    @Transactional
    public PreRegistrationResponse create(PreRegistrationRequest request) {
        User user = userRepository.findById(request.userId())
                .orElseThrow(() -> new ResourceNotFoundException("사용자", request.userId()));
        CivilServiceOffice office = officeRepository.findById(request.officeId())
                .orElseThrow(() -> new ResourceNotFoundException("민원실", request.officeId()));

        PreRegistration registration = PreRegistration.builder()
                .user(user)
                .office(office)
                .taskName(request.taskName())
                .content(request.content())
                .voiceText(request.voiceText())
                .visitDate(request.visitDate())
                .visitTime(request.visitTime())
                .build();

        PreRegistration saved = preRegistrationRepository.save(registration);
        return PreRegistrationResponse.from(saved);
    }

    public PreRegistrationResponse getById(Long id) {
        PreRegistration reg = preRegistrationRepository.findByIdWithDetails(id)
                .orElseThrow(() -> new ResourceNotFoundException("선 정보 입력", id));
        return PreRegistrationResponse.from(reg);
    }

    public List<PreRegistrationResponse> getByUserId(Long userId) {
        return preRegistrationRepository.findByUserIdWithDetails(userId).stream()
                .map(PreRegistrationResponse::from)
                .toList();
    }

    @Transactional
    public PreRegistrationResponse updateStatus(Long id, StatusUpdateRequest request) {
        PreRegistration reg = preRegistrationRepository.findByIdWithDetails(id)
                .orElseThrow(() -> new ResourceNotFoundException("선 정보 입력", id));

        try {
            RegistrationStatus newStatus = RegistrationStatus.valueOf(request.status());
            reg.updateStatus(newStatus);
        } catch (IllegalArgumentException e) {
            throw new CustomException("유효하지 않은 상태값입니다: " + request.status());
        }

        return PreRegistrationResponse.from(reg);
    }
}
