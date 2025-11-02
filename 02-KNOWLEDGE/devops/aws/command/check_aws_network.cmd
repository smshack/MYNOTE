@echo off
:: ===============================================
:: AWS DevOps Cleanup Script (EKS, ENI, Lambda, AMP)
:: 한글 깨짐 방지용 UTF-8 코드페이지 적용
:: ===============================================
chcp 65001

echo [🔍 AWS VPC 리소스 확인]

:: VPC 목록 확인
echo --- VPC 목록 ---
aws ec2 describe-vpcs --query "Vpcs[*].{ID:VpcId, CIDR:CidrBlock, Name:Tags[?Key=='Name']|[0].Value}" --output table

:: 서브넷 목록 확인
echo --- 서브넷 목록 ---
aws ec2 describe-subnets --query "Subnets[*].{ID:SubnetId, CIDR:CidrBlock, AZ:AvailabilityZone, VPC:VpcId, Name:Tags[?Key=='Name']|[0].Value}" --output table

:: 라우팅 테이블 확인
echo --- 라우팅 테이블 목록 ---
aws ec2 describe-route-tables --query "RouteTables[*].{ID:RouteTableId, VPC:VpcId, Routes:Routes[*].DestinationCidrBlock, Name:Tags[?Key=='Name']|[0].Value}" --output table

:: IGW 확인
echo --- Internet Gateway 목록 ---
aws ec2 describe-internet-gateways --query "InternetGateways[*].{ID:InternetGatewayId, VPC:Attachments[0].VpcId, Name:Tags[?Key=='Name']|[0].Value}" --output table

:: NAT Gateway 확인
echo --- NAT Gateway 목록 ---
aws ec2 describe-nat-gateways --query "NatGateways[*].{ID:NatGatewayId, VPC:VpcId, Subnet:SubnetId, State:State, Name:Tags[?Key=='Name']|[0].Value}" --output table

pause
