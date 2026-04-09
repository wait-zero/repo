package com.waitzero.domain.queue.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.office.repository.OfficeRepository;
import com.waitzero.domain.queue.dto.QueueStatusResponse;
import com.waitzero.infra.publicdata.dto.CsoRealtimeItem;
import com.waitzero.infra.publicdata.dto.PublicDataApiResponse;
import com.waitzero.infra.publicdata.service.PublicDataSyncService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class QueueStatusService {

    private final OfficeRepository officeRepository;
    private final PublicDataSyncService publicDataSyncService;
    private final ObjectMapper objectMapper;

    public QueueStatusResponse getStatusByOfficeId(Long officeId) {
        var officeOpt = officeRepository.findById(officeId);
        if (officeOpt.isEmpty()) return null;

        CivilServiceOffice office = officeOpt.get();
        if (office.getCsoSn() == null || office.getCsoSn().isBlank()) return null;

        try {
            String url = publicDataSyncService.getBaseUrl()
                    + "/cso_realtime_v2?serviceKey=" + publicDataSyncService.getEncodedApiKey()
                    + "&pageNo=1&numOfRows=500&type=json";

            String json = publicDataSyncService.curlFetch(url);
            PublicDataApiResponse<CsoRealtimeItem> response = objectMapper.readValue(json,
                    objectMapper.getTypeFactory().constructParametricType(
                            PublicDataApiResponse.class, CsoRealtimeItem.class));

            if (response == null || response.body() == null
                    || response.body().items() == null
                    || response.body().items().item() == null) {
                return null;
            }

            List<CsoRealtimeItem> officeItems = response.body().items().item().stream()
                    .filter(item -> office.getCsoSn().equals(item.csoSn()))
                    .toList();

            if (officeItems.isEmpty()) return null;

            return QueueStatusResponse.fromRealtimeItems(officeId, officeItems);
        } catch (Exception e) {
            log.warn("실시간 대기현황 조회 실패 (officeId={}): {}", officeId, e.getMessage());
            return null;
        }
    }
}
