package com.waitzero.domain.office.service;

import com.waitzero.domain.office.dto.OfficeDetailResponse;
import com.waitzero.domain.office.dto.OfficeResponse;
import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.office.repository.OfficeRepository;
import com.waitzero.domain.queue.dto.QueueStatusResponse;
import com.waitzero.domain.queue.service.QueueStatusService;
import com.waitzero.global.exception.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class OfficeService {

    private final OfficeRepository officeRepository;
    private final QueueStatusService queueStatusService;

    public List<OfficeResponse> searchOffices(String keyword, String region) {
        return officeRepository.searchOffices(keyword, region).stream()
                .map(OfficeResponse::from)
                .toList();
    }

    public OfficeDetailResponse getOfficeDetail(Long id) {
        CivilServiceOffice office = officeRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("민원실", id));
        QueueStatusResponse queueStatus = queueStatusService.getStatusByOfficeId(id);
        return OfficeDetailResponse.from(office, queueStatus);
    }

    public List<OfficeResponse> getNearbyOffices(double lat, double lng, double radius) {
        return officeRepository.findNearbyOffices(lat, lng, radius).stream()
                .map(OfficeResponse::from)
                .toList();
    }
}
