## 개념
- ClusterIP 기반 서비스 트래픽을 전달하는 네트워크 컴포넌트
### 기능
- iptables 또는 ipvs 모드로 동작
    
- Service → Pod 라우팅 담당
    
- 각 Node에서 DaemonSet 형태로 실행됨
### 설치
```bash
wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-proxy
```