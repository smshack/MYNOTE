---
tags:
  - database
  - mysql
---
![[Pasted image 20251120012908.png]]
# 1. mysql 이란?

[MySQL Enterprise Edition](https://www.mysql.com/products/enterprise/)

- 관계형 데이터베이스 관리 시스템(RDBMS)
- MYSQL은 전세계적으로 가장 널리 사용되고 있는 오픈 소스 데이터베이스
- MySQL AB사가 개발하여 배포/판매하고 있는 데이터베이스
- 표준 데이터베이스 질의 언어 SQL(Structured Query Language)을 사용하는 개방 소스의 관계형 데이터베이스 관리 관리시스템(RDBMS), 매우 빠르고, 유연하며, 사용하기 쉬운 특징
- 다중사용자, 다중 쓰레드를 지원하고, C, C++, Eiffel, 자바, 펄, PHP, Pyton 스크립트 등을 위한 응용프로그램 인터페이스(API)를 제공
- 유닉스나 리눅스, Windows 운영체제 등에서 사용 가능
- LAPM 즉 리눅스 운영체제와 Apahe 서버 프로그램, MySQL, PHP 스크립트 언어 구성은 상호 연동이 잘되면서도 오픈소스로 개발되는 무료 프로그램이어서 홈페이지나 소핑몰 등등 일반적인 웹 개발에 널리 사용

## mysql 특징

### 1)**단일 코어에서 Nested Loop Join 처리**

MySQL에서는 **모든 SQL 처리를 단일 코어에서 Nested Loop Join 방식으로만 데이터를 처리**

병렬 처리라는 것은 없습니다. 물론 일부 3rd스토리지 엔진을 플러그인으로 설치를 하면 병렬 처리가 가능하다고는 하지만, 기본적인 스토리지 엔진에는 단일 코어 수행합니다. 그렇기 때문에 MySQL 입장에서는 CPU코어 개수를 늘리는 Scale-Out보다는 오히려 단위 처리량이 좋은 CPU로 Scale-Up을 하는 것이 훨씬 유리합니다.

### **2) 다양한 스토리지 엔진**

MySQL은 다양한 스토리지 엔진을 지원합니다. MyISAM, InnoDB, Archive, Memory, NDB, Federated 등 기본 엔진 뿐만 아니라 3rd Party 스토리지 엔진도 간단하게 플러그인 형식으로 설치를 할 수 있음

### **3) 데이터 복제(Replication) 기능**

**MySQL은 물리적으로 독립적인 디스크 영역에 데이터를 복제(Replication)하여 데이터를 이중화할 수 있음**

# 2. 데이터 저장형식 - 어떻게 데이터 저장해서 사용?
![[Pasted image 20251120012918.png]]
- MySQL은 각 데이터베이스(스키마라고도 불리는)를 파일시스템 안의 데이터 디렉터리의 하위 디렉터리로 저장합니다. 테이블을 생성하면 MySQL은 테이블 이름과 같은 이름을 가진 .frm 파일을 만들고 그 안에 테이블 정의 정보를 저장

[](https://nomadlee.com/mysql-%EC%8A%A4%ED%86%A0%EB%A6%AC%EC%A7%80-%EC%97%94%EC%A7%84-%EC%A2%85%EB%A5%98-%EB%B0%8F-%ED%8A%B9%EC%A7%95/)

# 3. mysql 장단점, 활용시 고민 사항

[](https://www.websiterating.com/ko/web-hosting/glossary/what-is-mysql/)

## **장점**

- ubiquitous: 이미 많이 쓰이고 있다. 따라서 믿을 수 있다.
- simple: 배우고 운영하기 쉽다, 그리고 구조가 간단하기 때문에 빠르다.
- TCO: Total Cost of Ownership(총소유비용)이 낮다. 상용 버전을 구매하더라도 가격이 낮다.
- support: 지원이 잘 된다. 커뮤니티를 통한 지원, 유료 지원 모두 쓸만하다.
- flexible, scalable: 유연하고 확장이 가능한 구조이다.

## 단점

- GPL: GPL의 구속을 벗어나려면 상용 버전을 구매해야 한다.
- Integration: 이미 다른 DB를 사용하고 있는 경우에는 mysql로 옮겨가기 어렵다.
- Product Maturity: Oracle은 30년째 개발되고 있는데 mysql은 아직 어리다.
- Feature Maturity: 새로 추가되기 시작한 기능들은 아직 충분히 안정화되지 않았다.
- Certification: 인증된 개발자/운영자나 공인 파트너사가 부족하다.
- Corporate: mysql은 Oracle이나 MS에 비해 규모가 작아 신뢰가 어렵다.
- Scalability: mysql의 확장성에 대해 아직 의문을 가지고 있는 사람들이 많다.

## 활용시 주의사항

## 테이블 설계 시 유의 사항

### 1. 반드시 Primary Key를 정의하고 최대한 작은 데이터 타입을 선정한다.

- 로그 성 테이블에도 기본적으로 PK 생성을 원칙으로 함
- InnoDB에서 PK는 인덱스와 밀접한 관계를 가지므로 최대한 작은 데이터 타입을 가지도록 유지

### 2. 테이블 Primary Key는 auto_increment를 사용한다.

- InnoDB에서는 기본 키 순서로 데이터가 저장되므로, Random PK 저장 시 불필요한 DISK I/O가 발생 가능
- InnoDB의 PK는 절대 갱신되지 않도록 유지(갱신 시 갱신된 행 이후 데이터를 하나씩 새 위치로 옮겨야 함)

### 3. 데이터 타입은 최대한 작게 설계한다.

- 시간정보는 MySQL데이터 타입 date/datetime/timestamp 활용
- IP는 INET_ATON(‘IP’), INET_NTOA(int) 함수를 활용
- 정수 타입으로 저장 가능한 문자열 패턴은 최대한 정수 타입으로 저장

### 4. 테이블 내 모든 필드에 NOT NULL 속성을 추가한다.

- NULL을 유지를 위한 추가 비용 발생(NULL 허용 칼럼을 인덱싱 할 때 항목마다 한 바이트 씩 더 소요)

### 5. Partitioning을 적절하게 고려하여 데이터를 물리적으로 구분한다.

- 데이터 및 인덱스 파일이 커질수록 성능이 저하되므로Partitioning 유도
- PK 존재 시 PK 내부에 반드시 Partitioning 조건이 포함되어야 함

## 인덱스 설계 시 유의 사항

### 1. 인덱스 개수를 최소화 한다.

- 현재 인덱스로 Range Scan이 가능한지 여부를 사전에 체크
- 인덱스도 서버 자원을 소모하는 자료구조이므로 성능에 영향을 줌

### 2. 인덱스 칼럼은 분포도를 고려하여 선정한다.

- 인덱스 칼럼 데이터의 중복이 줄어들수록 인덱스는 최대의 효과를 가짐
    
- 하단 쿼리 결과 값이 1에 가까울수록(0.9이상 권고) 인덱스 컬럼으로 적합함
    
    ```
    SELECT count(distinct INDEX_COLUMN)/count(*)
    FROM TABLE;
    ```
    

### 3. 커버링 인덱스(Covering Index)를 활용한다.

- 쿼리 조건이 인덱스 안에 포함된 경우 인덱스에서만 연산 유도
- 인덱스는 일반적으로 행 전체보다 작으므로 불필요한 Disk I/O 회피 가능“[MySQL에서 커버링 인덱스로 쿼리 성능을 높여보자!!](http://gywn.net/2012/04/mysql-covering-index/)” 편 참고

### 4. 스토리지 엔진 별 INDEX 특성을 정확히 인지한다.

- InnoDB에서 데이터는 PK 순서로 저장되고, 인덱스는 PK를 Value로 가짐
- MyISAM은 PK와 일반 인덱스의 구조는 동일하나, Prefix 압축 인덱스를 사용(MyISAM 엔진에서 ORDER BY 시 DESC는 가급적 지양)

### 5. 문자열을 인덱싱 시 Prefix 인덱스 활용한다.

- 긴 문자열 경우 Prefix 인덱스(앞 자리 몇 글자만 인덱싱)를 적용
    
    ```
    CREATE INDEX IDX01 on TAB1(COL(4), COL(4))
    ```
    
- Prifix Size는 앞 글자 분포도에 따라 적절하게 설정(하단 결과가 1에 가까울 수록 최적의 성능 유지, 0.9이상 권고)
    
    ```
    SELECT count(distinct LEFT(INDEX_COLUMN,3))/count(*)
    FROM TABLE;
    ```
    

### 6. CRC32함수 및 Trigger를 활용하여 인덱스 생성한다.

- URL/Email같이 문자 길이기 긴 경우 유용
    
- INSERT/UPDATE 발생 시 Trigger로 CRC32 함수 실행 결과 값을 인덱싱
    
- CRC32 결과값을 저장할 칼럼 추가 및 인덱스 생성
    
    ```
    alter table user_tbl add email_crc int unsigned not null;
    create index idx01_email_crc on user_tbl (email_crc);
    ```
    
- Insert Trigger 생성
    
    ```
    create trigger trg_user_tbl_insert
    before insert on user_tbl
    for each row
    begin
        set new.email_crc = crc32(lower(trim(new.email)));
    end$
    ```
    
- Update Trigger 생성
    
    ```
    create trigger trg_user_tbl_update
    before update on user_tbl
    for each row
    begin
        if old.email <> new.email then
            set new.email_crc = crc32(lower(trim(new.email)));
        end if;
    end$
    ```
    
- 검색 쿼리
    
    ```
    select *
    from user_tbl
    where email_crc = crc32(lower(trim('mail@domain.com')))
    and email= 'mail@domain.com'
    ```
    
    CRC32 결과가 중복되어도, email값을 직접 비교하는 부분에서 중복이 제거됩니다.
    

### 7. 중복 인덱스 생성 회피

- MySQL은 동일한 인덱스를 중복 생성해도 에러를 발생하지 않음
- Primary Key로 구성된 칼럼과 동일한 인덱스를 생성하지 않도록 주의

# 4. mysql 문 연습

## 샘플 sql 파일

[MySQL Sample Database](https://www.mysqltutorial.org/mysql-sample-database.aspx)
![[Pasted image 20251120012932.png]]
- **Customers**
    
    : 고객의 데이터를 저장합니다.
    
- **Products**
    
    : 축소 모형 자동차의 목록을 저장합니다.
    
- **ProductLines**
    
    : 제품 라인 카테고리 목록을 저장합니다.
    
- **Orders**
    
    : 고객이 주문한 판매 주문을 저장합니다.
    
- **OrderDetails**
    
    : 각 판매 주문에 대한 판매 주문 라인 항목을 저장합니다.
    
- **Payments**
    
    : 고객이 자신의 계정을 기반으로 결제한 금액을 저장합니다.
    
- **Employees**
    
    : 모든 직원 정보와 누가 누구에게 보고하는지와 같은 조직 구조를 저장합니다.
    
- **Offices**
    
    : 영업소 데이터를 저장합니다.
    

# Select

[MySQL SELECT](https://www.mysqltutorial.org/mysql-select-statement-query-data.aspx)

### S**ELECT 문을 사용하여 단일 열에서 데이터 검색 예제**

```sql
SELECT lastName
FROM employees;

```

### **MySQL SELECT 문을 사용하여 여러 열의 데이터 쿼리 예제**

```sql
SELECT 
    lastName, 
    firstName, 
    jobTitle
FROM
    employees;
```

### **MySQL SELECT 문을 사용하여 모든 열에서 데이터 검색 예제**

```sql
SELECT employeeNumber,
       lastName,
       firstName,
       extension,
       email,
       officeCode,
       reportsTo,
       jobTitle
FROM   employees;
```

```sql
SELECT * 
FROM employees;
```
![[Pasted image 20251120012945.png]]
### `ORDER BY`

[MySQL ORDER BY](https://www.mysqltutorial.org/mysql-order-by/)

- `ORDER BY`
    
    하나 이상의 열을 기준으로 결과 집합을 정렬 하려면 이 절을 사용합니다 .
    
- 옵션을 사용하여 `ASCDESC`
    
    결과 집합을 오름차순으로 정렬하고 옵션을 사용
    
    하여 결과 집합을 내림차순으로 정렬합니다.
    
- `ORDER BYFROMSELECT`
    
    절은
    
    and 절 다음 에 평가
    
    됩니다.
    
- MySQL에서 `NULL`
    
    NULL이 아닌 값보다 작음
    

### **MySQL ORDER BY 절을 사용하여 하나의 열로 결과 집합을 정렬하는 예**

- `ORDER BY`절을 사용하여 성을 오름차순으로 정렬

```sql
SELECT
	contactLastname,
	contactFirstname
FROM
	customers
ORDER BY
	contactLastname;
```

- 고객을 성을 기준으로 내림차순으로 정렬

```sql
SELECT
	contactLastname,
	contactFirstname
FROM
	customers
ORDER BY
	contactLastname DESC;
```

### **MySQL ORDER BY 절을 사용하여 결과 집합을 여러 열로 정렬하는 예**

- 고객을 성을 내림차순으로 정렬한 다음 이름을 오름차순으로 정렬

```sql
SELECT 
    contactLastname, 
    contactFirstname
FROM
    customers
ORDER BY 
	contactLastname DESC , 
	contactFirstname ASC;
```
![[Pasted image 20251120012953.png]]
### **MySQL ORDER BY 절을 사용하여 표현식 예제로 결과 집합 정렬**

- `orderdetails`테이블에서 주문 라인 항목을 선택합니다. 각 라인 항목에 대한 부분합을 계산하고 부분합을 기반으로 결과 집합을 정렬

```sql
SELECT 
    orderNumber, 
    orderlinenumber, 
    quantityOrdered * priceEach
FROM
    orderdetails
ORDER BY 
   quantityOrdered * priceEach DESC;
```
![[Pasted image 20251120012959.png]]
- 쿼리를 더 읽기 쉽게 만들려면 다음 쿼리와 같이 `SELECT`절의 표현식에 [열 별칭](https://www.mysqltutorial.org/mysql-alias/) 을 할당하고 해당 열 별칭을 절에서 사용할 수 `ORDER BY`있음

```sql
SELECT 
    orderNumber,
    orderLineNumber,
    quantityOrdered * priceEach AS subtotal
FROM
    orderdetails
ORDER BY subtotal DESC;
```
![[Pasted image 20251120013004.png]]
### **`WHERE`**

- 이 절을 사용하여 `WHERE`
    
    조건별로 행을 필터링합니다.
    
- MySQL은 `WHEREFROMSELECTORDER BY`
    
    절 뒤 와 and 절
    
    앞 절을 평가합니다 .
    
    ![[Pasted image 20251120013013.png]]
    ![[Pasted image 20251120013020.png]]
    
    ### **1) 등호 연산자 예제와 함께 MySQL WHERE 절 사용**
    
    ```sql
    SELECT 
        lastname, 
        firstname, 
        jobtitle
    FROM
        employees
    WHERE
        jobtitle = 'Sales Rep';
    ```
    
    ![[Pasted image 20251120013026.png]]
    
    ### **2) AND 연산자와 함께 MySQL WHERE 절 사용**
    
    ```sql
    SELECT 
        lastname, 
        firstname, 
        jobtitle,
        officeCode
    FROM
        employees
    WHERE
        jobtitle = 'Sales Rep' AND 
        officeCode = 1;
    ```
    
    ![[Pasted image 20251120013033.png]]
    
    ### **3) OR 연산자와 함께 MySQL WHERE 절 사용**
    
    ```sql
    SELECT 
        lastName, 
        firstName, 
        jobTitle, 
        officeCode
    FROM
        employees
    WHERE
        jobtitle = 'Sales Rep' OR 
        officeCode = 1
    ORDER BY 
        officeCode , 
        jobTitle;
    ```
    
    ![[Pasted image 20251120013038.png]]
    
    ### **4) BETWEEN 연산자 예제와 함께 MySQL WHERE 절 사용**
    
    [`BETWEEN`](https://www.mysqltutorial.org/mysql-between)연산자는 `TRUE`값이 값 범위에 있는 경우 반환 합니다.
    
    ```
    expression BETWEEN low AND high
    코드 언어:SQL(구조적 쿼리 언어)(sql)
    ```
    
    다음 쿼리는 사무실 코드가 1에서 3 사이인 사무실에 있는 직원을 찾음
    
    ```sql
    SELECT 
        firstName, 
        lastName, 
        officeCode
    FROM
        employees
    WHERE
        officeCode BETWEEN 1 AND 3
    ORDER BY officeCode;
    ```
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f2b3ae2e-8daf-4e42-b9ff-52289d89f296/Untitled.png)
    
    ### 5) LIKE 연산자 예제와 함께 MySQL WHERE 절 사용
    
    [`LIKE`](https://www.mysqltutorial.org/mysql-like/)연산자는 값이 지정된 패턴과 일치하는지 평가 합니다 `TRUE`.
    
    패턴을 형성하려면 `%`및 `_`와일드카드를 사용합니다. `%`와일드카드는 0개 이상의 문자와 일치하는 반면 와일드 `_`카드는 단일 문자와 일치합니다.
    
    다음 쿼리는 성이 문자열로 끝나는 직원을 찾습니다 `'son'`.
    
    ```sql
    SELECT 
        firstName, 
        lastName
    FROM
        employees
    WHERE
        lastName LIKE '%son'
    ORDER BY firstName;
    ```
    
    ![[Pasted image 20251120013048.png]]
    
    ### 6) IN 연산자 예제와 함께 MySQL WHERE 절 사용
    
    [`IN`](https://www.mysqltutorial.org/mysql-basics/mysql-in/)연산자는 값이 목록의 값과 일치하는 경우 반환 합니다 `TRUE`.
    
    ```
    value IN (value1, value2,...)
    코드 언어:SQL(구조적 쿼리 언어)(sql)
    ```
    
    다음 예에서는 연산자 `WHERE`와 함께 절을 사용 `IN`하여 사무실 코드가 1인 사무실에 있는 직원을 찾습니다.
    
    ```sql
    SELECT 
        firstName, 
        lastName, 
        officeCode
    FROM
        employees
    WHERE
        officeCode IN (1 , 2, 3)
    ORDER BY 
        officeCode;
    ```
    
    ![[Pasted image 20251120013056.png]]
    
    ### 7) IS NULL 연산자와 함께 MySQL WHERE 절 사용
    
    값이 있는지 확인하려면 등호 연산자( )가 아닌 연산자 [`NULL`](https://www.mysqltutorial.org/mysql-null/)를 사용합니다 . 연산자는 값이 이면 반환 합니다 .[`IS NULL](<https://www.mysqltutorial.org/mysql-is-null/>)=IS NULLTRUENULL`
    
    ```
    value IS NULL
    코드 언어:SQL(구조적 쿼리 언어)(sql)
    ```
    
    데이터베이스 세계에서 `NULL`값이 없거나 알 수 없음을 나타내는 마커입니다. 그리고 NULL은 숫자 0 또는 빈 문자열과 동일하지 않습니다.
    
    다음 명령문은 연산자 `WHERE`와 함께 절을 사용하여 열의 값이 있는 행을 가져옵니다 .`IS NULLreportsToNULL`
    
    ```sql
    SELECT 
        lastName, 
        firstName, 
        reportsTo
    FROM
        employees
    WHERE
        reportsTo IS NULL;
    ```
    
    ![[Pasted image 20251120013102.png]]
    
    ### **8) 비교 연산자와 함께 MySQL WHERE 절 사용**
    
    다음 쿼리는 같지 않음(<>) 연산자를 사용하여 다음이 아닌 모든 직원을 찾습니다 `Sales Rep`.
    
    ```sql
    SELECT 
        lastname, 
        firstname, 
        jobtitle
    FROM
        employees
    WHERE
        jobtitle <> 'Sales Rep';
    ```
    
    ![[Pasted image 20251120013108.png]]
    
    다음 쿼리는 사무실 코드가 5보다 큰 직원을 찾습니다
    
    ```sql
    SELECT 
        lastname, 
        firstname, 
        officeCode
    FROM
        employees
    WHERE 
        officecode > 5;
    ```
    
    ![[Pasted image 20251120013114.png]]
    다음 쿼리는 사무실 코드가 4(<=4) 이하인 직원을 반환
    
    ```sql
    SELECT 
        lastname, 
        firstname, 
        officeCode
    FROM
        employees
    WHERE 
        officecode <= 4;
    ```
    
   ![[Pasted image 20251120013119.png]]
    
    ### MySQL DISTINCT 절 소개
    
    테이블에서 데이터를 쿼리할 때 중복 행이 나타날 수 있습니다. 이러한 중복 행을 제거하려면 문 `DISTINCT` 에서 절 을 사용
    
    ![[Pasted image 20251120013125.png]]
    
    성이 동일한건 한번만 선택하여 출력
    
    ```sql
    SELECT 
        DISTINCT lastname
    FROM
        employees
    ORDER BY 
        lastname;
    ```
    
    ### 여러 열이 있는 MySQL DISTINCT
    
    `DISTINCT`절 에 여러 열을 지정하면 `DISTINCT`절은 이러한 열의 값 조합을 사용하여 결과 집합에 있는 행의 고유성을 결정합니다.
    
    예를 들어, 테이블에서 도시와 주의 고유한 조합을 얻으려면 `customers`다음 쿼리를 사용
    
    ```sql
    SELECT DISTINCT
        state, city
    FROM
        customers
    WHERE
        state IS NOT NULL
    ORDER BY 
        state, 
        city;
    ```
    
    ![[Pasted image 20251120013147.png]]
    
    ## MySQL AND 연산자 소개
    
    MySQL에는 기본 제공 부울 유형이 없습니다. 대신 숫자 0을 FALSE로 사용하고 0이 아닌 값을 TRUE로 사용합니다.
    
    `AND`연산자는 둘 이상의 [부울](https://www.mysqltutorial.org/mysql-boolean/) 표현식을 결합하고 1, 0 또는 NULL을 반환 하는 논리 연산자
    
    연산자 를 사용하여 `AND`둘 이상의 부울 표현식을 결합할 수 있습니다. 예를 들어 다음 쿼리는 미국 캘리포니아에 거주하고 신용 한도가 100,000보다 큰 고객을 반환
    
    - `AND`
        
        연산자를 사용 하여 두 개의 부울 표현식을 결합합니다. 연산자는 두 표현식 이
        
        모두 true일 때 true를 반환합니다. 그렇지 않으면 false를 반환합니다.
        
    - `AND`연산자를 사용 하여 `WHERE`명령문 의 `SELECT`절 에서 조건을 형성합니다.
        
    
    ```sql
    SELECT 
        customername, 
        country, 
        state, 
        creditlimit
    FROM
        customers
    WHERE
        country = 'USA' AND 
        state = 'CA' AND 
        creditlimit > 100000;
    ```
    
    ![[Pasted image 20251120013211.png]]
    
    ## MySQL OR 연산자 소개
    
    MySQL 연산자는 두 개의 [부울](https://www.mysqltutorial.org/mysql-boolean/) 표현식 `OR`을 결합한 논리 연산자
    
    ## 연산자 우선순위
    
    표현식에 `AND`and `OR`연산자가 모두 포함되어 있으면 MySQL은 연산자 우선 순위를 사용하여 연산자 평가 순서를 결정합니다. MySQL은 우선 순위가 높은 연산자를 먼저 평가합니다.
    
    `AND`연산자는 연산자보다 우선 순위가 높기 때문에 MySQL은 연산자보다 먼저 연산자 `OR`를 평가 `AND`합니다
    
    다음 예에서는 `OR`연산자를 사용하여 미국 또는 프랑스에 있고 신용 한도가 100,000보다 큰 고객을 선택
    
    ```sql
    SELECT   
    	customername, 
    	country, 
    	creditLimit
    FROM   
    	customers
    WHERE(country = 'USA'
    		OR country = 'France')
    	  AND creditlimit > 100000;
    ```
    
    ![[Pasted image 20251120013225.png]]
    
    ## MySQL IN 연산자 소개
    
    연산자를 사용하면 값 이 `IN`값 목록의 값과 일치하는지 확인할 수 있습니다. 다음은 `IN`연산자 구문
    
    ```sql
    value IN (value1, value2, value3,...)
    ```
    
    ## MySQL IN 연산자 및 NULL
    
    일반적으로 `IN`연산자는 `NULL`다음 두 가지 경우에 반환합니다.
    
    - 연산자 의 `value`
        
        왼쪽은 NULL입니다.
        
    - 값이 목록의 값과 같지 않고 목록의 값 중 하나가 NULL입니다.
        
    
    다음 예제에서는 IN 연산자의 왼쪽 값이 NULL이므로 NULL을 반환합니다.
    
    ```
    SELECT NULL IN (1,2,3);
    
    ```
    
    다음 예에서는 `IN`연산자를 사용하여 미국과 프랑스에 있는 사무실을 찾음
    
    ```sql
    SELECT 
        officeCode, 
        city, 
        phone, 
        country
    FROM
        offices
    WHERE
        country IN ('USA' , 'France');
    ```
    
    ```sql
    SELECT 
        officeCode, 
        city, 
        phone
    FROM
        offices
    WHERE
        country = 'USA' OR country = 'France';
    ```
    
    ![[Pasted image 20251120013236.png]]
    연산자를 사용하여 및 에 `NOT IN`없는 사무실을 찾음
    
    ```sql
    SELECT 
        officeCode, 
        city, 
        phone
    FROM
        offices
    WHERE
        country NOT IN ('USA' , 'France')
    ORDER BY 
        city;
    ```
    
    ![[Pasted image 20251120013242.png]]
    
    ## MySQL BETWEEN 연산자 소개
    
    연산자는 값 이 `BETWEEN`범위에 있는지 여부를 지정하는 논리 연산자
    
    ```sql
    value BETWEEN low AND high;
    ```
    
    `<`보다 작음( ), 보다 큼( `>`) 및 논리 연산자( ) 를 사용하여 위의 쿼리를 다음과 같이 다시 작성할 수 있습니다 [`AND`](https://www.mysqltutorial.org/mysql-and/).
    
    ```sql
    SELECT 
        productCode, 
        productName, 
        buyPrice
    FROM
        products
    WHERE
        buyPrice < 20 OR buyPrice > 100;
    ```
    
    ![[Pasted image 20251120013249.png]]
    ### **날짜 예제와 함께 MySQL BETWEEN 연산자 사용**
    
    값이 날짜 범위 사이에 있는지 확인하려면 값을 [DATE](https://www.mysqltutorial.org/mysql-date/) 유형 으로 명시적으로 [캐스트 해야 합니다.](https://www.mysqltutorial.org/mysql-cast/)
    
    예를 들어 다음 문은 2003년 1월 1일에서 2003년 1월 31일 사이에 필요한 날짜가 있는 주문을 반환
    
    ```sql
    SELECT 
       orderNumber,
       requiredDate,
       status
    FROM 
       orders
    WHERE 
       requireddate BETWEEN 
         CAST('2003-01-01' AS DATE) AND 
         CAST('2003-01-31' AS DATE);
    ```
    
    ![[Pasted image 20251120013255.png]]
    
    ## MySQL LIKE 연산자 소개
    
    연산자는 문자열에 지정된 패턴 이 `LIKE`포함되어 있는지 여부를 테스트하는 논리 연산자
    
    ```sql
    expression LIKE pattern ESCAPE escape_character
    ```
    
    ### 백분율(%) 와일드카드 예제와 함께 MySQL LIKE 연산자 사용
    
    이 예에서는 `LIKE` 연산자를 사용하여 이름이 문자로 시작하는 직원을 찾습니다 `a`
    
    ```sql
    SELECT 
        employeeNumber, 
        lastName, 
        firstName
    FROM
        employees
    WHERE
        firstName LIKE 'a%';
    ```
    
    ![[Pasted image 20251120013302.png]]
    
    연산자를 사용하여 성이 리터럴 문자열 (예: , ) `LIKE`로 끝나는 직원을 찾습니다 .`onPattersonThompson`
    
    ```sql
    SELECT 
        employeeNumber, 
        lastName, 
        firstName
    FROM
        employees
    WHERE
        lastName LIKE '%on';
    ```
    
    ![[Pasted image 20251120013308.png]]
    
    ### 밑줄( ) 와일드카드 예제 와 함께 MySQL LIKE 연산자 사용
    
    이름이 문자로 시작하고 문자  `T`로 끝나고 , , `m`사이에 단일 문자를 포함하는 직원을 찾으려면 밑줄(_) 와일드카드를 사용하여 다음과 같이 패턴을 구성합니다.`TomTim`
    
    ```sql
    SELECT 
        employeeNumber, 
        lastName, 
        firstName
    FROM
        employees
    WHERE
        firstname LIKE 'T_m';
    ```
    
    ![[Pasted image 20251120013315.png]]
    
    ### MySQL NOT LIKE 연산자 사용 예
    
    - 연산자를 사용하여 `LIKE`
        
        값이 패턴과 일치하는지 테스트합니다.
        
    - 와일드 `%`
        
        카드는 0개 이상의 문자와 일치합니다.
        
    - 와일드 `_`
        
        카드는 단일 문자와 일치합니다.
        
    - Use `ESCAPE\\`
        
        절은 기본 이스케이프 문자( ) 이외의 이스케이프 문자를 지정합니다
        
        .
        
    - 연산자를 사용하여 `NOTLIKE`
        
        연산자를 부정합니다
        
        .
        
    
    MySQL을 사용하면 `NOT`연산자와 연산자 를 결합하여 `LIKE`특정 패턴과 일치하지 않는 문자열을 찾을 수 있습니다.
    
    성이 문자로 시작하지 않는 직원을 검색하려는 경우 다음과 같이 연산자를 `B`사용할 수 있습니다 .`NOT LIKE`
    
    ```sql
    SELECT 
        employeeNumber, 
        lastName, 
        firstName
    FROM
        employees
    WHERE
        lastName NOT LIKE 'B%';
    ```
    
    ![[Pasted image 20251120013323.png]]
    
    ## MySQL LIMIT 절 소개
    
    이 `LIMIT`절은 [`SELECT`](https://www.mysqltutorial.org/mysql-select-statement-query-data.aspx)반환할 행 수를 제한하기 위해 문에서 사용됩니다. 이 `LIMIT`절은 하나 또는 두 개의 인수를 허용합니다. 두 인수의 값은 0 또는 양의 [정수](https://www.mysqltutorial.org/mysql-int/)
    
    • MySQL 절을 사용  하여 명령문 `LIMIT` 이 반환하는 행 수를 제한합니다  .`SELECT`
    
    ### LIMIT 및 ORDER BY 절
    
    기본적으로 `SELECT`문은 지정되지 않은 순서로 행을 반환합니다. `LIMIT`명령문에 절을 추가하면 `SELECT`반환되는 행을 예측할 수 없습니다.
    
    따라서 절이 예상 출력을 반환하도록 하려면 항상 다음과 같은 절과 `LIMIT`함께 사용해야 합니다 .[`ORDER BY`](https://www.mysqltutorial.org/mysql-order-by/)
    
    ```sql
    SELECT 
        select_list
    FROM 
        table_name
    ORDER BY 
        sort_expression
    LIMIT offset, row_count;
    ```
    
    ### 페이지 매김을 위해 MySQL LIMIT 절 사용
    
    화면에 데이터를 표시할 때 행을 페이지로 나누고자 하는 경우가 많습니다. 각 페이지에는 10 또는 20과 같이 제한된 수의 행이 포함
    
    ```sql
    SELECT 
        customerNumber, 
        customerName
    FROM
        customers
    ORDER BY customerName    
    LIMIT 10;
    ```
    
    ![[Pasted image 20251120013330.png]]
    
    ```sql
    SELECT 
        customerNumber, 
        customerName
    FROM
        customers
    ORDER BY customerName    
    LIMIT 5, 5;
    ```
    
    ![[Pasted image 20251120013337.png]]
    
    ## MySQL LIMIT 및 DISTINCT 절
    
    `LIMIT`절과 함께 절 을 사용하는 경우 [`DISTINCT`](https://www.mysqltutorial.org/mysql-distinct.aspx) MySQL은 절에 지정된 고유 행 수를 찾으면 즉시 검색을 중지합니다 `LIMIT`.
    
    이 예에서는 `LIMIT`절과 함께 절을 사용하여 테이블 `DISTINCT`의 처음 5개 고유 상태를 반환
    
    ```sql
    SELECT DISTINCT
        state
    FROM
        customers
    WHERE
        state IS NOT NULL
    LIMIT 5;
    ```
    
    ![[Pasted image 20251120013341.png]]
    
    ## MySQL IS NULL 연산자 소개
    
    값이 있는지 여부를 테스트하려면 연산자 `NULL`를 사용
    
    - `IS NULLNULLIS NULLNULL`
        
        연산자를 사용하여 값이 있는지 여부를 테스트합니다
        
        . 연산자는 값 이
        
        이면 1을 반환합니다
        
        .
        
    - 값 이 `IS NOT NULLNULL`
        
        아닌 경우 1을 반환합니다
        
        .
        
    
    ```sql
    SELECT 1 IS NULL,  -- 0
           0 IS NULL,  -- 0
           NULL IS NULL; -- 1
    ```
    
    쿼리는 `IS NULL`연산자를 사용하여 영업 담당자가 없는 고객을 찾음
    
    ```sql
    SELECT 
        customerName, 
        country, 
        salesrepemployeenumber
    FROM
        customers
    WHERE
        salesrepemployeenumber IS NULL
    ORDER BY 
        customerName;
    ```
    
    ![[Pasted image 20251120013350.png]]
    
    ## MySQL IS NULL – 특수 기능
    
    ODBC 프로그램과 호환되도록 MySQL은 `IS NULL`연산자의 일부 특수 기능을 지원
    
    ### 날짜 '0000-00-00' 처리
    
    1) [`DATE`](https://www.mysqltutorial.org/mysql-date/)또는 [`DATETIME`](https://www.mysqltutorial.org/mysql-datetime/)열에 [`NOT NULL`](https://www.mysqltutorial.org/mysql-not-null-constraint/)제약 조건이 있고 특수 날짜가 포함된 경우 연산자를 `'0000-00-00'`사용하여 `IS NULL`이러한 행을 찾을 수 있습니다.
    
    먼저 다음과 같은 테이블을 만듭니다 `projects`.
    
    ```sql
    CREATE TABLE IF NOT EXISTS projects (
        id INT AUTO_INCREMENT,
        title VARCHAR(255),
        begin_date DATE NOT NULL,
        complete_date DATE NOT NULL,
        PRIMARY KEY(id)
    );
    ```
    
    `projects`둘째, 테이블 에 일부 행을 삽입 합니다.
    
    ```sql
    INSERT INTO projects(title,begin_date, complete_date)
    VALUES('New CRM','2020-01-01','0000-00-00'),
          ('ERP Future','2020-01-01','0000-00-00'),
          ('VR','2020-01-01','2030-01-01');
    ```
    
    셋째, `IS NULL`연산자를 사용하여 `complete_date`열의 값이 is 인 행을 선택합니다 `'0000-00-00'`.
    
    ```sql
    SELECT * 
    FROM projects
    WHERE complete_date IS NULL;
    ```