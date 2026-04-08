package com.waitzero.domain.category.dto;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.waitzero.domain.category.entity.CivilServiceCategory;

import java.util.List;

public record CategoryResponse(
        Long id,
        String name,
        String description,
        List<String> requiredDocuments,
        Integer estimatedProcessMinutes
) {
    private static final ObjectMapper objectMapper = new ObjectMapper();

    public static CategoryResponse from(CivilServiceCategory category) {
        List<String> docs = parseDocuments(category.getRequiredDocuments());
        return new CategoryResponse(
                category.getId(),
                category.getName(),
                category.getDescription(),
                docs,
                category.getEstimatedProcessMinutes()
        );
    }

    private static List<String> parseDocuments(String json) {
        if (json == null || json.isBlank()) {
            return List.of();
        }
        try {
            return objectMapper.readValue(json, new TypeReference<>() {});
        } catch (Exception e) {
            return List.of();
        }
    }
}
