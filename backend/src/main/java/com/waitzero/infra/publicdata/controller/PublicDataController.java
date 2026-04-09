package com.waitzero.infra.publicdata.controller;

import com.waitzero.global.response.ApiResponse;
import com.waitzero.infra.publicdata.dto.SyncResultResponse;
import com.waitzero.infra.publicdata.service.PublicDataSyncService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/admin/public-data")
@RequiredArgsConstructor
public class PublicDataController {

    private final PublicDataSyncService publicDataSyncService;

    @PostMapping("/sync")
    public ApiResponse<SyncResultResponse> sync() {
        return ApiResponse.ok(publicDataSyncService.syncOffices());
    }

    @PostMapping("/sync-realtime")
    public ApiResponse<SyncResultResponse> syncRealtime() {
        return ApiResponse.ok(publicDataSyncService.syncRealtimeStatus());
    }
}
