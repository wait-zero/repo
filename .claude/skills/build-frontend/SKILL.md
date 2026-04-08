---
name: build-frontend
description: "WaitZero Flutter 앱 구현. Dart/Flutter로 민원실 현황 대시보드, 지도, 선 정보 입력 폼, 음성 입력 UI를 구현한다. Riverpod 상태 관리, Dio API 연동, GoRouter 네비게이션. '프론트엔드 구현', 'Flutter', '앱 개발', 'UI 구현' 요청 시 사용."
---

# WaitZero Flutter 앱 구현

`_workspace/02_backend_api_spec.md`의 API 스펙을 기반으로 Flutter 앱을 구현한다.

## 구현 순서

### 1. 모델 계층
`lib/core/models/` — API 응답에 대응하는 Dart 모델:
- `freezed` + `json_serializable`로 immutable 모델 생성
- 필드명은 백엔드 API 스펙의 JSON 키와 정확히 일치
- camelCase 사용, 불일치 시 `@JsonKey(name: '...')` 매핑

### 2. Repository 계층
`lib/core/repositories/` — API 호출 추상화:
- `Dio` 인스턴스는 `lib/core/network/dio_client.dart`에서 싱글턴 관리
- 각 도메인별 Repository 클래스 (OfficeRepository, PreRegistrationRepository 등)
- `ApiResponse<T>` 래핑 파싱: `response.data['data']`에서 실제 데이터 추출
- 에러 처리: `DioException` catch → 사용자 친화적 메시지 변환

### 3. 상태 관리 (Riverpod)
`lib/features/{feature}/providers/`:
- `FutureProvider` — 단순 API 호출 결과
- `StateNotifierProvider` — 복잡한 상태 (폼 입력, 필터 등)
- `ref.watch()`로 자동 리빌드, `ref.invalidate()`로 수동 새로고침

### 4. 화면 구현
`lib/features/{feature}/screens/`:

| 화면 | 핵심 위젯 |
|------|----------|
| 홈 | 검색바 + 주변 민원실 카드 리스트 + 지도 토글 |
| 민원실 목록 | 필터 + 무한 스크롤 리스트 |
| 민원실 상세 | 실시간 대기 현황 카드 + 지도 + 선 정보 입력 버튼 |
| 선 정보 입력 | 다단계 Stepper (카테고리 → 상세 → 확인) |
| 음성 입력 | 마이크 버튼 + 실시간 텍스트 + 수정 필드 |
| 내 신청 | 신청 목록 카드 + 상태 뱃지 |

### 5. 공통 위젯
`lib/shared/widgets/`:
- `LoadingWidget` — Shimmer 효과
- `ErrorWidget` — 재시도 버튼 포함
- `EmptyWidget` — 빈 상태 안내
- `CongestionBadge` — 혼잡도 색상 뱃지 (여유/보통/혼잡)

### 6. 라우팅 (GoRouter)
`lib/core/router/app_router.dart`:
- 설계 문서의 화면 구조와 1:1 매칭
- 딥링크 지원
- 화면 전환 애니메이션

### 7. 테마
`lib/core/theme/`:
- Material Design 3 기반
- 혼잡도 색상 체계: 여유(green), 보통(orange), 혼잡(red)
- 한국어 폰트, 다크모드 지원

## 핵심 규칙
- API 모델 필드는 `_workspace/02_backend_api_spec.md`의 DTO와 **정확히** 일치해야 한다
- 모든 화면에 로딩/에러/빈 상태 처리 필수
- 하드코딩된 문자열은 별도 상수 파일로 분리
