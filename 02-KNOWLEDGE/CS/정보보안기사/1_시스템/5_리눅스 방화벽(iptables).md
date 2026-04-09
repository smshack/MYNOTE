# 📘 리눅스 방화벽 (iptables) 정리

---

### 📌 1. iptables 개념

|항목|설명|
|---|---|
|iptables|리눅스 패킷 필터링 방화벽|
|역할|패킷 허용/차단|
|기반|Netfilter|

👉 한 줄  
➡️ **“패킷 필터링 도구”**

---

### 📌 2. 기본 구조

```id="ip01"
Table → Chain → Rule
```

---

### 📌 3. 체인 종류 ⭐

|체인|역할|
|---|---|
|INPUT|들어오는 패킷|
|OUTPUT|나가는 패킷|
|FORWARD|다른 곳으로 전달|

👉 핵심  
➡️ **INPUT / OUTPUT / FORWARD 3개 무조건 암기**

---

### 📌 4. state (상태 기반 필터링) ⭐

---

## ✅ 개념

|상태|설명|
|---|---|
|NEW|새로운 연결|
|ESTABLISHED|이미 연결됨|
|RELATED|관련된 연결|
|INVALID|잘못된 패킷|

---

## ✅ 예제

```bash
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
```

👉 의미  
➡️ 기존 연결은 허용

---

### 📌 5. recent / limit / hashlimit

---

## ✅ 1) recent ⭐ (접속 기록 기반 차단)

```bash
iptables -A INPUT -m recent --name bad --set
iptables -A INPUT -m recent --name bad --update --seconds 60 --hitcount 5 -j DROP
```

👉 의미  
➡️ 1분에 5번 이상 접속 시 차단

---

## ✅ 2) limit ⭐ (속도 제한)

```bash
iptables -A INPUT -p icmp -m limit --limit 1/s -j ACCEPT
```

👉 의미  
➡️ 초당 1개만 허용

---

## ✅ 3) hashlimit ⭐ (IP별 제한)

```bash
iptables -A INPUT -p tcp --dport 80 -m hashlimit \
--hashlimit 10/min --hashlimit-mode srcip \
--hashlimit-name http_limit -j ACCEPT
```

👉 의미  
➡️ IP별 요청 제한

---

### 📌 6. 기본 사용법

---

## ✅ 구조

```bash
iptables -A [체인] [조건] -j [동작]
```

---

## ✅ 주요 옵션

|옵션|설명|
|---|---|
|-A|추가|
|-D|삭제|
|-L|목록|
|-F|초기화|

---

## ✅ 동작

|값|의미|
|---|---|
|ACCEPT|허용|
|DROP|차단|
|REJECT|거부|

---

### 📌 7. 사용 예제 ⭐⭐⭐

---

## ✅ SSH 허용

```bash
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
```

---

## ✅ 특정 IP 차단

```bash
iptables -A INPUT -s 192.168.0.10 -j DROP
```

---

## ✅ 웹 서버 허용

```bash
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
```

---

## ✅ 모든 차단 (기본 정책)

```bash
iptables -P INPUT DROP
```

---

## ✅ 기존 연결 허용 (필수 ⭐)

```bash
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
```

---

### 📌 8. 시험 문제 패턴

---

## ✅ 패턴 1

👉 INPUT 체인 의미?

➡️ **들어오는 패킷**

---

## ✅ 패턴 2

👉 state ESTABLISHED 의미?

➡️ **이미 연결된 세션**

---

## ✅ 패턴 3

👉 limit 옵션?

➡️ **속도 제한**

---

## ✅ 패턴 4

👉 recent 기능?

➡️ **접속 횟수 기반 차단**

---

## ✅ 패턴 5

👉 기본 정책 DROP?

➡️ **기본 차단**

---

# 🎯 초압축 암기 (시험 직전)

```id="ip-final"
체인:
INPUT / OUTPUT / FORWARD

state:
NEW / EST / REL / INV

limit = 속도 제한
recent = 횟수 제한
hashlimit = IP별 제한

명령:
-A / -D / -L / -F

기본:
ESTABLISHED 허용
```

---

# 🔥 시험 핵심 TOP

✔ INPUT / OUTPUT / FORWARD ⭐⭐⭐  
✔ state 4가지 ⭐  
✔ ESTABLISHED 규칙 ⭐  
✔ limit / recent 차이 ⭐  
✔ 기본 정책 DROP ⭐

---

원하면  
👉 “실무 서버 방화벽 세팅 (보안 기준)”  
👉 “iptables 실수로 SSH 막혔을 때 복구 방법”  
👉 “firewalld vs iptables 비교”

실무 기준으로 더 깊게 알려줄게 👍