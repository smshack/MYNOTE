---
tags:
  - portainer
  - container
---

Portainer는 **Docker, Docker Swarm, Kubernetes 환경을 GUI로 쉽게 관리할 수 있게 해주는 오픈소스 툴**이에요.  
즉, 명령어 없이도 **웹 브라우저에서 컨테이너를 시각적으로 관리**할 수 있게 해주는 **컨테이너 관리 대시보드**입니다.

---

## 🧭 Portainer 개요

|항목|설명|
|---|---|
|**이름**|Portainer (포테이너)|
|**종류**|오픈소스 컨테이너 관리 플랫폼|
|**공식 이미지**|`portainer/portainer-ce`|
|**주요 지원 환경**|Docker, Docker Swarm, Kubernetes|
|**웹 포트**|기본 `9000` (HTTP), `9443` (HTTPS)|
|**라이선스**|CE(Community Edition) – 무료, BE(Business Edition) – 유료|

---

## 🧩 Portainer의 주요 기능

|분류|기능|
|---|---|
|**컨테이너 관리**|실행 중인 컨테이너의 상태, 로그, 터미널 접근, 재시작/삭제|
|**이미지 관리**|로컬 또는 레지스트리(Harbor, Docker Hub 등)에서 이미지 Pull/Push|
|**네트워크 관리**|Docker 네트워크 생성, 브리지 연결, 서비스 간 네트워크 연결 관리|
|**볼륨 관리**|볼륨 생성 및 연결, 데이터 마운트 확인|
|**스택(Stack)**|`docker-compose.yml` 기반으로 여러 컨테이너 묶음 실행|
|**사용자 및 팀 관리**|사용자 권한 설정, 팀 단위 접근 제어|
|**로그 / 모니터링**|실시간 로그 확인 및 CPU, 메모리 사용량 확인|
|**Kubernetes 지원**|Pod, Namespace, Deployment 등 GUI로 관리 (옵션)|

---

## 🧠 사용 예시

### 1️⃣ Docker 관리용

- 단일 서버에서 여러 컨테이너를 GUI로 관리
    
- Jenkins, Nginx, Strapi, ELK 같은 서비스들을 한눈에 파악
    

### 2️⃣ Swarm 클러스터 관리

- 여러 Docker 노드를 하나의 클러스터로 묶어 GUI로 모니터링
    

### 3️⃣ Kubernetes 클러스터 관리

- Kubernetes Dashboard 대체로 사용 가능
    

---

## ⚙️ 아키텍처 구조

```text
[Web Browser]
      ↓
 [Portainer UI] (웹 인터페이스)
      ↓
 [Portainer Server]  ←→  [Docker Socket or Portainer Agent]
      ↓
 [Docker / Swarm / K8s]
```

- 단일 서버에서는 `Docker Socket`을 직접 연결 (`/var/run/docker.sock`)
    
- 여러 서버 관리 시, 각 노드에 **Portainer Agent** 설치 후 연결
    

---

## 🧑‍💻 장점

✅ **GUI 기반 관리** — 복잡한 CLI 없이 컨테이너 관리  
✅ **멀티 호스트 관리** — 여러 Docker 서버를 한 화면에서 관리  
✅ **보안/권한 제어** — 사용자 계정 및 역할 기반 접근 제어  
✅ **가벼운 구성** — 컨테이너 하나로 손쉽게 배포  
✅ **오픈소스 / 무료** — 개인, 중소기업 모두 사용 가능

---

## 🚀 단점

⚠️ 실시간 모니터링 기능이 Prometheus만큼 세밀하지 않음  
⚠️ 대규모 Kubernetes 클러스터에서는 기능이 제한적  
⚠️ 일부 고급 기능(예: RBAC 세분화, SSO 연동)은 Business Edition에서만 제공

---

## 🌐 공식 리소스

- **공식 웹사이트**: [https://www.portainer.io/](https://www.portainer.io/)
    
- **Docker Hub**: [https://hub.docker.com/r/portainer/portainer-ce](https://hub.docker.com/r/portainer/portainer-ce)
    
- **GitHub**: [https://github.com/portainer/portainer](https://github.com/portainer/portainer)
    
![[컨테이너 관리 페이지.png]]