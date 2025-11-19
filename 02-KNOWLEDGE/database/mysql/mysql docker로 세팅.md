---
tags:
  - database
  - mysql
---
```bash
docker -v

## mysql Docker 이미지 다운로드
docker pull mysql

## 이미지 확인
docker images

## 커맨드를 실행하면 컨테이너가 생성-실행
## MYSQL_ROOT_PASSWORD=<password> 는 MySQL의 로그인 패스워드를 입력
## -v ~/data:/data/db는 호스트(컨테이너를 구동하는 로컬 컴퓨터)의 ~/data 디렉터리와 컨테이너의 /data/db 디렉터리를 마운트시킨다. 
## 이처럼 볼륨을 설정하지 않으면 컨테이너를 삭제할 때 컨테이너에 저장되어있는 데이터도 삭제되기 때문에 복구할 수 없다.
# 한글이 깨지지 않도록 설정하려면 아래 인자값을 넣어주어야 한다.
docker run -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=1234 --name mysql-container -v ~/data/mysql:/var/lib/mysql mysql --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

## 컨테이너 리스트 출력
docker ps -a

# mysql 컨테이너 접속
docker exec -it mysql-container bash

# MySQL 서버 접속
mysql -u root -p

## 데이터베이스와 사용자를 생성하고 mysql 에서 권한을 부여
CREATE USER 'smart'@'%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON *.* TO 'smart'@'%';
flush privileges;
CREAT DATABASE TESTDB;

# 기타 명령어
# 현재 DBMS에 존재하는 DB 확인 
mysql> show databases; 

# 사용중인 DB 전환 
mysql> use db이름; 

# 현재 DB에 존재하는 테이블 목록 확인 
mysql> show tables; 

# 테이블 구조 확인(DESCRIBE 명령) 
mysql> desc table이름;
```
![[Pasted image 20251120012742.png]]
![[Pasted image 20251120012758.png]]