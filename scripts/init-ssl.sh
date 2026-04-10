#!/bin/bash
# SSL 인증서 최초 발급 스크립트
# 사용법: bash ~/waitzero/scripts/init-ssl.sh [이메일]
set -e

cd ~/waitzero

DOMAIN="waitzero.site"
EMAIL="${1:-admin@waitzero.site}"

echo "=== Step 1: 인증서 발급 (HTTP 모드에서) ==="
docker compose run --rm certbot certonly \
  --webroot \
  --webroot-path=/var/www/certbot \
  --email "$EMAIL" \
  --agree-tos \
  --no-eff-email \
  -d "$DOMAIN" \
  -d "www.$DOMAIN"

echo "=== Step 2: HTTPS 설정으로 Nginx 재시작 ==="
# SSL 설정으로 nginx.conf 교체 후 재빌드
cp nginx/nginx.conf nginx/nginx.conf  # 원본이 SSL 버전
docker compose up -d --build nginx

echo "=== Step 3: 인증서 자동 갱신 cron 등록 ==="
(crontab -l 2>/dev/null | grep -v certbot; echo "0 3 1 * * cd ~/waitzero && docker compose run --rm certbot renew && docker compose exec nginx nginx -s reload") | crontab -

echo ""
echo "=== 완료! https://$DOMAIN ==="
