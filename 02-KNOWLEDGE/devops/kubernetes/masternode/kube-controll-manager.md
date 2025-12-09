## 개념
- 쿠버네티스의 리소스의 상태를 자동으로 원하는 상태로 유지하는 역할

### 주요 컨트롤러

- Node Controller
    
- Replication Controller
    
- Deployment Controller
    
- Namespace Controller
    
- Job Controller
    
- PV/PVC Controller
    
- ServiceAccount Controller
    
- CronJob Controller
    
- StatefulSet Controller
    
- Endpoint Controller
    
---
### NodeController 시간 파라미터

- Node Monitor Period: **5s**
    
- Node Monitor Grace Period: **40s**
    
- Pod Eviction Timeout: **5m**

## 설치
```bash
wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-controller-manager
```

## kubeadm 에서 kube-controller
- /etc/kubernetes/manifests/kube-controller-manager.yaml
```bash
kubectl get pods -n kube-system
```