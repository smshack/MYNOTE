# 쿠버네티스 환경 구성
## 1️⃣ VirtualBox 설치  
## 2️⃣ **리눅스 ISO 이미지 다운로드**  
- 👉 **Ubuntu Server 22.04 LTS (AMD64)**
- 🔗 [https://ubuntu.com/download/server](https://ubuntu.com/download/server)

## 3️⃣ VM 생성 (마스터 / 워커)  
![[Pasted image 20260103203513.png]]
## 4️⃣ OS 설치 & 기본 세팅  
```
[Host PC (Windows/Mac)]
 └─ VirtualBox
     ├─ master-node (Ubuntu)
     ├─ worker-node-1 (Ubuntu)
     └─ worker-node-2 (Ubuntu)
```

- 메모리 8G
- cpu 4 core
- 스토리지 각 100G 로 vm 세팅
- 네트워크 어댑터 브릿지, 네트워크, 호스트 온리로 추가
![[Pasted image 20260105025857.png]]

### 호스트 초기 세팅
#### hostname 설정 (CKA에서 자주 나옴)
```
# master
hostnamectl set-hostname master

# worker1
hostnamectl set-hostname worker1

# worker2
hostnamectl set-hostname worker2
```

#### /etc/hosts 설정 (시험에서 중요) -> 모든 노드에 동일하게 추가
- 이거 안 하면 kubeadm 통신에서 문제 자주 남
```
192.168.219.104 master
192.168.219.105 worker1
192.168.219.106 worker2
```

#### Swap 끄기 (CKA 단골)
- kubelet은 swap 활성화 시 실행 거부
- 이유: 리소스 스케줄링 정확성
```
swapoff -a
sed -i '/ swap / s/^/#/' /etc/fstab
```

#### 커널 네트워크 설정
- - **Pod 네트워크 = Linux bridge**
- - iptables가 브리지 트래픽을 봐야 함
```
cat <<EOF | tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

modprobe br_netfilter

cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF
```

### Container Runtime 설치 (containerd)
- kubelet ↔ container runtime 통신
- **systemd cgroup = kubelet 권장 방식**
#### containerd 설치
```
apt update
apt install -y containerd
```

#### containerd 설정 (중요 ⭐)
```
mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml
```

#### systemd cgroup 사용하도록 변경
```
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' \
/etc/containerd/config.toml
systemctl restart containerd
systemctl enable containerd
```

## 5️⃣ 쿠버네티스 설치 
|컴포넌트|역할|
|---|---|
|kubelet|노드 에이전트|
|kubeadm|클러스터 부트스트랩 도구|
|kubectl|API Server 클라이언트|
### Kubernetes repo 등록
```
apt install -y apt-transport-https ca-certificates curl

curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.29/deb/Release.key \
| gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] \
https://pkgs.k8s.io/core:/stable:/v1.29/deb/ /" \
> /etc/apt/sources.list.d/kubernetes.list

```

### kubeadm / kubelet / kubectl 설치
```
apt update
apt install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
```

## 6️⃣ 마스터 초기화  

### 마스터 노드 초기화
- `apiserver-advertise-address`
    
    - **다른 노드가 접근할 마스터 IP**
        
- `pod-network-cidr`
    
    - CNI(Pod 네트워크) 주소 대역
```
kubeadm reset -f
rm -rf /etc/kubernetes
rm -rf /var/lib/kubelet
rm -rf /etc/cni/net.d

rm -rf ~/.kube # 마스터노드
mkdir -p ~/.kube
cp /etc/kubernetes/admin.conf ~/.kube/config
chown $(id -u):$(id -g) ~/.kube/config

systemctl restart containerd
systemctl restart kubelet





kubeadm init \
  --apiserver-advertise-address=192.168.219.104 \
  --pod-network-cidr=192.168.0.0/16
```

### kubectl 설정
```
mkdir -p $HOME/.kube
cp /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

```
![[Pasted image 20260105034026.png]]

| CNI        | 이유                           |
| ---------- | ---------------------------- |
| **Calico** | CKA 표준 / NetworkPolicy 학습 가능 |
| Flannel    | 가장 단순 (학습엔 한계)               |
```
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.0/manifests/calico.yaml

```
## 7️⃣ 워커 노드 조인
```
kubeadm token create --print-join-command # 문제 있을시 마스터에서 토큰 다시



kubeadm join 192.168.219.104:6443 \
--token xxxx \
--discovery-token-ca-cert-hash sha256:xxxx
```

![[Pasted image 20260105034200.png]]

## 쿠버네티스 치트 시트
아래는 **쿠버네티스(Kubernetes)** 공식 **치트시트 및 유용한 명령어 정리**, **kubectl alias 예시**, 그리고 **공식 사이트 URL** 정리입니다 👇

---

## 🎯 Kubernetes 공식 사이트 (Cheat Sheet 포함)

### 📌 공식 문서 링크

- **kubectl 치트시트 (한국어)** — Kubernetes 공식: [kubectl 치트 시트 공식 문서 (한국어)](https://kubernetes.io/ko/docs/reference/kubectl/cheatsheet/?utm_source=chatgpt.com)
    
- **kubectl Quick Reference (English)** — 가장 자주 쓰는 명령 모음: [kubectl Quick Reference (영문)](https://kubernetes.io/docs/reference/kubectl/quick-reference/?utm_source=chatgpt.com)
    
- **kubectl CLI Reference (명령 전체)** — 모든 명령 & 서브커맨드: [kubectl 명령 레퍼런스 공식](https://kubernetes.io/docs/reference/kubectl/?utm_source=chatgpt.com)
    

📌 이 공식 문서들은 Kubernetes 및 `kubectl` CLI 사용에 대한 **가장 정확한 레퍼런스**입니다. ([Kubernetes](https://kubernetes.io/ko/docs/reference/kubectl/cheatsheet/?utm_source=chatgpt.com "kubectl 치트 시트"))

---

## 📋 기본 kubectl 치트시트 (핵심 명령)

### 🔧 클러스터 & 설정

```bash
kubectl version                        # 클라이언트 + 서버 버전 확인
kubectl cluster-info                  # 클러스터 정보
kubectl config view                   # kubeconfig 전체 보기
kubectl config get-contexts           # 컨텍스트 목록
kubectl config current-context        # 현재 컨텍스트
kubectl config use-context <ctx>      # 컨텍스트 변경
```

---

### 🧩 네임스페이스 관리

```bash
kubectl get ns                        # 네임스페이스 목록
kubectl create namespace <name>       # 네임스페이스 생성
kubectl delete namespace <name>       # 삭제
```

---

### 📦 리소스 조회 & 관리

```bash
kubectl get pods                      # Pod 리스트
kubectl get pods -A                   # 모든 네임스페이스 Pods
kubectl get svc                       # Service 리스트
kubectl get deploy                    # Deployment 리스트

kubectl describe pod <name>           # 상세 정보
kubectl logs <pod>                    # 로그 확인
```

---

### 📁 리소스 생성/적용/삭제

```bash
kubectl apply -f file.yaml            # YAML로 생성/업데이트
kubectl create deployment nginx --image=nginx
kubectl delete -f file.yaml
kubectl delete pod <name>
```

---

### 🔄 배포 관리

```bash
kubectl rollout status deploy/<name>
kubectl rollout undo deploy/<name>    # 롤백
kubectl scale deploy <name> --replicas=5
```

---

### 📡 포트 포워딩

```bash
kubectl port-forward svc/<name> 8080:80
```

---

📌 위의 명령들은 공식 **kubectl Cheat Sheet**를 기본으로 정리한 내용입니다. ([Kubernetes](https://kubernetes.io/ko/docs/reference/kubectl/cheatsheet/?utm_source=chatgpt.com "kubectl 치트 시트"))

---

## 🧠 자주 쓰는 Alias 예시

아래 alias를 `~/.bashrc` 또는 `~/.zshrc`에 추가하면 편리합니다:

```bash
# kubectl 단축
alias k=kubectl
alias kg='kubectl get'
alias kd='kubectl describe'
alias ka='kubectl apply'
alias kl='kubectl logs'

# 네임스페이스 작업
alias kgns='kubectl get namespaces'
alias kctx='kubectl config current-context'
alias kus='kubectl config use-context'

# 리소스 조회 넓게 보기
alias kgp='kubectl get pods -o wide'
alias kgs='kubectl get svc -o wide'
```

✔ 예:

```bash
k get pods -n dev
ka -f ./app.yaml
```

📌 또한 **자동완성(completion)** 설정도 함께 하면 더 빠르게 명령어를 입력할 수 있습니다:

```bash
source <(kubectl completion bash)   # bash 자동완성
complete -F __start_kubectl k        # alias(k) 자동완성
```

_이 설정 예시는 공식 문서에서도 소개됩니다._ ([Kubernetes](https://kubernetes.io/de/docs/reference/kubectl/cheatsheet/?utm_source=chatgpt.com "kubectl Spickzettel"))

![[Pasted image 20260105034852.png]]
---

## 📌 추가 공식 레퍼런스

- **kubectl 자동완성 설명** (공식 docs)  
    👉 자동완성 & alias 설명 포함: [kubectl Autocomplete & alias (영문)](https://kubernetes.io/de/docs/reference/kubectl/cheatsheet/?utm_source=chatgpt.com)
    
## Openlens  설치
https://github.com/MuhammedKalkan/OpenLens

```
winget install openlens
```

![[Pasted image 20260105035333.png]]