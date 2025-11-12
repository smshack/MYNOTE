---
tags:
  - mattermost
---

**Mattermost**는 **Slack(슬랙)**과 비슷한 오픈소스 **팀 협업용 메신저 & 커뮤니케이션 플랫폼**이에요.  
주로 **개발팀**, **DevOps팀**, **보안이 중요한 기업 내부망 환경**에서 많이 사용됩니다.

---

## 🧭 Mattermost 개요

|항목|설명|
|---|---|
|**이름**|Mattermost|
|**종류**|오픈소스 팀 커뮤니케이션/콜라보레이션 플랫폼|
|**배포 방식**|자체 호스팅 (On-premise) 또는 Cloud|
|**주요 언어**|Go(백엔드) + React(프론트엔드)|
|**DB**|PostgreSQL (또는 MySQL)|
|**웹 포트**|기본 8065 (HTTP), 8067 (HTTPS)|
|**라이선스**|오픈소스 (Team Edition) + 유료 (Enterprise Edition)|

---

## 💬 주요 기능

|분류|설명|
|---|---|
|**채널 기반 채팅**|Slack처럼 채널별로 대화 가능 (공개 / 비공개 / 그룹 DM 등)|
|**파일 공유**|이미지, 문서, 코드 스니펫 등 업로드 가능|
|**알림 시스템**|데스크톱 / 모바일 푸시 알림 지원|
|**통합 기능 (Integrations)**|Jenkins, GitLab, Jira, GitHub, Prometheus, Grafana 등 연동|
|**명령어 기능 (Slash Commands)**|`/deploy`, `/build` 같은 자동화 명령 실행|
|**Bot 및 Webhook 지원**|자동화 및 외부 시스템 통신 가능|
|**보안 및 권한 제어**|LDAP, SSO, MFA 지원 / 사용자별 역할 제어 가능|
|**게시판 / To-do 확장**|Playbooks, Boards 같은 확장 기능으로 프로젝트 관리 가능|

---

## ⚙️ Mattermost 구조

```text
[Web Browser / Mobile App]
          ↓
     [Mattermost Server]
          ↓
[PostgreSQL or MySQL Database]
```

- **Mattermost Server** : 실제 서비스의 중심, REST API 및 WebSocket 제공
    
- **Database** : 사용자, 메시지, 채널, 파일 등 저장
    
- **Nginx** : HTTPS 리버스 프록시로 외부에서 접근 가능하게 구성
    

---

## 🧩 Mattermost의 장점

✅ **자체 서버에 호스팅 가능** — 민감한 데이터 외부 유출 걱정 없음  
✅ **완전한 오픈소스** — Slack 대비 자유로운 커스터마이징 가능  
✅ **CI/CD 연동 용이** — GitLab, Jenkins 등 개발 환경과 긴밀하게 연동  
✅ **API / Webhook 기반 확장성** — 사내 봇, 자동 알림, 빌드 알림 구현 쉬움  
✅ **멀티 플랫폼 지원** — Web / 데스크톱 / 모바일 앱 제공

---

## ⚠️ 단점

⚠️ **설치 및 유지보수 필요** — Slack처럼 SaaS가 아니라 직접 운영해야 함  
⚠️ **초기 설정 복잡** — Nginx, DB, SSL 설정 필요  
⚠️ **Enterprise 기능 제한** — LDAP 그룹 동기화, 감사 로그 등은 유료 버전에만 있음

---

## 🧠 사용 예시

|환경|설명|
|---|---|
|**사내 개발팀**|Jenkins 빌드 완료 → Mattermost 채널에 자동 알림|
|**운영팀**|서버 장애 발생 시 Webhook으로 알림 수신|
|**DevOps 환경**|GitLab Merge, Pipeline 결과를 Mattermost로 전송|
|**폐쇄망 기업 환경**|외부 서비스 접근 불가 시 내부 메신저로 대체 사용|

---

## 🧰 Docker Compose 예시 (간단 버전)

```yaml
version: '3.8'

services:
  mattermost:
    image: mattermost/mattermost-team-edition:latest
    container_name: mattermost
    restart: always
    ports:
      - "8065:8065"
    environment:
      - TZ=Asia/Seoul
      - MM_SQLSETTINGS_DRIVERNAME=postgres
      - MM_SQLSETTINGS_DATASOURCE=postgres://mmuser:mostest@db:5432/mattermost?sslmode=disable
    depends_on:
      - db
    volumes:
      - ./mattermost_data:/mattermost/data
      - ./config:/mattermost/config
      - ./logs:/mattermost/logs
      - ./plugins:/mattermost/plugins

  db:
    image: postgres:15
    container_name: mattermost-db
    restart: always
    environment:
      - POSTGRES_USER=mmuser
      - POSTGRES_PASSWORD=mostest
      - POSTGRES_DB=mattermost
    volumes:
      - ./postgres_data:/var/lib/postgresql/data
```

---

## 🌐 공식 리소스

- **공식 사이트:** [https://mattermost.com/](https://mattermost.com/)
    
- **GitHub:** [https://github.com/mattermost/mattermost](https://github.com/mattermost/mattermost)
    
- **Docker Hub:** [https://hub.docker.com/r/mattermost/mattermost-team-edition](https://hub.docker.com/r/mattermost/mattermost-team-edition)
    

---
![[mattermost 메인페이지.png]]

---
### mattermost webhook 생성
![[채널생성.png]]![[통합메뉴.png]]![[incomming webhook 생성.png]]
![[incomming webhook 생성2.png]]
![[webhook 생성 리스트.png]]