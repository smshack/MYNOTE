---
tags:
  - redis
  - database
---
```bash
docker -v

## redis Docker 이미지 다운로드
docker pull redis

## 이미지 확인
docker images

## 커맨드를 실행하면 컨테이너가 생성-실행
# 볼륨 설정하기 
docker run --name redis-container -p 6379:6379 -v ~/data/redis -d redis redis-server --appendonly --restart always yes
```

![[Pasted image 20251120014532.png]]