> Ubuntu 서버/VM 환경에서 자주 사용하는 필수 CLI 명령어 요약본입니다.

## 1. System 관리

### 시스템 정보

```bash
uname -a          # 커널 및 OS 정보
hostnamectl       # 호스트명 정보
lscpu              # CPU 정보
timedatectl status # 시간/타임존
```

### 시스템 모니터링

```bash
top        # 실시간 프로세스
htop       # 인터랙티브 모니터링 (설치 필요)
df -h      # 디스크 사용량
free -m    # 메모리 사용량
kill PID   # 프로세스 종료
```

### 서비스 관리 (systemd)

```bash
sudo systemctl start <service>
sudo systemctl stop <service>
sudo systemctl status <service>
sudo systemctl reload <service>
journalctl -f
journalctl -u <service>
```

---

## 2. 파일 & 디렉토리

### 파일 관리

```bash
ls
touch file
cp src dst
mv src dst
rm file
```

### 디렉토리 이동

```bash
pwd
cd dir
mkdir dir
```

### 권한 & 소유자

```bash
chmod u+x file
chmod 755 file
chown user:group file
```

### 검색

```bash
find /path -name "*.log"
grep "text" file
```

### 압축

```bash
tar -czvf file.tar.gz files
tar -xvf file.tar.gz
```

---

## 3. 텍스트 처리

```bash
nano file
cat file
less file
head file
tail file
awk '{print}' file
```

---

## 4. 패키지 관리

### APT

```bash
sudo apt update
sudo apt upgrade
sudo apt install pkg
sudo apt remove pkg
sudo apt purge pkg
apt search pkg
```

### SNAP

```bash
snap find pkg
sudo snap install pkg
sudo snap remove pkg
snap list
```

---

## 5. 사용자 & 그룹

### 사용자

```bash
w
sudo adduser user
sudo deluser user
sudo passwd user
su user
```

### 그룹

```bash
id user
groups user
sudo addgroup group
sudo delgroup group
```

---

## 6. 네트워크

```bash
ip addr show
ip -s link
ss -l
ping host
```

### Netplan

```bash
cat /etc/netplan/*.yaml
sudo netplan try
sudo netplan apply
```

### 방화벽 (UFW)

```bash
sudo ufw status
sudo ufw enable
sudo ufw allow 22
sudo ufw deny 80
```

### SSH

```bash
ssh user@host
scp src user@host:/path
```

---

## 7. LXD (컨테이너 / VM)

### 초기화

```bash
lxd init
```

### 생성

```bash
lxc launch ubuntu:24.04 my-container
lxc launch ubuntu:24.04 my-vm --vm
```

### 관리

```bash
lxc list
lxc start name
lxc stop name
lxc delete name
```

### 접속

```bash
lxc exec name -- bash
lxc console name
lxc file pull name:/path local
lxc file push local name:/path
```

---

## 8. Ubuntu Pro

### 활성화

```bash
sudo pro attach <token>
sudo pro status
```

### 보안 서비스

```bash
sudo pro enable esm-infra
sudo pro enable esm-apps
sudo pro enable livepatch
sudo pro enable fips
```

### 해제

```bash
sudo pro detach
```

---

## 참고

- [https://ubuntu.com/pro](https://ubuntu.com/pro)
    
- [https://canonical.com/lxd](https://canonical.com/lxd)
    
