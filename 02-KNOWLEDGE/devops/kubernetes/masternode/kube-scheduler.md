## 개념
- 파드가 어디에 할당되어야 할지 결정

### 기능

- 실행해야 할 Pod을 어떤 Node에 배치할지 결정
    
- Node 후보 필터링(Filter)
    
- 점수 기반 Ranking 후 최적 노드 선택
    

### 고려 요소

- CPU/Memory 리소스
    
- Taints / Tolerations
    
- Node Affinity
    
- Pod Affinity
    
- 사용자 정의 스케줄러 가능

## 설치
- /etc/kubernetes/manifests/kube-scheduler.yaml
```bash
wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-scheduler
```