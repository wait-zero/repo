package com.waitzero.domain.registration.controller;

import com.waitzero.domain.registration.dto.PreRegistrationRequest;
import com.waitzero.domain.registration.dto.PreRegistrationResponse;
import com.waitzero.domain.registration.dto.StatusUpdateRequest;
import com.waitzero.domain.registration.service.PreRegistrationService;
import com.waitzero.global.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/pre-registrations")
@RequiredArgsConstructor
public class PreRegistrationController {

    private final PreRegistrationService preRegistrationService;

    @PostMapping
    public ApiResponse<PreRegistrationResponse> create(@Valid @RequestBody PreRegistrationRequest request) {
        return ApiResponse.ok(preRegistrationService.create(request));
    }

    @GetMapping("/{id}")
    public ApiResponse<PreRegistrationResponse> getById(@PathVariable Long id) {
        return ApiResponse.ok(preRegistrationService.getById(id));
    }

    @GetMapping("/user/{userId}")
    public ApiResponse<List<PreRegistrationResponse>> getByUserId(@PathVariable Long userId) {
        return ApiResponse.ok(preRegistrationService.getByUserId(userId));
    }

    @GetMapping("/me")
    public ApiResponse<List<PreRegistrationResponse>> getMyRegistrations(Authentication authentication) {
        Long userId = (Long) authentication.getPrincipal();
        return ApiResponse.ok(preRegistrationService.getByUserId(userId));
    }

    @PatchMapping("/{id}/status")
    public ApiResponse<PreRegistrationResponse> updateStatus(
            @PathVariable Long id,
            @Valid @RequestBody StatusUpdateRequest request) {
        return ApiResponse.ok(preRegistrationService.updateStatus(id, request));
    }
}
