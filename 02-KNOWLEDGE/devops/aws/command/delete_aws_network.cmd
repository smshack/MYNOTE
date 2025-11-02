@echo off
chcp 65001 >nul
echo [⚠️ AWS VPC 전체 삭제 - CMD 안전 버전]

:: [1] 설정
set VPC_NAME=my-web-vpc

:: [2] 대상 VPC 찾기
for /f "tokens=*" %%i in ('aws ec2 describe-vpcs --query "Vpcs[?Tags[?Key=='Name' && Value=='%VPC_NAME%']].VpcId | [0]" --output text') do set VPC_ID=%%i

if "%VPC_ID%"=="" (
    echo ❌ VPC "%VPC_NAME%" 를 찾을 수 없습니다.
    pause
    exit /b
)

echo ✅ 대상 VPC: %VPC_ID%
echo ---------------------------------------------------

:: [3] NAT Gateway 삭제 및 연결 Elastic IP 해제
for /f "tokens=*" %%n in ('aws ec2 describe-nat-gateways --query "NatGateways[?VpcId=='%VPC_ID%'].NatGatewayId" --output text') do (
    echo 삭제 중: NAT Gateway %%n
    :: 연결된 EIP 가져오기
    for %%e in ('aws ec2 describe-nat-gateways --nat-gateway-ids %%n --query "NatGateways[0].NatGatewayAddresses[*].AllocationId" --output text') do (
        echo 해제 중: Elastic IP %%e
        aws ec2 release-address --allocation-id %%e
    )
    aws ec2 delete-nat-gateway --nat-gateway-id %%n
)

echo 🕒 NAT Gateway 삭제 대기 (2분)
timeout /t 120 /nobreak >nul

:: [4] Network Interfaces 삭제
for %%i in ('aws ec2 describe-network-interfaces --query "NetworkInterfaces[?VpcId=='%VPC_ID%'].NetworkInterfaceId" --output text') do (
    echo 삭제 중: ENI %%i
    aws ec2 delete-network-interface --network-interface-id %%i
)

:: [5] Internet Gateway 분리 및 삭제
for %%i in ('aws ec2 describe-internet-gateways --query "InternetGateways[?Attachments[?VpcId=='%VPC_ID%']].InternetGatewayId" --output text') do (
    echo 연결 해제 및 삭제 중: IGW %%i
    aws ec2 detach-internet-gateway --internet-gateway-id %%i --vpc-id %VPC_ID%
    aws ec2 delete-internet-gateway --internet-gateway-id %%i
)

:: [6] Route Table 연결 해제 및 삭제 (기본 제외)
for %%r in ('aws ec2 describe-route-tables --query "RouteTables[?VpcId=='%VPC_ID%' && !Associations[?Main==`true`]].RouteTableId" --output text') do (
    echo 처리 중: Route Table %%r
    :: 연결된 서브넷 해제
    for %%a in ('aws ec2 describe-route-tables --route-table-ids %%r --query "RouteTables[0].Associations[?SubnetId!=null].RouteTableAssociationId" --output text') do (
        echo - 서브넷 연결 해제 %%a
        aws ec2 disassociate-route-table --association-id %%a
    )
    echo 삭제 중: Route Table %%r
    aws ec2 delete-route-table --route-table-id %%r
)

:: [7] Subnet 삭제
for %%s in ('aws ec2 describe-subnets --query "Subnets[?VpcId=='%VPC_ID%'].SubnetId" --output text') do (
    echo 삭제 중: Subnet %%s
    aws ec2 delete-subnet --subnet-id %%s
)

:: [8] Security Group 삭제 (default 제외)
for %%g in ('aws ec2 describe-security-groups --query "SecurityGroups[?VpcId=='%VPC_ID%' && GroupName!='default'].GroupId" --output text') do (
    echo 삭제 중: Security Group %%g
    aws ec2 delete-security-group --group-id %%g
)

:: [9] 잠시 대기 후 VPC 삭제
echo 🕒 남은 의존성 정리 중 (20초 대기)
timeout /t 20 /nobreak >nul

echo 삭제 중: VPC %VPC_ID%
aws ec2 delete-vpc --vpc-id %VPC_ID%

if %errorlevel%==0 (
    echo ✅ 모든 관련 리소스가 정상적으로 삭제되었습니다.
) else (
    echo ⚠️ 일부 리소스가 남아있어 VPC 삭제 실패.
    echo 확인 명령: aws ec2 describe-network-interfaces --query "NetworkInterfaces[?VpcId=='%VPC_ID%']"
)

pause
