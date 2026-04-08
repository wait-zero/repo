package com.waitzero.ai.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.waitzero.ai.dto.AiClassifyResponse;
import com.waitzero.ai.dto.AiSummarizeResponse;
import com.waitzero.global.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class AiClassifyService {

    private final RestClient restClient;
    private final String model;
    private final ObjectMapper objectMapper;

    public AiClassifyService(
            @Value("${ai.claude.api-key}") String apiKey,
            @Value("${ai.claude.model}") String model,
            @Value("${ai.claude.base-url}") String baseUrl,
            ObjectMapper objectMapper) {
        this.model = model;
        this.objectMapper = objectMapper;
        this.restClient = RestClient.builder()
                .baseUrl(baseUrl)
                .defaultHeader("x-api-key", apiKey)
                .defaultHeader("anthropic-version", "2023-06-01")
                .defaultHeader("Content-Type", "application/json")
                .build();
    }

    public AiClassifyResponse classify(String text) {
        String systemPrompt = """
                당신은 민원 분류 전문가입니다. 사용자의 민원 내용을 분석하여 적절한 카테고리로 분류하세요.
                가능한 카테고리: 주민등록, 전입신고, 인감증명, 차량등록, 건축허가, 사업자등록, 기타
                반드시 아래 JSON 형식으로만 응답하세요:
                {"category": "카테고리명", "confidence": 0.0~1.0, "summary": "요약 내용"}
                """;

        String responseText = callClaudeApi(systemPrompt, text);
        return parseClassifyResponse(responseText);
    }

    public AiSummarizeResponse summarize(String text) {
        String systemPrompt = """
                당신은 민원 요약 전문가입니다. 사용자의 민원 내용을 간결하게 요약하세요.
                반드시 아래 JSON 형식으로만 응답하세요:
                {"summary": "요약 내용"}
                """;

        String responseText = callClaudeApi(systemPrompt, text);
        return parseSummarizeResponse(responseText);
    }

    private String callClaudeApi(String systemPrompt, String userText) {
        Map<String, Object> requestBody = Map.of(
                "model", model,
                "max_tokens", 1024,
                "system", systemPrompt,
                "messages", List.of(
                        Map.of("role", "user", "content", userText)
                )
        );

        try {
            String response = restClient.post()
                    .uri("/v1/messages")
                    .contentType(MediaType.APPLICATION_JSON)
                    .body(requestBody)
                    .retrieve()
                    .body(String.class);

            JsonNode root = objectMapper.readTree(response);
            return root.path("content").get(0).path("text").asText();
        } catch (Exception e) {
            log.error("Claude API 호출 실패", e);
            throw new CustomException("AI 서비스 호출에 실패했습니다.", HttpStatus.SERVICE_UNAVAILABLE);
        }
    }

    private AiClassifyResponse parseClassifyResponse(String text) {
        try {
            String json = extractJson(text);
            JsonNode node = objectMapper.readTree(json);
            return new AiClassifyResponse(
                    node.path("category").asText(),
                    node.path("confidence").asDouble(),
                    node.path("summary").asText()
            );
        } catch (Exception e) {
            log.warn("AI 응답 파싱 실패, 기본값 반환: {}", text);
            return new AiClassifyResponse("기타", 0.0, text);
        }
    }

    private AiSummarizeResponse parseSummarizeResponse(String text) {
        try {
            String json = extractJson(text);
            JsonNode node = objectMapper.readTree(json);
            return new AiSummarizeResponse(node.path("summary").asText());
        } catch (Exception e) {
            log.warn("AI 응답 파싱 실패, 원문 반환: {}", text);
            return new AiSummarizeResponse(text);
        }
    }

    private String extractJson(String text) {
        int start = text.indexOf('{');
        int end = text.lastIndexOf('}');
        if (start >= 0 && end > start) {
            return text.substring(start, end + 1);
        }
        return text;
    }
}
