#!/bin/bash
# Oracle Cloud 1GB RAM 인스턴스용 Swap 메모리 설정 스크립트
# 사용법: sudo bash setup-swap.sh

set -e

SWAP_SIZE="2G"
SWAP_FILE="/swapfile"

# 기존 swap 확인
echo "=== 현재 메모리 상태 ==="
free -h

if swapon --show | grep -q "$SWAP_FILE"; then
    echo "swap이 이미 활성화되어 있습니다."
    exit 0
fi

# swap 파일 생성
echo "=== ${SWAP_SIZE} swap 파일 생성 중... ==="
fallocate -l $SWAP_SIZE $SWAP_FILE
chmod 600 $SWAP_FILE
mkswap $SWAP_FILE
swapon $SWAP_FILE

# 재부팅 후에도 유지되도록 fstab 등록
if ! grep -q "$SWAP_FILE" /etc/fstab; then
    echo "$SWAP_FILE none swap sw 0 0" >> /etc/fstab
    echo "fstab에 swap 등록 완료"
fi

# swappiness 조정 (메모리가 적으므로 적극적으로 swap 사용)
sysctl vm.swappiness=60
if ! grep -q "vm.swappiness" /etc/sysctl.conf; then
    echo "vm.swappiness=60" >> /etc/sysctl.conf
fi

echo ""
echo "=== 설정 완료 ==="
free -h
