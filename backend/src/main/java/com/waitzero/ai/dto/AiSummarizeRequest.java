package com.waitzero.ai.dto;

import jakarta.validation.constraints.NotBlank;

public record AiSummarizeRequest(
        @NotBlank(message = "요약할 텍스트는 필수입니다.")
        String text
) {
}
