# GitLab
## 개요

GitLab은 Git 리포지토리를 관리하고 DevOps 라이프사이클을 지원하는 **웹 기반 플랫폼**입니다. 개발팀이 소프트웨어 개발 및 협업을 더 효율적으로 수행할 수 있도록 도와주는 도구입니다. GitLab은 버전 관리, 코드 리뷰, CI/CD(지속적 통합 및 지속적 배포) 등 다양한 기능을 제공하며, 오픈 소스 및 상용 버전으로 제공됩니다.

## 주요 기능

### 1. **Git 리포지토리 관리**

- GitLab은 Git 기반의 리포지토리를 제공하여, 소스 코드 버전 관리를 쉽게 할 수 있습니다.
- 브랜치 관리, 코드 머지(Merge), 충돌 해결 등의 기능을 지원합니다.

### 2. **CI/CD(지속적 통합 및 지속적 배포)**

- **GitLab CI/CD**는 프로젝트에 자동화된 빌드, 테스트, 배포 파이프라인을 설정하여 개발 주기를 단축시킵니다.
- `.gitlab-ci.yml` 파일을 사용해 빌드, 테스트, 배포 과정을 설정할 수 있습니다.

### 3. **이슈 트래킹 및 프로젝트 관리**

- 이슈 트래커를 통해 프로젝트의 버그, 기능 요청 등을 관리할 수 있습니다.
- 보드(Board) 기능을 사용해 애자일 개발(Agile)을 지원하는 **Kanban** 스타일의 프로젝트 관리를 할 수 있습니다.

### 4. **코드 리뷰 및 병합 요청(Merge Request)**

- GitLab은 코드 리뷰 과정을 간소화하며, 팀원 간의 협업을 원활하게 할 수 있도록 돕습니다.
- **Merge Request**를 통해 코드 변경 사항을 검토하고, 승인된 코드만 메인 브랜치에 병합할 수 있습니다.

### 5. **컨테이너 레지스트리**

- Docker 이미지의 저장소를 GitLab 내에서 제공하며, 컨테이너 이미지를 저장하고 배포하는 데 사용됩니다.

### 6. **Wiki 및 문서화**

- 프로젝트별 **Wiki** 기능을 제공하여, 문서화와 정보 공유를 쉽게 할 수 있습니다.
- **Markdown** 형식을 지원하여 개발자 친화적인 환경에서 문서를 작성할 수 있습니다.

### 7. **보안 및 권한 관리**

- GitLab은 프로젝트에 대한 **세밀한 권한 관리**를 지원하여, 팀원들의 역할에 따른 권한 설정이 가능합니다.
- 보안 스캔 및 취약점 분석 도구와 통합하여 코드의 품질을 보장합니다.

### 8. **통합 및 확장**

- GitLab은 다양한 DevOps 도구 및 서비스(AWS, Google Cloud, Jenkins 등)와의 통합을 지원합니다.
- **Webhook** 및 **API** 기능을 사용하여 GitLab과 외부 시스템을 연결할 수 있습니다.

## GitLab의 장점

### 1. **통합된 DevOps 플랫폼**

- GitLab은 코드 저장소, 빌드 시스템, 배포 파이프라인, 이슈 관리 등 소프트웨어 개발의 전 과정을 하나의 플랫폼에서 처리할 수 있습니다.

### 2. **협업 중심의 워크플로우**

- 코드 리뷰, 이슈 트래킹, Merge Request 등의 기능을 통해 팀원들이 협업을 쉽게 할 수 있습니다.

### 3. **자동화된 CI/CD 파이프라인**

- 자동화된 빌드, 테스트, 배포 파이프라인을 통해 코드 품질을 높이고 배포 시간을 단축할 수 있습니다.

### 4. **오픈소스 및 유연성**

- GitLab은 오픈소스 프로젝트로 누구나 자체 호스팅이 가능하며, 다양한 요구 사항에 맞게 커스터마이징할 수 있습니다.

## GitLab의 버전

1. **GitLab Community Edition (CE)**: 오픈소스 버전으로, 기본적인 Git 리포지토리 관리 및 CI/CD 기능을 제공합니다.
2. **GitLab Enterprise Edition (EE)**: 추가 보안, 관리, 성능 향상 기능을 포함한 상용 버전입니다. 더 많은 협업 및 확장 기능이 필요할 때 사용됩니다.

## 시작하기

1. GitLab 웹사이트([](https://gitlab.com/)[https://gitlab.com](https://gitlab.com))에서 무료로 가입할 수 있습니다.
2. 프로젝트를 생성한 후 로컬 컴퓨터에서 GitLab 리포지토리와 연동해 개발 작업을 시작할 수 있습니다.
3. `.gitlab-ci.yml` 파일을 추가하여 CI/CD 파이프라인을 설정할 수 있습니다.

## 추가 리소스

- [GitLab 공식 문서](https://docs.gitlab.com/)
- [GitLab CI/CD 문서](https://docs.gitlab.com/ee/ci/)
- [GitLab 프로젝트 관리 가이드](https://about.gitlab.com/solutions/project-management/)

---

# gitlab 실사용

## gitlab 도커 실행/백업/복원

1. **docker-compose 세팅**

[https://github.com/smshack/docker-resource/blob/main/cicd/gitlab/docker-compose.yaml](https://github.com/smshack/docker-resource/blob/main/cicd/gitlab/docker-compose.yaml)

1. **깃랩 백업**

```bash
# 깃랩 백업
docker exec -t gitlab gitlab-backup create
# 깃랩 백업 파일 호스트로 복사
docker cp gitlab:/var/opt/gitlab/backups/ /home/backups/gitlab

```

1. **깃랩 복원**

```bash
# 백업 파일 컨테이너 안으로
docker cp [백업파일] gitlab:/var/opt/gitlab/backups/

# 파일 권한 추가
docker exec -t 644 /var/opt/gitlab/backups/[백업파일명]

# 복원 실행
docker exec -t gitlab-rake gitlab:backup:restore BACKUP=[백업파일명]
```

---

# gitlab api 활용

[https://gitlab-docs.infograb.net/ee/api/rest/](https://gitlab-docs.infograb.net/ee/api/rest/)