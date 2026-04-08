---
name: verify-integration
description: "WaitZero 통합 정합성 검증. Spring Boot API DTO ↔ Flutter Dart 모델 교차 비교, 엔드포인트 매핑 확인, Gradle 빌드 테스트를 수행한다. 'QA', '검증', '테스트', '정합성 확인', '빌드 확인' 요청 시 사용."
---

# WaitZero 통합 정합성 검증

백엔드(Spring Boot)와 프론트엔드(Flutter) 간 경계면을 교차 검증한다.

## 검증 항목

### 1. API DTO ↔ Dart Model 교차 비교

양쪽 코드를 **동시에** 읽고 비교한다:

1. `backend/` 하위 모든 DTO record의 필드명/타입 추출
2. `frontend/lib/core/models/` 하위 모든 Dart 모델의 필드명/타입 추출
3. 1:1 대조 → 불일치 항목 기록
4. 특히 확인:
   - camelCase 일관성 (Java record → JSON → Dart)
   - nullable 처리 (Java `@Nullable` ↔ Dart `?`)
   - 래핑 응답 (`ApiResponse<T>`) unwrap 여부

### 2. 엔드포인트 ↔ Repository 매핑

1. `@RequestMapping` / `@GetMapping` / `@PostMapping`에서 URL 패턴 추출
2. Flutter Repository 클래스의 Dio 호출 URL 추출
3. 1:1 매핑 확인 → 누락된 연결 식별

### 3. 화면 라우트 정합성

1. GoRouter 정의에서 경로 목록 추출
2. 코드 내 `context.go()`, `context.push()` 값 수집
3. 각 네비게이션이 실제 존재하는 라우트를 가리키는지 확인

### 4. 빌드 검증

- 백엔드: `cd backend && ./gradlew build` 실행
- 프론트: Flutter 프로젝트 `dart analyze` 실행 (가능한 경우)

### 5. 데이터 흐름 추적

DB Entity → DTO 변환 → JSON 응답 → Dart Model → UI 위젯까지 전체 흐름 추적:
- Entity 필드가 DTO에 누락되지 않았는지
- DTO 필드가 JSON 직렬화에서 의도대로 변환되는지
- Dart Model이 모든 필수 필드를 포함하는지

## 보고서 형식

`_workspace/05_qa_report.md`에 작성:

```markdown
# QA Report — WaitZero

## 검증 결과 요약
- PASS: N개
- FAIL: N개
- WARN: N개

## 상세

### [PASS/FAIL/WARN] 항목명
- 왼쪽: {파일경로:라인} — {내용}
- 오른쪽: {파일경로:라인} — {내용}
- 문제: {불일치 설명}
- 수정: {구체적 수정 방법}
```
