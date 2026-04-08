package com.waitzero.infra.publicdata.dto;

public record SyncResultResponse(
        int totalFetched,
        int newlyCreated,
        int updated,
        String message
) {
}
