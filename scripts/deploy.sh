#!/bin/bash
# 서버 배포 스크립트
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

# 빌드 & 배포
docker compose down
docker compose up -d --build

# 헬스체크 대기
echo "Waiting for backend to start..."
for i in $(seq 1 30); do
  if curl -sf http://localhost:8080/actuator/health > /dev/null 2>&1 || curl -sf http://localhost:8080 > /dev/null 2>&1; then
    echo "Backend is healthy!"
    exit 0
  fi
  sleep 5
done

echo "Backend health check failed. Checking logs..."
docker compose logs --tail=50 backend
exit 1
