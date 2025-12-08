## 개념
- 쿠버네티스의 모든 상태를 저장하는 분산 **Key-Value Store**

## 설치
```bash
# 1. 다운로드
curl -L https://github.com/etcd-io/etcd/releases/download/v3.3.11/etcdv3.3.11-linux-amd64.tar.gz -o etcd-v3.3.11-linux-amd64.tar.gz

# 2. 설치
tar -xzvf etcd-v3.3.11-linux-amd64.tar.gz

# 3. 설치 실행
./etcd
```

## 동작
- 실행시 기본적으로 2379 포트 사용
```bash
./etcdctl set key1 value1
./etcdctl get key1
./etcdctl
```
---
## kubenetes에서 역할
### 저장하는 데이터 종류
- nodes 정보
- pods 정보
- configMaps
- Secrets
- ServiceAccounts
- Roles/Bindings
- Replicasets, Deployments 등 리소스 전체

---
### kube etcd 설치 메뉴얼
- 광고된 client url: etcd가 수신하는 주소(서버의 ip, etcd가 수신하는 기본포트)
- etcd 서버에 접속하려고 할 때 kube API 서버에서 구성해야 하는 URL
- 
```bash
# 마스터 노드에서 직접 cted 서비스로 구성 배포
wget -q --https-only \ "https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz"

# 배포
ExecStart=/usr/local/bin/etcd \\ --name ${ETCD_NAME} \\ --cert-file=/etc/etcd/kubernetes.pem \\ --key-file=/etc/etcd/kubernetes-key.pem \\ --peer-cert-file=/etc/etcd/kubernetes.pem \\ --peer-key-file=/etc/etcd/kubernetes-key.pem \\ --trusted-ca-file=/etc/etcd/ca.pem \\ --peer-trusted-ca-file=/etc/etcd/ca.pem \\ --peer-client-cert-auth \\ --client-cert-auth \\ --initial-advertise-peer-urls https://${INTERNAL_IP}:2380 \\ --listen-peer-urls https://${INTERNAL_IP}:2380 \\ --listen-client-urls https://${INTERNAL_IP}:2379,https://127.0.0.1:2379 \\ --advertise-client-urls https://${INTERNAL_IP}:2379 \\ --initial-cluster-token etcd-cluster-0 \\ --initial-cluster controller-0=https://${CONTROLLER0_IP}:2380,controller-1=https://${CONTROLLER1_IP}:2380 \\ --initial-cluster-state new \\ --data-dir=/var/lib/etcd
```

### kube adm 사용 클러스터 설정
- kube adm은 etcd 서버를 kube 시스템 네임스페이스에 파드로 배포
- 해당 파트의 etcd 제어 유틸리티를 사용하여 etcd 데이터베이스를 탐색 가능
```bash
kubectl get pods -n kube-system
```

![[Pasted image 20251209004349.png]]
```bash
# 쿠버네티스가 저장한 모든 키를 나열
kubectl exec etcd-master –n kube-system etcdctl get / --prefix –keys-only
```

![[Pasted image 20251209004428.png]]