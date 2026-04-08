package com.waitzero.ai.controller;

import com.waitzero.ai.dto.AiClassifyRequest;
import com.waitzero.ai.dto.AiClassifyResponse;
import com.waitzero.ai.dto.AiSummarizeRequest;
import com.waitzero.ai.dto.AiSummarizeResponse;
import com.waitzero.ai.service.AiClassifyService;
import com.waitzero.global.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/ai")
@RequiredArgsConstructor
public class AiController {

    private final AiClassifyService aiClassifyService;

    @PostMapping("/classify")
    public ApiResponse<AiClassifyResponse> classify(@Valid @RequestBody AiClassifyRequest request) {
        return ApiResponse.ok(aiClassifyService.classify(request.text()));
    }

    @PostMapping("/summarize")
    public ApiResponse<AiSummarizeResponse> summarize(@Valid @RequestBody AiSummarizeRequest request) {
        return ApiResponse.ok(aiClassifyService.summarize(request.text()));
    }
}
