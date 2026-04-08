---
name: waitzero-build
description: "WaitZero 프로젝트 빌드 오케스트레이터. Flutter 앱 + Spring Boot 백엔드 + AI 음성 기능의 전체 개발 워크플로우를 조율한다. '프로젝트 빌드', '개발 시작', '구현 시작', '전체 개발', 'WaitZero 만들어줘', '앱 만들어줘', '민원 서비스 개발' 요청 시 사용. 후속 작업: '다시 빌드', '수정', '보완', '업데이트', '백엔드만 다시', '프론트만 다시', 'AI 기능 추가', '결과 개선' 요청 시에도 반드시 이 스킬을 사용."
---

# WaitZero Build Orchestrator

WaitZero 프로젝트의 전체 빌드 파이프라인을 조율하는 오케스트레이터.

## 실행 모드: 서브 에이전트

## 에이전트 구성

| 에이전트 | subagent_type | 역할 | 스킬 | 출력 |
|---------|--------------|------|------|------|
| setup | general-purpose | 프로젝트 설계/스캐폴딩 | setup-project | `_workspace/00_architecture.md`, 프로젝트 구조 |
| backend-dev | backend-dev | Spring Boot API 구현 | build-backend | `backend/`, `_workspace/02_backend_api_spec.md` |
| frontend-dev | frontend-dev | Flutter 앱 구현 | build-frontend | `frontend/` |
| ai-voice-dev | ai-voice-dev | AI/음성 기능 | build-ai-voice | 백엔드+프론트에 AI 코드 추가 |
| qa-inspector | qa-inspector | 통합 검증 | verify-integration | `_workspace/05_qa_report.md` |

## 워크플로우

### Phase 0: 컨텍스트 확인

1. `_workspace/` 디렉토리 존재 여부 확인
2. 실행 모드 결정:
   - **`_workspace/` 미존재** → 초기 실행. Phase 1로 진행
   - **`_workspace/` 존재 + 사용자가 부분 수정 요청** → 부분 재실행. 해당 에이전트만 재호출
   - **`_workspace/` 존재 + 새 입력 제공** → 새 실행. 기존 `_workspace/`를 `_workspace_{YYYYMMDD_HHMMSS}/`로 이동
3. 부분 재실행 시: 이전 산출물 경로를 에이전트 프롬프트에 포함

### Phase 1: 프로젝트 설계 및 스캐폴딩

```
Agent(
  description: "프로젝트 설계 및 스캐폴딩",
  subagent_type: "general-purpose",
  model: "opus",
  prompt: "Skill 도구로 /setup-project를 호출하여 WaitZero 프로젝트를 설계하고 스캐폴딩하라.
           작업 디렉토리: {project_root}
           _workspace/ 디렉토리를 생성하고 00_architecture.md를 작성하라.
           Spring Boot(Java 23 + Gradle) 프로젝트를 backend/에,
           Flutter 프로젝트를 frontend/에 스캐폴딩하라."
)
```

산출물 확인:
- `_workspace/00_architecture.md` 존재 여부
- `backend/build.gradle` 존재 여부
- `frontend/pubspec.yaml` 존재 여부

### Phase 2: 백엔드 API 구현

```
Agent(
  description: "백엔드 API 구현",
  subagent_type: "backend-dev",
  model: "opus",
  prompt: "Skill 도구로 /build-backend를 호출하여 WaitZero 백엔드를 구현하라.
           설계 문서: _workspace/00_architecture.md를 읽고 따르라.
           구현 완료 후 _workspace/02_backend_api_spec.md에 API 스펙을 문서화하라.
           작업 디렉토리: {project_root}/backend/"
)
```

산출물 확인:
- `_workspace/02_backend_api_spec.md` 존재 및 내용 확인
- `backend/src/main/java/com/waitzero/` 하위 파일 존재

### Phase 3: Flutter 앱 구현

```
Agent(
  description: "Flutter 앱 구현",
  subagent_type: "frontend-dev",
  model: "opus",
  prompt: "Skill 도구로 /build-frontend를 호출하여 WaitZero Flutter 앱을 구현하라.
           설계 문서: _workspace/00_architecture.md
           API 스펙: _workspace/02_backend_api_spec.md를 읽고, DTO shape과 정확히 일치하는 Dart 모델을 생성하라.
           작업 디렉토리: {project_root}/frontend/"
)
```

산출물 확인:
- `frontend/lib/` 하위 파일 존재
- GoRouter 경로가 설계 문서와 일치

### Phase 4: AI/음성 기능 구현

```
Agent(
  description: "AI/음성 기능 구현",
  subagent_type: "ai-voice-dev",
  model: "opus",
  prompt: "Skill 도구로 /build-ai-voice를 호출하여 AI/음성 기능을 구현하라.
           설계 문서: _workspace/00_architecture.md
           API 스펙: _workspace/02_backend_api_spec.md
           백엔드({project_root}/backend/)에 Claude API 연동 코드를 추가하고,
           프론트({project_root}/frontend/)에 음성 입력 기능을 추가하라."
)
```

산출물 확인:
- 백엔드 AI Controller/Service 존재
- 프론트 voice 관련 위젯 존재

### Phase 5: QA 통합 검증

```
Agent(
  description: "통합 정합성 검증",
  subagent_type: "qa-inspector",
  model: "opus",
  prompt: "Skill 도구로 /verify-integration을 호출하여 WaitZero 프로젝트를 검증하라.
           backend/와 frontend/ 양쪽을 동시에 읽고 교차 비교하라.
           결과를 _workspace/05_qa_report.md에 작성하라."
)
```

### Phase 6: QA 결과 반영

1. `_workspace/05_qa_report.md`를 Read
2. FAIL 항목이 있으면:
   - 백엔드 FAIL → backend-dev 재호출 (FAIL 항목만 수정 지시)
   - 프론트 FAIL → frontend-dev 재호출 (FAIL 항목만 수정 지시)
   - 양쪽 FAIL → 순서대로 수정
3. FAIL 0개가 될 때까지 최대 2회 반복
4. 최종 결과 요약을 사용자에게 보고

## 데이터 흐름

```
[Phase 1: setup]
    ↓ 00_architecture.md
[Phase 2: backend-dev]
    ↓ 02_backend_api_spec.md + backend/ 코드
[Phase 3: frontend-dev]
    ↓ frontend/ 코드
[Phase 4: ai-voice-dev]
    ↓ backend/ + frontend/ AI 코드 추가
[Phase 5: qa-inspector]
    ↓ 05_qa_report.md
[Phase 6: 결과 반영]
    ↓ 수정된 코드
[사용자 보고]
```

## 에러 핸들링

| 상황 | 전략 |
|------|------|
| 에이전트 1개 실패 | 1회 재시도. 재실패 시 해당 결과 없이 진행, 보고서에 누락 명시 |
| 스캐폴딩 실패 (Phase 1) | 전체 중단, 사용자에게 알림 |
| 빌드 실패 (Phase 5) | 에러 로그를 해당 에이전트에 전달하여 수정 |
| API 스펙 미생성 | Phase 3 진행 불가 → 사용자에게 알림 |

## 테스트 시나리오

### 정상 흐름
1. 사용자가 "WaitZero 개발 시작해줘" 요청
2. Phase 1: 설계 문서 + 프로젝트 스캐폴딩 완료
3. Phase 2: Spring Boot API 8개 엔드포인트 구현
4. Phase 3: Flutter 6개 화면 구현
5. Phase 4: 음성 인식 + AI 분류 기능 추가
6. Phase 5: QA 검증 → PASS 12개, FAIL 2개
7. Phase 6: FAIL 2개 수정 → 재검증 PASS
8. 사용자에게 완료 보고

### 에러 흐름
1. Phase 2에서 공공데이터 API 연동 실패
2. 1회 재시도 후에도 실패
3. 더미 데이터로 폴백하여 나머지 API 구현 진행
4. 보고서에 "공공데이터 연동: 더미 데이터 사용 중" 명시
