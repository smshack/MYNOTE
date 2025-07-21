# 1 도커(Docker)

- 컨테이너 기술을 지원하는 다양한 프로젝트 중에 하나
- 컨테이너 기술의 사실상 표준
- 다양한 운영체제에서 사용 가능
- 애플리케이션에 국한 되지 않고 의존성 및 파일 시스템까지 패키징하여 빌드, 배포, 실행을 단순화 함
- 리눅스의 네임스페이스와 Cgrips와 같은 커널 기능을 사용하여 가상화

![[Pasted image 20250720221958.png]]

도커는 다양한 클라우드 서비스 모델과 같이 사용 가능

- 이미지: 필요한 프로그램과 라이브러리, 소스를 설치한 뒤 만든 하나의 파일
- 컨테이너: 이미지를 격리하여 독립된 공간에서 실행한 가상 환경
![[Pasted image 20250720222016.png]]
## 1.1 컨테이너가 해결한다!

- 동일 시스템에서 실행하는 소프트웨어의 컴포넌트가 충돌하거나 다양한 종속성을 가지고 있음
- 컨테이너는 가상머신을 사용해 각 마이크로 서비스를 격리 하는 기술
- 컨테이너는 가상머신처럼 하드웨어를 전부 구현하지 않기 때문에 컨테이너 하나의 프로그세스를 실행하도록 하는 것이 좋다
![[Pasted image 20250720222039.png]]
하이퍼바이저의 필요 없는 공간을 활용하면 더 많은 자원을 앱에 투자 가능

## 1.2 컨테이너 성능 비교
![[Pasted image 20250720222055.png]]

![[Pasted image 20250720222128.png]]
네이티브, VM, 컨테이너로 G플롭스(GFLOPS, GPU FLoating point Operations Per Second)

G플롭스(GFLOPS, GPU FLoating point Operations Per Second)는 컴퓨터의 성능을 수치로 나타낼 때 주로 사용되는 단위

## 1.3 컨테이너를 격리하는 기술

**리눅스 네임스페이스**

각 프로세스가 파일 시스템 마운트, 네트워크, 유저, 호스트 네임 등에 대해 시스템에 독립 뷰를 제공

![[Pasted image 20250720222225.png]]

**리눅스 컨트롤 그룹**

프로세스로 소비할 수 있는 리소스 양(CPU, 메모리, I/O, 네트워크 대역대, device 노드 등)을 제한
![[Pasted image 20250720222243.png]]
## 1.4 도커의 한계

서비스가 커지면 커질수록 관리해야 하는 컨테이너의 양이 급격히 증가

도커를 사용하여 관리를 한다 하더라도 쉽지 않은 형태

배포 및 컨테이너 배치 전략

스케일-인, 스케일-아웃이 어려움
![[Pasted image 20250720222300.png]]
# 2. 도커 사용 기초

## 도커 레지스트리

도커 레지스트리에는 사용자가 사용할 수 있도록 데이터베이스를 통해 이미지를 제공해주고 있음 누구나 이미지를 만들어 푸시할 수 있으며 푸시된 이미지는 다른 사람들에게 공유 가능
![[Pasted image 20250720222331.png]]
[https://github.com/dotnet-architecture/eShopModernizing/wiki/03.-Publishing-your-Windows-Container-images-into-a-Docker-Registry](https://github.com/dotnet-architecture/eShopModernizing/wiki/03.-Publishing-your-Windows-Container-images-into-a-Docker-Registry)

도커 퍼블릭 레지스트리 검색 및 확인

## 도커 퍼블릭 레지스트리 검색 및 확인

[https://hub.docker.com/](https://hub.docker.com/)
![[Pasted image 20250720222430.png]]
## 도커 명령어로 검색

```bash
docker search tomcat
```

## 도커 이미지 다운로드하기

```bash
docker pull tomcat
```

## 로컬 시스템에 있는 도커 이미지 확인하기

```bash
docker images
```

# 3. 도커 라이프 사이클 명령어 실습
![[Pasted image 20250720222510.png]]
## 도커 이미지 다운로드와 삭제

```bash
sudo docker pull consol/tomcat-7.0
sudo docker rmi consol/tomcat-7.0
```

## 톰캣 컨테이너 생성

```bash
docker run -d --name tc tomcat # 톰캣 생성 및 실행
```

## 실행중인 컨테이너 확인

```bash
docker ps # 톰캣 컨테이너 확인
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
f6e513b399a6        tomcat              "catalina.sh run"   27 seconds ago      Up 26 seconds       8080/tcp            tc
```

## 모든 컨테이너 확인

```bash
docker ps -a # 모든 컨테이너 확인
```

## 컨테이너 중지

```bash
docker stop f6e513b399a6 # 컨테이너 실행 중지
f6e513b399a6

```

## 컨테이너 삭제

```bash
docker rm f6e513b399a6 # 컨테이너 삭제
f6e513b399a6

```

# 4. 이미지 비밀: 레이어

## 레이어의 개념
![[Pasted image 20250720222710.png]]
## 도커 이미지 정보 확인

```bash
docker pull nginx
sudo docker inspect nginx
```

## 도커 이미지 저장소 위치 확인

```bash
 docker info
sudo -i
cd /var/lib/docker/overlay2

```

## 레이어 저장소 확인

```bash
root@server1-VirtualBox:/var/lib/docker/overlay2# ls
0cc29ea5605872d9c8291673064e85b07160203fbf04b34eeeed899731361960 # 레이어 변경 사항 저장
615767e7221dbc99b8e441e35a88df5d74c911f2674ceaa28001388535e95be2 # 레이어 변경 사항 저장
9f3bb671f38d7f61f661af369d420cdedb195e4d623bdb6ba8e3b045f72e8d69 # 레이어 변경 사항 저장
l # 원본 레이어 저장
```

## 도커 용량 확인하기

```bash
du -sh /var/lib/docker/ #도커가 설치된 환경 용량 확인
```

# 5. 도커 유용한 명령어

## 포트포워딩으로 톰캣 실행하기

```bash
docker run -d --name getstart -p 8080:80 docker/getting-started
```

## 컨테이너 내부 셸 실행

```bash
docker exec -it tc /bin/bash
```

## 컨테이너 로그 확인

```bash
docker logs tc # stdout, stderr
```

## 호스트 및 컨테이너 간 파일 복사

```bash
docker cp <path> <to container>:<path>
docker cp <from container>:<path> <path>
docker cp <from container>:<path> <to container>:<path>
```
![[Pasted image 20250720222730.png]]
![[Pasted image 20250720222754.png]]
## 도커 컨테이너 모두 삭제

```bash
docker stop `sudo docker ps -a -q`
docker rm `sudo docker ps -a -q`
```

## 임시 컨테이너 생성

```bash
docker run -d -p 80:8080 --rm --name tc tomcat 
```

# 도커 컨테이너 실행 연습문제

다음 이미지를 사용 : jenkins/jenkins:lts-jdk11

1. 기존에 설치된 모든 컨테이너와 이미지 정지 및 삭제

```bash
docker stop `docker ps -a -q`
docker rm `docker ps -a -q`
docker rmi `docker images -q`
```

1. 도커 기능을 사용해 Jenkins 검색

```bash
docker search jenkins
```

[Jenkins - Official Image | Docker Hub](https://hub.docker.com/_/jenkins)

1. Jenkins를 사용하여 설치 Jenkins 포트로 접속하여 웹 서비스 열기

```bash
docker pull jenkins
docker run -d -p 8080:8080 --name jk jenkins/jenkins:lts
```

1. Jenkins의 초기 패스워드 찾아서 로그인하기

```bash

docker exec -it jk sh
cat /var/jenkins_home/secrets/initialAdminPassword
4db62f75450046dd997cdfa1cf528839
```

![[Pasted image 20250720222936.png]]
![[Pasted image 20250720222947.png]]
# 6. 도커에서 쿠버로 넘어간 이유
![[Pasted image 20250720222959.png]]
![[Pasted image 20250720223016.png]]
## 컨테이너 오케스트레이션(쿠버네티스)

- 쿠버네티스의 역할은 도커와 같은 컨테이너 런타임을 통해 컨테이너를 다루는 일
- 여러 컨테이너를 자동으로 배포, 관리, 확장 및 네트워킹하는 기술을 의미합니다. 이 과정은 특히 대규모 애플리케이션에서 수많은 컨테이너가 상호작용하고, 고가용성, 자동 복구 및 확장이 필요한 환경에서 중요한 역할

## 쿠버네티스의 역할

- **자동화된 복구(self-healing)**컨테이너를 모니터링 하면서 컨테이너가 죽는 즉시 쿠버네티스는 그것을 빠르게 재시작시킨다.
- **로드 밸런싱(Load balancing)**서비스 웹사이트의 니즈에 따라 컨테이너의 숫자를 자동으로 조절한다. 접속하는 유저가 많을수록 쿠버네티스는 구동하는 컨테이너의 숫자를 늘리고, 유저가 적어지면 컨테이너의 숫자를 줄인다.
- **무중단(Fault tolerance-FT) 서비스**점진적 업데이트를 통해 서비스를 중단하지 않고도 서비스 업데이트를 가능하게 한다.
- **호환성(Vendor Lock In 해결)**서로 다른 클라우드 사이의 호환 문제를 해결하여 사용자들이 특정 업체에 종속되는 일 없이 환경을 이전할 수 있도록 해준다.