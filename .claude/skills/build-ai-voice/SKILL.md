---
name: build-ai-voice
description: "WaitZero AI/음성 기능 구현. Flutter speech_to_text 음성 인식, Spring Boot Claude API 연동, 민원 자동 분류/요약 기능을 구현한다. '음성 인식', 'AI 분류', 'Claude API', '음성 입력' 요청 시 사용."
---

# WaitZero AI/음성 기능 구현

음성 인식(Flutter) + AI 민원 분류(Spring Boot + Claude API) 기능을 구현한다.

## 구현 순서

### 1. 백엔드 — Claude API 연동

`com.waitzero.ai` 패키지:

**AiClassifyService:**
- Claude API로 민원 내용 → 카테고리 자동 분류
- 시스템 프롬프트:
  ```
  당신은 한국 관공서 민원 분류 전문가입니다.
  사용자가 설명하는 민원 내용을 아래 카테고리 중 하나로 분류하세요:
  [주민등록, 인감증명, 가족관계, 전입신고, 차량등록, 세금/납부, 기타]
  반드시 JSON 형식으로 응답: {"category": "...", "confidence": 0.0~1.0, "summary": "..."}
  ```
- RestClient로 Claude API 호출 (`https://api.anthropic.com/v1/messages`)
- API 키: `${CLAUDE_API_KEY}` (application.yml)

**AiController:**
- `POST /api/ai/classify` — 텍스트 → 카테고리 분류
- `POST /api/ai/summarize` — 긴 텍스트 → 핵심 요약
- 요청: `{ "text": "..." }`, 응답: `{ "category": "...", "confidence": 0.9, "summary": "..." }`

### 2. 프론트엔드 — 음성 인식

`lib/features/voice/`:

**VoiceRecognitionService:**
- `speech_to_text` 패키지로 실시간 음성→텍스트
- 한국어(`ko-KR`) 로케일 설정
- 마이크 권한 요청/확인 (`permission_handler`)

**VoiceInputScreen:**
- 큰 마이크 버튼 (탭 → 녹음 시작/중지)
- 실시간 인식 텍스트 표시 (스트리밍)
- 녹음 완료 후: 텍스트 수정 가능 → "AI 분류" 버튼
- AI 분류 결과 표시 (카테고리 + 신뢰도)
- "선 정보 입력에 반영" 버튼 → 폼에 자동 채움

**VoiceInputWidget (재사용 위젯):**
- 선 정보 입력 폼의 각 필드에 부착 가능한 소형 마이크 버튼
- 필드별 음성 입력 → 해당 필드에 텍스트 채움

### 3. AI 분류 연동

**AiRepository (Flutter):**
- `POST /api/ai/classify` 호출
- 응답 모델: `AiClassifyResult(category, confidence, summary)`

**분류 결과 활용 흐름:**
```
음성 입력 → 텍스트 변환 → AI 분류 API 호출 → 카테고리 자동 선택 + 요약 채움
```

## 에러 처리
- 마이크 권한 거부: 설정 화면 안내 다이얼로그
- 음성 인식 실패: "음성을 인식하지 못했습니다. 다시 시도하거나 직접 입력해주세요."
- Claude API 실패: "자동 분류를 사용할 수 없습니다. 카테고리를 직접 선택해주세요."
- 네트워크 오프라인: 음성 인식은 가능, AI 분류만 비활성화
