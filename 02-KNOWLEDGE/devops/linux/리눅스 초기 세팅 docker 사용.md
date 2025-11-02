---
tags:
  - linux
  - docker
---

```
# 필요한 패키지 설치
apt update && sudo apt upgrade -y
apt install -y ca-certificates curl gnupg lsb-release

# Docker 공식 GPG 키 추가
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Docker 저장소 등록
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  
# Docker 설치  
apt update -y

apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# docker 서비스 자동 시작 설정
systemctl enable docker
systemctl start docker
systemctl status docker

```