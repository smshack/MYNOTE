https://www.cncf.io/training/certification/cka/

[CKA 공식 정보](https://www.cncf.io/training/certification/cka/)
[시험 커리큘럼(주제)](https://github.com/cncf/curriculum)
[후보자 핸드북](https://docs.linuxfoundation.org/tc-docs/certification/lf-handbook2)
[시험팁](https://docs.linuxfoundation.org/tc-docs/certification/tips-cka-and-ckad)

## 시험 세부 정보
- 온라인 진행 리눅스 명령줄에서 풀어야 하는 성과 기반 과주로 구성
- 시험은 15~20문제
- 시험 시간은 2시간
- 시험은 스트리밍 오디오, 비디오, 화면 공유 피드를 통해 원격으로 감독
- 시험 완료 후 24시간 이내에 결과가 이메일로 전송


## 강의 자료
- https://github.com/kodekloudhub/certified-kubernetes-administrator-course
---

## 핵심 개념

- 본 문서는 Kubernetes CKA 학습 자료의 “Core Concepts / Cluster Architecture / ETCD / Control Plane 구성 요소”를 한국어로 이해하기 쉽게 정리한 문서입니다.
---
---

# 📌 1. Kubernetes 아키텍처 개요

쿠버네티스는 **Master(Node)** 와 **Worker Nodes** 로 구성된다.

### 🔹 **Master (Control Plane)**

클러스터 전체를 관리하며 아래 기능을 수행한다.

- 노드 관리
    
- 스케줄링
    
- 모니터링
    
- API 제공
    
- 상태 유지(Controller)
    
---
### 🔹 **Worker Nodes**

실제 애플리케이션(Pod)이 배포·실행되는 공간.

- kubelet
    
- kube-proxy
    
- Container Runtime (containerd, Docker 등)
    
---

# 📌 2. 주요 컴포넌트

## 🟦 2.1 ETCD

쿠버네티스의 모든 상태를 저장하는 **분산 Key-Value Store**.

### 저장하는 데이터 종류

- Nodes 정보
    
- PODs 정보
    
- ConfigMaps
    
- Secrets
    
- ServiceAccounts
    
- Roles/Bindings
    
- Replicasets, Deployments 등 리소스 전체
    
---
### ETCD 특징

- 분산 시스템 기반
    
- RAFT 합의 알고리즘 사용
    
- 빠르고 신뢰성 높은 저장소
    

### CLI 예시

```bash
etcdctl set key1 value1
etcdctl get key1
```
---
### kubeadm 설치 시 etcd 확인

```bash
kubectl get pods -n kube-system | grep etcd
kubectl exec etcd-master -n kube-system -- etcdctl get / --prefix --keys-only
```

---

# 📌 3. API Server (kube-apiserver)

쿠버네티스의 **중앙 API 엔드포인트**.

### 주요 기능

1. 클라이언트 인증(Authentication)
    
2. 요청 검증(Validation)
    
3. 권한 처리(RBAC)
    
4. ETCD 읽기/쓰기
    
5. 스케줄러 트리거
    
6. kubelet에 작업 전달
    
---
### 단일 요청 처리 흐름

1. 인증 → 2. 권한 체크 → 3. 요청 파싱 →
    
2. ETCD 업데이트 → 5. Scheduler 호출 → 6. kubelet 수행
    

### kubeadm 구성 확인

```bash
cat /etc/kubernetes/manifests/kube-apiserver.yaml
```

---

# 📌 4. Controller Manager (kube-controller-manager)

쿠버네티스 리소스의 **상태를 자동으로 원하는 상태(Desired State)** 로 유지하는 역할.
---
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
    

---

# 📌 5. Scheduler (kube-scheduler)

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
    

---

# 📌 6. Kubelet

### 역할

- Node 를 Kubernetes 클러스터에 등록
    
- Pod 생성/수정/삭제 관리
    
- 컨테이너 상태 모니터링
    
- kube-apiserver 와 통신하여 명령 수행
    

### kubeadm 환경에서

kubelet은 데몬으로 Node 별로 실행된다.

---

# 📌 7. Kube-Proxy

ClusterIP 기반 서비스 트래픽을 전달하는 네트워크 컴포넌트

- iptables 또는 ipvs 모드로 동작
    
- Service → Pod 라우팅 담당
    
- 각 Node에서 DaemonSet 형태로 실행됨
    

### kubeadm 확인

```bash
kubectl get daemonset -n kube-system | grep kube-proxy
```

---

# 📌 8. 전체 Control Plane 요약

|구성 요소|역할|
|---|---|
|**API Server**|클러스터 모든 통신의 중심 API|
|**etcd**|클러스터 상태 저장|
|**Controller Manager**|리소스 상태 유지|
|**Scheduler**|Pod 배치 결정|
|**Kubelet**|컨테이너 실행/노드 관리|
|**Kube-proxy**|서비스 네트워크 구성|

---

# 📌 9. kubectl로 주요 컴포넌트 확인

### 컨트롤 플레인 확인

```bash
kubectl get pods -n kube-system
```

### kube-apiserver 프로세스 확인

```bash
ps -aux | grep kube-apiserver
```

### kube-controller-manager 확인

```bash
ps -aux | grep kube-controller-manager
```

### kube-scheduler 확인

```bash
ps -aux | grep kube-scheduler
```

---

