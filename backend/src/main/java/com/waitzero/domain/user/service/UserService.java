package com.waitzero.domain.user.service;

import com.waitzero.domain.user.dto.UserResponse;
import com.waitzero.domain.user.entity.User;
import com.waitzero.domain.user.repository.UserRepository;
import com.waitzero.global.exception.ResourceNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class UserService {

    private final UserRepository userRepository;

    public UserResponse getUserById(Long id) {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("사용자", id));
        return UserResponse.from(user);
    }

    public UserResponse getUserByPhone(String phone) {
        User user = userRepository.findByPhone(phone)
                .orElseThrow(() -> new ResourceNotFoundException("사용자", 0L));
        return UserResponse.from(user);
    }
}
