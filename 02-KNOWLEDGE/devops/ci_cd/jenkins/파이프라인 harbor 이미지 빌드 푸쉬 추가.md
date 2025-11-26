# 1. Jenkins Credential 추가
- Harbor 로그인용 계정 생성 후 Jenkins Credentials에 추가
![[Pasted image 20251127010539.png]]

# 2. jenkins 컨테이너에서 docker cli 설치
```bash
docker exec -it jenkins bash

# apt 업데이트
apt-get update

# Docker CLI 설치
apt-get install -y docker.io

# 설치 확인
docker --version
```

![[Pasted image 20251127010805.png]]

# 3. 파이프라인 동작 확인

```groovy
        stage("Docker Build & Push") {

            steps {

                script {

                    def gitKey     = "${info.group}.${info.subGroup}.${info.project}"

                    def projectKey = loadProjectKey(gitKey)

  

                    // Docker 이미지 이름 및 태그

                    def imageName = "harbor.smartseoapp.com/practice_team/${info.project}"

                    def imageTag  = "${info.branch}-${env.BUILD_NUMBER}"

  

                    echo "▶️ Docker Build Start: ${imageName}:${imageTag}"

  

                    // Docker 빌드

                    sh """

                        docker build -t ${imageName}:${imageTag} .

                    """

  

                    // Harbor 로그인

                    withCredentials([usernamePassword(credentialsId: 'Harbor-Account', usernameVariable: 'HARBOR_USER', passwordVariable: 'HARBOR_PASS')]) {

                        sh """

                            echo $HARBOR_PASS | docker login harbor.smartseoapp.com -u $HARBOR_USER --password-stdin

                        """

                    }

  

                    // 이미지 푸시

                    sh """

                        docker push ${imageName}:${imageTag}

                    """

  

                    echo "✅ Docker Image Pushed: ${imageName}:${imageTag}"

                }

            }

        }
```


![[Pasted image 20251127010633.png]]
![[Pasted image 20251127010642.png]]