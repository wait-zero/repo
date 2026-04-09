package com.waitzero.domain.auth.controller;

import com.waitzero.domain.auth.dto.AuthResponse;
import com.waitzero.domain.auth.dto.LoginRequest;
import com.waitzero.domain.auth.dto.SignupRequest;
import com.waitzero.domain.auth.service.AuthService;
import com.waitzero.global.response.ApiResponse;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;

    @PostMapping("/signup")
    public ApiResponse<AuthResponse> signup(@Valid @RequestBody SignupRequest request) {
        return ApiResponse.ok(authService.signup(request), "회원가입이 완료되었습니다.");
    }

    @PostMapping("/login")
    public ApiResponse<AuthResponse> login(@Valid @RequestBody LoginRequest request) {
        return ApiResponse.ok(authService.login(request), "로그인 성공");
    }

    @GetMapping("/me")
    public ApiResponse<AuthResponse> getMe(Authentication authentication) {
        Long userId = (Long) authentication.getPrincipal();
        return ApiResponse.ok(authService.getMe(userId));
    }
}
