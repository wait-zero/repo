package com.waitzero.domain.office.controller;

import com.waitzero.domain.office.dto.OfficeDetailResponse;
import com.waitzero.domain.office.dto.OfficeResponse;
import com.waitzero.domain.office.service.OfficeService;
import com.waitzero.domain.queue.dto.QueueStatusResponse;
import com.waitzero.domain.queue.service.QueueStatusService;
import com.waitzero.global.response.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/offices")
@RequiredArgsConstructor
public class OfficeController {

    private final OfficeService officeService;
    private final QueueStatusService queueStatusService;

    @GetMapping
    public ApiResponse<List<OfficeResponse>> getOffices(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String region) {
        return ApiResponse.ok(officeService.searchOffices(keyword, region));
    }

    @GetMapping("/{id}")
    public ApiResponse<OfficeDetailResponse> getOfficeDetail(@PathVariable Long id) {
        return ApiResponse.ok(officeService.getOfficeDetail(id));
    }

    @GetMapping("/{id}/status")
    public ApiResponse<QueueStatusResponse> getOfficeStatus(@PathVariable Long id) {
        return ApiResponse.ok(queueStatusService.getStatusByOfficeId(id));
    }

    @GetMapping("/nearby")
    public ApiResponse<List<OfficeResponse>> getNearbyOffices(
            @RequestParam double lat,
            @RequestParam double lng,
            @RequestParam(defaultValue = "5") double radius) {
        return ApiResponse.ok(officeService.getNearbyOffices(lat, lng, radius));
    }
}
