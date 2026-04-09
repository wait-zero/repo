package com.waitzero.domain.auth.service;

import com.waitzero.domain.auth.dto.AuthResponse;
import com.waitzero.domain.auth.dto.LoginRequest;
import com.waitzero.domain.auth.dto.SignupRequest;
import com.waitzero.domain.user.entity.User;
import com.waitzero.domain.user.repository.UserRepository;
import com.waitzero.global.exception.CustomException;
import com.waitzero.global.exception.ResourceNotFoundException;
import com.waitzero.global.security.JwtProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtProvider jwtProvider;

    @Transactional
    public AuthResponse signup(SignupRequest request) {
        if (userRepository.findByPhone(request.phone()).isPresent()) {
            throw new CustomException("이미 등록된 전화번호입니다: " + request.phone());
        }

        User user = User.builder()
                .name(request.name())
                .phone(request.phone())
                .password(passwordEncoder.encode(request.password()))
                .build();

        User saved = userRepository.save(user);
        String token = jwtProvider.generateToken(saved.getId(), saved.getPhone());

        return new AuthResponse(token, saved.getId(), saved.getName(), saved.getPhone());
    }

    public AuthResponse login(LoginRequest request) {
        User user = userRepository.findByPhone(request.phone())
                .orElseThrow(() -> new CustomException("등록되지 않은 전화번호입니다."));

        if (!passwordEncoder.matches(request.password(), user.getPassword())) {
            throw new CustomException("비밀번호가 일치하지 않습니다.");
        }

        String token = jwtProvider.generateToken(user.getId(), user.getPhone());
        return new AuthResponse(token, user.getId(), user.getName(), user.getPhone());
    }

    public AuthResponse getMe(Long userId) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new ResourceNotFoundException("사용자", userId));
        return new AuthResponse(null, user.getId(), user.getName(), user.getPhone());
    }
}
