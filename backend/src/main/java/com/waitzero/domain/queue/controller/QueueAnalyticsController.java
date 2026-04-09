package com.waitzero.domain.queue.controller;

import com.waitzero.domain.queue.dto.QueueTrendResponse;
import com.waitzero.domain.queue.service.QueueAnalyticsService;
import com.waitzero.global.response.ApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/queue-history")
@RequiredArgsConstructor
public class QueueAnalyticsController {

    private final QueueAnalyticsService queueAnalyticsService;

    @GetMapping("/{officeId}/trends")
    public ApiResponse<QueueTrendResponse> getTrends(@PathVariable Long officeId) {
        return ApiResponse.ok(queueAnalyticsService.getAverageTrendByOffice(officeId));
    }
}
