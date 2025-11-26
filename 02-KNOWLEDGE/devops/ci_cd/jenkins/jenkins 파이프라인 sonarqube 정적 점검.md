---
tags:
  - Jenkins
  - sonarqube
  - 정적점검
  - 파이프라인
---
# 1. Jenkins에 Sonarqube 플러그인 설치
> Jenkins 관리 → **플러그인 관리** → `SonarQube Scanner` 설치
- https://plugins.jenkins.io/sonar/
![[Pasted image 20251126201641.png]]

# 2. Sonarqube 서버 정보 등록
> Jenkins 관리 → **System 설정** → 아래 항목 등록

![[Pasted image 20251126202336.png]]

> Jenkins 관리 → **Global Tool Configuration**

![[Pasted image 20251126202640.png]]
# 💡 성공적으로 등록되면?

파이프라인에서 다음처럼 사용 가능:

`tools {     sonarScanner 'SonarScanner-CLI' }`

## 깃 푸쉬 시 젠킨스 파이프 라인 동작 해당 소나큐브 스캔
```groovy
@Library('jenkins-pipelines') _

  

pipeline {

    agent any

  

    environment {

        SONARQUBE_SERVER = 'SonarQubeServer'

        SONAR_SCANNER    = 'SonarScanner-CLI'

    }

  

    stages {

  

        stage('Git Info') {

            steps {

                script {

                    info = parseGitInfo()

                    echo "Group: ${info.group}"

                    echo "SubGroup: ${info.subGroup}"

                    echo "Project: ${info.project}"

                    echo "Branch: ${info.branch}"

                }

            }

        }

  

        stage('Checkout Source') {

            steps {

                script {

                    def repoUrl = "https://gitlab.smartseoapp.com/${info.group}/${info.subGroup}/${info.project}.git"

                    echo "Checking out: ${repoUrl}"

                }

  

                checkout([

                    $class: 'GitSCM',

                    branches: [[name: info.branch ]],

                    userRemoteConfigs: [[

                        url: "https://gitlab.smartseoapp.com/${info.group}/${info.subGroup}/${info.project}.git",

                        credentialsId: 'root'

                    ]]

                ])

            }

        }

  

        stage('SonarQube Scan') {

            steps {

                script {

                    // Git 기반 Key 생성

                    def gitKey = "${info.group}.${info.subGroup}.${info.project}"

  

                    // JSON 매핑 로드

                    def projectKey = loadProjectKey(gitKey)

  

                    echo "▶️ SonarQube Scan Start"

                    echo "Mapped Project Key: ${projectKey}"

  

                    withSonarQubeEnv("${SONARQUBE_SERVER}") {

                        def scannerHome = tool "${SONAR_SCANNER}"

  

                        sh """

                            ${scannerHome}/bin/sonar-scanner \

                            -Dsonar.projectKey=${projectKey} \

                            -Dsonar.projectName=${info.project} \

                            -Dsonar.sources=. \

                            -Dsonar.sourceEncoding=UTF-8

                        """

                    }

                }

            }

        }

  

        stage("SonarQube Quality Gate") {

            steps {

                timeout(time: 15, unit: 'MINUTES') {

                    waitForQualityGate abortPipeline: true

                }

            }

        }

    }

}

```

![[Pasted image 20251126215857.png]]


![[Pasted image 20251126220036.png]]![[Pasted image 20251126223750.png]]