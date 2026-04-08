---
name: build-backend
description: "WaitZero Spring Boot 백엔드 구현. Java 23 + Spring Boot + Gradle + MySQL/JPA 기반 REST API를 구현한다. Entity, Repository, Service, Controller, DTO 계층을 생성하고 공공데이터포털 API를 연동한다. '백엔드 구현', 'API 개발', 'Spring Boot', '서버 개발' 요청 시 사용."
---

# WaitZero 백엔드 구현

`_workspace/00_architecture.md`의 설계를 기반으로 Spring Boot REST API를 구현한다.

## 구현 순서

### 1. Entity 계층
`com.waitzero.domain.entity` 패키지에 JPA 엔티티 생성:
- `@Entity`, `@Table(name = "...")` 명시
- `@Id @GeneratedValue(strategy = GenerationType.IDENTITY)` 사용
- 관계 매핑: `@ManyToOne`, `@OneToMany` (fetch = LAZY 기본)
- `@CreatedDate`, `@LastModifiedDate`로 감사 필드 자동 관리
- Lombok `@Getter`, `@NoArgsConstructor(access = PROTECTED)`, `@Builder` 사용

### 2. Repository 계층
`com.waitzero.domain.repository` 패키지:
- `JpaRepository<Entity, Long>` 상속
- 커스텀 쿼리는 `@Query` 또는 메서드 이름 규칙 활용
- 검색: `findByNameContaining`, `findByAddressContaining` 등

### 3. DTO 계층
`com.waitzero.api.dto` 패키지:
- 요청 DTO: Java record 사용 + `@Valid` 검증 어노테이션
- 응답 DTO: Java record 사용
- Entity ↔ DTO 변환 메서드는 DTO 내부 `from(Entity)` 정적 팩토리

### 4. Service 계층
`com.waitzero.domain.service` 패키지:
- `@Service`, `@Transactional(readOnly = true)` 기본
- 쓰기 메서드만 `@Transactional`
- 비즈니스 로직 집중, Controller는 얇게

### 5. Controller 계층
`com.waitzero.api.controller` 패키지:
- `@RestController`, `@RequestMapping("/api/...")`
- 응답 래핑: `ApiResponse<T>` 공통 래퍼
- 입력 검증: `@Valid @RequestBody`

### 6. 공공데이터포털 연동
`com.waitzero.infra.publicdata` 패키지:
- RestClient로 공공데이터 API 호출
- 응답 파싱 후 DB 저장 (배치 또는 요청 시)
- API 키는 `application.yml`의 `${PUBLIC_DATA_API_KEY}`
- 호출 실패 시 더미 데이터 폴백

### 7. 전역 에러 처리
```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(EntityNotFoundException.class) → 404
    @ExceptionHandler(MethodArgumentNotValidException.class) → 400
    @ExceptionHandler(Exception.class) → 500
}
```

### 8. API 스펙 문서화
구현 완료 후 `_workspace/02_backend_api_spec.md`에 문서화:
- 각 엔드포인트의 URL, HTTP 메서드, 요청/응답 DTO 필드 목록
- 이 문서는 frontend-dev가 Flutter 모델을 생성할 때 사용

## 공통 응답 형식
```java
public record ApiResponse<T>(boolean success, T data, String message) {
    public static <T> ApiResponse<T> ok(T data) { ... }
    public static <T> ApiResponse<T> error(String message) { ... }
}
```
