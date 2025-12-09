## 개념
- 쿠버네티스의 중앙 API 엔드포인트
- 쿠버 제어 명령 실행시 api서버에서 해당 명령어 전달받음
- 요청을 인증하고 유효성을 검사
- etcd 클러스터에서 데이터를 검색하고 요청된 정보로 다시 응답
- 

## 주요 기능
1. 클라이언트 인증
2. 요청 검증
3. 권한 처리
4. ETCD 읽기/쓰기
5. 스케줄러 트리거
6. kubelet에 작업 전달


### 설치
```bash
wget https://storage.googleapis.com/kubernetes-release/release/v1.13.0/bin/linux/amd64/kube-apiserver

```

### kubeadm 에서 apiserver 확인
- /etc/kubernetes/manifests/kube-apiserver.yaml 파일 정의
- /etc/systemd/system/kube-apiserver.service
```bash
# 마스터 노드의 kube-system 네임스페이스 확인
kubectl get pods -n kube-system

# 옵션 확인
ps -aux | grep kube-apiserver

```