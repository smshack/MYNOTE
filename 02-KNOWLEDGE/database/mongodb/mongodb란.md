---
tags:
  - database
  - mongodb
---
![[Pasted image 20251120010052.png]]
# 1. 몽고DB 란? - 몽고 DB가 뭘까

- 비필수 스키마와 함께 JSON과 같은 문서를 사용하여 대량의 데이터를 저장하는 NoSQL 데이터베이스
- MongoDB는 기존의 테이블 기반 관계형 데이터베이스 구조가 아닌 문서 지향 [데이터 모델](https://kr.teradata.com/Glossary/What-is-Data-Modeling) 을 사용하는 교차 플랫폼 오픈 소스 데이터베이스입니다. 이러한 유형의 모델을 사용하면 [정형 및](https://kr.teradata.com/Glossary/What-is-Structured-Data)  [비정형 데이터](https://kr.teradata.com/Glossary/What-is-Unstructured-Data)를 보다 쉽고 빠르게 통합할 수 있습

## 몽고 DB의 특징

1. Document-Oriented Storage: 모든 데이터가 JSON 형태로 저장되며 스키마가 없음
    - 스키마가 없기 때문에 각 필드는 서로 다른 데이터 타입을 가질 수 있고 데이터베이스에 저장된 Documents도 각기 다른 다양한 필드를 가질 수 있다.
    - 복잡한 구조를 쉽게 저장할 수 있다.
    - Join을 사용하지 않아도 되고 다형성을 가능케한다.
2. Full Index Support: RDBMS에 뒤지지 않는 다양한 인덱싱 제공
    - 강력한 인덱스 기능 덕분에 거의 모든 쿼리들을 빠르게 처리할 수 있다.
    - `다른 NoSQL에서 찾아보기 힘든 장정미다.`
3. Replication & High Availability: 데이터 복제를 통한 가용성 향상
4. Auto-Sharing: Primary key를 기반으로 여러 서버에 데이터를 나누는 scale-out이 가능
5. Querying: Key 기반의 get, put뿐만 아니라 다양한 종류의 쿼리 제공
    - 강력한 쿼리 기능과 다양한 쿼리를 지원한다.
6. Fast In-Place Updates: 고성능 atomic operation 지원
7. MapReduce: 맵리듀스 지원
8. GridFS:

- 별도의 스토리지 엔진을 통해 파일 저장. 스토리지 엔진에서 DB 엔진을 분리하는 새로운 아키텍처를 도입
- 몽고DB의 기본 스토리지 엔진인 와이어드 타이거(Wired Tiger)는 높은 쓰기 성능을 제공하고, 압축을 기본 내장해 더 적은 스토리지 비용을 요구
- 별개의 인메모리와 암호화 데이터스토어를 추가. 또한 몽고DB는 스파크 커넥터를 제공해 대용량 인메모리 분석을 지원

## 몽고DB 데이터 모델링
![[Pasted image 20251120005915.png]]
### Database:

- 컬렉션의 물리적 컨테이너

### Collection

- RDBMS의 table 역할
- document의 그룹
- rdbms와 달리 스키마를 따로 갖고 있지 않음(동적 스키마로 생성)

### Document

- nosql을 다른말로 Document Oriented Database라함
- 한개 이상의 key-value 쌍으로 이루어진 구조
- rdbms에서의 row or tuple과 유사

### key/Field

- rdbms에서의 column
- 컬럼 명과 저장값으로 생각하면 쉬움

![[Pasted image 20251120005934.png]]

인스타그램에서 게시물을 올릴 때 필요한 정보는 다음과 같다.

- 게시글에는 사진, 설명, 작성자, 작성일이 포함되어 있다.
    
- 게시글에는 0개 이상의 해쉬태그를 가질 수 있다.
    
- 게시글에 덧글을 달 수 있다.
    
    ![[Pasted image 20251120005946.png]]
    

![[Pasted image 20251120005951.png]]

```json
{
  _id: POST_ID, title: POST_TITLE,
  content: POST_CONTENT,
  author: POST_WRITER,
  hashtags: [ TAG1, TAG2, TAG3 ], // subdocument 
  time: POST_TIME
  comments: [ // subdocument 
     { 
       username: COMMENT_WRITER,
       mesage: COMMENT_MESSAGE,
       time: COMMENT_TIME
     },
     { 
       username: COMMENT_WRITER,
       mesage: COMMENT_MESSAGE,
       time: COMMENT_TIME
     }
  ]
}
```

한 쌍 이상의 **Key 와 value**가 pair 로 이루어진

**Document**들이 모여 **Collection** 을 이루고,

**Collection** 들은 **Database** 안에 포함 되어 있다.

그리고 Database 는 Server 안에 위치한다

# 2. 데이터 저장 형식 - 데이터를 어떻게 저장해서 사용할까?

### **JSON 형식**

일반적으로 JSON은 JavaScript Object Notation의 줄임말로 Javascript 언어의 일부로 정의되어있는 형식이며 2013년에 공식화 된 형식이다.

JSON의 형태는 일반적으로 key와 value의 값으로 채워져 있다.

직관적이고 간단한 특성으로 쉽게 이해할 수 있는 형태의 표현 방법

```json
{
	"_id": "10009999",
	"listing_url": "<https://www.aaabbb.com/rooms/10009999>",
	"name": "Horto flat with small garden",
	"summary": "One bedroom + sofa-bed ...",
	"cancellation_policy": "flexible",
	"last_scraped": {
		"$date": {
			"$numberLong": "1549861200000"
		}
	}
}
```

### **BSON 형식**

BSON은 단순히 말하면 Binary JSON이다.

JSON과 동일한 구조지만 _**Binary 형태로 변경된 구조**_를 말한다.

그럼 JSON이 있는데 왜 BSON이 등장한 것일까?

몽고DB가 처음 개발될 때에는 JSON을 이용해서 개발을 진행했다고 한다. 그러다가 문제점 몇가지가 나타나기 시작한 것이다.

- _JSON은 텍스트 기반으로 구문 분석이 매우 느리다._
- _JSON은 공간 효율성과는 거리가 멀다. (데이터베이스 문제)_

이 외에도 여러가지 문제가 발생하여 고안해 낸것이 바로 BJSON 인 것이다.

JSON구조의 좋은점은 그대로 가져가면서 기계가 빠르게 읽을 수 있는 binary 형태로 변경하여 저장을 한 것이다.

동일한 형태로 사람에게 보여질 때에는 JSON의 형태로 보여주고, 저장할 때나 네트워크로 전송할 때에는 BSON 형태로 만들어서 저장 또는 전송한다.

```json
{"hello": "world"} 
 
→       \\x16\\x00\\x00\\x00           // total document size
        \\x02                       // 0x02 = type String
        hello\\x00                  // field name
        \\x06\\x00\\x00\\x00world\\x00  // field value
        \\x00                       // 0x00 = type EOO ('end of object')
```

# 3. 몽고 DB 장단점 , 활용시 고민 사항

## **장점**

1. **비동기 드라이버를 사용할 수 있다.**
    - 현재 JDBC의 경우 동기 드라이버만 존재해 블러킹 포인트가 된다.
2. **RDB와 개념이 유사해, 쿼리 변환기가 있을 만큼 개념적으로 어색하지 않다.**
    - 사용법도 마찬가지로 이질감이 없다.
3. **RDB에 비해 성능이 100배 이상 빠르다.**
    - 별도의 캐시 솔루션이 필요하지 않을 만큼 성능 문제에서 우월하다.
4. **스키마 관리가 필요 없다.**
5. **이미 성숙기에 접어들어 운용, 개발, 유틸리티에 부족함이 없다.**
    - Cassandra, Couchbase, MongoDB의 경우 대규모 트래픽, 데이터 저장, fail-over, fault-tolerance에 다양한 대안이 마련 되어있는 상황이다.
    - redis과 비교해봐도 충분히 안정권에 들어온 상태다.
6. **샤드 추가가 간편하다.**
    - 다른 NOSQL처럼 리밸런싱은 불가능하지만, 그럼에도 적정 수치때 샤드를 추가해준다면 장점은 충분히 누릴 수 있다.

## **단점**

1. **복잡한 쿼리를 사용할 수 없다.**
    - join을 사용할 수 없다.
2. **메모리 사용량이 큰 편이다.**
    - 메모리 부족 시 퍼포먼스가 급락한다.
3. **데이터 일관성이 보장되지 않는다.**
    - 다만, ACID 도입 베타 릴리즈 진행 중이다.

## **적절한 사용 사례**

1. 로그성 데이터나 빅데이터 처리의 중간 저장소
    - RDB보다는 성능이 우월하고, 파일보다는 다양한 유틸리티성 기능과 검색에 유연하다.
2. 설정 데이터의 보관소
    - 이는 Redis같은 Key-Value DB가 유용하다고 여겨질 수 있으나, 검색 조건의 다양화가 필요할 경우 MongoDB가 훨씬 유용하다.
3. null 필드가 많이 존재할 때
    - 데이터에 null 필드가 가변으로 다양하게 존재할 경우, rdb보다 스토리지 사용량, 처리 속도등에서 효율이 좋다.
4. 압도적인 퍼포먼스가 필요할 떄
    - RDB 대비 100배 이상의 차이를 내는 압도적인 퍼포먼스 차이.
    - memory mapped file 기반 구조에서의 장점
5. nosql 계열에서 압도적인 index 활용도
    - Single Field Indexes : 기본적인 인덱스 타입
    - Compound Indexes : RDBMS의 복합인덱스 같은 거
    - Multikey Indexes : Array에 매칭되는 값이 하나라도 있으면 인덱스에 추가하는 멀티키 인덱스
    - Geospatial Indexes and Queries : 위치기반 인덱스와 쿼리
    - Text Indexes : String에도 인덱싱이 가능
    - Hashed Index : Btree 인덱스가 아닌 Hash 타입의 인덱스도 사용 가능
6. 집계 연산, paging, 복잡한 쿼리 (단일 document 한정)가 필요할 때
    - key-value db (redis, aerospike 등)와 달리 집계 연산, paging이 가능함.
        - RDB와 동일한 접근의 데이터 스토어로서 사용 가능함.
            - 실제로 쿼리 변환기가 존재함.
7. 스키마 관리가 불필요함.
    - json 기반 저장 구조로, 유연한 동적 데이터 저장이 가능.
    - 정규화할 데이터보다는, 단일 스키마 기반의 참조 데이터 저장에 장점이 많음.
    - 로그성 데이터도 매우 적합 함.

## **부적절한 사용 사례**

1. 데이터 무결성이 가장 중요한 가치 일 때
    - 단일 document 무결성은 유지되지만, 멀티 document 무결성은 유지 되지 않음.
        - 애초에 join이 되지 않는지라, 일말이 오차는 존재할 수 있음.
2. 데이터 처리량보다 일관성 있는 데이터 구조가 중요할 때
    - 데이터 처리량이 빠른 이유는 ACID를 수행하지 않기 때문이다.
    - 특히 샤딩+레플리카를 조합해서 사용 할 때 무결성이 깨진 상태의 데이터가 조회 될 수 있다. (document 자체가 corrupt 된다는 의미는 아니고, 조회한 시점 이전의 데이터가 조회 될 수 있거나, 이미 삭제된 데이터가 조회될 수 있다는 의미)
3. 운용 이슈에 대한 우려 사항들이 해소가 덜 됐을 때
    - NoSQL 계열도 여타 DB와 마찬가지로 운용 이슈가 중요하고, 이에 대한 경험과 노하우가 부족하다면, 이 부분이 리스크가 될 수 있다.
    - 임계치가 높을 뿐 RDB와 마찬가지로 데이터가 많아지면 성능이 저하되는 부분은 마찬가지고, 이를 해결하기 위한 방안과, 풀 스캔이나, 메모리 사용량이 커질 수 있는 작업을 production 레벨에선 사용할 수 없게 만들어야 한다.
4. 데이터 무결성이 무엇보다 중요할 때
    - 결제, 아이템 등을 담기엔 여전히 RDB보단 불안한 면이 존재한다.
5. 엄격한 데이터 타입 검사나 연관 관계가 중요할 때
    - 데이터 타입이 동적 결정되는 스키마리스 DB이고, 컬럼도 동적 컬럼이다보니 마이그레이션이 어려운 편이고, 제약 검사를 추가할 만큼 스키마가 중요하다면 선택해선 안된다.
        - 코드 레벨에서 제어할 방법도 있지만, 접근 권한을 준 다른 서버 혹은 툴 등에서 쿼리를 날렸을 때 이를 막을 수 없다.
    - 또한 테이블 간 연관 관계가 중요하다면, 이 또한 선택지에서 배제해야 한다.
    - 위에서 언급한 대로 여러 document (테이블)을 동시에 조회할 수 없기에, 동일한 시점에 무결성이 깨지지 않은 데이터를 조회할 수 없다.

[MongoDB Vs MySQL](https://www.mongodb.com/ko-kr/compare/mongodb-mysql)

[MONGODB 정리 - NoSQL & mongoDB 주종면](https://blog.kjslab.com/159)

[MongoDB 샤딩](https://givemesource.tistory.com/87)

[비정형 데이터란? | 테라데이타](https://kr.teradata.com/Glossary/What-is-Unstructured-Data)

[[MONGO] 📚 몽고디비 특징 & 비교 & 구조 (NoSQL)](https://inpa.tistory.com/entry/MONGO-%F0%9F%93%9A-%EB%AA%BD%EA%B3%A0%EB%94%94%EB%B9%84-%ED%8A%B9%EC%A7%95-%EB%B9%84%EA%B5%90-%EA%B5%AC%EC%A1%B0-NoSQL?category=890811)

# 4. 몽고 DB 명령어 정리

## Create

[Insert Documents](https://www.mongodb.com/docs/manual/tutorial/insert-documents/)

### 단일 문서 삽입

- [`db.collection.insertOne()`](https://www.mongodb.com/docs/manual/reference/method/db.collection.insertOne/#mongodb-method-db.collection.insertOne)

```json
db.inventory.insertOne(
   { item: "canvas", qty: 100, tags: ["cotton"], size: { h: 28, w: 35.5, uom: "cm" } }
)
```
![[Pasted image 20251120010115.png]]
### 여러 문서 삽입

- [`db.collection.insertMany()`](https://www.mongodb.com/docs/manual/reference/method/db.collection.insertMany/#mongodb-method-db.collection.insertMany)

```json
db.inventory.insertMany([
   { item: "journal", qty: 25, tags: ["blank", "red"], size: { h: 14, w: 21, uom: "cm" } },
   { item: "mat", qty: 85, tags: ["gray"], size: { h: 27.9, w: 35.5, uom: "cm" } },
   { item: "mousepad", qty: 25, tags: ["gel", "blue"], size: { h: 19, w: 22.85, uom: "cm" } }
])
```
![[Pasted image 20251120010124.png]]
### **삽입을 위한 추가 방법**

다음 메서드는 컬렉션에 새 문서를 추가할 수도 있습니다.

- [`db.collection.updateOne()`](https://www.mongodb.com/docs/manual/reference/method/db.collection.updateOne/#mongodb-method-db.collection.updateOne)옵션 과 함께 사용할 때 `upsert: true`.
- [`db.collection.updateMany()`](https://www.mongodb.com/docs/manual/reference/method/db.collection.updateMany/#mongodb-method-db.collection.updateMany)옵션 과 함께 사용할 때 `upsert: true`.
- [`db.collection.findAndModify()`](https://www.mongodb.com/docs/manual/reference/method/db.collection.findAndModify/#mongodb-method-db.collection.findAndModify)옵션 과 함께 사용할 때 `upsert: true`.
- [`db.collection.findOneAndUpdate()`](https://www.mongodb.com/docs/manual/reference/method/db.collection.findOneAndUpdate/#mongodb-method-db.collection.findOneAndUpdate)옵션 과 함께 사용할 때 `upsert: true`.
- [`db.collection.findOneAndReplace()`](https://www.mongodb.com/docs/manual/reference/method/db.collection.findOneAndReplace/#mongodb-method-db.collection.findOneAndReplace)옵션 과 함께 사용할 때 `upsert: true`.
- [`db.collection.bulkWrite()`](https://www.mongodb.com/docs/manual/reference/method/db.collection.bulkWrite/#mongodb-method-db.collection.bulkWrite).

## Read

[Query Documents](https://www.mongodb.com/docs/manual/tutorial/query-documents/#specify-and-conditions)

### **컬렉션의 모든 문서 선택**

```json
db.inventory.find( {} )
## sql
## SELECT * FROM inventory

```
![[Pasted image 20251120010141.png]]
### 비교 쿼리 연산자

[Comparison Query Operators](https://www.mongodb.com/docs/manual/reference/operator/query-comparison/#std-label-query-selectors-comparison)

|이름|설명|
|---|---|
|$eq|지정된 값과 같은 값을 찾습니다.|
|$gt|지정된 값보다 큰 값과 일치합니다.|
|$gte|지정된 값보다 크거나 같은 값을 찾습니다.|
|$in|배열에 지정된 값 중 하나와 일치합니다.|
|$lt|지정된 값보다 작은 값과 일치합니다.|
|$lte|지정된 값보다 작거나 같은 값을 찾습니다.|
|$ne|지정된 값과 같지 않은 모든 값과 일치합니다.|
|$nin|배열에 지정된 값과 일치하지 않습니다.|

### 등식 조건 지정

```json
db.inventory.find( { status: "D" } )
## sql
## **SELECT * FROM inventory WHERE status = "D"**
```


![[Pasted image 20251120010149.png]]
### **`AND`조건 지정**

```json
db.inventory.find( { status: "A", qty: { $lt: 30 } } )

## sql
## SELECT * FROM inventory WHERE status = "A" AND qty < 30
```
![[Pasted image 20251120010207.png]]
### **`OR`조건 지정**

```json
db.inventory.find( { $or: [ { status: "A" }, { qty: { $lt: 30 } } ] } )
## sql
## SELECT * FROM inventory WHERE status = "A" OR qty < 30
```

### **조건 `AND`뿐만 아니라 지정`OR`**

```json
db.inventory.find( {
     status: "A",
     $or: [ { qty: { $lt: 30 } }, { item: /^p/ } ]
} )

## sql
## SELECT * FROM inventory WHERE status = "A" AND ( qty < 30 OR item LIKE "p%")
```
![[Pasted image 20251120010217.png]]
### **포함/중첩 문서 일치**

```json
db.inventory.find( { size: { h: 14, w: 21, uom: "cm" } } )
```
![[Pasted image 20251120010223.png]]
### **중첩 필드에 대한 쿼리**

포함/중첩 문서의 필드에 쿼리 조건을 지정하려면 다음을 사용하십시오.[점 표기법](https://www.mongodb.com/docs/manual/reference/glossary/#std-term-dot-notation)( `"field.nestedField"`).

점 표기법을 사용하여 쿼리할 때 필드와 중첩 필드는 따옴표 안에 있어야 합니다.

```json
db.inventory.find( { "size.uom": "in" } )
```
![[Pasted image 20251120010233.png]]

![[Pasted image 20251120010248.png]]
![[Pasted image 20251120010257.png]]
### **배열 일치**

배열에 같음 조건을 지정하려면 요소의 순서를 포함하여 일치시킬 정확한 배열이 있는 쿼리 문서를 사용합니다 `{ <field>: <value> }`.`<value>`

다음 예제는 필드 `tags` 값이 정확히 두 개의 요소 `"red"`와 `"blank"`, 지정된 순서로 포함된 배열인 모든 문서를 쿼리

```json
db.inventory.find( { tags: ["red", "blank"] } )
```
![[Pasted image 20251120010304.png]]
배열의 순서나 다른 요소에 관계없이 요소 `"red"`와 `"blank"`모두를 포함하는 배열을 찾으려면
![[Pasted image 20251120010309.png]]
### **요소에 대한 배열 쿼리**

요소가 _하나이상 포함되어 있는지 쿼리하려면 가 요소 값인 필터 를 사용_

```json
db.inventory.find( { tags: "red" } )
```
![[Pasted image 20251120010315.png]]
### **배열 요소에 대해 여러 조건 지정하기**

- **배열 요소에 대한 복합 필터 조건을 사용하여 배열 쿼리**

```json
db.inventory.find( { dim_cm: { $gt: 15, $lt: 20 } } )
```
![[Pasted image 20251120010321.png]]
- **여러 기준을 충족하는 배열 요소 쿼리**

[](https://www.mongodb.com/docs/manual/reference/operator/query/elemMatch/#mongodb-query-op.-elemMatch)

```json
db.inventory.find( { dim_cm: { $elemMatch: { $gt: 22, $lt: 30 } } } )
```
![[Pasted image 20251120010328.png]]
### **포함된 문서 배열 쿼리**

### **배열에 중첩된 문서 쿼리**

다음 예에서는 `instock`배열의 요소가 지정된 문서와 일치하는 모든 문서를 선택

```json
db.inventory.find( { "instock": { warehouse: "A", qty: 5 } } )
```
![[Pasted image 20251120010336.png]]
### **문서 배열에 포함된 필드에 쿼리 조건 지정**

배열에 중첩된 문서의 인덱스 위치를 모르는 경우 배열 필드의 이름을 점( `.`)으로 연결하고 중첩된 문서의 필드 이름을 연결

```json
db.inventory.find( { 'instock.qty': { $lte: 20 } } )
```
![[Pasted image 20251120010341.png]]
값이 다음보다 작거나 같은 `instock`필드가 포함된 문서를 배열의 첫 번째 요소로 포함하는 모든 문서를 선택

```json
db.inventory.find( { 'instock.0.qty': { $lte: 20 } } )
```
![[Pasted image 20251120010348.png]]
### **단일 중첩 문서가 중첩 필드에서 여러 쿼리 조건을 충족함**

사용$elemMatch연산자를 사용하여

하나 이상의 포함된 문서가 지정된 모든 기준을 충족하도록 포함된 문서의 배열에 여러 기준을 지정

```json
db.inventory.find( { "instock": { $elemMatch: { qty: 5, warehouse: "A" } } } )
```
![[Pasted image 20251120010400.png]]
배열에 크 거나 작거나 같은 `instock`필드가 포함된 문서가 하나 이상 있는 문서를 쿼리합니다 .`qty1020`

```json
db.inventory.find( { "instock": { $elemMatch: { qty: { $gt: 10, $lte: 20 } } } } )
```
![[Pasted image 20251120010405.png]]
### **포함된 문서의 특정 필드 반환**

포함된 문서의 특정 필드를 반환할 수 있습니다. 사용 [점 표기법](https://www.mongodb.com/docs/manual/core/document/#std-label-document-dot-notation)포함된 필드를 참조 `1`하고 투영 문서에서 로 설정합니다.

다음 예제는 다음을 반환합니다.

- 필드 ( `_id`기본적으로 반환됨),
- `item`필드 ,
- `status`필드 ,
- 문서 의 `uom`필드입니다 `size`.

`uom`필드는 `size`문서 에 포함 된 상태로 유지

### 쿼리에서 반환할 필드 선택

```sql
db.inventory.find( { status: "A" } )

## sql
SELECT * from inventory WHERE status = "A"
```

- **지정된 필드 및** `item`, `status` , **`_id`필드만 반환**

```sql
db.inventory.find( { status: "A" }, { item: 1, status: 1 } )

## sql
SELECT _id, item, status from inventory WHERE status = "A"
```
![[Pasted image 20251120010414.png]]
**`_id`필드 억제**

```sql
db.inventory.find( { status: "A" }, { item: 1, status: 1, _id: 0 } )

## sql
SELECT item, status from inventory WHERE status = "A"
```

![[Pasted image 20251120010442.png]]

**제외된 필드를 제외한 모든 필드 반환**

![[Pasted image 20251120010451.png]]

```sql
db.inventory.find(
   { status: "A" },
   { item: 1, status: 1, "size.uom": 1 }
)
```
![[Pasted image 20251120010456.png]]
### 포함된 문서에서 특정 필드 표시 안함

```sql
db.inventory.find(
   { status: "A" },
   { "size.uom": 0 }
)
```
![[Pasted image 20251120010501.png]]
```sql
db.inventory.find( { status: "A" }, { item: 1, status: 1, "instock.qty": 1 } )
```
![[Pasted image 20251120010506.png]]
### **동등 필터**

쿼리 는 값이 있는 필드를 포함 _하거나_ 포함 하지 않는 `{ item : null }`문서와 일치 합니다.`itemnull` `item`

```sql
db.inventory.find( { item: null } )
```
![[Pasted image 20251120010513.png]]
### **유형 확인**

`{ item : { $type: 10 } }`쿼리 는 값이 인 필드가 포함된 문서 _만_ 일치시킵니다 . 즉, 필드의 값은 `itemnullitem`[BSON 유형](https://www.mongodb.com/docs/manual/reference/bson-types/) `Null` (유형 번호 `10`) :

```sql
db.inventory.find( { item : { $type: 10 } } )
```
![[Pasted image 20251120010518.png]]
### **존재 확인**

다음 예제에서는 필드가 포함되지 않은 문서를 쿼리

쿼리 는 필드 `{ item : { $exists: false } }`가 포함되지 않은 문서와 일치

```sql
db.inventory.find( { item : { $exists: false } } )
```
![[Pasted image 20251120010524.png]]
## Update

처음 자료 insert

```sql
db.students.insertMany( [
   { _id: 1, test1: 95, test2: 92, test3: 90, modified: new Date("01/05/2020") },
   { _id: 2, test1: 98, test2: 100, test3: 102, modified: new Date("01/05/2020") },
   { _id: 3, test1: 95, test2: 110, modified: new Date("01/04/2020") }
] )
```

### 날짜 현재 시간으로 업데이트

```sql
**db.students.updateOne( { _id: 3 }, [ { $set: { "test3": 98, modified: "$$NOW"} } ] )**
```
![[Pasted image 20251120010531.png]]
생성 자료

```sql
db.students2.insertMany( [
   { "_id" : 1, quiz1: 8, test2: 100, quiz2: 9, modified: new Date("01/05/2020") },
   { "_id" : 2, quiz2: 5, test1: 80, test2: 89, modified: new Date("01/05/2020") },
] )
```

### 업데이트2

```sql
db.students2.updateMany( {},
  [
    { $replaceRoot: { newRoot:
       { $mergeObjects: [ { quiz1: 0, quiz2: 0, test1: 0, test2: 0 }, "$$ROOT" ] }
    } },
    { $set: { modified: "$$NOW"}  }
  ]
)
```

비교

```sql
{
  _id: new Int32(2),
  quiz2: new Int32(5),
  test1: new Int32(80),
  test2: new Int32(89),
  modified: 2020-01-04T15:00:00.000Z
}
{
  _id: new Int32(1),
  quiz1: new Int32(8),
  test2: new Int32(100),
  quiz2: new Int32(9),
  modified: 2020-01-04T15:00:00.000Z
}
```

```sql

{
  _id: new Int32(2),
  quiz1: new Int32(0),
  quiz2: new Int32(5),
  test1: new Int32(80),
  test2: new Int32(89),
  modified: 2022-09-09T12:14:23.954Z
}
{
  _id: new Int32(1),
  quiz1: new Int32(8),
  quiz2: new Int32(9),
  test1: new Int32(0),
  test2: new Int32(100),
  modified: 2022-09-09T12:14:23.954Z
}

```

### 업데이트 3

```sql
db.students3.insertMany( [
   { "_id" : 1, "tests" : [ 95, 92, 90 ], "modified" : ISODate("2019-01-01T00:00:00Z") },
   { "_id" : 2, "tests" : [ 94, 88, 90 ], "modified" : ISODate("2019-01-01T00:00:00Z") },
   { "_id" : 3, "tests" : [ 70, 75, 82 ], "modified" : ISODate("2019-01-01T00:00:00Z") }
] );
```

집계 파이프라인을 사용하여 계산된 등급 평균 및 문자 등급으로 문서를 업데이트

```sql
db.students3.updateMany(
   { },
   [
     { $set: { average : { $trunc: [ { $avg: "$tests" }, 0 ] }, modified: "$$NOW" } },
     { $set: { grade: { $switch: {
                           branches: [
                               { case: { $gte: [ "$average", 90 ] }, then: "A" },
                               { case: { $gte: [ "$average", 80 ] }, then: "B" },
                               { case: { $gte: [ "$average", 70 ] }, then: "C" },
                               { case: { $gte: [ "$average", 60 ] }, then: "D" }
                           ],
                           default: "F"
     } } } }
   ]
)

```

비교

```sql

{
  _id: new Int32(1),
  tests: [ new Int32(95), new Int32(92), new Int32(90) ],
  modified: 2019-01-01T00:00:00.000Z
}
{
  _id: new Int32(2),
  tests: [ new Int32(94), new Int32(88), new Int32(90) ],
  modified: 2019-01-01T00:00:00.000Z
}
{
  _id: new Int32(3),
  tests: [ new Int32(70), new Int32(75), new Int32(82) ],
  modified: 2019-01-01T00:00:00.000Z
}

```

```sql
{
  _id: new Int32(1),
  tests: [ new Int32(95), new Int32(92), new Int32(90) ],
  modified: 2022-09-09T12:21:57.406Z,
  average: new Double(92.0),
  grade: 'A'
}
{
  _id: new Int32(2),
  tests: [ new Int32(94), new Int32(88), new Int32(90) ],
  modified: 2022-09-09T12:21:57.406Z,
  average: new Double(90.0),
  grade: 'A'
}
{
  _id: new Int32(3),
  tests: [ new Int32(70), new Int32(75), new Int32(82) ],
  modified: 2022-09-09T12:21:57.406Z,
  average: new Double(75.0),
  grade: 'C'
}
```

### 업데이트4

```sql
db.students4.insertMany( [
  { "_id" : 1, "quizzes" : [ 4, 6, 7 ] },
  { "_id" : 2, "quizzes" : [ 5 ] },
  { "_id" : 3, "quizzes" : [ 10, 10, 10 ] }
] )
```

집계 파이프라인을 사용하여 다음을 사용하여 문서에 퀴즈 점수를 추가

```sql
db.students4.updateOne( { _id: 2 },
  [ { $set: { quizzes: { $concatArrays: [ "$quizzes", [ 8, 6 ]  ] } } } ]
)
```

비교

```sql
{
  _id: new Int32(1),
  quizzes: [ new Int32(4), new Int32(6), new Int32(7) ]
}
{ _id: new Int32(2), quizzes: [ new Int32(5) ] }
{
  _id: new Int32(3),
  quizzes: [ new Int32(10), new Int32(10), new Int32(10) ]
}
```

```sql
{
  _id: new Int32(1),
  quizzes: [ new Int32(4), new Int32(6), new Int32(7) ]
}
{
  _id: new Int32(2),
  quizzes: [ new Int32(5), new Int32(8), new Int32(6) ]
}
{
  _id: new Int32(3),
  quizzes: [ new Int32(10), new Int32(10), new Int32(10) ]
}
```

- 섭씨 온도를 포함 하는 예제 `temperatures`컬렉션 생성

```sql
db.temperatures.insertMany( [
  { "_id" : 1, "date" : ISODate("2019-06-23"), "tempsC" : [ 4, 12, 17 ] },
  { "_id" : 2, "date" : ISODate("2019-07-07"), "tempsC" : [ 14, 24, 11 ] },
  { "_id" : 3, "date" : ISODate("2019-10-30"), "tempsC" : [ 18, 6, 8 ] }
] )
```

- 집계 파이프라인을 사용하여 문서를 화씨의 해당 온도로 업데이트

```sql
db.temperatures.updateMany( { },
  [
    { $addFields: { "tempsF": {
          $map: {
             input: "$tempsC",
             as: "celsius",
             in: { $add: [ { $multiply: ["$$celsius", 9/5 ] }, 32 ] }
          }
    } } }
  ]
)
```

비교

```sql
{
  _id: new Int32(1),
  date: 2019-06-23T00:00:00.000Z,
  tempsC: [ new Int32(4), new Int32(12), new Int32(17) ]
}
{
  _id: new Int32(2),
  date: 2019-07-07T00:00:00.000Z,
  tempsC: [ new Int32(14), new Int32(24), new Int32(11) ]
}
{
  _id: new Int32(3),
  date: 2019-10-30T00:00:00.000Z,
  tempsC: [ new Int32(18), new Int32(6), new Int32(8) ]
}
```

```sql
{
  _id: new Int32(1),
  date: 2019-06-23T00:00:00.000Z,
  tempsC: [ new Int32(4), new Int32(12), new Int32(17) ],
  tempsF: [ new Double(39.2), new Double(53.6), new Double(62.6) ]
}
{
  _id: new Int32(2),
  date: 2019-07-07T00:00:00.000Z,
  tempsC: [ new Int32(14), new Int32(24), new Int32(11) ],
  tempsF: [ new Double(57.2), new Double(75.2), new Double(51.8) ]
}
{
  _id: new Int32(3),
  date: 2019-10-30T00:00:00.000Z,
  tempsC: [ new Int32(18), new Int32(6), new Int32(8) ],
  tempsF: [ new Double(64.4), new Double(42.8), new Double(46.4) ]
}
```

|db.collection.updateOne()|여러 문서가 지정된 필터와 일치하더라도 지정된 필터와 일치하는 단일 문서만 업데이트합니다.|
|---|---|
|db.collection.updateMany()|지정된 필터와 일치하는 모든 문서를 업데이트합니다.|
|db.collection.replaceOne()|여러 문서가 지정된 필터와 일치하더라도 지정된 필터와 일치하는 최대 단일 문서를 바꿉니다.|

## Delete

### 모든 문서 삭제

```sql
db.inventory.deleteMany({})
```
![[Pasted image 20251120010549.png]]
![[Pasted image 20251120010558.png]]
### **조건과 일치하는 모든 문서 삭제**

```sql
db.inventory.deleteMany({ status : "A" })
```

### **조건과 일치하는 문서 하나만 삭제**

```sql
db.inventory.deleteOne( { status: "D" } )
```

|db.collection.deleteOne()|여러 문서가 지정된 필터와 일치하더라도 지정된 필터와 일치하는 최대 단일 문서를 삭제합니다.|
|---|---|
|db.collection.deleteMany()|지정된 필터와 일치하는 모든 문서를 삭제합니다.|
|db.collection.remove()|지정된 필터와 일치하는 단일 문서 또는 모든 문서를 삭제합니다.|
# 집계 파이프라인

## 예시 데이터 insert

```sql
db.orders.insertMany( [
   { _id: 0, name: "Pepperoni", size: "small", price: 19,
     quantity: 10, date: ISODate( "2021-03-13T08:14:30Z" ) },
   { _id: 1, name: "Pepperoni", size: "medium", price: 20,
     quantity: 20, date : ISODate( "2021-03-13T09:13:24Z" ) },
   { _id: 2, name: "Pepperoni", size: "large", price: 21,
     quantity: 30, date : ISODate( "2021-03-17T09:22:12Z" ) },
   { _id: 3, name: "Cheese", size: "small", price: 12,
     quantity: 15, date : ISODate( "2021-03-13T11:21:39.736Z" ) },
   { _id: 4, name: "Cheese", size: "medium", price: 13,
     quantity:50, date : ISODate( "2022-01-12T21:23:13.331Z" ) },
   { _id: 5, name: "Cheese", size: "large", price: 14,
     quantity: 10, date : ISODate( "2022-01-12T05:08:13Z" ) },
   { _id: 6, name: "Vegan", size: "small", price: 17,
     quantity: 10, date : ISODate( "2021-01-13T05:08:13Z" ) },
   { _id: 7, name: "Vegan", size: "medium", price: 18,
     quantity: 10, date : ISODate( "2021-01-13T05:10:13Z" ) }
] )
```

## **총 주문 수량 계산**

- 피자 이름별로 그룹화된 중간 크기 피자의 총 주문 수량을 반환

```sql
db.orders.aggregate( [
   // Stage 1: Filter pizza order documents by pizza size
   {
      $match: { size: "medium" }
   },
   // Stage 2: Group remaining documents by pizza name and calculate total quantity
   {
      $group: { _id: "$name", totalQuantity: { $sum: "$quantity" } }
   }
] )
```

```sql
{
  _id: new Int32(0),
  name: 'Pepperoni',
  size: 'small',
  price: new Int32(19),
  quantity: new Int32(10),
  date: 2021-03-13T08:14:30.000Z
}
{
  _id: new Int32(1),
  name: 'Pepperoni',
  size: 'medium',
  price: new Int32(20),
  quantity: new Int32(20),
  date: 2021-03-13T09:13:24.000Z
}
{
  _id: new Int32(2),
  name: 'Pepperoni',
  size: 'large',
  price: new Int32(21),
  quantity: new Int32(30),
  date: 2021-03-17T09:22:12.000Z
}
{
  _id: new Int32(3),
  name: 'Cheese',
  size: 'small',
  price: new Int32(12),
  quantity: new Int32(15),
  date: 2021-03-13T11:21:39.736Z
}
{
  _id: new Int32(4),
  name: 'Cheese',
  size: 'medium',
  price: new Int32(13),
  quantity: new Int32(50),
  date: 2022-01-12T21:23:13.331Z
}
{
  _id: new Int32(5),
  name: 'Cheese',
  size: 'large',
  price: new Int32(14),
  quantity: new Int32(10),
  date: 2022-01-12T05:08:13.000Z
}
{
  _id: new Int32(6),
  name: 'Vegan',
  size: 'small',
  price: new Int32(17),
  quantity: new Int32(10),
  date: 2021-01-13T05:08:13.000Z
}
{
  _id: new Int32(7),
  name: 'Vegan',
  size: 'medium',
  price: new Int32(18),
  quantity: new Int32(10),
  date: 2021-01-13T05:10:13.000Z
}
```

```sql
{ _id: 'Cheese', totalQuantity: new Int32(50) }
{ _id: 'Pepperoni', totalQuantity: new Int32(20) }
{ _id: 'Vegan', totalQuantity: new Int32(10) }
```

## **총 주문 금액 및 평균 주문 수량 계산**

- 두 날짜 사이의 총 피자 주문 금액과 평균 주문 수량을 계산

```sql
db.orders.aggregate( [
   // Stage 1: Filter pizza order documents by date range
   {
      $match:
      {
         "date": { $gte: new ISODate( "2020-01-30" ), $lt: new ISODate( "2022-01-30" ) }
      }
   },
   // Stage 2: Group remaining documents by date and calculate results
   {
      $group:
      {
         _id: { $dateToString: { format: "%Y-%m-%d", date: "$date" } },
         totalOrderValue: { $sum: { $multiply: [ "$price", "$quantity" ] } },
         averageOrderQuantity: { $avg: "$quantity" }
      }
   },
   // Stage 3: Sort documents by totalOrderValue in descending order
   {
      $sort: { totalOrderValue: -1 }
   }
 ] )
```

```sql
{
  _id: '2022-01-12',
  totalOrderValue: new Int32(790),
  averageOrderQuantity: new Double(30.0)
}
{
  _id: '2021-03-13',
  totalOrderValue: new Int32(770),
  averageOrderQuantity: new Double(15.0)
}
{
  _id: '2021-03-17',
  totalOrderValue: new Int32(630),
  averageOrderQuantity: new Double(30.0)
}
{
  _id: '2021-01-13',
  totalOrderValue: new Int32(350),
  averageOrderQuantity: new Double(10.0)
}
```

# 조인

[$lookup (aggregation)](https://www.mongodb.com/docs/manual/reference/operator/aggregation/lookup/#syntax)

```sql
{
   $lookup:
     {
       from: <collection to join>,
       localField: <field from the input documents>,
       foreignField: <field from the documents of the "from" collection>,
       as: <output array field>
     }
}

SELECT *, <output array field>
FROM collection
WHERE <output array field> IN (
   SELECT *
   FROM <collection to join>
   WHERE <foreignField> = <collection.localField>
);
```

# 인덱싱

[Indexes](https://www.mongodb.com/docs/manual/indexes/)

```sql
db.products.createIndex(
  { item: 1, quantity: -1 } ,
  { name: "query for inventory" }
)
```
