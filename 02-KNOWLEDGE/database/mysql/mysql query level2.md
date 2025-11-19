---
tags:
  - mysql
  - database
---
## 열에 대한 MySQL 별칭

경우에 따라 열 이름이 너무 기술적이어서 쿼리 출력을 이해하기가 매우 어렵습니다. 열에 설명적인 이름을 지정하려면 열 별칭을 사용할 수 있습니다.

다음 문은 열 별칭을 사용하는 방법을 보여줍니다.

```
SELECT
   [column_1 | expression] AS descriptive_name
FROM table_name;
코드 언어:SQL(구조적 쿼리 언어)(sql)
```

열에 별칭을 할당하려면 `AS`키워드 다음에 별칭을 사용합니다. 별칭에 공백이 포함된 경우 다음과 같이 인용해야 합니다.

```
SELECT
   [column_1 | expression] AS `descriptive name`
FROM
   table_name;
코드 언어:SQL(구조적 쿼리 언어)(sql)
```

키워드는 선택 사항 이므로 `AS`문에서 생략할 수 있습니다. 표현식에 별칭을 지정할 수도 있습니다

직원의 이름과 성을 선택합니다. 이름과 성을 전체 이름으로 [연결](https://www.mysqltutorial.org/sql-concat-in-mysql.aspx)`CONCAT_WS()` 하는 기능을 사용

```sql
SELECT
   CONCAT_WS(', ', lastName, firstname) AS `Full name`
FROM
   employees;
```
![[Pasted image 20251120013752.png]]
총 금액이 60000보다 큰 주문을 선택합니다 . `GROUP BY`및 `HAVING`절에서 열 별칭을 사용합니다.

```sql
SELECT
	orderNumber `Order no.`,
	SUM(priceEach * quantityOrdered) total
FROM
	orderDetailsGROUP BY
	`Order no.`
HAVING
	total > 60000;

```

## 테이블에 대한 MySQL 별칭

별칭을 사용하여 테이블에 다른 이름을 지정할 수 있습니다. `AS`키워드를 다음 구문으로 사용하여 테이블 별칭을 할당 합니다.

```
table_name AS table_alias
코드 언어:SQL(구조적 쿼리 언어)(sql)
```

테이블의 별칭을 테이블 별칭이라고 합니다. 열 별칭과 마찬가지로 `AS`키워드는 선택 사항이므로 생략할 수 있습니다.

```sql
SELECT * FROM employees e;
```
![[Pasted image 20251120013759.png]]
```sql
SELECT 
    e.firstName, 
    e.lastName
FROM
    employees e
ORDER BY e.firstName;
```
![[Pasted image 20251120013806.png]]
![[Pasted image 20251120013814.png]]

테이블 별칭을 사용하여 `customerNumber`열을 한정

```sql
SELECT
	customerName,
	COUNT(o.orderNumber) total
FROM
	customers c
INNER JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY
	customerName
ORDER BY
	total DESC;
```
![[Pasted image 20251120013822.png]]
# 조인

## 샘플 테이블 생성

```sql
CREATE TABLE members (
    member_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (member_id)
);

CREATE TABLE committees (
    committee_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (committee_id)
);
```

```sql
INSERT INTO members(name)
VALUES('John'),('Jane'),('Mary'),('David'),('Amelia');

INSERT INTO committees(name)
VALUES('John'),('Mary'),('Amelia'),('Joe');
```
![[Pasted image 20251120013858.png]]
![[Pasted image 20251120013911.png]]
## MySQL INNER JOIN 절

다음은 두 테이블을 조인하는 내부 조인 절의 기본 구문을 보여 `table_1`줍니다 `table_2`.

```
SELECT column_list
FROM table_1
INNER JOIN table_2 ON join_condition;
코드 언어:SQL(구조적 쿼리 언어)(sql)
```

[내부 조인](https://www.mysqltutorial.org/mysql-inner-join.aspx) 절 은 조인 술어로 알려진 조건에 따라 두 테이블을 조인

이 예에서 내부 조인 절은 두 테이블의 열에 있는 값을 사용하여 일치 `name`시킴

```sql
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
INNER JOIN committees c ON c.name = m.name;
```

```sql
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
INNER JOIN committees c USING(name);
```
![[Pasted image 20251120013919.png]]
![[Pasted image 20251120013927.png]]

## MySQL LEFT JOIN 절

내부 조인과 마찬가지로 [왼쪽 조인](https://www.mysqltutorial.org/mysql-left-join.aspx) 에도 조인 조건자가 필요합니다. 왼쪽 조인을 사용하여 두 테이블을 조인할 때 왼쪽 및 오른쪽 테이블의 개념이 도입

즉, 왼쪽 조인은 오른쪽 테이블에 일치하는 행이 있는지 여부에 관계없이 왼쪽 테이블의 모든 데이터를 선택합니다.

오른쪽 테이블에서 일치하는 행이 없는 경우 왼쪽 조인은 결과 집합의 오른쪽 테이블에서 행의 열에 대해 NULL을 사용

두 테이블을 조인하는 왼쪽 조인 절의 기본 구문입니다.

```
SELECT column_list
FROM table_1
LEFT JOIN table_2 ON join_condition;
코드 언어:SQL(구조적 쿼리 언어)(sql)
```

왼쪽 조인은 `USING`두 테이블의 일치에 사용되는 열이 동일한 경우에도 절을 지원합니다.

```
SELECT column_list
FROM table_1
LEFT JOIN table_2 USING (column_name);
코드 언어:SQL(구조적 쿼리 언어)(sql)
```

다음 예에서는 왼쪽 조인 절을 `members`사용하여 `committees`테이블과 조인

```sql
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
LEFT JOIN committees c USING(name);
```
![[Pasted image 20251120013935.png]]
![[Pasted image 20251120013941.png]]

위원회 구성원이 아닌 구성원을 찾으려면 다음과 같이 [`WHERE`](https://www.mysqltutorial.org/mysql-where/)절과 [`IS NULL`](https://www.mysqltutorial.org/mysql-is-null/)연산자를 추가합니다.

```sql
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
LEFT JOIN committees c USING(name)
WHERE c.committee_id IS NULL;
```
![[Pasted image 20251120013948.png]]
![[Pasted image 20251120013953.png]]

## MySQL RIGHT JOIN 절

[오른쪽 조인](https://www.mysqltutorial.org/mysql-right-join/) 절 은 왼쪽 및 오른쪽 테이블의 처리가 반대라는 점을 제외하고는 왼쪽 조인 절과 유사

다음은 오른쪽 조인의 구문입니다.

```
SELECT column_list
FROM table_1
RIGHT JOIN table_2 ON join_condition;
코드 언어:SQL(구조적 쿼리 언어)(sql)
```

왼쪽 조인 절과 유사하게 오른쪽 절도 다음 `USING`구문을 지원합니다.

```
SELECT column_list
FROM table_1
RIGHT JOIN table_2 USING (column_name);
코드 언어:SQL(구조적 쿼리 언어)(sql)
```

왼쪽 테이블에 해당 행이 없는 오른쪽 테이블의 행을 찾으려면 연산자 [`WHERE`](https://www.mysqltutorial.org/mysql-where/)와 함께 절도 사용합니다.[`IS NULL`](https://www.mysqltutorial.org/mysql-is-null/)

```
SELECT column_list
FROM table_1
RIGHT JOIN table_2 USING (column_name)
WHERE column_table_1 IS NULL;
코드 언어:SQL(구조적 쿼리 언어)(sql)
```

이 문은 올바른 조인을 사용하여 `members`및 `committees`테이블을 조인합니다.

```sql
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
RIGHT JOIN committees c on c.name = m.name;
```
![[Pasted image 20251120014001.png]]
![[Pasted image 20251120014007.png]]

테이블 에 없는 위원회 구성원을 찾으려면 `members`다음 쿼리를 사용합니다.

```sql
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
RIGHT JOIN committees c USING(name)
WHERE m.member_id IS NULL;
```

![[Pasted image 20251120014013.png]]
![[Pasted image 20251120014017.png]]


## MySQL CROSS JOIN 절

[내부 조인](https://www.mysqltutorial.org/mysql-inner-join.aspx) , [왼쪽 조인](https://www.mysqltutorial.org/mysql-left-join.aspx) , [오른쪽 조인](https://www.mysqltutorial.org/mysql-right-join/) 과 달리 [교차 조인](https://www.mysqltutorial.org/mysql-cross-join/) 절에는 조인 조건이 없습니다.

교차 조인은 조인된 테이블의 행을 데카르트 곱으로 만듭니다. 교차 조인은 첫 번째 테이블의 각 행을 오른쪽 테이블의 모든 행과 결합하여 결과 집합

`n`첫 번째 테이블에 행이 있고 두 번째 테이블에 행 이 있다고 가정합니다 `m`. 테이블을 조인하는 교차 조인은 `nxm`행을 반환합니다.

다음은 교차 조인 절의 구문을 보여줍니다.

```
SELECT select_list
FROM table_1
CROSS JOIN table_2;
코드 언어:SQL(구조적 쿼리 언어)(sql)
```

이 예에서는 교차 조인 절을 사용 `members`하여 `committees`테이블과 조인
![[Pasted image 20251120014028.png]]
[MySQL Join Made Easy For Beginners](https://www.mysqltutorial.org/mysql-join/)