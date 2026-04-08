package com.waitzero.ai.dto;

import jakarta.validation.constraints.NotBlank;

public record AiClassifyRequest(
        @NotBlank(message = "분류할 텍스트는 필수입니다.")
        String text
) {
}
