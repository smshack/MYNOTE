---
tags:
  - 옵시디언
  - 데이터뷰
  - 플러그인
description: 옵시디언 데이터 태그로 쿼리 플러그인
---


### **Dataview 플러그인 사용법**

#### **쿼리문의 구성**
- 어떤 타입으로 무엇을?
- 어디서?
- 어떤 조건을?
- 어떤 순으로?(옵션)

````
```dataview
TABLE|LIST|TASK <field> [AS "Column Name"], <field>, ..., <field>
FROM <source> (like #tag or "folder")
WHERE <expression> (like 'field = value')
SORT <expression> [ASC/DESC] (like 'field ASC') 
```
````

## table 방식
```dataview
TABLE time-played, length, rating
FROM "옵시디언"
SORT rating desc
```
```

```

```dataview

List

From #dataview 

```

```dataview

List

From #옵시디언  

```

```dataview
TABLE description AS "설명"
FROM #옵시디언
```