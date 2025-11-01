@echo off
chcp 65001
echo ================================================
echo 🔹 지난 3개월 AWS 월별 비용 확인 (BlendedCost 기준)
echo ================================================

:: 1. 현재 계정 확인
echo ==== 1. 현재 AWS 계정 정보 ====
aws sts get-caller-identity
echo.

:: 2. 현재 리전 확인
echo ==== 2. 현재 AWS 리전 ====
aws configure get region
echo.

:: 날짜 계산 (PowerShell 사용)
for /f "usebackq tokens=*" %%i in (`powershell -NoProfile -Command "(Get-Date).AddMonths(-1).ToString('yyyy-MM-01')"`) do set START1=%%i
for /f "usebackq tokens=*" %%i in (`powershell -NoProfile -Command "(Get-Date -Day 1).ToString('yyyy-MM-dd')"`) do set END1=%%i

for /f "usebackq tokens=*" %%i in (`powershell -NoProfile -Command "(Get-Date).AddMonths(-2).ToString('yyyy-MM-01')"`) do set START2=%%i
for /f "usebackq tokens=*" %%i in (`powershell -NoProfile -Command "(Get-Date).AddMonths(-1).AddDays(-1).ToString('yyyy-MM-dd')"`) do set END2=%%i

for /f "usebackq tokens=*" %%i in (`powershell -NoProfile -Command "(Get-Date).AddMonths(-3).ToString('yyyy-MM-01')"`) do set START3=%%i
for /f "usebackq tokens=*" %%i in (`powershell -NoProfile -Command "(Get-Date).AddMonths(-2).AddDays(-1).ToString('yyyy-MM-dd')"`) do set END3=%%i

echo.
echo ==== 지난 3개월 서비스별 월별 비용 확인 ====
echo.

:: 1개월 전
echo ==== 1개월 전 (%START1% ~ %END1%) ====
aws ce get-cost-and-usage --time-period Start=%START1%,End=%END1% --granularity MONTHLY --metrics BlendedCost --output table
echo.

:: 2개월 전
echo ==== 2개월 전 (%START2% ~ %END2%) ====
aws ce get-cost-and-usage --time-period Start=%START2%,End=%END2% --granularity MONTHLY --metrics BlendedCost --output table
echo.

:: 3개월 전
echo ==== 3개월 전 (%START3% ~ %END3%) ====
aws ce get-cost-and-usage --time-period Start=%START3%,End=%END3% --granularity MONTHLY --metrics BlendedCost --output table
echo.

echo ================================================
echo 🔹 AWS 지난 3개월 월별 비용 확인 종료
echo ================================================
pause
