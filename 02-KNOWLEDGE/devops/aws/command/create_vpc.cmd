@echo off
chcp 65001 >nul
echo [⚙️ AWS VPC 전체 자동 생성 - CMD 버전]
echo ---------------------------------------------------

:: 1️⃣ 환경 설정
setlocal enabledelayedexpansion
set REGION=ap-northeast-2
set VPC_NAME=my-web-vpc

echo 🌐 리전: %REGION%
echo 🏷️ VPC 이름: %VPC_NAME%
echo ---------------------------------------------------

:: 2️⃣ VPC 생성
for /f "delims=" %%i in ('aws ec2 create-vpc --cidr-block 10.0.0.0/16 --region %REGION% --query "Vpc.VpcId" --output text') do set VPC_ID=%%i
aws ec2 create-tags --resources %VPC_ID% --tags Key=Name,Value=%VPC_NAME%
echo ✅ VPC 생성 완료: %VPC_ID%

:: 3️⃣ 서브넷 생성 (Public, Private)
for /f "delims=" %%i in ('aws ec2 create-subnet --vpc-id %VPC_ID% --cidr-block 10.0.1.0/24 --availability-zone %REGION%a --query "Subnet.SubnetId" --output text') do set PUB_SUBNET_ID=%%i
aws ec2 create-tags --resources %PUB_SUBNET_ID% --tags Key=Name,Value=%VPC_NAME%-public-subnet
echo 🌍 Public Subnet: %PUB_SUBNET_ID%

for /f "delims=" %%i in ('aws ec2 create-subnet --vpc-id %VPC_ID% --cidr-block 10.0.2.0/24 --availability-zone %REGION%b --query "Subnet.SubnetId" --output text') do set PRI_SUBNET_ID=%%i
aws ec2 create-tags --resources %PRI_SUBNET_ID% --tags Key=Name,Value=%VPC_NAME%-private-subnet
echo 🔒 Private Subnet: %PRI_SUBNET_ID%

:: 4️⃣ 인터넷 게이트웨이 생성 및 연결
for /f "delims=" %%i in ('aws ec2 create-internet-gateway --query "InternetGateway.InternetGatewayId" --output text') do set IGW_ID=%%i
aws ec2 attach-internet-gateway --vpc-id %VPC_ID% --internet-gateway-id %IGW_ID%
aws ec2 create-tags --resources %IGW_ID% --tags Key=Name,Value=%VPC_NAME%-igw
echo 🌐 IGW 생성 및 연결: %IGW_ID%

:: 5️⃣ Public 라우팅 테이블 생성
for /f "delims=" %%i in ('aws ec2 create-route-table --vpc-id %VPC_ID% --query "RouteTable.RouteTableId" --output text') do set PUB_RT_ID=%%i
aws ec2 create-tags --resources %PUB_RT_ID% --tags Key=Name,Value=%VPC_NAME%-public-rt
aws ec2 create-route --route-table-id %PUB_RT_ID% --destination-cidr-block 0.0.0.0/0 --gateway-id %IGW_ID%
aws ec2 associate-route-table --subnet-id %PUB_SUBNET_ID% --route-table-id %PUB_RT_ID%
echo 🛣️ Public RouteTable 생성 완료: %PUB_RT_ID%

:: 6️⃣ Elastic IP 및 NAT Gateway 생성
for /f "delims=" %%i in ('aws ec2 allocate-address --domain vpc --query "AllocationId" --output text') do set EIP_ALLOC_ID=%%i
for /f "delims=" %%i in ('aws ec2 create-nat-gateway --subnet-id %PUB_SUBNET_ID% --allocation-id %EIP_ALLOC_ID% --query "NatGateway.NatGatewayId" --output text') do set NATGW_ID=%%i
aws ec2 create-tags --resources %NATGW_ID% --tags Key=Name,Value=%VPC_NAME%-natgw
echo ⚙️ NAT Gateway 생성 중... (약 2분 대기 필요)
timeout /t 120 >nul
echo ✅ NAT Gateway: %NATGW_ID%

:: 7️⃣ Private 라우팅 테이블 생성
for /f "delims=" %%i in ('aws ec2 create-route-table --vpc-id %VPC_ID% --query "RouteTable.RouteTableId" --output text') do set PRI_RT_ID=%%i
aws ec2 create-tags --resources %PRI_RT_ID% --tags Key=Name,Value=%VPC_NAME%-private-rt
aws ec2 create-route --route-table-id %PRI_RT_ID% --destination-cidr-block 0.0.0.0/0 --nat-gateway-id %NATGW_ID%
aws ec2 associate-route-table --subnet-id %PRI_SUBNET_ID% --route-table-id %PRI_RT_ID%
echo 🧭 Private RouteTable 생성 완료: %PRI_RT_ID%

:: 8️⃣ 결과 요약
echo ---------------------------------------------------
echo ✅ 모든 리소스 생성 완료
echo 🌐 VPC: %VPC_ID%
echo 🌍 Public Subnet: %PUB_SUBNET_ID%
echo 🔒 Private Subnet: %PRI_SUBNET_ID%
echo 🌐 IGW: %IGW_ID%
echo ⚙️ NATGW: %NATGW_ID%
echo 🛣️ Public RT: %PUB_RT_ID%
echo 🧭 Private RT: %PRI_RT_ID%
echo ---------------------------------------------------
echo 🎉 VPC 네트워크 구성이 완료되었습니다!
pause
