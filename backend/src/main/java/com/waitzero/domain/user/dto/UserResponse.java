package com.waitzero.domain.user.dto;

import com.waitzero.domain.user.entity.User;

import java.time.LocalDateTime;

public record UserResponse(
        Long id,
        String name,
        String phone,
        LocalDateTime createdAt
) {
    public static UserResponse from(User user) {
        return new UserResponse(
                user.getId(),
                user.getName(),
                user.getPhone(),
                user.getCreatedAt()
        );
    }
}
