
---
## 1️⃣ Jenkins Docker 컨테이너 실행

실무에서는 **데이터 영속성**과 **네트워크 접근**이 중요합니다.

```bash
docker volume create jenkins_home

docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkins/jenkins:lts
```

- `jenkins_home` : Jenkins 데이터(설정, 빌드 기록, 플러그인 등) 영속성을 위한 볼륨
    
- `-v /var/run/docker.sock:/var/run/docker.sock` : Jenkins 안에서 Docker 명령 실행 가능
    
- `8080` : 웹 UI
    
- `50000` : 에이전트 연결용 포트
    
![[젠킨스 초기페이지.png]]
---

## 2️⃣ 초기 관리자 계정 생성

1. 브라우저에서 `http://서버IP:8080` 접속
    
2. 초기 관리자 비밀번호 확인
    

```bash
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

3. 비밀번호 입력 → 추천 플러그인 설치 선택
    
![[젠킨스 어드민 유저 세팅.png]]
---

## 3️⃣ 실무용 추천 플러그인 설치

- **Git**: 소스 코드 관리
    
- **Pipeline**: Declarative / Scripted pipeline 작성
    
- **Blue Ocean**: 시각화된 Pipeline UI
    
- **Docker Pipeline**: Docker 빌드/실행
    
- **Credentials Binding**: 비밀번호, 토큰 관리
    
- **Slack / Mattermost Notification**: 알림
    
- **GitLab / GitHub Integration**: SCM 연동
    
- **Job DSL / Configuration as Code (JCasC)**: 설정 자동화
    
![[제안된 플러그인 세팅.png]]

![[플러그인설치.png]]

> 실무에서는 설치 후 Jenkins 설정을 **코드로 관리(CAC / JCasC)** 하는 게 중요합니다.

---

## 4️⃣ 관리자 계정 및 보안 설정

- **관리자 계정 추가**: 초기 `admin` 계정 외 다른 계정 생성
    
- **Global Security 활성화**:
    
    - Jenkins 로그인 필수
        
    - CSRF Protection 켜기
        
- **Matrix-based security**:
    
    - 실무에서는 **역할 기반(RBAC)** 권장
    - 사용자에게 역할을 부여하고, 역할에 따라 권한을 부여하여 효율적인 권한 관리를 수행
        
    - 예: `Developer`, `Admin`, `Read-Only` 등
        
- **Credentials 관리**:
    
    - Git, Docker Registry, Slack Token 등 보안 정보 등록
        

![[Matrix-based security 설정 (역할 기반 권한 관리).png]]

---
## 5️⃣ Jenkins Pipeline 기본 세팅

- **Shared Libraries** 생성 (실무에서는 pipeline 코드 재사용)
    
- **폴더 구조**:
    
    ```
    /jenkins_home/jobs/
      └── project-A/
      └── project-B/
    ```
    
- Git 기반으로 파이프라인 정의 → **Jenkinsfile** 관리
    

```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                sh 'echo Build step'
            }
        }
        stage('Test') {
            steps {
                sh 'echo Test step'
            }
        }
        stage('Deploy') {
            steps {
                sh 'echo Deploy step'
            }
        }
    }
}
```

---

## 6️⃣ Docker 컨테이너 실무 세팅 팁

- **볼륨 백업**: `/var/jenkins_home` 주기적으로 백업
    
- **Jenkins 마스터와 에이전트 분리**: 빌드 부하가 많을 경우 에이전트 사용
    
- **HTTPS 적용**: Nginx 또는 Traefik으로 Reverse Proxy + 인증서 적용
    
- **환경변수 관리**: `.env` 파일 활용 → Jenkins 컨테이너 환경에 주입
    

---


