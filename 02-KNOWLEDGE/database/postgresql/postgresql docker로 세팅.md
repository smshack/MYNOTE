---
tags:
  - database
  - postgresql
---
```bash
docker -v

## postgres Docker 이미지 다운로드
docker pull postgres

## 이미지 확인
docker images

## 커맨드를 실행하면 컨테이너가 생성-실행
## –name postgres-container : 컨테이너 이름 지정.
## –restart unless-stopped : 따로 stop 명령을 보내지 않으면 컨테이너 재시작의 경우에도 자동 실행됨.
## -p 5432:5432 : postgreSQL이 사용할 포트 번호 기재
## -e POSTGRES_PASSWORD=123456 : postgreSQL DB에 대한 비밀번호 설정.
## -v 볼륨 정보 : 컨테이너가 사용할 볼륨 정보 기재.
## postgres:13.3 : 실행할 postgreSQL 컨테이너 버전.
docker run --name postgres-container -d --restart unless-stopped -p 5432:5432 -e POSTGRES_PASSWORD=1234 -v ~/data/postgres:/var/lib/postgresql/data postgres

## 컨테이너 구동 확인
docker logs postgres-container

# postgres 컨테이너 접속
docker exec -it postgres-container bash

# postgres 서버 접속
psql -U postgres
CREATE DATABASE TESTDB;

postgreSQL DB URL 설정Permalink
postgreSQL 구동은 완료하였고 외부에서 DB를 연결하는 방법을 해보자.
 Flask 등 외부 어플리케이션에서 입력할 DB URL을 구성하는 방법이다.

위에서 실행한 컨테이너의 경우는 아래의 같이 입력하면 연결된다.

export DATABASE_URL='postgresql://postgres:123456@localhost:5432/postgres'
각 항목은 아래와같은 형식이니 본인의 환경에 맞춰서 변경해주면 된다.
```
![[Pasted image 20251120012344.png]]