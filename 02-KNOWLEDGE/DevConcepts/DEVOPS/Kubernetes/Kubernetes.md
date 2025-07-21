# 컨테이너 오케스트레이션(쿠버네티스)
## 쿠버네티스의 역할은 도커와 같은 컨테이너 런타임을 통해 컨테이너를 다루는 일이다.
 ###  **자동화된 복구(self-healing)**
 - 컨테이너를 모니터링 하면서 컨테이너가 죽는 즉시 쿠버네티스는 그것을 빠르게 재시작시킨다.
 ###  **로드 밸런싱(Load balancing)**
 - 서비스 웹사이트의 니즈에 따라 컨테이너의 숫자를 자동으로 조절한다. 접속하는 유저가 많을수록 쿠버네티스는 구동하는 컨테이너의 숫자를 늘리고, 유저가 적어지면 컨테이너의 숫자를 줄인다.
 ### **무중단(Fault tolerance-FT) 서비스**
 - 점진적 업데이트를 통해 서비스를 중단하지 않고도 서비스 업데이트를 가능하게 한다.
 ### **호환성(Vendor Lock In 해결)**
 - 서로 다른 클라우드 사이의 호환 문제를 해결하여 사용자들이 특정 업체에 종속되는 일 없이 환경을 이전할 수 있도록 해준다.

# vmware로 우분투 쿠버 환경 구성해보기
[vmware 다운로드](https://www.vmware.com/kr/products/workstation-player/workstation-player-evaluation.html)

- 우분투 및 centos 다운로드
- 실습 환경은 ubuntu20.04 에서 실습 진행

[https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=cestlavie_01&logNo=40208819768](https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=cestlavie_01&logNo=40208819768)

[https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=cestlavie_01&logNo=40208819768](https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=cestlavie_01&logNo=40208819768)

[https://velog.io/@dashh/Ubuntu-install-netstat-ifconfig](https://velog.io/@dashh/Ubuntu-install-netstat-ifconfig)

1. nat 설정에서 네트워크 접속 할수 있게 ip를 게이트웨이에 할당된 네트워크 범위로 맞춰줌

```bash
sudo vi /etc/netplan/00 ~
netplan apply

```

1. ssh 접속 ⇒ moxaterm으로 접속

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c7dc62f4-2e74-4c6d-91a8-68e50e9ac605/Untitled.png)

1. apt 업데이트 및 도커 설치 네트워크 툴 설치

```bash
apt update && apt install docker.io -y && apt install net-tools
```

1. 쿠버 설치를 위한 명령어(**kubeadm)**

[https://kubernetes.io/ko/docs/setup/production-environment/tools/kubeadm/install-kubeadm/](https://kubernetes.io/ko/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)

```bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg <https://packages.cloud.google.com/apt/doc/apt-key.gpg>
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] <https://apt.kubernetes.io/> kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

1. 우분투 swal 비활성화

[https://askubuntu.com/questions/214805/how-do-i-disable-swap](https://askubuntu.com/questions/214805/how-do-i-disable-swap)

```bash

sudo sed -i '/ swap / s/^/#/' /etc/fstab
sudo swapoff -a
```

1. 도커 cgroup 네임 변경

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e7ae90de-f0a3-4e28-a558-123cfc3581e6/Untitled.png)

[docker change cgroup driver to systemd](https://stackoverflow.com/questions/43794169/docker-change-cgroup-driver-to-systemd)

```bash
docker info | grep -i group

vi /etc/docker/daemon.json
```

{ "exec-opts": ["native.cgroupdriver=systemd"] }

```
sudo systemctl restart docker
docker info | grep -i group
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3ac12e58-1b19-48d9-a543-931d16cdc27b/Untitled.png)

이미지 하나를 이렇게 만들어 두고 복제해서 나머지 노드를 구성할 예정

```bash
shutdown -h now
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/96c52d20-10b0-4466-8a2d-e5ea1cc7d9a5/Untitled.png)

어떻게 될지 모르니 스냅샷도 하나 떠두자

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/be3afdb2-ec03-41c5-ac02-2938a9f13ee3/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f349e089-9381-4cc7-b407-9d2e3df0be72/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/91fc5618-2910-4f4b-9cf2-1d2b7ae22b0b/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/986f81d6-9496-428b-9719-0b4191bb48dc/Untitled.png)

나머지 이미지도 사용할 수 있게 ip 설정을 바꾸고

로컬에서 접속 할 수 있는지 확인

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b10e25d7-ff0b-4c10-a917-aaa971e401f0/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1dae3932-6c6a-4894-8cd1-657d58e55dbb/Untitled.png)

호스트 네임을 다르게 변경해주자

```bash
hostnamectl set-hostname mater0

vi /etc/hosts
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/003b73bb-ef02-4239-b818-f584959f86e7/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a96f5c31-0588-4847-8af7-093d27aa1e4a/Untitled.png)

각 노드에서 다른 노드로 통신이 되는지 ping으로 테스트를 해보자

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/593e95bd-3ad8-431b-a3e4-3bd2bb29eff1/Untitled.png)

## 클러스터 구성 및 쿠버 테스트

```bash
# 마스터 노드에서
kubeadm init
```

위 과정에서 swap 오류가 난다면

```bash
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  <https://kubernetes.io/docs/concepts/cluster-administration/addons/>

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.174.154:6443 --token l0fcj5.udlrbss7c61z2841 \\
        --discovery-token-ca-cert-hash sha256:63a167e969602cac7a1009cffe3bb1507a764984aec91f55fa869872a5acc69d
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5703cb18-3101-4761-b289-75e3af318e5a/Untitled.png)

```bash
mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

kubectl get nodes

kubeadm reset ⇒ 리셋이 필요한 경우 위에 .kube도 삭제 후 에 진행 해야함

worker node에서 join 명령어 실행

```bash
kubeadm join 192.168.174.154:6443 --token l0fcj5.udlrbss7c61z2841 \\
        --discovery-token-ca-cert-hash sha256:63a167e969602cac7a1009cffe3bb1507a764984aec91f55fa869872a5acc69d
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/a24b058c-845f-468c-bc6a-2fa36b3a6428/Untitled.png)

노드가 추가된 것을 볼수 있음

하지만 status가 notReady인 것을 볼수 있다

포드 네트워크를 구성하지 않았기 때문

[https://kubernetes.io/docs/concepts/cluster-administration/addons/](https://kubernetes.io/docs/concepts/cluster-administration/addons/)

• [Weave Net](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/) 은 네트워킹 및 네트워크 정책을 제공하고 네트워크 파티션의 양쪽에서 계속 작동하며 외부 데이터베이스가 필요하지 않습니다.

[https://www.weave.works/docs/net/latest/kubernetes/kube-addon/](https://www.weave.works/docs/net/latest/kubernetes/kube-addon/)

```bash
kubectl apply -f "<https://cloud.weave.works/k8s/net?k8s-version=$>(kubectl version | base64 | tr -d '\\n')"
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1d297364-8a21-4faa-945f-41bf0e7080a3/Untitled.png)

좀 기다리면 ready로 다 변경 된것을 확인 할 수 있음

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/1cf65dfc-fbe0-4857-a3c4-963d0ab42765/Untitled.png)

```bash
kubectl create deploy nx --image=nginx
kubectl get pod -w
kubectl expose deploy nx --type=NodePort --port=80 --target-port=80
kubectl get svc
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/03822f34-39f3-4327-ab0f-2141c9ca48cf/Untitled.png)

CLUSTER-IP ⇒ 클러스터 내부에서만 사용 가능한 포드 네트워크 아이피

```bash
curl 127.0.0.1:31494
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/232d5492-68ce-4906-9217-222982e4ea04/Untitled.png)

```bash
k scale deploy nx --replicas=5
# 파드를 증가를 시키면 
k get pod
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/00212654-3d78-4c63-a35e-dccfbcf73de2/Untitled.png)

1. init 이나 join을 잘못한 경우

```bash
kubeadm reset ⇒ 리셋이 필요한 경우 위에 .kube도 삭제 후 에 진행 해야함
```

1. kubeadm token 재발급 받는 방법

```bash
kubeadm token create --print-join-command
kubeadm join 192.168.174.154:6443 --token ejr887.oq6iz6cnoyms12lk --discovery-token-ca-cert-hash sha256:63a167e969602cac7a1009cffe3bb1507a764984aec91f55fa869872a5acc69d
```

# 쿠버네티스에서 실행할 Go 언어 컨테이너 작성

main.go

```bash
package main

import (
    "fmt"
    "github.com/julienschmidt/httprouter"
    "net/http"
    "log"
    "os"
)

func Index(w http.ResponseWriter, r *http.Request, _ httprouter.Params) {
    hostname, err := os.Hostname()
    if err == nil {
        fmt.Fprint(w, "Welcome! " + hostname +"\\n")
    } else {
        fmt.Fprint(w, "Welcome! ERROR\\n")
    }
}

func main() {
    router := httprouter.New()
    router.GET("/", Index)

    log.Fatal(http.ListenAndServe(":8080", router))
}
```

설치 및 앱 작성 후 실행

```bash
apt install golang
go get github.com/julienschmidt/httprouter
go build main.go
main
curl 127.0.0.1:8080
```

도커 파일 작성

```bash
FROM golang:1.11
WORKDIR /usr/src/app
COPY main  /usr/src/app
CMD ["/usr/src/app/main"]
```

도커 빌드 및 푸시

```bash
docker build -t smshack/http-go .
docker login
docker push smshack/http-go
docker run -d -p 8080:8080 --rm http-go
 curl 127.0.0.1:8080
```

모든 자원 삭제

```yaml
kubectl delete all --all
```

hub.docker.com에서 젠킨스에 대한 정보 확인

[https://hub.docker.com/r/jenkins/jenkins](https://hub.docker.com/r/jenkins/jenkins)

젠키스 띄워보기

```bash
kubectl create deploy jk --image=jenkins/jenkins:lts-jdk11
kubectl expose deploy jk --type=LoadBalancer --port=80 --target-port=8080

k get svc
k get pod
k logs 파드아이디

```

[http://192.168.174.154:32219/login?from=%2F](http://192.168.174.154:32219/login?from=%2F)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/617c1a99-ed9c-480c-aa91-cf95d1103be8/Untitled.png)

```jsx
mongod.service - MongoDB 데이터베이스 서버 로드됨: 로드됨(/usr/lib/systemd/system/mongod.service; 활성화됨, 공급업체 사전 설정: 비활성화됨) 활성: 실패(결과: 종료 코드) 이후 월요일 2022-02-28 11:47:38 KST; 10초 전 문서: <https://docs.mongodb.org/manual> 프로세스: 61464 ExecStart=/usr/bin/mongod $OPTIONS(코드=종료, 상태=51) 프로세스: 61461 ExecStartPre=/usr/bin/chmod 0755 /var/run/mongodb(코드=종료, 상태=0/성공) 프로세스: 61458 ExecStartPre=/usr/bin/chown mongod:mongod /var/run/mongodb(코드=종료, 상태=0/성공) 프로세스: 61454 ExecStartPre=/usr/bin/mkdir -p /var/run/mongodb(코드=종료, 상태=0/성공)
2월 28일 11:47:38 obenef-high-mongo systemd[1]: MongoDB 데이터베이스 서버 시작 중...
Feb 28 11:47:38 obenef-high-mongo mongod[61464]: 서버가 연결 준비가 될 때까지 대기 중인 자식 프로세스를 포크하려고 합니다.
2월 28일 11:47:38 obenef-high-mongo mongod[61464]: 분기된 프로세스: 61466
2월 28일 11:47:38 obenef-high-mongo mongod[61464]: 오류: 자식 프로세스가 실패했습니다. 오류 번호 51과 함께 종료되었습니다.
Feb 28 11:47:38 obenef-high-mongo mongod[61464]: 이 출력에서 추가 정보를 보려면 "--fork" 옵션 없이 시작하십시오.
2월 28일 11:47:38 obenef-high-mongo systemd[1]: mongod.service: 제어 프로세스 종료, 코드=종료 상태=51
2월 28일 11:47:38 obenef-high-mongo systemd[1]: MongoDB 데이터베이스 서버를 시작하지 못했습니다.
2월 28일 11:47:38 obenef-high-mongo systemd[1]: mongod.service 장치가 실패 상태에 들어갔습니다.
2월 28일 11:47:38 obenef-high-mongo systemd[1]: mongod.service가 실패했습니다.
```