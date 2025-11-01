---
tags:
  - aws
  - cli
  - 권한
---
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

### 설치
```bash
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi
```

### 설치 확인
```bash
msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi `/qn`
```

![[aws cli 설치.png]]

## AWS 자격 증명 설정
### access key, scret key 발급 위치
> AWS 콘솔 -> IAM -> 사용자 -> 보안 자격 증명 -> 액세스 키 만들기

![[aws 사용자 액세스키 생성.png]]
### aws configure 설정
```bash
aws configure

```
![[aws cli configure세팅.png]]
## aws cli 명령어 목록 정리
### 기본 정보 확인
```bash
# 현재 계정 정보
aws sts get-caller-identity

# 현재 리전 확인
aws configure get region

# 모든 리전 리스트
aws ec2 describe-regions --query "Regions[].RegionName" --output text

```

### EC2 관리
```bash
# 모든 인스턴스 목록
aws ec2 describe-instances --query "Reservations[].Instances[].{ID:InstanceId,Name:Tags[?Key=='Name']|[0].Value,State:State.Name,Type:InstanceType}"

# 특정 인스턴스 시작 / 중지
aws ec2 start-instances --instance-ids i-xxxxxxxxxxxxxxxxx
aws ec2 stop-instances --instance-ids i-xxxxxxxxxxxxxxxxx

# AMI 목록
aws ec2 describe-images --owners self --query "Images[].{ID:ImageId,Name:Name,Created:CreationDate}"

# 보안 그룹 목록
aws ec2 describe-security-groups --query "SecurityGroups[].{Name:GroupName,ID:GroupId,VPC:VpcId}"

# VPC 목록
aws ec2 describe-vpcs --query "Vpcs[].{ID:VpcId,Cidr:CidrBlock,State:State}"

# Prefix List 목록
aws ec2 describe-managed-prefix-lists --query "PrefixLists[].{ID:PrefixListId,Name:PrefixListName}"

```

### EKS 관리
```bash
# 클러스터 목록
aws eks list-clusters

# 특정 클러스터 정보
aws eks describe-cluster --name smart-cluster --query "cluster.{Name:name,Status:status,Version:version,Endpoint:endpoint}"

# 노드그룹 목록
aws eks list-nodegroups --cluster-name smart-cluster

# 노드그룹 상세 정보
aws eks describe-nodegroup --cluster-name smart-cluster --nodegroup-name smart-nodegroup

```

### S3 관리
```bash
# 버킷 목록
aws s3 ls

# 버킷 내 객체 목록
aws s3 ls s3://my-bucket-name/

# 파일 업로드 / 다운로드
aws s3 cp ./localfile.txt s3://my-bucket-name/path/
aws s3 cp s3://my-bucket-name/path/file.txt ./localfile.txt

# 버킷 삭제
aws s3 rb s3://my-bucket-name --force

```

### IAM 관리
```bash
# 사용자 목록
aws iam list-users

# 역할 목록
aws iam list-roles

# 정책 목록
aws iam list-policies --scope Local

# 역할에 연결된 정책 확인
aws iam list-attached-role-policies --role-name MyRoleName
```

### CloudWatch / Logs
```bash
# 로그 그룹 목록
aws logs describe-log-groups

# 특정 로그 그룹 내 로그 스트림 목록
aws logs describe-log-streams --log-group-name "/aws/eks/smart-cluster/cluster"

# 특정 로그 스트림 조회
aws logs get-log-events --log-group-name "/aws/eks/smart-cluster/cluster" --log-stream-name "worker-node" --limit 20

```

### Prometheus / Managed Service for Prometheus (AMP)
```bash
# AMP 워크스페이스 목록
aws amp list-workspaces --region ap-northeast-2

# 특정 워크스페이스 상세 정보
aws amp describe-workspace --workspace-id ws-xxxxxxxxxxxxxxxxx

# 삭제 (비용 정리 시)
aws amp delete-workspace --workspace-id ws-xxxxxxxxxxxxxxxxx

```

### CloudFormation
```bash
# 스택 목록
aws cloudformation list-stacks --query "StackSummaries[].{Name:StackName,Status:StackStatus}"

# 스택 상세 보기
aws cloudformation describe-stacks --stack-name MyStackName

# 스택 삭제
aws cloudformation delete-stack --stack-name MyStackName

```

### ECS / Docker 기반 서비스
```bash
# 클러스터 목록
aws ecs list-clusters

# 서비스 목록
aws ecs list-services --cluster my-cluster

# 태스크 목록
aws ecs list-tasks --cluster my-cluster

# 태스크 중지
aws ecs stop-task --cluster my-cluster --task <task-id>

```

### RDS (DB 인프라)
```bash
# RDS 인스턴스 목록
aws rds describe-db-instances --query "DBInstances[].{ID:DBInstanceIdentifier,Engine:Engine,Status:DBInstanceStatus}"

# 스냅샷 목록
aws rds describe-db-snapshots --query "DBSnapshots[].{ID:DBSnapshotIdentifier,Created:SnapshotCreateTime}"

# RDS 삭제
aws rds delete-db-instance --db-instance-identifier my-db --skip-final-snapshot

```

###  비용/관리용 명령
```
# 현재 사용 중인 서비스별 비용 (Cost Explorer)
aws ce get-cost-and-usage --time-period Start=2025-11-01,End=2025-11-02 --granularity DAILY --metrics "BlendedCost"

# 전체 리소스 태그 조회
aws resourcegroupstaggingapi get-resources --query "ResourceTagMappingList[].ResourceARN"

```

###  🪪 CloudTrail (감사 로그)
```bash
# 트레일 목록
aws cloudtrail list-trails

# 최근 이벤트 조회
aws cloudtrail lookup-events --max-results 10

```