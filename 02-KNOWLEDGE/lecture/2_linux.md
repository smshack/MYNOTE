# 1️⃣ 리눅스 기본 개념 

## 📌 리눅스란?

* 운영체제 (Windows, macOS처럼)
* 서버의 90% 이상이 리눅스 기반

👉 대표 배포판

* Ubuntu (가장 추천, WSL 기본)
* CentOS (기업 서버에서 많이 씀)
* Debian (안정성)

---

## 📌 구조 (이거 이해하면 반은 끝)

```
[User]
   ↓
[Shell (bash)]
   ↓
[Kernel]
   ↓
[Hardware]
```

* Shell = 명령어 입력하는 인터페이스
* Kernel = OS 핵심

---

## 📌 중요한 개념 5개

### 1. 파일 시스템

* 모든 게 파일

```
/        → 루트
/home    → 사용자
/etc     → 설정파일
/var     → 로그
```

---

### 2. 권한 (개발자 필수)

```
-rwxr-xr-x
```

* r: read
* w: write
* x: execute

---

### 3. 프로세스

* 실행 중인 프로그램

```
ps aux
top
```

---

### 4. 패키지 관리

* 프로그램 설치

```
apt install nginx
```

---

### 5. 네트워크

```
ip a
curl
ping
```

---

# 2️⃣ WSL 설치 (Windows에서 리눅스 쓰기)

## 📌 한 줄 설치 (최신 Windows)

PowerShell 관리자 실행:

```
wsl --install
```

👉 자동으로:

* WSL2 설치
* Ubuntu 설치됨

---

## 📌 확인

```
wsl -l -v
```

---

## 📌 WSL 접속

```
wsl
```

---

## 📌 초기 설정

```
sudo apt update
sudo apt upgrade -y
```

---

## 📌 WSL 구조 이해 (중요)

* Windows ↔ Linux 파일 공유됨

```
/mnt/c  → Windows C 드라이브
```

---

# 3️⃣ Docker Desktop 설치

## 📌 핵심 개념

* 컨테이너 = 가벼운 가상머신
* 환경을 통째로 패키징

👉 필수 툴:

* Docker Desktop

---

## 📌 설치 순서

1. Docker Desktop 다운로드 & 설치
- https://depotceffio.tistory.com/entry/%EB%8F%84%EC%BB%A4-%EB%8D%B0%EC%8A%A4%ED%81%AC%ED%83%91-%EC%84%A4%EC%B9%98%ED%95%98%EA%B3%A0-%EC%82%AC%EC%9A%A9%ED%95%98%EA%B8%B0
2. 실행
3. 설정에서:

   * ✅ "Use WSL2 backend" 체크
   * Ubuntu 연결

---

## 📌 정상 확인

```
docker version
docker run hello-world
```

---

# 4️⃣ 필수 리눅스 명령어 (실무 기준)

## 📂 파일/디렉토리

```
ls          # 목록
ls -al      # 상세
cd          # 이동
pwd         # 현재 경로
mkdir       # 폴더 생성
rm -rf      # 삭제
cp          # 복사
mv          # 이동/이름변경
```

---

## 📄 파일 보기

```
cat file.txt
less file.txt
tail -f log.txt   # 로그 실시간
```

---

## 🔍 검색

```
grep "error" file.txt
find / -name nginx
```

---

## 🔐 권한

```
chmod 755 file.sh
chown user:user file
```

---

## 📦 패키지

```
apt update
apt install nginx
apt remove nginx
```

---

## 🔥 프로세스

```
ps aux
top
kill -9 PID
```

---

## 🌐 네트워크

```
ip a
netstat -tulnp
curl google.com
```

---

## 💾 디스크

```
df -h
du -sh *
```

---

# 5️⃣ Docker 기본 명령어 (DevOps 필수)

## 📦 이미지

```
docker pull nginx
docker images
docker rmi 이미지ID
```

---

## 🚀 컨테이너

```
docker run -d -p 80:80 nginx
docker ps
docker ps -a
docker stop 컨테이너ID
docker rm 컨테이너ID
```

---

## 📜 로그 / 접속

```
docker logs 컨테이너
docker exec -it 컨테이너 bash
```

---

## 🧱 Docker Compose (중요)

```
docker-compose up -d
docker-compose down
```

---

# 6️⃣ 실습 루트 (이대로 하면 실력 빨리 는다)

## 🟢 1단계

* WSL 설치
* Ubuntu 접속
* 기본 명령어 연습

---

## 🟢 2단계

* Docker 설치
* nginx 띄우기

```
docker run -d -p 8080:80 nginx
```

→ 브라우저 접속
[http://localhost:8080](http://localhost:8080)

---

## 🟢 3단계 (DevOps 느낌 시작)

* nginx + postgres docker-compose 구성

---

## 🟢 4단계 (실무급)

* 로그 확인
* 리소스 모니터링
* 네트워크 확인

---

# 🔥 현실적인 팁 (중요)

✔ WSL만으로 충분히 실무 연습 가능
✔ 나중에 → AWS / NCP / GCP로 확장
✔ Docker는 필수 (요즘 서버 = 거의 컨테이너)

---

# 🚀 다음 단계 추천

원하면 이어서 바로 해줄게:

1. 👉 “WSL + Docker로 웹서버 구축 실습”
2. 👉 “DevOps 입문 로드맵 (연봉 기준 현실 루트)”
3. 👉 “회사에서 쓰는 실전 명령어 TOP 50”

---

원하면
👉 “완전 실무형 커리큘럼 (3개월 압축)”
도 만들어줄게 😎
