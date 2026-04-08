# WaitZero — Technical Reference Document (TRD)

**프로젝트명:** WaitZero (웨이트제로)
**버전:** 1.0.0
**작성일:** 2026-04-08
**목적:** 프론트엔드(Flutter) 개발자가 백엔드 API와 통합하기 위한 기술 참조 문서

---

## 1. 프로젝트 개요

민원실 이용 현황 실시간 정보 서비스. 2026 전국 통합데이터 활용 공모전 출품작 (주제 6번).

### 핵심 기능
1. **실시간 민원 현황 확인** — 대기 인원, 예상 대기 시간, 혼잡도
2. **민원 업무 단축을 위한 선 정보 입력** — 방문 전 미리 민원 정보 입력
3. **AI 기반 음성 인식** — 음성으로 민원 내용 입력, 자동 분류/요약

---

## 2. 기술 스택

| 영역 | 기술 |
|------|------|
| Backend | Java 21 + Spring Boot 3.4.1 + Gradle (Kotlin DSL) |
| Database | MySQL 8.0 + JPA (Hibernate ORM) |
| Frontend | Flutter (모바일 앱) |
| AI | Claude API (Anthropic) — 민원 분류/요약 |
| 음성 인식 | Flutter speech_to_text 패키지 |
| 공공데이터 | 공공데이터포털 REST API |

---

## 3. 서버 환경

| 항목 | 값 |
|------|-----|
| 서버 | OCI (Oracle Cloud Infrastructure) — Ubuntu 24.04 LTS |
| 공인 IP | `134.185.104.136` |
| API Base URL | `http://134.185.104.136:8080` |
| API 포트 | 8080 |
| DB | MySQL 8.0 (서버 내 로컬 설치) |

---

## 4. 아키텍처

### 4-1. 모노레포 구조
```
waitzero/
├── backend/         # Spring Boot 프로젝트
├── frontend/        # Flutter 프로젝트
├── _workspace/      # 중간 산출물
├── docker-compose.yml
├── CLAUDE.md
├── TRD.md           # 이 문서
└── API_SPEC.md      # API 명세서
```

### 4-2. 백엔드 패키지 구조
```
com.waitzero/
├── WaitzeroApplication.java
├── global/
│   ├── config/          # CorsConfig, JpaConfig, DataInitializer
│   ├── entity/          # BaseTimeEntity (@MappedSuperclass)
│   ├── response/        # ApiResponse<T> (공통 응답 래퍼)
│   └── exception/       # GlobalExceptionHandler, CustomException
├── domain/
│   ├── office/          # 민원실 (Entity, Repository, Service, Controller, DTO)
│   ├── queue/           # 대기 현황
│   ├── category/        # 민원 카테고리
│   ├── registration/    # 선 정보 입력
│   └── user/            # 사용자
├── ai/                  # Claude API 연동 (분류/요약)
└── infra/
    └── publicdata/      # 공공데이터포털 연동
```

### 4-3. 공통 API 응답 형식

모든 API 응답은 `ApiResponse<T>`로 래핑된다:

```json
{
  "success": true,
  "data": { ... },
  "message": "요청이 처리되었습니다."
}
```

에러 시:
```json
{
  "success": false,
  "data": null,
  "message": "에러 메시지"
}
```

### 4-4. CORS 설정
- 모든 Origin 허용 (`*`)
- 허용 메서드: GET, POST, PUT, PATCH, DELETE, OPTIONS
- Max Age: 3600초

---

## 5. 데이터 모델 (ERD)

### 5-1. 테이블 관계
```
user (1) ──< (N) pre_registration
civil_service_office (1) ──< (N) pre_registration
civil_service_office (1) ──< (N) queue_status
civil_service_category (1) ──< (N) pre_registration
```

### 5-2. 테이블 상세

#### user
| 컬럼 | 타입 | 제약조건 | 설명 |
|------|------|---------|------|
| id | BIGINT | PK, AUTO_INCREMENT | 사용자 ID |
| name | VARCHAR(50) | NOT NULL | 이름 |
| phone | VARCHAR(20) | NOT NULL, UNIQUE | 전화번호 |
| created_at | DATETIME | NOT NULL | 생성일 |
| updated_at | DATETIME | NOT NULL | 수정일 |

#### civil_service_office
| 컬럼 | 타입 | 제약조건 | 설명 |
|------|------|---------|------|
| id | BIGINT | PK, AUTO_INCREMENT | 민원실 ID |
| name | VARCHAR(100) | NOT NULL | 민원실 이름 |
| address | VARCHAR(255) | NOT NULL | 주소 |
| detail_address | VARCHAR(255) | | 상세 주소 |
| latitude | DOUBLE | | 위도 |
| longitude | DOUBLE | | 경도 |
| phone | VARCHAR(20) | | 전화번호 |
| operating_hours | VARCHAR(100) | | 운영시간 |
| region_code | VARCHAR(10) | | 지역코드 |
| created_at | DATETIME | NOT NULL | 생성일 |
| updated_at | DATETIME | NOT NULL | 수정일 |

#### queue_status
| 컬럼 | 타입 | 제약조건 | 설명 |
|------|------|---------|------|
| id | BIGINT | PK, AUTO_INCREMENT | ID |
| office_id | BIGINT | FK, NOT NULL | 민원실 ID |
| waiting_count | INT | NOT NULL, DEFAULT 0 | 현재 대기 인원 |
| estimated_wait_minutes | INT | NOT NULL, DEFAULT 0 | 예상 대기 시간(분) |
| congestion_level | VARCHAR(10) | NOT NULL | 혼잡도 (LOW/MEDIUM/HIGH) |
| active_windows | INT | NOT NULL, DEFAULT 1 | 운영 창구 수 |
| updated_at | DATETIME | NOT NULL | 갱신 시각 |

#### civil_service_category
| 컬럼 | 타입 | 제약조건 | 설명 |
|------|------|---------|------|
| id | BIGINT | PK, AUTO_INCREMENT | 카테고리 ID |
| name | VARCHAR(50) | NOT NULL | 카테고리명 |
| description | VARCHAR(255) | | 설명 |
| required_documents | TEXT | | 필요 서류 (JSON 배열) |
| estimated_process_minutes | INT | | 예상 처리 시간(분) |

#### pre_registration
| 컬럼 | 타입 | 제약조건 | 설명 |
|------|------|---------|------|
| id | BIGINT | PK, AUTO_INCREMENT | 신청 ID |
| user_id | BIGINT | FK, NOT NULL | 사용자 ID |
| office_id | BIGINT | FK, NOT NULL | 민원실 ID |
| category_id | BIGINT | FK, NOT NULL | 카테고리 ID |
| content | TEXT | | 민원 내용 |
| voice_text | TEXT | | 음성 인식 원문 |
| ai_summary | TEXT | | AI 요약 |
| status | VARCHAR(20) | NOT NULL, DEFAULT 'PENDING' | 상태 |
| visit_date | DATE | NOT NULL | 방문 예정일 |
| visit_time | TIME | | 방문 예정 시간 |
| created_at | DATETIME | NOT NULL | 등록일 |
| updated_at | DATETIME | NOT NULL | 수정일 |

### 5-3. Enum 값

#### CongestionLevel (혼잡도)
| 값 | 설명 |
|----|------|
| `LOW` | 여유 |
| `MEDIUM` | 보통 |
| `HIGH` | 혼잡 |

#### RegistrationStatus (신청 상태)
| 값 | 설명 |
|----|------|
| `PENDING` | 대기 중 |
| `CONFIRMED` | 확인됨 |
| `COMPLETED` | 완료 |
| `CANCELLED` | 취소 |

---

## 6. 데모 데이터

앱 기동 시 `DataInitializer`에 의해 자동 삽입 (DB가 비어있을 때만).

### 민원실 5개
| ID | 이름 | 주소 | 위도 | 경도 | 전화 | 지역코드 |
|----|------|------|------|------|------|---------|
| 1 | 서울시청 민원실 | 서울특별시 중구 세종대로 110 | 37.5666 | 126.9784 | 02-120 | 11 |
| 2 | 강남구청 민원실 | 서울특별시 강남구 학동로 426 | 37.5172 | 127.0473 | 02-3423-5114 | 11 |
| 3 | 수원시청 민원실 | 경기도 수원시 팔달구 효원로 241 | 37.2636 | 127.0286 | 031-228-2114 | 41 |
| 4 | 부산시청 민원실 | 부산광역시 연제구 중앙대로 1001 | 35.1796 | 129.0756 | 051-120 | 26 |
| 5 | 대전시청 민원실 | 대전광역시 서구 둔산로 100 | 36.3504 | 127.3845 | 042-120 | 30 |

### 카테고리 7개
| ID | 이름 | 필요서류 | 예상 소요(분) |
|----|------|---------|-------------|
| 1 | 주민등록 | 신분증, 위임장(대리 시) | 10 |
| 2 | 전입신고 | 신분증, 임대차계약서 | 15 |
| 3 | 인감증명 | 신분증, 인감도장 | 10 |
| 4 | 차량등록 | 신분증, 자동차매매계약서, 자동차등록증 | 20 |
| 5 | 건축허가 | 신분증, 건축허가신청서, 설계도서 | 30 |
| 6 | 사업자등록 | 신분증, 사업자등록신청서, 임대차계약서 | 20 |
| 7 | 기타 | 신분증 | 15 |

### 대기 현황 5개
| 민원실 | 대기 인원 | 예상 대기(분) | 혼잡도 | 창구 수 |
|--------|----------|-------------|--------|---------|
| 서울시청 | 12 | 25 | MEDIUM | 3 |
| 강남구청 | 5 | 10 | LOW | 4 |
| 수원시청 | 20 | 40 | HIGH | 2 |
| 부산시청 | 8 | 15 | LOW | 5 |
| 대전시청 | 15 | 30 | MEDIUM | 3 |

### 데모 사용자 3명
| ID | 이름 | 전화번호 |
|----|------|---------|
| 1 | 홍길동 | 010-1234-5678 |
| 2 | 김철수 | 010-9876-5432 |
| 3 | 이영희 | 010-5555-1234 |
