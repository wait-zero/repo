#!/bin/bash
# 서버 배포 스크립트 — CI에서 빌드된 JAR을 받아서 실행
set -e

cd ~/waitzero

# swap 확인
if ! swapon --show | grep -q /swapfile; then
  echo "Swap not found, please run setup-swap.sh first"
  exit 1
fi

# .env 파일 존재 확인
if [ ! -f .env ]; then
  echo ".env file not found at ~/waitzero/.env"
  exit 1
fi

# 배포
docker compose down || true
docker compose up -d --build

# 헬스체크 대기 — 컨테이너 실행 상태 확인
echo "Waiting for backend to start..."
for i in $(seq 1 20); do
  if docker inspect --format='{{.State.Running}}' waitzero-backend 2>/dev/null | grep -q true; then
    # 포트 응답 확인
    if curl -sf -o /dev/null -w '%{http_code}' http://localhost:8080 2>/dev/null | grep -qE '(200|401|403|404)'; then
      echo "Backend is healthy!"
      docker compose logs --tail=5 backend
      exit 0
    fi
  fi
  sleep 5
done

echo "Backend health check failed. Checking logs..."
docker compose logs --tail=30 backend
exit 1
