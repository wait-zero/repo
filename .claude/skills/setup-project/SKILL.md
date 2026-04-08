---
name: setup-project
description: "WaitZero 프로젝트 초기 설정. 아키텍처 설계, DB 스키마, API 설계, Flutter/Spring Boot 프로젝트 스캐폴딩을 수행한다. '프로젝트 설정', '초기 설정', '스캐폴딩', '아키텍처 설계' 요청 시 사용."
---

# WaitZero 프로젝트 초기 설정

프로젝트 구조, DB 스키마, API 설계를 정의하고 양쪽 프로젝트를 스캐폴딩한다.

## Step 1: 아키텍처 설계 문서 작성

`_workspace/00_architecture.md`에 다음을 정의한다:

### DB 스키마 (MySQL)
```
civil_service_office    — 민원실 정보 (id, name, address, lat, lng, phone, ...)
queue_status           — 실시간 대기 현황 (office_id, waiting_count, estimated_wait_min, congestion_level, updated_at)
civil_service_category — 민원 카테고리 (id, name, description, required_docs)
pre_registration       — 선 정보 입력 (id, user_id, office_id, category_id, content, voice_text, status, visit_date, ...)
user                   — 사용자 (id, name, phone, created_at)
```

### API 엔드포인트 설계
```
GET    /api/offices              — 민원실 목록 (검색, 필터)
GET    /api/offices/{id}         — 민원실 상세
GET    /api/offices/{id}/status  — 실시간 대기 현황
GET    /api/categories           — 민원 카테고리 목록
POST   /api/pre-registrations    — 선 정보 입력 등록
GET    /api/pre-registrations/{id} — 선 정보 조회
POST   /api/ai/classify          — AI 민원 분류
POST   /api/ai/summarize         — AI 민원 내용 요약
GET    /api/public-data/sync     — 공공데이터 동기화 (관리용)
```

### Flutter 화면 구조
```
/ (홈)                    — 검색 + 주변 민원실
/offices                  — 민원실 목록
/offices/:id              — 민원실 상세 + 실시간 현황
/pre-register             — 선 정보 입력 (다단계 폼)
/pre-register/voice       — 음성 입력
/my-registrations         — 내 신청 목록
```

## Step 2: Spring Boot 프로젝트 스캐폴딩

`backend/` 디렉토리에 Gradle + Spring Boot 프로젝트 생성:
- Java 23, Spring Boot 3.x
- 의존성: spring-boot-starter-web, spring-boot-starter-data-jpa, mysql-connector-j, lombok, spring-boot-starter-validation
- `application.yml` 기본 설정 (MySQL 연결, 서버 포트)
- 패키지 구조 생성

## Step 3: Flutter 프로젝트 스캐폴딩

`frontend/` 디렉토리에 Flutter 프로젝트 생성:
- `pubspec.yaml`에 핵심 의존성: dio, riverpod, go_router, speech_to_text, google_maps_flutter, freezed, json_serializable
- `lib/` 폴더 구조: features/, core/, shared/
- 기본 라우터 설정, 테마 설정
