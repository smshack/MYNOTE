---
tags:
  - harbor
  - image-registry
---
## 🚀 1️⃣ 초기 세팅 체크리스트

Harbor를 “정상 동작하는 레지스트리”로 완성하기 위한 **기본 초기 설정**입니다.

### ✅ (1) 관리자 로그인

```bash
https://harbor.smartseoapp.com
```

- `admin / Harbor12345` → 로그인
    
- 즉시 비밀번호 변경: **`Administrator → Change Password`**
    
![[하버관리자로 접속.png]]
---

---

### ✅ (2) 로그인 테스트 (Docker Client)

```bash
docker login harbor.smartseoapp.com
```

- 성공 시: `Login Succeeded`
    
- 실패 시: `harbor-core` 로그 확인
    
![[docker 로그인.png]]
---

## 🧠 2️⃣ 실무에서 고려해야 하는 주요 포인트

이제 “도는 상태”를 넘어서 **운영 가능한 Harbor**를 위해 신경 쓸 부분입니다.

---

### 🔒 (1) 보안 정책

| 항목            | 권장 설정                            |
| ------------- | -------------------------------- |
| 관리자 계정        | `admin` 비활성화 또는 비밀번호 강제 변경       |
| HTTPS         | 필수 (이미 OK)                       |
| 사용자 인증        | **LDAP / OIDC 연동** (회사 계정으로 로그인) |
| 프로젝트 권한       | Public ❌ / Private ✅             |
| CVE 스캐너       | **Trivy** 활성화 (기본 포함)            |
| Content Trust | 이미지 서명 검증 필요 시 사용 (Notary)       |

---
### 🧱 (2) 스토리지 관리

|유형|설명|
|---|---|
|`/data`|Harbor가 실제 이미지 blob, DB, 로그 등을 저장하는 경로|
|백업|최소 1일 1회 Snapshot or rsync|
|용량 관리|registry GC(garbage collect) 주기적 실행|
![[harbor data 디렉터리 마운트.png]]

---

### 🧍 (3) 사용자 / 프로젝트 구조 설계

> 실무에서는 “조직 단위”로 Project를 구분하는 게 핵심입니다.

| 조직/팀       | Harbor 프로젝트   | 예시                                           |
| ---------- | ------------- | -------------------------------------------- |
| Smartglass | `smartglass`  | `harbor.smartseoapp.com/smartglass/frontend` |
| Infra (공통) | `base-images` | `harbor.smartseoapp.com/base/node:18`        |

---

### 🧰 (4) CI/CD 연계

**Portainer / Jenkins / GitLab CI** 등에서 Harbor 사용 예:

```yaml
docker build -t harbor.smartseoapp.com/smartglass/frontend:$BUILD_NUMBER .
docker push harbor.smartseoapp.com/smartglass/frontend:$BUILD_NUMBER
```

- Jenkins에는 Harbor 인증을 미리 등록:
    
    - `docker login harbor.smartseoapp.com -u robot$jenkins -p <token>`
        

> Robot 계정을 Harbor에서 발급해서 CI/CD에 사용하는 게 **보안상 안전**합니다.
![[jenkins-bot harbor 계정.png]]
---

### 💾 (5) 백업 & 복구

|항목|경로|백업 방법|
|---|---|---|
|이미지|`/data/registry`|rsync / snapshot|
|DB|`/data/database`|`pg_dump` 사용 가능|
|설정|`/common/config`|git으로 버전 관리 권장|

복구는 동일한 Harbor 버전으로 `/data` 복원 후 재기동만 하면 됩니다.

---

### 📈 (6) 모니터링 / 로그

- **로그 위치**
    
    ```bash
    docker logs harbor-core
    docker logs harbor-jobservice
    docker logs harbor-registry
    ```
    
- **메트릭 노출**
    
    - `/metrics` endpoint (Prometheus 통합 가능)
        
- **Webhook**
    
    - `Administration → Webhooks` → Jenkins, Slack, Mattermost 연동 가능
        
![[harbor 로그.png]]
---

## 🧭 3️⃣ 운영 시 Best Practice 요약

| 구분         | 실무 팁                                       |
| ---------- | ------------------------------------------ |
| 이미지 Naming | `<registry>/<project>/<service>:<version>` |
| 태그 관리      | `latest` 금지, 항상 버전 명시                      |
| 주기적 점검     | CVE 스캔, GC, 로그 용량                          |
| 인증서 자동화    | Certbot renew + Nginx reload               |
| CI/CD 통합   | Robot 계정 + Jenkins Secret 관리               |
| 백업         | `/data`, `/common/config` 주기 백업            |

---

원하신다면,  
제가 **“실무용 Harbor 운영 템플릿 (폴더 구조, compose 파일, cronjob, 백업 스크립트, Jenkins 연계 샘플)”**을 통째로 정리해드릴 수도 있습니다.

👉 그렇게 “운영용 템플릿 세트”까지 정리해드릴까요?