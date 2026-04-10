package com.waitzero.domain.queue.service;

import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.office.repository.OfficeRepository;
import com.waitzero.domain.queue.dto.QueueStatusResponse;
import com.waitzero.infra.publicdata.dto.CsoRealtimeItem;
import com.waitzero.infra.publicdata.service.RealtimeStatusService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class QueueStatusService {

    private final OfficeRepository officeRepository;
    private final RealtimeStatusService realtimeStatusService;

    public QueueStatusResponse getStatusByOfficeId(Long officeId) {
        var officeOpt = officeRepository.findById(officeId);
        if (officeOpt.isEmpty()) return null;

        CivilServiceOffice office = officeOpt.get();
        if (office.getCsoSn() == null || office.getCsoSn().isBlank()) return null;
        if (office.getRegionCode() == null || office.getRegionCode().isBlank()) return null;

        try {
            // 캐시된 지역 데이터에서 해당 민원실 업무만 추출 (캐시 hit 시 API 호출 없음)
            List<CsoRealtimeItem> officeItems = realtimeStatusService.getByOffice(
                    office.getRegionCode(), office.getCsoSn());

            if (officeItems.isEmpty()) return null;
            return QueueStatusResponse.fromRealtimeItems(officeId, officeItems);
        } catch (Exception e) {
            log.warn("실시간 대기현황 조회 실패 (officeId={}): {}", officeId, e.getMessage());
            return null;
        }
    }
}
