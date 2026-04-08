package com.waitzero.ai.dto;

public record AiClassifyResponse(
        String category,
        double confidence,
        String summary
) {
}
