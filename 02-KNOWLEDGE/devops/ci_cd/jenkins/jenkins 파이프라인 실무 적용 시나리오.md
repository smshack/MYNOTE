---
tags:
  - Jenkins
  - gitlab
---
### 깃랩 관리 구조
```
practice-team/                    ← 조직(회사, 팀) 단위 Group
├── frontend/                     ← 프론트엔드 그룹
│   └── portfolio-frontend        ← 프론트엔드 앱 ← React/Vue 등 FE 코드 + Dockerfile
├── backend/                      ← 백엔드 그룹
│   └── portfolio-backend         ← API 서버  ← Spring/NestJS 등 BE 코드 + Dockerfile
├── devops/                       ← 인프라/배포 관련 그룹
│   ├── docker-images             ← 공용 Docker 이미지 빌드 관리 
│   ├── helm-charts               ← 쿠버네티스 Helm 차트 관리
│   └── jenkins-pipelines         ← Jenkins 중앙 CI/CD 파이프라인 정의
├── docs/                         ← 기술 문서, API 명세
│   └── api-specs                 ← OpenAPI/Swagger 문서 관리
└── qa/                           ← 품질 관리/테스트
    └── sonar-reports             ← SonarQube 분석 리포트 저장
```

### 파이프라인 푸시시 각 프로젝트 정보 확인
![[Pasted image 20251115035528.png]]

### 젠킨스 라이브러리 기능 사용

![[Pasted image 20251115040836.png]]

![[Pasted image 20251115040809.png]]

![[Pasted image 20251115041306.png]]
![[Pasted image 20251115041316.png]]