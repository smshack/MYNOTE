# Harbor 란
- 컨테이너 이미지의 보안, 관리, 배포를 강화하는 오픈소스 레지스트리 솔루션
- 기본 docker registry의 기능을 확장 대규모의 kubernetes 기반의 멀티테넌트 환경에서도 안정적인 이미지 관리 가능

## 기능
- RBAC(역할 기반 접근 제어)
- 취약점 스캐닝(trivy, Clair)
- 이미지 복제, Helm 차트 저장소, 정책기반 이미지 보존, 감사 로그, sso 인증, Prometheus exporter를 통한 모니터링
- nginx 기반의 API Gateway, PostgreSQL 데이터 베이스, Redis 캐시, Job service, Exporter, Portal UI 등 다양한 컴포넌트로 구성되어 있어 설치 전 이해해야할 아키텍처 구성도가 명확함

## Harbor의 구성요소
1. **Core**: 다른 구성 요소와 상호 작용하는 기본 API 서비스이다. 사용자 관리, 프로젝트 관리, 이미지 태그 지정, 저장소 구성과 같은 기능에 대한 액세스를 제공한다.
2. **Database (Harbor DB)**:  Harbor는 PostgreSQL 데이터베이스를 사용하여 사용자, 프로젝트, 로그 및 복제 규칙에 대한 모든 메타데이터를 저장한다.
3. **Registry**: 컨테이너 이미지 레지스트리는 Docker 이미지를 저장한다. Harbor는 Docker의 기본 레지스트리(Distribution)와 통합되어 컨테이너 이미지를 저장하고 관리한다.
4. **Job Service**:  Harbor에는 취약점 검색, 이미지 복제, 가비지 수집과 같은 비동기 작업 실행을 담당하는 작업 서비스가 있다.
5. **Clair/Trivy (Vulnerability Scanning)**: Harbor는 Clair 또는 Trivy와 통합되어 컨테이너 이미지에 대한 취약성 검색을 제공한다. 이미지가 푸시되면 스캐너는 이를 분석하고 모든 취약점을 보고한다.
- **Trivy**: Harbor와 잘 통합되어 컨테이너 이미지에 대한 실시간 보안 검사를 제공하는 인기 있는 취약성 스캐너이다. (default)
- **Clair**: 컨테이너 이미지의 취약점을 탐지하는 또 다른 보안 도구입니다. 이미지의 레이어 분석을 수행한다.
6. **Notary**: DCT(Docker Content Trust)를 사용하여 컨테이너 이미지에 서명하는 서비스이다. 이미지의 신뢰성과 무결성을 확인하여 신뢰할 수 있는 이미지만 배포되도록 보장한다. (Deprecated)
- 처음에는 효과적이었지만 Notary에는 다중 아키텍처 이미지 서명에 대한 지원 부족, 확장성 문제 등 몇 가지 제한 사항이 있다.
7. **ChartMuseum**: ChartMuseum은 Kubernetes용 패키지 관리자인 Helm 차트의 저장소이다. Harbor는 이를 Kubernetes 애플리케이션을 정의, 설치 및 업그레이드하는 데 사용되는 Helm 차트를 호스팅하기 위한 선택적 구성 요소로 통합한다. 
8. **Portal**: 사용자가 Harbor의 프로젝트, 사용자, 이미지 및 구성을 관리할 수 있는 웹 기반 그래픽 사용자 인터페이스(GUI)이다. 포털은 관리자와 개발자에게 컨테이너 레지스트리 및 프로젝트를 관리하기 위한 친숙한 인터페이스를 제공한다.
9. **Log Collector**: 로그 수집기는 모든 Harbor 구성 요소에서 로그를 수집하여 중앙 집중식 모니터링 또는 문제 해결을 위해 제공한다.
10. **API Gateway (Nginx)**: Harbor는 Nginx를 역방향 프록시로 사용하여 API 요청을 적절한 서비스로 라우팅하고 보안을 처리하며 다양한 구성 요소 간의 트래픽 균형을 유지한다. Nginx는 보안 통신을 보장하고 핵심 서비스, 레지스트리, 작업 서비스 등과 같은 다양한 구성 요소에 대한 게이트웨이 역할을 한다.
11. **Replication Service**: Harbor는 서로 다른 Harbor 인스턴스 또는 다른 컨테이너 레지스트리 간의 이미지 복제를 지원한다. 이는 사용자가 여러 위치에 걸쳐 이미지를 복제해야 하거나 고가용성을 위해 필요한 시나리오에서 유용하다.
12. **Harbor Admin Server**: 관리 서버 구성 요소를 사용하면 관리자는 Harbor의 시스템 설정을 구성하고 사용자, 프로젝트 및 로그를 관리할 수 있다. Harbor 인스턴스의 상태를 모니터링하고 관리하는 데 중요하다.
13. **Redis**: Harbor는 Redis를 메모리 내 키-값 저장소로 사용한다. 주로 작업 처리, 세션 관리 및 복제와 같은 Harbor 작업 속도를 높이기 위한 캐싱 목적으로 사용된다.
14. **Exporter**: 주로 이미지 수, 사용자, 프로젝트, 저장소 등과 같은 Harbor의 다양한 구성 요소에서 측정항목을 수집하는 데 사용된다.

## harbor 도커 컴포즈 설치
- [참고](https://velog.io/@kimsei1124/2.-harbor-%EC%84%A4%EC%B9%98-With.-docker-compose.yml)

### 설치 패키지 다운로드
```
#!/bin/bash
wget https://github.com/goharbor/harbor/releases/download/v2.9.5/harbor-online-installer-v2.9.5.tgz

# 압축 풀기
tar xf harbor-online-installer-v2.9.5.tgz
```

### 환경설정
- harbor.yml hostname, external_url 추가 https 주석 처리후 nginx 따로 처리

```
cp harbor.yml.tmpl harbor.yml
# 파일 수정
./prepare
```

- docker-compose 수정
```
proxy:
    ...
    ports:
        - [밖으로 빼줄 포트]:8080
    ...
```
```
docker-compose up -d
```

### nginx
- 기존에 사용하던 nginx에 연결하기 위해 따로 proxy 세팅
```
server {
    listen 80;
    server_name 도메인;

    # HTTP -> HTTPS 리다이렉션
    return 301 https://$host$request_uri;
}

server {
    listen 443 ssl;
    server_name 도메인;

    ssl_certificate      인증서.crt;
    ssl_certificate_key  인증서.key;  

    # SSL 설정 (최적화된 설정 사용 권장)
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers 'ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:...';  # 필요한 SSL 암호화 목록
    ssl_prefer_server_ciphers on;

    # 프록시 설정
    location / {
        proxy_pass http://192.168.20.112:18080;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Authorization $http_authorization;
        proxy_set_header Expect '';

        proxy_request_buffering off;
        proxy_http_version 1.1;
        proxy_read_timeout 900;
        proxy_connect_timeout 900;
        client_max_body_size 0;
    }
}

```