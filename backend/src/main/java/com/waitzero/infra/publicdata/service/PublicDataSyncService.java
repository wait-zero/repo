package com.waitzero.infra.publicdata.service;

import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.office.repository.OfficeRepository;
import com.waitzero.infra.publicdata.dto.PublicDataResponse;
import com.waitzero.infra.publicdata.dto.SyncResultResponse;
import com.waitzero.global.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestClient;

@Slf4j
@Service
public class PublicDataSyncService {

    private final RestClient restClient;
    private final OfficeRepository officeRepository;

    public PublicDataSyncService(
            @Value("${publicdata.api-key}") String apiKey,
            @Value("${publicdata.base-url}") String baseUrl,
            OfficeRepository officeRepository) {
        this.officeRepository = officeRepository;
        this.restClient = RestClient.builder()
                .baseUrl(baseUrl)
                .defaultHeader("Authorization", "Infuser " + apiKey)
                .build();
    }

    @Transactional
    public SyncResultResponse syncOffices() {
        try {
            PublicDataResponse response = restClient.get()
                    .uri(uriBuilder -> uriBuilder
                            .path("/15000563/v1/uddi:civil_service_office")
                            .queryParam("page", 1)
                            .queryParam("perPage", 1000)
                            .build())
                    .retrieve()
                    .body(PublicDataResponse.class);

            if (response == null || response.data() == null) {
                return new SyncResultResponse(0, 0, 0, "응답 데이터가 없습니다.");
            }

            int newCount = 0;
            int updateCount = 0;

            for (PublicDataResponse.PublicDataItem item : response.data()) {
                CivilServiceOffice office = CivilServiceOffice.builder()
                        .name(item.name())
                        .address(item.address())
                        .detailAddress(item.detailAddress())
                        .latitude(item.latitude())
                        .longitude(item.longitude())
                        .phone(item.phone())
                        .operatingHours(item.operatingHours())
                        .regionCode(item.regionCode())
                        .build();
                officeRepository.save(office);
                newCount++;
            }

            return new SyncResultResponse(
                    response.data().size(),
                    newCount,
                    updateCount,
                    "동기화가 완료되었습니다."
            );
        } catch (Exception e) {
            log.error("공공데이터 동기화 실패", e);
            throw new CustomException("공공데이터 동기화에 실패했습니다.", HttpStatus.SERVICE_UNAVAILABLE);
        }
    }
}
