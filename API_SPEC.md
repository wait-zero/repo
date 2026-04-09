# WaitZero — API 명세서

**Base URL:** `http://134.185.104.136:8080`
**Content-Type:** `application/json`
**작성일:** 2026-04-08

---

## 공통 사항

### 응답 래퍼
모든 응답은 아래 형식으로 래핑된다:
```json
{
  "success": boolean,
  "data": T | null,
  "message": "string"
}
```

### 에러 응답
```json
{
  "success": false,
  "data": null,
  "message": "에러 내용"
}
```

### HTTP 상태 코드
| 코드 | 의미 |
|------|------|
| 200 | 성공 |
| 400 | 요청 검증 실패 (필수값 누락 등) |
| 401 | 인증 필요 (JWT 토큰 없음/만료) |
| 403 | 접근 권한 없음 |
| 404 | 리소스를 찾을 수 없음 |
| 500 | 서버 내부 오류 |

### 인증
JWT Bearer 토큰 인증을 사용한다. 보호된 엔드포인트에는 `Authorization: Bearer <token>` 헤더를 포함해야 한다.

**공개 엔드포인트 (인증 불필요):**
- `/api/auth/signup`, `/api/auth/login`
- `/api/offices/**`, `/api/categories/**`
- `/api/queue-status/**`, `/api/queue-history/**`
- `/api/admin/**`, `/api/ai/**`

**보호 엔드포인트 (JWT 필수):**
- `/api/pre-registrations/**`
- `/api/auth/me`

### 날짜/시간 형식
| 타입 | 형식 | 예시 |
|------|------|------|
| LocalDateTime | ISO 8601 | `2026-04-08T14:30:00` |
| LocalDate | ISO 8601 | `2026-04-10` |
| LocalTime | ISO 8601 | `14:00:00` |

---

## 0. 인증 API

### 0-1. 회원가입

```
POST /api/auth/signup
```

**요청 바디:**
```json
{
  "name": "홍길동",
  "phone": "010-1234-5678",
  "password": "1234"
}
```

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| name | String | O | 이름 |
| phone | String | O | 전화번호 (고유) |
| password | String | O | 비밀번호 |

**응답:**
```json
{
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzM4NCJ9...",
    "userId": 1,
    "name": "홍길동",
    "phone": "010-1234-5678"
  },
  "message": "회원가입이 완료되었습니다."
}
```

---

### 0-2. 로그인

```
POST /api/auth/login
```

**요청 바디:**
```json
{
  "phone": "010-1234-5678",
  "password": "1234"
}
```

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| phone | String | O | 전화번호 |
| password | String | O | 비밀번호 |

**응답:**
```json
{
  "success": true,
  "data": {
    "token": "eyJhbGciOiJIUzM4NCJ9...",
    "userId": 1,
    "name": "홍길동",
    "phone": "010-1234-5678"
  },
  "message": "로그인 성공"
}
```

---

### 0-3. 내 정보 조회

```
GET /api/auth/me
```

**헤더:** `Authorization: Bearer <token>` (필수)

**응답:**
```json
{
  "success": true,
  "data": {
    "token": null,
    "userId": 1,
    "name": "홍길동",
    "phone": "010-1234-5678"
  },
  "message": "요청이 처리되었습니다."
}
```

---

## 1. 민원실 API

### 1-1. 민원실 목록 조회

```
GET /api/offices
```

**Query Parameters:**
| 파라미터 | 타입 | 필수 | 설명 |
|---------|------|------|------|
| keyword | String | X | 검색어 (이름, 주소에서 검색) |
| region | String | X | 지역코드 필터 (예: "11") |

**응답:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "서울시청 민원실",
      "address": "서울특별시 중구 세종대로 110",
      "latitude": 37.5666,
      "longitude": 126.9784,
      "phone": "02-120",
      "operatingHours": "09:00-18:00"
    }
  ],
  "message": "요청이 처리되었습니다."
}
```

---

### 1-2. 민원실 상세 조회

```
GET /api/offices/{id}
```

**Path Parameters:**
| 파라미터 | 타입 | 설명 |
|---------|------|------|
| id | Long | 민원실 ID |

**응답:**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "name": "서울시청 민원실",
    "address": "서울특별시 중구 세종대로 110",
    "detailAddress": "1층 민원실",
    "latitude": 37.5666,
    "longitude": 126.9784,
    "phone": "02-120",
    "operatingHours": "09:00-18:00",
    "regionCode": "11",
    "queueStatus": {
      "officeId": 1,
      "waitingCount": 12,
      "estimatedWaitMinutes": 25,
      "congestionLevel": "MEDIUM",
      "activeWindows": 3,
      "updatedAt": "2026-04-08T14:30:00"
    }
  },
  "message": "요청이 처리되었습니다."
}
```

> `queueStatus`는 대기 현황이 없으면 `null`이 될 수 있다.

---

### 1-3. 민원실 실시간 대기 현황

```
GET /api/offices/{id}/status
```

**Path Parameters:**
| 파라미터 | 타입 | 설명 |
|---------|------|------|
| id | Long | 민원실 ID |

**응답:**
```json
{
  "success": true,
  "data": {
    "officeId": 1,
    "waitingCount": 12,
    "estimatedWaitMinutes": 25,
    "congestionLevel": "MEDIUM",
    "activeWindows": 3,
    "updatedAt": "2026-04-08T14:30:00"
  },
  "message": "요청이 처리되었습니다."
}
```

**congestionLevel 값:**
| 값 | 의미 | 권장 색상 |
|----|------|----------|
| `LOW` | 여유 | 초록 (#4CAF50) |
| `MEDIUM` | 보통 | 주황 (#FF9800) |
| `HIGH` | 혼잡 | 빨강 (#F44336) |

---

### 1-4. 주변 민원실 검색

```
GET /api/offices/nearby
```

**Query Parameters:**
| 파라미터 | 타입 | 필수 | 기본값 | 설명 |
|---------|------|------|--------|------|
| lat | double | O | - | 현재 위도 |
| lng | double | O | - | 현재 경도 |
| radius | double | X | 5 | 검색 반경 (km) |

**응답:** 민원실 목록 (OfficeResponse 배열), 거리순 정렬

```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "서울시청 민원실",
      "address": "서울특별시 중구 세종대로 110",
      "latitude": 37.5666,
      "longitude": 126.9784,
      "phone": "02-120",
      "operatingHours": "09:00-18:00"
    }
  ],
  "message": "요청이 처리되었습니다."
}
```

---

## 2. 대기 현황 API

### 2-1. 대기 현황 조회 (별도 엔드포인트)

```
GET /api/queue-status/{officeId}
```

**Path Parameters:**
| 파라미터 | 타입 | 설명 |
|---------|------|------|
| officeId | Long | 민원실 ID |

**응답:** QueueStatusResponse (1-3과 동일)

---

## 2-2. 대기 추세 분석

```
GET /api/queue-history/{officeId}/trends
```

**Path Parameters:**
| 파라미터 | 타입 | 설명 |
|---------|------|------|
| officeId | Long | 민원실 ID |

**응답:**
```json
{
  "success": true,
  "data": {
    "officeId": 1,
    "dataPoints": [
      {
        "dayOfWeek": 1,
        "dayLabel": "월",
        "hourOfDay": 9,
        "averageWaitingCount": 8.5
      },
      {
        "dayOfWeek": 1,
        "dayLabel": "월",
        "hourOfDay": 10,
        "averageWaitingCount": 18.2
      }
    ]
  },
  "message": "요청이 처리되었습니다."
}
```

| 필드 | 타입 | 설명 |
|------|------|------|
| dayOfWeek | int | 요일 (1=월 ~ 7=일, ISO) |
| dayLabel | String | 요일 한글 라벨 ("월"~"일") |
| hourOfDay | int | 시간 (0~23) |
| averageWaitingCount | double | 평균 대기인원 |

> 최근 4주 이력 데이터를 기반으로 요일/시간대별 평균 대기인원을 계산한다.

---

## 3. 카테고리 API

### 3-1. 카테고리 목록 조회

```
GET /api/categories
```

**응답:**
```json
{
  "success": true,
  "data": [
    {
      "id": 1,
      "name": "주민등록",
      "description": "주민등록 등·초본 발급, 주소 변경 등",
      "requiredDocuments": ["신분증", "위임장(대리 시)"],
      "estimatedProcessMinutes": 10
    }
  ],
  "message": "요청이 처리되었습니다."
}
```

---

### 3-2. 카테고리 상세 조회

```
GET /api/categories/{id}
```

**Path Parameters:**
| 파라미터 | 타입 | 설명 |
|---------|------|------|
| id | Long | 카테고리 ID |

**응답:** CategoryResponse (3-1과 동일 구조, 단일 객체)

---

## 4. 선 정보 입력 API

### 4-1. 선 정보 등록

```
POST /api/pre-registrations
```

**요청 바디:**
```json
{
  "userId": 1,
  "officeId": 1,
  "categoryId": 2,
  "content": "전입신고를 하려고 합니다.",
  "voiceText": "전입신고를 하려고 합니다 새 주소는...",
  "visitDate": "2026-04-10",
  "visitTime": "14:00"
}
```

**필수 필드:**
| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| userId | Long | O | 사용자 ID |
| officeId | Long | O | 민원실 ID |
| categoryId | Long | O | 카테고리 ID |
| content | String | X | 민원 내용 |
| voiceText | String | X | 음성 인식 원문 |
| visitDate | LocalDate | O | 방문 예정일 (YYYY-MM-DD) |
| visitTime | LocalTime | X | 방문 예정 시간 (HH:mm) |

**응답:**
```json
{
  "success": true,
  "data": {
    "id": 1,
    "userId": 1,
    "officeId": 1,
    "officeName": "서울시청 민원실",
    "categoryId": 2,
    "categoryName": "전입신고",
    "content": "전입신고를 하려고 합니다.",
    "voiceText": "전입신고를 하려고 합니다 새 주소는...",
    "aiSummary": null,
    "status": "PENDING",
    "visitDate": "2026-04-10",
    "visitTime": "14:00:00",
    "createdAt": "2026-04-08T14:30:00"
  },
  "message": "요청이 처리되었습니다."
}
```

---

### 4-2. 선 정보 조회

```
GET /api/pre-registrations/{id}
```

**Path Parameters:**
| 파라미터 | 타입 | 설명 |
|---------|------|------|
| id | Long | 신청 ID |

**응답:** PreRegistrationResponse (4-1 응답과 동일 구조)

---

### 4-3. 사용자별 선 정보 목록

```
GET /api/pre-registrations/user/{userId}
```

**Path Parameters:**
| 파라미터 | 타입 | 설명 |
|---------|------|------|
| userId | Long | 사용자 ID |

**응답:** PreRegistrationResponse 배열 (최신순 정렬)

---

### 4-3b. 내 선 정보 목록 (JWT 인증)

```
GET /api/pre-registrations/me
```

**헤더:** `Authorization: Bearer <token>` (필수)

**응답:** PreRegistrationResponse 배열 (JWT 토큰의 userId 기반)

> 4-3과 동일한 응답 형식. JWT에서 userId를 자동 추출하므로 Path Parameter 불필요.

---

### 4-4. 선 정보 상태 변경

```
PATCH /api/pre-registrations/{id}/status
```

**Path Parameters:**
| 파라미터 | 타입 | 설명 |
|---------|------|------|
| id | Long | 신청 ID |

**요청 바디:**
```json
{
  "status": "CONFIRMED"
}
```

**status 허용 값:** `PENDING`, `CONFIRMED`, `COMPLETED`, `CANCELLED`

**응답:** PreRegistrationResponse (업데이트된 상태 반영)

---

## 5. AI API

### 5-1. 민원 분류

```
POST /api/ai/classify
```

**요청 바디:**
```json
{
  "text": "주민등록등본을 발급받고 싶어요"
}
```

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| text | String | O | 분류할 텍스트 (음성 인식 결과 등) |

**응답:**
```json
{
  "success": true,
  "data": {
    "category": "주민등록",
    "confidence": 0.95,
    "summary": "주민등록등본 발급 요청"
  },
  "message": "요청이 처리되었습니다."
}
```

| 필드 | 타입 | 설명 |
|------|------|------|
| category | String | 분류된 카테고리명 |
| confidence | double | 신뢰도 (0.0 ~ 1.0) |
| summary | String | 민원 내용 요약 |

> Claude API 키가 미설정이면 에러 응답 반환. 프론트에서 폴백 처리 필요.

---

### 5-2. 민원 요약

```
POST /api/ai/summarize
```

**요청 바디:**
```json
{
  "text": "어 저기요 제가 이사를 해서 전입신고를 해야 하는데요 새 주소는 서울시 강남구..."
}
```

| 필드 | 타입 | 필수 | 설명 |
|------|------|------|------|
| text | String | O | 요약할 텍스트 |

**응답:**
```json
{
  "success": true,
  "data": {
    "summary": "전입신고 요청. 이사로 인한 주소지 변경 (서울시 강남구)."
  },
  "message": "요청이 처리되었습니다."
}
```

---

## 6. 공공데이터 동기화 API (관리용)

### 6-1. 공공데이터 동기화

```
POST /api/admin/public-data/sync
```

**요청 바디:** 없음

**응답:**
```json
{
  "success": true,
  "data": {
    "totalFetched": 50,
    "newlyCreated": 45,
    "updated": 5,
    "message": "동기화가 완료되었습니다."
  },
  "message": "요청이 처리되었습니다."
}
```

> 공공데이터 API 키가 미설정이면 에러 응답. 데모에서는 DataInitializer의 더미 데이터를 사용.

---

## 7. Flutter 연동 가이드

### 7-1. Dart 모델 매핑 참조

모든 API 응답의 JSON 키는 **camelCase**이다. Dart 모델에서 `json_serializable` 사용 시 별도 `@JsonKey` 매핑 불필요.

#### 공통 래퍼
```dart
class ApiResponse<T> {
  final bool success;
  final T? data;
  final String message;
}
```

#### OfficeResponse → Office 모델
```dart
class Office {
  final int id;
  final String name;
  final String address;
  final double? latitude;
  final double? longitude;
  final String? phone;
  final String? operatingHours;
}
```

#### OfficeDetailResponse → OfficeDetail 모델
```dart
class OfficeDetail {
  final int id;
  final String name;
  final String address;
  final String? detailAddress;
  final double? latitude;
  final double? longitude;
  final String? phone;
  final String? operatingHours;
  final String? regionCode;
  final QueueStatus? queueStatus;  // null 가능
}
```

#### QueueStatusResponse → QueueStatus 모델
```dart
class QueueStatus {
  final int officeId;
  final int waitingCount;
  final int estimatedWaitMinutes;
  final String congestionLevel;    // "LOW" | "MEDIUM" | "HIGH"
  final int activeWindows;
  final DateTime updatedAt;
}
```

#### CategoryResponse → Category 모델
```dart
class Category {
  final int id;
  final String name;
  final String? description;
  final List<String> requiredDocuments;
  final int? estimatedProcessMinutes;
}
```

#### PreRegistrationResponse → PreRegistration 모델
```dart
class PreRegistration {
  final int id;
  final int userId;
  final int officeId;
  final String officeName;
  final int categoryId;
  final String categoryName;
  final String? content;
  final String? voiceText;
  final String? aiSummary;
  final String status;             // "PENDING" | "CONFIRMED" | "COMPLETED" | "CANCELLED"
  final DateTime visitDate;        // date only
  final String? visitTime;         // "HH:mm:ss" or null
  final DateTime createdAt;
}
```

#### AiClassifyResponse → AiClassifyResult 모델
```dart
class AiClassifyResult {
  final String category;
  final double confidence;
  final String summary;
}
```

#### AiSummarizeResponse → AiSummarizeResult 모델
```dart
class AiSummarizeResult {
  final String summary;
}
```

#### AuthResponse → AuthResult 모델
```dart
class AuthResult {
  final String? token;
  final int userId;
  final String name;
  final String phone;
}
```

#### QueueTrendResponse → QueueTrend 모델
```dart
class QueueTrend {
  final int officeId;
  final List<TrendDataPoint> dataPoints;
}

class TrendDataPoint {
  final int dayOfWeek;
  final String dayLabel;
  final int hourOfDay;
  final double averageWaitingCount;
}
```

### 7-2. API 호출 시 주의사항

1. **응답 unwrap**: 모든 응답에서 `response['data']`를 꺼내서 모델로 변환한다
2. **에러 처리**: `success == false`일 때 `message`를 사용자에게 표시
3. **nullable 필드**: `detailAddress`, `queueStatus`, `voiceText`, `aiSummary`, `visitTime`은 null 가능
4. **날짜 형식**: `visitDate`는 `YYYY-MM-DD`, `visitTime`은 `HH:mm` 형식으로 전송
5. **AI API 폴백**: Claude API 미설정 시 에러 반환되므로, 프론트에서 수동 카테고리 선택으로 전환
