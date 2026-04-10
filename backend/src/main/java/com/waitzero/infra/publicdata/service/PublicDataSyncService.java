package com.waitzero.infra.publicdata.service;

import com.waitzero.domain.office.entity.CivilServiceOffice;
import com.waitzero.domain.office.repository.OfficeRepository;
import com.waitzero.domain.queue.entity.CongestionLevel;
import com.waitzero.domain.queue.entity.QueueStatus;
import com.waitzero.domain.queue.repository.QueueStatusRepository;
import com.waitzero.infra.publicdata.client.PublicDataClient;
import com.waitzero.infra.publicdata.dto.CsoInfoItem;
import com.waitzero.infra.publicdata.dto.CsoRealtimeItem;
import com.waitzero.infra.publicdata.dto.SyncResultResponse;
import com.waitzero.infra.publicdata.entity.SupportedRegion;
import com.waitzero.infra.publicdata.repository.SupportedRegionRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 공공데이터 동기화 서비스 — 지원 지자체를 순회하며 기본정보/실시간 현황을 DB에 적재.
 *
 * 주의: 실시간 현황 DB 저장은 "초기 부트스트랩" 용도로만 유지되며,
 *       운영 중에는 {@link RealtimeStatusService}가 캐시 기반으로 직접 조회한다.
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class PublicDataSyncService {

    private final OfficeRepository officeRepository;
    private final QueueStatusRepository queueStatusRepository;
    private final SupportedRegionRepository supportedRegionRepository;
    private final PublicDataClient publicDataClient;

    @Transactional
    public SyncResultResponse syncOffices() {
        log.info("민원실 기본정보 동기화 시작");
        List<SupportedRegion> regions = supportedRegionRepository.findAllByEnabledTrue();
        int total = 0, newCount = 0, updateCount = 0;

        for (SupportedRegion region : regions) {
            List<CsoInfoItem> items = publicDataClient.fetchOfficeInfoByRegion(region.getStdgCd());
            for (CsoInfoItem item : items) {
                if (item.csoSn() == null || item.csoSn().isBlank()) continue;
                total++;

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
        }

        log.info("민원실 기본정보 동기화 완료: 총 {}건, 신규 {}건, 갱신 {}건", total, newCount, updateCount);
        return new SyncResultResponse(total, newCount, updateCount,
                "민원실 기본정보 동기화가 완료되었습니다.");
    }

    @Transactional
    public SyncResultResponse syncRealtimeStatus() {
        log.info("실시간 대기현황 동기화 시작 (지원 지역 순회)");
        List<SupportedRegion> regions = supportedRegionRepository.findAllByEnabledTrue();
        int total = 0, newCount = 0, updateCount = 0;

        for (SupportedRegion region : regions) {
            List<CsoRealtimeItem> items = publicDataClient.fetchRealtimeByRegion(region.getStdgCd());
            for (CsoRealtimeItem item : items) {
                if (item.csoSn() == null || item.csoSn().isBlank()) continue;
                total++;

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
                            .congestionLevel(computeCongestion(waiting))
                            .activeWindows(item.clotCnterNo() != null && !item.clotCnterNo().isBlank() ? 1 : 0)
                            .callNumber(item.clotNo())
                            .callCounterNo(item.clotCnterNo())
                            .dataTimestamp(item.totDt())
                            .build());
                    newCount++;
                }
            }
        }

        log.info("실시간 대기현황 동기화 완료: 총 {}건, 신규 {}건, 갱신 {}건", total, newCount, updateCount);
        return new SyncResultResponse(total, newCount, updateCount,
                "실시간 대기현황 동기화가 완료되었습니다.");
    }

    private CongestionLevel computeCongestion(int waiting) {
        if (waiting < 3) return CongestionLevel.LOW;
        if (waiting < 10) return CongestionLevel.MEDIUM;
        return CongestionLevel.HIGH;
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
