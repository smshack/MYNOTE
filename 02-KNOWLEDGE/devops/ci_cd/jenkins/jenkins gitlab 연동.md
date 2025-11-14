---
tags:
  - gitlab
  - Jenkins
---

## ✅ 1️⃣ 웹 UI로 그룹에 Webhook 등록하는 방법 (가장 간단)

### 📍 전제 조건

- GitLab 관리자 또는 그룹 Maintainer 이상 권한 필요
    
- Jenkins에 GitLab Plugin 설치되어 있어야 함
    
- Jenkins Webhook URL 준비되어야 함
    
    ```
    https://jenkins.smartseoapp.com/project/practice-team-pipeline
    ```
    

---

### 🪜 단계별 설정

1. GitLab 로그인
    
2. 상단 메뉴에서 **Groups → Your Groups**
    
3. `practice-team` 그룹 클릭
    
4. 왼쪽 메뉴에서  
    **Settings → Webhooks** 클릭
    
5. 다음 입력:
    
    - **URL:**
        
        ```
        https://jenkins.smartseoapp.com/gitlab-webhook/
        ```
        
    - **Secret token:**  
        Jenkins에서 설정한 GitLab secret token 입력
        
    - **Trigger:**
        
        -  Push events
            
        -  Merge request events
            
        -  Tag push events
            
        -  Job events (선택 안함)
            
    - **Enable SSL verification:** ✓ 체크 유지
        
6. **Add Webhook** 클릭
    
7. **Test → Push event** 눌러서 Jenkins에 전달되는지 확인
    

---

## ✅ 2️⃣ GitLab API로 그룹 Webhook 등록하기 (자동화 방식)

그룹 단위 Webhook은 GitLab REST API의 **Group Hooks API**를 통해 등록할 수 있습니다.

### 📘 API 문서:

[https://docs.gitlab.com/ee/api/group_hooks.html](https://docs.gitlab.com/ee/api/group_hooks.html)

---

### 🪜 요청 예시 (Postman / curl)

```bash
curl --request POST \
  --header "PRIVATE-TOKEN: <your_access_token>" \
  --header "Content-Type: application/json" \
  --data '{
    "url": "https://jenkins.smartseoapp.com/gitlab-webhook/",
    "push_events": true,
    "merge_requests_events": true,
    "tag_push_events": true,
    "enable_ssl_verification": true,
    "token": "jenkins-secret-token"
  }' \
  "https://gitlab.com/api/v4/groups/practice-team/hooks"
```

> 🔹 `<your_access_token>` → GitLab Personal Access Token (api 권한 필요)  
> 🔹 `"practice-team"` → 그룹 이름 or 그룹 ID  
> 🔹 `"jenkins-secret-token"` → Jenkins와 동일하게 설정해야 함

---

### 🧾 확인 명령

```bash
curl --header "PRIVATE-TOKEN: <your_access_token>" \
     "https://gitlab.com/api/v4/groups/practice-team/hooks"
```

이렇게 하면 등록된 Webhook 목록을 확인할 수 있습니다.

---

## ✅ 3️⃣ Jenkins 쪽 Webhook 수신 설정

### 📦 플러그인

- **GitLab Plugin**
    
- **GitLab API Plugin**
    
- **Pipeline Plugin**
    

설치 후 →  
`Manage Jenkins → Configure System → GitLab` 이동

1. **GitLab connections** → “Add GitLab connection” 클릭
    
2. Name: `gitlab-practice-team`
    
3. GitLab host URL: `https://gitlab.com` (또는 내부 GitLab 주소)
    
4. Credentials → GitLab API Token 등록
    
5. Connection test 클릭 (✅ Success 뜨면 OK)
    
![[젠킨스 깃랩 connection 등록.png]]
---

## ✅ 4️⃣ Jenkins Job에서 Webhook 받기

- **Pipeline Job** 생성  
    예: `practice-team-pipeline`
    
- “Build Triggers” 섹션에서  
    🔘 “Build when a change is pushed to GitLab” 체크  
    ✅ Secret token 입력  
    ✅ Trigger push / merge request 선택
    
- 저장 후 GitLab에서 Push 하면 자동 빌드됨
    
![[젠킨스 푸쉬 트리거 세팅.png]]
---

## 📋 동작 확인

1. GitLab → `practice-team` 그룹 → Webhooks
    
2. “Recent Deliveries” 탭 클릭
    
3. 상태 200 OK 확인
    
4. Jenkins 콘솔 로그 확인 (Webhook 수신 로그 출력)
    

![[깃랩 젠킨스 url 등록.png]]
![[파이프라인 콘솔 테스트.png]]
---

## ✅ 핵심 요약

|항목|내용|
|---|---|
|Webhook 등록 위치|그룹 단위 (Settings → Webhooks)|
|Jenkins Webhook URL|`https://jenkins.example.com/gitlab-webhook/`|
|이벤트|Push, Merge, Tag|
|Token|GitLab과 Jenkins 동일|
|Jenkins 플러그인|GitLab Plugin, GitLab API Plugin|
|자동화 방식|`/api/v4/groups/:id/hooks` REST API 사용 가능|

### 깃랩 레포 젠킨스 아이템 파이프라인 연결
![[Pasted image 20251115034704.png]]
![[Pasted image 20251115034724.png]]

![[Pasted image 20251115035024.png]]