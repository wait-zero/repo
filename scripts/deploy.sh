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

# SSL 인증서 유무에 따라 nginx 설정 선택
if docker volume inspect waitzero_certbot-etc > /dev/null 2>&1 && \
   docker run --rm -v waitzero_certbot-etc:/etc/letsencrypt alpine test -f /etc/letsencrypt/live/waitzero.site/fullchain.pem 2>/dev/null; then
  echo "SSL cert found → HTTPS mode"
  cp nginx/nginx.conf nginx/nginx.active.conf
else
  echo "No SSL cert → HTTP-only mode"
  cp nginx/nginx.init.conf nginx/nginx.active.conf
fi
# deploy에서 사용할 설정으로 교체
cp nginx/nginx.active.conf nginx/nginx.conf

# 배포
docker compose down || true
docker compose up -d --build

# 컨테이너 실행 확인
echo "Checking containers..."
sleep 10

MYSQL_RUNNING=$(docker inspect --format='{{.State.Running}}' waitzero-mysql 2>/dev/null || echo "false")
BACKEND_RUNNING=$(docker inspect --format='{{.State.Running}}' waitzero-backend 2>/dev/null || echo "false")
NGINX_RUNNING=$(docker inspect --format='{{.State.Running}}' waitzero-nginx 2>/dev/null || echo "false")

echo "MySQL running: $MYSQL_RUNNING"
echo "Backend running: $BACKEND_RUNNING"
echo "Nginx running: $NGINX_RUNNING"

if [ "$MYSQL_RUNNING" = "true" ] && [ "$BACKEND_RUNNING" = "true" ] && [ "$NGINX_RUNNING" = "true" ]; then
  echo "All containers are running. Deploy successful!"
  exit 0
fi

echo "Some containers failed to start. Logs:"
docker compose logs --tail=30
exit 1
