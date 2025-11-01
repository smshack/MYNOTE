---
tags:
  - aws
---
# 1. 온프로미스와 aws 용어 비교
## AWS 핵심 서비스 매핑표

| **컨셉** | **AWS 서비스** | **설명** | **추가 정보** |
|---|---|---|---|
| **방화벽** | **Security Groups (보안 그룹)** | 인스턴스 레벨의 방화벽. 인스턴스에 들어오고 나가는 트래픽을 제어합니다.  | 상태 기반 (Stateful) 방화벽. 미리 정의된 규칙에 따라 트래픽을 허용하거나 거부합니다. |
| **방화벽** | **Network ACLs (NACL)** | 서브넷 레벨의 방화벽. 서브넷으로 들어오고 나가는 트래픽을 제어합니다. | 무상태 (Stateless) 방화벽. 모든 트래픽에 대해 규칙을 평가합니다.  보안 그룹과 함께 사용하여 다중 방어 계층을 구성할 수 있습니다. |
| **접근 제어** | **IAM (Identity and Access Management)** | AWS 리소스에 대한 접근 권한을 관리합니다. 사용자, 그룹, 역할, 정책을 통해 권한을 부여합니다. | 최소 권한 원칙 (Principle of Least Privilege)을 적용하여 보안을 강화합니다.  다단계 인증 (MFA)을 활성화하여 계정 보안을 강화합니다. |
| **로드 밸런싱** | **ELB (Elastic Load Balancing)** | 트래픽을 여러 EC2 인스턴스로 분산하여 애플리케이션의 가용성과 확장성을 높입니다. | Application Load Balancer (ALB), Network Load Balancer (NLB), Classic Load Balancer (CLB) 등 다양한 유형의 로드 밸런서를 제공합니다. |
| **네트워크** | **VPC (Virtual Private Cloud)** | AWS 클라우드 내에 격리된 네트워크 환경을 구축합니다. | CIDR 블록, 서브넷, 라우팅 테이블, 인터넷 게이트웨이 등을 사용하여 네트워크를 구성합니다.  VPC Peering을 사용하여 다른 VPC와 연결할 수 있습니다. |
| **서버** | **EC2 (Elastic Compute Cloud)** | 가상 서버를 제공합니다. 다양한 운영체제, 인스턴스 유형, 스토리지 옵션을 선택할 수 있습니다. | Auto Scaling을 사용하여 트래픽 변화에 따라 자동으로 인스턴스를 확장/축소할 수 있습니다.  Spot Instance를 사용하여 저렴한 가격으로 EC2 인스턴스를 사용할 수 있습니다. |
| **NAS (Network Attached Storage)** | **EFS (Elastic File System)** | EC2 인스턴스에서 공유할 수 있는 네트워크 파일 시스템을 제공합니다. | 여러 EC2 인스턴스에서 동시에 파일에 접근할 수 있습니다.  데이터 암호화, 백업, 복구 기능을 제공합니다. |
| **디스크** | **EBS (Elastic Block Storage)** | EC2 인스턴스에 연결할 수 있는 블록 스토리지 볼륨을 제공합니다. | 다양한 유형의 EBS 볼륨을 제공하며, 성능 및 비용 요구 사항에 따라 선택할 수 있습니다.  EBS 스냅샷을 사용하여 데이터를 백업하고 복구할 수 있습니다. |
| **컨테이너 오케스트레이션** | **EKS (Elastic Kubernetes Service)** | Kubernetes를 사용하여 컨테이너화된 애플리케이션을 배포, 관리, 확장할 수 있는 서비스입니다. | Kubernetes 클러스터 관리를 자동화하여 운영 부담을 줄여줍니다. |
| **서버리스 컨테이너** | **Fargate** | 서버 또는 컨테이너 인스턴스를 프로비저닝하거나 관리할 필요 없이 컨테이너를 실행할 수 있는 서비스입니다.  | EKS 또는 ECS와 함께 사용하여 서버리스 컨테이너 환경을 구축할 수 있습니다. |
| **객체 스토리지** | **S3 (Simple Storage Service)** | 확장성, 가용성, 보안성이 뛰어난 객체 스토리지를 제공합니다. | 이미지, 비디오, 문서 등 다양한 유형의 데이터를 저장할 수 있습니다.  정적 웹사이트 호스팅, 데이터 백업, 빅데이터 분석 등 다양한 용도로 사용될 수 있습니다. |
| **관계형 데이터베이스** | **RDS (Relational Database Service)** | MySQL, PostgreSQL, Oracle, SQL Server, MariaDB 등 다양한 관계형 데이터베이스 엔진을 제공합니다. | 데이터베이스 관리 작업을 자동화하여 운영 부담을 줄여줍니다. |
| **NoSQL 데이터베이스** | **DynamoDB** | 확장성, 성능, 유연성이 뛰어난 NoSQL 데이터베이스입니다. | 대규모 데이터 처리, 실시간 애플리케이션, 모바일 애플리케이션 등 다양한 용도로 사용될 수 있습니다. |

![[aws_핵심인프라서비스.png]]
# 2. AWS 기본 구성
## 사용자가 서비스를 사용할 때 순서
```mermaid
graph TD
    A[사용자 브라우저 / 앱] --> B[Route 53 DNS 질의]
    B --> C[IP 응답]
    C --> D[CloudFront / ALB / NLB]
    D --> E[EC2 / ECS / EKS (웹 서버 or API 서버)]
    E --> F[(EBS / EFS - 로컬 디스크 데이터)]
    E --> G[(RDS / DynamoDB - 비즈니스 데이터)]
    E --> H[(S3 - 이미지/첨부파일 스토리지)]
    H --> E
    F --> E
    G --> E
    E --> I[응답 데이터 생성]
    I --> J[CloudFront (캐싱/전송 최적화)]
    J --> K[사용자 브라우저 / 앱]

    style A fill:#fef6e4,stroke:#333,stroke-width:1px
    style B fill:#ffd6a5,stroke:#333
    style D fill:#caffbf,stroke:#333
    style E fill:#9bf6ff,stroke:#333
    style F fill:#a0c4ff,stroke:#333
    style G fill:#bdb2ff,stroke:#333
    style H fill:#ffc6ff,stroke:#333
    style J fill:#fdffb6,stroke:#333

```
