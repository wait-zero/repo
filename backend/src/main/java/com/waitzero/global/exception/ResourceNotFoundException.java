package com.waitzero.global.exception;

import org.springframework.http.HttpStatus;

public class ResourceNotFoundException extends CustomException {

    public ResourceNotFoundException(String resource, Long id) {
        super(resource + "을(를) 찾을 수 없습니다. ID: " + id, HttpStatus.NOT_FOUND);
    }
}
