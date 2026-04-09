package com.waitzero.domain.auth.dto;

public record AuthResponse(
        String token,
        Long userId,
        String name,
        String phone
) {}
