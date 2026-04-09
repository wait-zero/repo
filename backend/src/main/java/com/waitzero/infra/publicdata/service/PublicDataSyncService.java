package com.waitzero.infra.publicdata.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.office.repository.OfficeRepository;
import com.waitzero.domain.queue.entity.QueueStatus;
import com.waitzero.domain.queue.repository.QueueStatusRepository;
import com.waitzero.infra.publicdata.dto.CsoInfoItem;
import com.waitzero.infra.publicdata.dto.CsoRealtimeItem;
import com.waitzero.infra.publicdata.dto.PublicDataApiResponse;
import com.waitzero.infra.publicdata.dto.SyncResultResponse;
import com.waitzero.global.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.concurrent.TimeUnit;

@Slf4j
@Service
public class PublicDataSyncService {

    private final OfficeRepository officeRepository;
    private final QueueStatusRepository queueStatusRepository;
    private final ObjectMapper objectMapper;
    private final String encodedApiKey;
    private final String baseUrl;

    public PublicDataSyncService(
            @Value("${publicdata.api-key}") String apiKey,
            @Value("${publicdata.base-url}") String baseUrl,
            OfficeRepository officeRepository,
            QueueStatusRepository queueStatusRepository,
            ObjectMapper objectMapper) {
        this.officeRepository = officeRepository;
        this.queueStatusRepository = queueStatusRepository;
        this.objectMapper = objectMapper;
        this.encodedApiKey = URLEncoder.encode(apiKey, StandardCharsets.UTF_8);
        this.baseUrl = baseUrl;
    }

    @Transactional
    public SyncResultResponse syncOffices() {
        try {
            String url = baseUrl + "/cso_info_v2?serviceKey=" + encodedApiKey
                    + "&pageNo=1&numOfRows=500&type=json";
            log.info("민원실 기본정보 동기화 시작");

            String json = curlFetch(url);
            PublicDataApiResponse<CsoInfoItem> response = objectMapper.readValue(json,
                    objectMapper.getTypeFactory().constructParametricType(
                            PublicDataApiResponse.class, CsoInfoItem.class));

            if (response == null || response.body() == null
                    || response.body().items() == null
                    || response.body().items().item() == null) {
                return new SyncResultResponse(0, 0, 0, "응답 데이터가 없습니다.");
            }

            List<CsoInfoItem> items = response.body().items().item();
            int newCount = 0, updateCount = 0;

            for (CsoInfoItem item : items) {
                if (item.csoSn() == null || item.csoSn().isBlank()) continue;

                String operatingHours = formatOperatingHours(item.wkdyOperBgngTm(), item.wkdyOperEndTm());
                Double lat = parseDouble(item.lat());
                Double lng = parseDouble(item.lot());
                String address = (item.roadNmAddr() != null && !item.roadNmAddr().isBlank())
                        ? item.roadNmAddr() : item.lotnoAddr();
                String nightOp = "Y".equals(item.nghtOperYn()) ? item.nghtDowExpln() : null;
                String weekendOp = "Y".equals(item.wkndOperYn()) ? item.wkndDowExpln() : null;

                var existing = officeRepository.findByCsoSn(item.csoSn());
                if (existing.isPresent()) {
                    existing.get().updateFromApi(item.csoNm(), address, lat, lng,
                            operatingHours, item.stdgCd(), nightOp, weekendOp);
                    updateCount++;
                } else {
                    officeRepository.save(CivilServiceOffice.builder()
                            .csoSn(item.csoSn())
                            .name(item.csoNm())
                            .address(address != null ? address : "")
                            .latitude(lat)
                            .longitude(lng)
                            .operatingHours(operatingHours)
                            .regionCode(item.stdgCd())
                            .nightOperation(nightOp)
                            .weekendOperation(weekendOp)
                            .build());
                    newCount++;
                }
            }

            log.info("민원실 기본정보 동기화 완료: 총 {}건, 신규 {}건, 갱신 {}건", items.size(), newCount, updateCount);
            return new SyncResultResponse(items.size(), newCount, updateCount,
                    "민원실 기본정보 동기화가 완료되었습니다.");
        } catch (Exception e) {
            log.error("민원실 기본정보 동기화 실패", e);
            throw new CustomException("민원실 기본정보 동기화에 실패했습니다: " + e.getMessage(),
                    HttpStatus.SERVICE_UNAVAILABLE);
        }
    }

    @Transactional
    public SyncResultResponse syncRealtimeStatus() {
        try {
            String url = baseUrl + "/cso_realtime_v2?serviceKey=" + encodedApiKey
                    + "&pageNo=1&numOfRows=500&type=json";
            log.info("실시간 대기현황 동기화 시작");

            String json = curlFetch(url);
            PublicDataApiResponse<CsoRealtimeItem> response = objectMapper.readValue(json,
                    objectMapper.getTypeFactory().constructParametricType(
                            PublicDataApiResponse.class, CsoRealtimeItem.class));

            if (response == null || response.body() == null
                    || response.body().items() == null
                    || response.body().items().item() == null) {
                return new SyncResultResponse(0, 0, 0, "실시간 데이터가 없습니다.");
            }

            List<CsoRealtimeItem> items = response.body().items().item();
            int newCount = 0, updateCount = 0;

            for (CsoRealtimeItem item : items) {
                if (item.csoSn() == null || item.csoSn().isBlank()) continue;

                var officeOpt = officeRepository.findByCsoSn(item.csoSn());
                if (officeOpt.isEmpty()) continue;

                CivilServiceOffice office = officeOpt.get();
                int waiting = parseInt(item.wtngCnt());

                var statusOpt = queueStatusRepository.findByOfficeAndTaskNo(office, item.taskNo());
                if (statusOpt.isPresent()) {
                    statusOpt.get().updateFromRealtimeApi(waiting,
                            item.clotNo(), item.clotCnterNo(), item.totDt());
                    updateCount++;
                } else {
                    queueStatusRepository.save(QueueStatus.builder()
                            .office(office)
                            .taskNo(item.taskNo())
                            .taskName(item.taskNm())
                            .waitingCount(waiting)
                            .estimatedWaitMinutes(waiting * 5)
                            .congestionLevel(
                                    waiting <= 5 ? com.waitzero.domain.queue.entity.CongestionLevel.LOW :
                                    waiting <= 15 ? com.waitzero.domain.queue.entity.CongestionLevel.MEDIUM :
                                    com.waitzero.domain.queue.entity.CongestionLevel.HIGH)
                            .activeWindows(item.clotCnterNo() != null && !item.clotCnterNo().isBlank() ? 1 : 0)
                            .callNumber(item.clotNo())
                            .callCounterNo(item.clotCnterNo())
                            .dataTimestamp(item.totDt())
                            .build());
                    newCount++;
                }
            }

            log.info("실시간 대기현황 동기화 완료: 총 {}건, 신규 {}건, 갱신 {}건", items.size(), newCount, updateCount);
            return new SyncResultResponse(items.size(), newCount, updateCount,
                    "실시간 대기현황 동기화가 완료되었습니다.");
        } catch (Exception e) {
            log.error("실시간 대기현황 동기화 실패", e);
            throw new CustomException("실시간 대기현황 동기화에 실패했습니다: " + e.getMessage(),
                    HttpStatus.SERVICE_UNAVAILABLE);
        }
    }

    public String getEncodedApiKey() {
        return encodedApiKey;
    }

    public String getBaseUrl() {
        return baseUrl;
    }

    public String curlFetch(String url) throws Exception {
        ProcessBuilder pb = new ProcessBuilder("curl", "-s", "-H", "Accept: application/json", url);
        pb.redirectErrorStream(true);
        Process process = pb.start();
        try (BufferedReader reader = new BufferedReader(
                new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) sb.append(line);
            boolean finished = process.waitFor(30, TimeUnit.SECONDS);
            if (!finished) {
                process.destroyForcibly();
                throw new RuntimeException("API 호출 타임아웃");
            }
            String result = sb.toString();
            if (result.isBlank()) throw new RuntimeException("빈 응답");
            return result;
        }
    }

    private String formatOperatingHours(String begin, String end) {
        if (begin == null || end == null) return null;
        return formatTime(begin) + "-" + formatTime(end);
    }

    private String formatTime(String hhmmss) {
        if (hhmmss == null || hhmmss.length() < 4) return hhmmss;
        String clean = hhmmss.replace(":", "");
        if (clean.length() >= 4) return clean.substring(0, 2) + ":" + clean.substring(2, 4);
        return hhmmss;
    }

    private Double parseDouble(String value) {
        if (value == null || value.isBlank()) return null;
        try { return Double.parseDouble(value); }
        catch (NumberFormatException e) { return null; }
    }

    private int parseInt(String value) {
        if (value == null || value.isBlank()) return 0;
        try { return Integer.parseInt(value); }
        catch (NumberFormatException e) { return 0; }
    }
}
