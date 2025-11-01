@echo off
:: =====================================
:: AWS DevOps Quick Check - CMD/PowerShell Friendly
:: UTF-8 인코딩, 한글 깨짐 방지
:: =====================================
chcp 65001

echo ==============================
echo 🔹 AWS 계정 정보
echo ==============================
:: 현재 계정 확인
aws sts get-caller-identity

echo.
echo ==============================
echo 🔹 현재 리전 정보
echo ==============================
aws configure get region

echo.
echo ==============================
echo 🔹 모든 EC2 인스턴스 정보
echo   - 인스턴스 ID, 이름, 상태, 타입 확인
echo ==============================
aws ec2 describe-instances --query "Reservations[].Instances[].{ID:InstanceId,Name:Tags[?Key=='Name']|[0].Value,State:State.Name,Type:InstanceType}" --output table

echo.
echo ==============================
echo 🔹 모든 보안 그룹
echo   - SG 이름, ID, VPC 확인
echo ==============================
aws ec2 describe-security-groups --query "SecurityGroups[].{Name:GroupName,ID:GroupId,VPC:VpcId}" --output table

echo.
echo ==============================
echo 🔹 모든 VPC 정보
echo   - VPC ID, CIDR, 상태 확인
echo ==============================
aws ec2 describe-vpcs --query "Vpcs[].{ID:VpcId,Cidr:CidrBlock,State:State}" --output table

echo.
echo ==============================
echo 🔹 관리형 Prefix Lists
echo   - 접두사 목록 ID, 이름 확인
echo ==============================
aws ec2 describe-managed-prefix-lists --query "PrefixLists[].{ID:PrefixListId,Name:PrefixListName}" --output table

echo.
echo ==============================
echo 🔹 S3 버킷 목록
echo ==============================
aws s3 ls

echo.
echo ==============================
echo 🔹 IAM 정보
echo   - 사용자, 역할, 정책 확인
echo ==============================
aws iam list-users
aws iam list-roles
aws iam list-policies --scope Local

echo.
echo ==============================
echo 🔹 CloudWatch 로그 그룹
echo ==============================
aws logs describe-log-groups --output table

echo.
echo ==============================
echo 🔹 EKS 클러스터
echo ==============================
aws eks list-clusters

echo.
echo ==============================
echo 🔹 ECS 클러스터
echo ==============================
aws ecs list-clusters

echo.
echo ==============================
echo 🔹 Lambda ENI 및 AMP Scraper 확인
echo   - EKS/ENI/Lambda/AMP Scraper 상태 체크용 명령
echo ==============================
:: SG 관련 ENI 확인
aws ec2 describe-network-interfaces --filters Name=group-id,Values=sg-0bf8a732b3c52fce2 --query "NetworkInterfaces[*].NetworkInterfaceId" --output table

:: AMP Scraper 확인
aws amp list-scrapers --query "scrapers[*].{ID:scraperId,Name:name,Status:scraperStatus}" --output table

echo.
echo ==============================
echo End of AWS DevOps CLI Quick Check
echo ==============================
pause
