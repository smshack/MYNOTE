---
tags:
  - postgresql
  - database
---
![[Pasted image 20251120012455.png]]
[Documentation](https://www.postgresql.org/docs/)

# 1. postgres 란?

- `PostgreSQL`은 `ORDBMS`중 하나이며 무료로 제공되고 있습니다.
- 1985년 개발을 시작하여 1996년 첫 출시되었습니다.
- 오라클 개발자들이 대거나와 PostgreSQL 개발에 합류하여 oracle과 유사합니다.
- 한국에서는 잘 사용되지 않고 있으나 전세계적으로의 [트렌드](https://db-engines.com/en/ranking)는 4위에 랭킹되어 있으며 작년, 전달대비 꾸준히 점유율이 증가하고 있는 DB입니다.

## 특징

### Portable

- PostgreSQL은 ANSI C로 개발되었으며, 지원하는 플랫폼의 종류로는 Windows, Linux, MAC OS/X, Unix 등 다양한 플랫폼을 지원한다.

### Reliable

- 트랜잭션 속성인 ACID에 대한 구현 및 MVCC
- 로우 레벨 라킹 등이 구현

### Scalable

- PostgreSQL의 멀티 버젼에 대해 사용이 가능
- 대용량 데이터 처리를 위한 Table Partitioning과 Tables Space 기능 구현이 가능

### Secure

- DB 보안은 데이터 암호화, 접근 제어 및 감시의 3가지로 구성됨
- 호스트-기반의 접근 제어, Object-Level 권한, SSL 통신을 통한 클라이언트와 네트워크 구간의 전송 데이터를 암호화 등 지원

### Recovery & Availability

- Streaming Replication을 기본으로, 동기식/비동기식 Hot Standbt 서버를 구축 가능
- WAL Log 아카이빙 및 Hot Back up을 통해 Point in time recovery 가능

### Advanced

- pg_upgrade를 통해 업그레이드를 할 수 있으며, 웹 또는 C/S 기반의 GUI 관리 도구를 제공하여 모니터링 및 관리는 물론 튜닝까지 가능
- 사용자 정의 Procedural로 Perl, Java, Php 등의 스크립트 언어 지원이 가능

# 2. 데이터 저장 형식

**Postgres**는 하드 디스크 내부에 개별 데이터베이스에 대한 모든 정보를 폴더와 수많은 파일의 형태로 저장

[Postgres는 데이터를 어디에 어떤 형태로 저장할까?](https://seunghyunson.tistory.com/16)
![[Pasted image 20251120012503.png]]
시작하기전에 먼저 알아야할 단어/개념들이 있습니다.

1. **Heap(Heap File)**: 특정 테이블에 존재하는 **모든 데이터(rows)를 담고 있는 공간(파일)** 입니다. -table 개념
2. **Block(Page)**: **Heap File**은 **여러개의 Block(Page)로 나뉘어져 구성**됩니다. 각 **Block(Page)** 는 **여러개의 rows 데이터를 담고** 있습니다. - column
3. **Tuple(Item)**: 특정 테이블의 **row 하나에 대한 데이터**를 담고 있는 곳입니다. - document 개념
![[Pasted image 20251120012509.png]]
위 다이어그램과 같이, 하나의 **Heap File**은 여러개의 **Block(Page)**로 나뉘어져 있고,

각 **Block(Page)**는 여러개의 **Tuple(Item)**을 담고 있음

# 3. postgres 장단점, 활용시 고민 사항

## 장점

1. **라이선스에 대한 비용 문제가 없음**
    - BSD 라이선스이며, 소스를 변경하고 그 소스를 숨긴 채 재배포 해도 법적으로 문제가 없습니다.
2. **오래된 오픈소스의 안정성**
    - 가볍게 돌아가며 대용량 처리에도 큰 문제가 없습니다.
    - 표준 SQL을 잘 따르고 있습니다.
3. **발전중인 데이터베이스**
    - 무료 SQL이지만 꾸준히 업데이트 되고 있으며 현재 14베타 버전이 나왔고 안정화 버전으로는 13.3 버전을 지원합니다.
4. **독창적인 자료형 및 문법**
    - PostgreSQL만의 독창적인 자료형이 있습니다.
    - jsonb,json 형식으로 저장이 가능하며 ILIKE기능으로 대소문자 상관없이 매칭되는 글자를 찾을 수 있습니다.
5. **oracle에 버금가는 통계 함수**
    - oracle에 버금가는 통계 함수를 제공합니다.

## 단점

1. CRUD성능이 RDBMS보다 좋지 않음
    - CRUD 성능이 RDBMS보다 좀 떨어집니다.
2. **독창적인 자료형 및 문법**
    - 독창적인 자료형과 문법때문에 새로운 개발자를 가르치는 비용이 발생합니다.
    - 다른 DB로 migration하기 쉽지 않습니다.

## 사용해야 되는 이유?

- 무료로 제공되며 무료로 제공하는 타 DBMS에 비해 트랜잭션 및 ACID이 월등히 좋습니다.
- 오래된 DBMS인만큼 안정적이고 신뢰성을 가지고 있습니다.
- 꾸준한 기능 추가 및 발전을 하고 있습니다.
- JSONB, ARRAY같은 타입으로 획기적으로 확장성을 늘릴수 있으며 인덱싱 작업 역시 효율적으로 할 수 있습니다.
- `vacuum`이라는 작업을 통해 데이터를 좀 더 효율적으로 관리 할 수 있습니다.

> vacuum : PostgreSQL에서 제공하는 디스크 조각 모음입니다.변경 또는 삭제된 자료들이 차지하고 있는

디스크 공간을 다시 사용할 수 있게 하며 인덱스 전용 검색 기능을 향상트랜잭션 ID겹침이나 다중 트랜잭션 ID 겹침 상황으로 손실될 가능성을 방지

- oracle은 좋지만 가격이 비싸며 MySQL이 대안으로 사용되었는데 oracle에 인수됨에 따라 다른 DBMS로 눈을 돌리고 있는 경우

# 4. DB 명령어 정리

[PostgreSQL Tutorial](https://www.tutorialspoint.com/postgresql/)

## DB 생성

[PostgreSQL - CREATE Database](https://www.tutorialspoint.com/postgresql/postgresql_create_database.htm)

이 명령은 PostgreSQL 셸 프롬프트에서 데이터베이스를 생성하지만 데이터베이스를 생성하려면 적절한 권한이 있어야 합니다. 기본적으로 새 데이터베이스는 표준 시스템 데이터베이스 _템플릿_ 1을 복제하여 생성됩니다 .

### **통사론**

CREATE DATABASE 문의 기본 구문은 다음과 같습니다.

```
CREATE DATABASE dbname;

```

여기서 _dbname_ 은 생성할 데이터베이스의 이름입니다.

### **예시**

다음은 PostgreSQL 스키마에 **testdb** 를 생성하는 간단한 예입니다.

```
postgres=# CREATE DATABASE testdb;
postgres-#
```

## **createdb 명령 사용**

PostgreSQL 명령줄 실행 파일 _createdb 는 SQL 명령 CREATE DATABASE_ 를 둘러싼 래퍼 입니다. _이 명령과 SQL 명령 CREATE DATABASE_ 의 유일한 차이점 은 전자는 명령줄에서 직접 실행할 수 있고 하나의 명령으로 데이터베이스에 주석을 추가할 수 있다는 것입니다.

## DB 선택

방법 중 하나를 사용하여 데이터베이스를 선택할 수 있습니다.

- 데이터베이스 SQL 프롬프트
- OS 명령 프롬프트

## **데이터베이스 SQL 프롬프트**

PostgreSQL 클라이언트를 이미 시작했고 다음 SQL 프롬프트에 도달했다고 가정합니다.

```
postgres=#

```

다음과 같이 백슬래시 el 명령인 **\l** 을 사용하여 사용 가능한 데이터베이스 목록을 확인할 수 있습니다.

```
postgres-# \\l
                             List of databases
   Name    |  Owner   | Encoding | Collate | Ctype |   Access privileges
-----------+----------+----------+---------+-------+-----------------------
 postgres  | postgres | UTF8     | C       | C     |
 template0 | postgres | UTF8     | C       | C     | =c/postgres          +
           |          |          |         |       | postgres=CTc/postgres
 template1 | postgres | UTF8     | C       | C     | =c/postgres          +
           |          |          |         |       | postgres=CTc/postgres
 testdb    | postgres | UTF8     | C       | C     |
(4 rows)

postgres-#
```

이제 다음 명령을 입력하여 원하는 데이터베이스를 연결/선택합니다. 여기서는 _testdb_ 데이터베이스에 연결합니다.

```
postgres=# \\c testdb;
psql (9.2.4)
Type "help" for help.
You are now connected to database "testdb" as user "postgres".
testdb=#
```

## **OS 명령 프롬프트**

데이터베이스에 로그인할 때 명령 프롬프트 자체에서 데이터베이스를 선택할 수 있습니다. 다음은 간단한 예입니다.

```
psql -h localhost -p 5432 -U postgress testdb
Password for user postgress: ****
psql (9.2.4)
Type "help" for help.
You are now connected to database "testdb" as user "postgres".
testdb=#
```

이제 PostgreSQL testdb에 로그인되었으며 testdb 내에서 명령을 실행할 준비가 되었습니다. 데이터베이스를 종료하려면 \q 명령을 사용할 수 있습니다.

## DB 삭제

### **DROP DATABASE 사용**

이 명령은 데이터베이스를 삭제합니다. 데이터베이스에 대한 카탈로그 항목을 제거하고 데이터가 포함된 디렉토리를 삭제합니다. 데이터베이스 소유자만 실행할 수 있습니다. 이 명령은 사용자 또는 다른 사람이 대상 데이터베이스에 연결되어 있는 동안에는 실행할 수 없습니다(이 명령을 실행하려면 postgres 또는 다른 데이터베이스에 연결).

### **통사론**

DROP DATABASE의 구문은 다음과 같습니다.

```
DROP DATABASE [ IF EXISTS ] name
```

### **dropdb 명령 사용**

PostgresSQL 명령줄 실행 파일 **dropdb 는 SQL 명령** _DROP DATABASE_ 를 둘러싼 명령줄 래퍼 입니다. 이 유틸리티를 통해 데이터베이스를 삭제하는 것과 서버에 액세스하는 다른 방법을 통해 데이터베이스를 삭제하는 것 사이에는 효과적인 차이가 없습니다. dropdb는 기존 PostgreSQL 데이터베이스를 파괴합니다. 이 명령을 실행하는 사용자는 데이터베이스 수퍼유저 또는 데이터베이스 소유자여야 합니다.

### **통사론**

_dropdb_ 의 구문 은 다음과 같습니다.

```
dropdb  [option...] dbname
```

## 테이블 생성

### **통사론**

CREATE TABLE 문의 기본 구문은 다음과 같습니다.

```
CREATE TABLE table_name(
   column1 datatype,
   column2 datatype,
   column3 datatype,
   .....
   columnN datatype,
   PRIMARY KEY( one or more columns )
);
```

다음은 ID를 기본 키로 사용하여 COMPANY 테이블을 생성하는 예제

```sql
CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL
);

CREATE TABLE DEPARTMENT(
   ID INT PRIMARY KEY      NOT NULL,
   DEPT           CHAR(50) NOT NULL,
   EMP_ID         INT      NOT NULL
);
```

## Create

### **통사론**

INSERT INTO 문의 기본 구문은 다음과 같습니다.

```
INSERT INTO TABLE_NAME (column1, column2, column3,...columnN)
VALUES (value1, value2, value3,...valueN);

```

- 여기서 column1, column2,...columnN은 데이터를 삽입하려는 테이블의 열 이름입니다.
- 대상 열 이름은 임의의 순서로 나열될 수 있습니다. VALUES 절 또는 쿼리에서 제공하는 값은 왼쪽에서 오른쪽으로 명시적 또는 암시적 열 목록과 연결됩니다.

테이블의 모든 열에 대한 값을 추가하는 경우 SQL 쿼리에서 열 이름을 지정할 필요가 없습니다. 그러나 값의 순서가 테이블의 열과 같은 순서인지 확인하십시오. SQL INSERT INTO 구문은 다음과 같습니다.

```
CREATE TABLE COMPANY(
   ID INT PRIMARY KEY     NOT NULL,
   NAME           TEXT    NOT NULL,
   AGE            INT     NOT NULL,
   ADDRESS        CHAR(50),
   SALARY         REAL,
   JOIN_DATE	  DATE
);
```

```sql
INSERT INTO COMPANY (ID,NAME,AGE,ADDRESS,SALARY,JOIN_DATE) VALUES (4, 'Mark', 25, 'Rich-Mond ', 65000.00, '2007-12-13' ), (5, 'David', 27, 'Texas', 85000.00, '2007-12-13');
```
![[Pasted image 20251120012533.png]]
## READ

PostgreSQL **SELECT** 문은 데이터베이스 테이블에서 데이터를 가져오는 데 사용되며 결과 테이블 형식으로 데이터를 반환합니다. 이러한 결과 테이블을 결과 집합이라고 합니다.

## **통사론**

SELECT 문의 기본 구문은 다음과 같습니다.

```
SELECT column1, column2, columnN FROM table_name;

```

여기서 column1, column2...는 값을 가져오려는 테이블의 필드입니다. 필드에서 사용 가능한 모든 필드를 가져오려면 다음 구문을 사용할 수 있습니다.

```
SELECT * FROM table_name;
```

```sql
SELECT ID, NAME, SALARY FROM COMPANY ;
```
![[Pasted image 20251120012539.png]]