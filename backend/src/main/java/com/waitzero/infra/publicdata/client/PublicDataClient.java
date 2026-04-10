package com.waitzero.infra.publicdata.client;

import com.waitzero.infra.publicdata.dto.CsoInfoItem;
import com.waitzero.infra.publicdata.dto.CsoRealtimeItem;
import com.waitzero.infra.publicdata.dto.PublicDataApiResponse;
import com.waitzero.infra.publicdata.monitor.PublicDataCallTracker;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestClient;
import org.springframework.web.client.RestClientException;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * 공공데이터포털 — 행정안전부 민원실 대기현황 API 클라이언트.
 *
 * API 엔드포인트:
 *  - /cso_info_v2     : 민원실 기본정보
 *  - /cso_realtime_v2 : 민원실 실시간 대기현황
 *
 * 특징:
 *  - stdgCd(법정동 코드)로 필터링 호출 가능
 *  - 응답은 JSON (type=JSON 파라미터)
 *  - 지원되지 않는 지역은 NODATA 에러 반환 → 빈 리스트로 처리
 */
@Slf4j
@Component
public class PublicDataClient {

    private static final int DEFAULT_PAGE_SIZE = 500;

    private final RestClient restClient;
    private final PublicDataCallTracker callTracker;
    private final String apiKey;

    public PublicDataClient(RestClient publicDataRestClient,
                            PublicDataCallTracker callTracker,
                            @Value("${publicdata.api-key}") String apiKey) {
        this.restClient = publicDataRestClient;
        this.callTracker = callTracker;
        this.apiKey = apiKey;
    }

    /**
     * 특정 지자체(stdgCd)의 실시간 대기현황 조회.
     * 페이징으로 전체 결과를 자동 수집한다.
     */
    public List<CsoRealtimeItem> fetchRealtimeByRegion(String stdgCd) {
        return fetchAllPages("/cso_realtime_v2", stdgCd, REALTIME_TYPE_REF);
    }

    /**
     * 특정 지자체(stdgCd)의 민원실 기본정보 조회.
     */
    public List<CsoInfoItem> fetchOfficeInfoByRegion(String stdgCd) {
        return fetchAllPages("/cso_info_v2", stdgCd, INFO_TYPE_REF);
    }

    /**
     * 전체 페이지를 순회하며 결과를 수집한다.
     * 빈 응답·NODATA 등은 빈 리스트로 fallback.
     */
    private <T> List<T> fetchAllPages(String path, String stdgCd,
                                      ParameterizedTypeReference<PublicDataApiResponse<T>> typeRef) {
        List<T> result = new ArrayList<>();
        int pageNo = 1;

        while (true) {
            final int currentPage = pageNo;
            try {
                callTracker.record(path);
                PublicDataApiResponse<T> response = restClient.get()
                        .uri(uriBuilder -> uriBuilder
                                .path(path)
                                .queryParam("serviceKey", apiKey)
                                .queryParam("type", "JSON")
                                .queryParam("stdgCd", stdgCd)
                                .queryParam("pageNo", currentPage)
                                .queryParam("numOfRows", DEFAULT_PAGE_SIZE)
                                .build())
                        .retrieve()
                        .body(typeRef);

                if (response == null || response.body() == null
                        || response.body().items() == null
                        || response.body().items().item() == null
                        || response.body().items().item().isEmpty()) {
                    break;
                }

                List<T> items = response.body().items().item();
                result.addAll(items);

                int totalCount = parseInt(response.body().totalCount());
                if (result.size() >= totalCount || items.size() < DEFAULT_PAGE_SIZE) {
                    break;
                }
                pageNo++;
            } catch (RestClientException e) {
                log.warn("공공데이터 API 호출 실패 [path={}, stdgCd={}, page={}]: {}",
                        path, stdgCd, pageNo, e.getMessage());
                if (result.isEmpty()) return Collections.emptyList();
                break;
            }
        }

        log.debug("공공데이터 API 호출 완료 [path={}, stdgCd={}, count={}]",
                path, stdgCd, result.size());
        return result;
    }

    private int parseInt(String value) {
        if (value == null || value.isBlank()) return 0;
        try { return Integer.parseInt(value); }
        catch (NumberFormatException e) { return 0; }
    }

    private static final ParameterizedTypeReference<PublicDataApiResponse<CsoRealtimeItem>> REALTIME_TYPE_REF =
            new ParameterizedTypeReference<>() {};

    private static final ParameterizedTypeReference<PublicDataApiResponse<CsoInfoItem>> INFO_TYPE_REF =
            new ParameterizedTypeReference<>() {};
}
