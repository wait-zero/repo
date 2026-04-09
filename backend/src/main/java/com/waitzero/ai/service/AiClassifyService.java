package com.waitzero.ai.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.waitzero.ai.dto.AiClassifyResponse;
import com.waitzero.ai.dto.AiSummarizeResponse;
import com.waitzero.global.exception.CustomException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class AiClassifyService {

    private final ChatClient chatClient;
    private final ObjectMapper objectMapper;

    private static final String CLASSIFY_SYSTEM_PROMPT = """
            당신은 한국 관공서 민원 분류 전문가입니다.
            사용자가 설명하는 민원 내용을 아래 카테고리 중 하나로 분류하세요:
            [주민등록, 전입신고, 인감증명, 차량등록, 건축허가, 사업자등록, 기타]
            반드시 아래 JSON 형식으로만 응답하세요:
            {"category": "카테고리명", "confidence": 0.0~1.0, "summary": "요약 내용"}
            """;

    private static final String SUMMARIZE_SYSTEM_PROMPT = """
            당신은 민원 요약 전문가입니다. 사용자의 민원 내용을 간결하게 요약하세요.
            반드시 아래 JSON 형식으로만 응답하세요:
            {"summary": "요약 내용"}
            """;

    public AiClassifyService(ChatClient.Builder chatClientBuilder, ObjectMapper objectMapper) {
        this.chatClient = chatClientBuilder.build();
        this.objectMapper = objectMapper;
    }

    public AiClassifyResponse classify(String text) {
        try {
            String response = chatClient.prompt()
                    .system(CLASSIFY_SYSTEM_PROMPT)
                    .user(text)
                    .call()
                    .content();

            return parseClassifyResponse(response);
        } catch (Exception e) {
            log.error("OpenAI API 호출 실패", e);
            throw new CustomException("AI 서비스 호출에 실패했습니다.", HttpStatus.SERVICE_UNAVAILABLE);
        }
    }

    public AiSummarizeResponse summarize(String text) {
        try {
            String response = chatClient.prompt()
                    .system(SUMMARIZE_SYSTEM_PROMPT)
                    .user(text)
                    .call()
                    .content();

            return parseSummarizeResponse(response);
        } catch (Exception e) {
            log.error("OpenAI API 호출 실패", e);
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
