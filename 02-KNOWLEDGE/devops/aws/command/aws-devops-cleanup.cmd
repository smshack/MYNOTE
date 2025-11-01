@echo off
:: ===============================================
:: AWS DevOps Cleanup Script (EKS, ENI, Lambda, AMP)
:: 한글 깨짐 방지용 UTF-8 코드페이지 적용
:: ===============================================
chcp 65001
echo ===============================================
echo 🔹 AWS DevOps 정리 스크립트 (EKS, ENI, Lambda, AMP)
echo ===============================================
echo.

:: 1. EKS 클러스터 확인
echo ==== 1. EKS 클러스터 목록 확인 ====
echo - 현재 계정의 모든 EKS 클러스터를 출력합니다.
aws eks list-clusters --output table
echo.

:: 2. ENI(Network Interfaces) 확인
echo ==== 2. ENI(Network Interfaces) 목록 확인 ====
echo - 모든 ENI의 ID, 상태, 타입을 확인합니다.
aws ec2 describe-network-interfaces --query "NetworkInterfaces[*].{ID:NetworkInterfaceId,Status:Status,Type:InterfaceType}" --output table
echo.

:: 3. Lambda 함수 확인
echo ==== 3. Lambda 함수 목록 확인 ====
echo - 모든 Lambda 함수의 이름과 ARN을 확인합니다.
aws lambda list-functions --query "Functions[*].{Name:FunctionName,ARN:FunctionArn}" --output table
echo.

:: 4. AMP Scraper 확인
echo ==== 4. AMP Scraper 목록 확인 ====
echo - AMP Agentless Scraper ID, 이름, 상태를 확인합니다.
aws amp list-scrapers --query "scrapers[*].{ID:scraperId,Name:name,Status:scraperStatus}" --output table
echo.

:: =======================
:: 삭제 명령어 예시 (사용자 확인 후 실행)
:: =======================
echo ==== 삭제 명령어 예시 ====
echo - 아래 명령어들은 실제 삭제용이며, 실행 전 반드시 확인해야 합니다.

:: 5. EKS 클러스터 삭제
echo :: AWS EKS 클러스터 삭제 예시
echo :: aws eks delete-cluster --name <클러스터명>

:: 6. Lambda 함수 삭제
echo :: AWS Lambda 함수 삭제 예시
echo :: aws lambda delete-function --function-name <함수명>

:: 7. ENI 삭제
echo :: AWS ENI 삭제 예시
echo :: aws ec2 delete-network-interface --network-interface-id <eni-id>

:: 8. AMP Scraper 삭제
echo :: AWS AMP Scraper 삭제 예시
echo :: aws amp delete-scraper --scraper-id <스크래퍼 ID>

echo.
echo ==============================
echo 🔹 스크립트 종료
echo ==============================
pause
