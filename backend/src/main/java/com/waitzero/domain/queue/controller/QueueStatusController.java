package com.waitzero.domain.queue.controller;

import com.waitzero.domain.queue.dto.QueueStatusResponse;
import com.waitzero.domain.queue.service.QueueStatusService;
import com.waitzero.global.response.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/queue-status")
@RequiredArgsConstructor
public class QueueStatusController {

    private final QueueStatusService queueStatusService;

    @GetMapping("/{officeId}")
    public ApiResponse<QueueStatusResponse> getStatus(@PathVariable Long officeId) {
        return ApiResponse.ok(queueStatusService.getStatusByOfficeId(officeId));
    }
}
