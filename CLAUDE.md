# WaitZero — 민원실 이용 현황 실시간 정보 서비스

2026 전국 통합데이터 활용 공모전 출품작 (주제 6번). 공모 마감: 2026-04-12.

## 기술 스택
- Frontend: Flutter (모바일 앱)
- Backend: Java 23 + Spring Boot + Gradle
- DB: MySQL + JPA (ORM)
- AI: OpenAI API via Spring AI (민원 분류/요약) + speech_to_text (음성 인식)
- 공공데이터: 공공데이터포털 API

## 하네스: WaitZero Build

**목표:** Flutter 앱 + Spring Boot 백엔드 + AI 음성 기능을 파이프라인으로 구현하는 빌드 하네스

**에이전트 팀:**
| 에이전트 | 역할 |
|---------|------|
| backend-dev | Java 23 + Spring Boot REST API, MySQL/JPA, 공공데이터 연동 |
| frontend-dev | Flutter 앱 UI, Riverpod 상태 관리, API 연동 |
| ai-voice-dev | 음성 인식(speech_to_text), Claude API 민원 분류/요약 |
| qa-inspector | API ↔ Flutter 통합 정합성 검증, 빌드 확인 |

**스킬:**
| 스킬 | 용도 | 사용 에이전트 |
|------|------|-------------|
| waitzero-build | 전체 빌드 오케스트레이터 | 리더(직접 실행) |
| setup-project | 아키텍처 설계, 프로젝트 스캐폴딩 | general-purpose |
| build-backend | Spring Boot API 구현 | backend-dev |
| build-frontend | Flutter 앱 구현 | frontend-dev |
| build-ai-voice | AI/음성 기능 구현 | ai-voice-dev |
| verify-integration | 통합 정합성 QA 검증 | qa-inspector |

**실행 규칙:**
- WaitZero 개발/빌드/구현 관련 작업 요청 시 `waitzero-build` 스킬을 통해 서브 에이전트 파이프라인으로 처리하라
- 단순 질문/확인은 에이전트 없이 직접 응답해도 무방
- 모든 에이전트는 `model: "opus"` 사용
- 중간 산출물: `_workspace/` 디렉토리

**디렉토리 구조:**
```
waitzero/
├── backend/                 # Spring Boot 프로젝트
├── frontend/                # Flutter 프로젝트
├── _workspace/              # 중간 산출물
│   ├── 00_architecture.md
│   ├── 02_backend_api_spec.md
│   ├── 04_ai_voice_spec.md
│   └── 05_qa_report.md
├── CLAUDE.md
└── .claude/
    ├── agents/
    │   ├── backend-dev.md
    │   ├── frontend-dev.md
    │   ├── ai-voice-dev.md
    │   └── qa-inspector.md
    └── skills/
        ├── waitzero-build/
        │   └── SKILL.md
        ├── setup-project/
        │   └── SKILL.md
        ├── build-backend/
        │   └── SKILL.md
        ├── build-frontend/
        │   └── SKILL.md
        ├── build-ai-voice/
        │   └── SKILL.md
        └── verify-integration/
            └── SKILL.md
```

**변경 이력:**
| 날짜 | 변경 내용 | 대상 | 사유 |
|------|----------|------|------|
| 2026-04-06 | 초기 구성 | 전체 | 하네스 신규 구축 |
