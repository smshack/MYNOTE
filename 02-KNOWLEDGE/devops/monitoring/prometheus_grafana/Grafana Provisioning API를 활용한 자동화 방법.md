```ad-info
Grafana Provisioning API는 YAML 파일을 사용하여 Grafana의 설정 (데이터 소스, 대시보드, 폴더, 알림 규칙 등)을 코드로 관리하고 자동화할 수 있는 강력한 기능입니다. 이를 통해 인프라 코드를 관리하는 것처럼 Grafana 설정을 관리하고, 버전 관리 시스템 (Git 등)을 통해 변경 사항을 추적할 수 있습니다.
```

## **1. Provisioning API 작동 방식**

*   **YAML 파일:** 모든 Grafana 설정을 YAML 파일로 정의합니다. 각 설정 유형 (데이터 소스, 대시보드 등)에 따라 파일 구조가 다릅니다.
*   **Provisioning 설정:** Grafana 설정 파일 (`grafana.ini`)에서 provisioning 설정을 활성화하고, provisioning 파일이 위치한 디렉토리를 지정합니다.
*   **자동 적용:** Grafana가 시작될 때 provisioning 디렉토리의 YAML 파일을 읽고 설정을 자동으로 적용합니다.

## **2. 자동화 예시: 데이터 소스 자동 설정**

Prometheus 데이터 소스를 자동으로 설정하는 예시를 살펴보겠습니다.

*   **파일 이름:** `datasources/prometheus.yaml`
*   **YAML 내용:**

```yaml
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    url: http://prometheus.example.com
    access: proxy
    isDefault: true
```

*   **설명:**
    *   `apiVersion: 1`: API 버전 지정
    *   `datasources`: 데이터 소스 목록
    *   `name`: 데이터 소스 이름
    *   `type`: 데이터 소스 유형 (prometheus)
    *   `url`: Prometheus 서버 주소
    *   `access`: 접근 방식 (proxy, direct)
    *   `isDefault`: 기본 데이터 소스 여부

## **3. 자동화 예시: 대시보드 자동 생성**

대시보드를 자동으로 생성하는 예시입니다.

*   **파일 이름:** `dashboards/system_overview.yaml`
*   **YAML 내용:**

```yaml
apiVersion: 1
dashboards:
  - title: System Overview
    uid: system_overview_dashboard
    panels:
      - title: CPU Usage
        type: graph
        datasource: Prometheus
        field: rate(node_cpu_seconds_total{mode!="idle"}[5m])
        unit: percent
      - title: Memory Usage
        type: graph
        datasource: Prometheus
        field: node_memory_MemTotal_bytes - node_memory_MemFree_bytes - node_memory_Buffers_bytes - node_memory_Cached_bytes
        unit: bytes
```

*   **설명:**
    *   `apiVersion: 1`: API 버전 지정
    *   `dashboards`: 대시보드 목록
    *   `title`: 대시보드 제목
    *   `uid`: 대시보드 UID (고유 식별자)
    *   `panels`: 패널 목록
    *   각 패널은 `title`, `type`, `datasource`, `field`, `unit` 등의 속성을 가집니다.

## **4. 자동화 예시: 알림 규칙 자동 설정**

알림 규칙을 자동으로 설정하는 예시입니다. (알림 관리자(Alertmanager) 연동 필요)

*   **파일 이름:** `alertrules/high_cpu_usage.yaml`
*   **YAML 내용:**

```yaml
apiVersion: 1
alertrules:
  - alert: HighCPUUsage
    expr: rate(node_cpu_seconds_total{mode!="idle"}[5m]) > 0.8
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: High CPU Usage on {{ $labels.instance }}
      description: CPU usage on {{ $labels.instance }} is above 80%.
```

*   **설명:**
    *   `apiVersion: 1`: API 버전 지정
    *   `alertrules`: 알림 규칙 목록
    *   `alert`: 알림 이름
    *   `expr`: PromQL 표현식 (조건)
    *   `for`: 조건이 충족되어야 하는 기간
    *   `labels`: 알림 레이블
    *   `annotations`: 알림 주석

## **5. Grafana 설정 (grafana.ini)**

`grafana.ini` 파일에서 provisioning 설정을 활성화하고 provisioning 디렉토리를 지정합니다.

```ini
[provisioning]
provisioning_enabled = true
provisioning_path = /etc/grafana/provisioning
```

## **6. 자동화 절차**

1.  `provisioning` 디렉토리를 생성합니다. (`/etc/grafana/provisioning`)
2.  YAML 파일을 `provisioning` 디렉토리에 저장합니다.
3.  Grafana를 재시작합니다.

Grafana가 재시작되면 provisioning 디렉토리의 YAML 파일을 읽고 설정을 자동으로 적용합니다.

**장점**

*   **코드 관리:** Grafana 설정을 코드로 관리하여 버전 관리 시스템을 통해 변경 사항을 추적할 수 있습니다.
*   **자동화:** 설정을 자동으로 적용하여 인프라 구축 및 배포를 자동화할 수 있습니다.
*   **일관성:** 여러 Grafana 인스턴스에 걸쳐 일관된 설정을 유지할 수 있습니다.
*   **협업:** 팀원들과 함께 설정을 관리하고 협업할 수 있습니다.

**참고 자료:**

*   **Grafana Provisioning 문서:** [https://grafana.com/docs/grafana/latest/provisioning/](https://grafana.com/docs/grafana/latest/provisioning/)
*   **Grafana Provisioning 예제:** [https://github.com/grafana/grafana/tree/master/example/provisioning](https://github.com/grafana/grafana/tree/master/example/provisioning)

이러한 방식으로 Grafana Provisioning API를 사용하면 Grafana 설정을 자동화하고, 코드처럼 관리하며, 일관성을 유지할 수 있습니다.


## Docker Compose + Git을 활용한 Grafana Provisioning 구조

Docker Compose로 Grafana를 관리하고 Git으로 프로비저닝 파일을 관리하는 최적의 구조는 다음과 같습니다.

## **1. 프로젝트 구조**

```
my-grafana-project/
├── docker-compose.yml          # Docker Compose 설정 파일
├── provisioning/              # 프로비저닝 파일 디렉토리
│   ├── datasources/
│   │   └── prometheus.yaml
│   ├── dashboards/
│   │   └── system_overview.yaml
│   └── alertrules/
│       └── high_cpu_usage.yaml
└── .git/                       # Git 저장소
```

*   **`docker-compose.yml`:** Grafana 컨테이너를 정의하고 실행합니다.
*   **`provisioning/`:** 모든 프로비저닝 파일을 저장하는 디렉토리입니다.
*   **`datasources/`, `dashboards/`, `alertrules/`:** 각 유형별 프로비저닝 파일을 저장하는 하위 디렉토리입니다.
*   **.git/:** Git 저장소 디렉토리입니다.

## **2. Docker Compose 설정 (docker-compose.yml)**

Grafana 컨테이너 설정에서 프로비저닝 디렉토리를 마운트합니다.

```yaml
version: "3.9"
services:
  grafana:
    image: grafana/grafana:latest
    ports:
      - "3000:3000"
    volumes:
      - grafana_data:/var/lib/grafana
      - ./provisioning:/etc/grafana/provisioning
    restart: unless-stopped

volumes:
  grafana_data:
```

*   **`./provisioning:/etc/grafana/provisioning`:** 로컬 `provisioning` 디렉토리를 컨테이너의 `/etc/grafana/provisioning` 디렉토리에 마운트합니다.  이렇게 하면 Grafana 컨테이너가 시작될 때 프로비저닝 파일을 읽어 설정을 적용합니다.

## **3. Git 관리**

*   `.gitignore` 파일에 다음 항목을 추가하여 불필요한 파일을 Git 저장소에 포함하지 않도록 합니다.

```
/grafana_data/
```

*   프로비저닝 파일 변경 사항을 Git에 커밋하고 푸시합니다.
*   Grafana 컨테이너를 재시작하면 변경 사항이 적용됩니다.

## **4. 워크플로우**

1.  프로비저닝 파일 변경
2.  Git에 커밋 및 푸시
3.  Grafana 컨테이너 재시작 (docker-compose restart grafana)
4.  Grafana에서 변경 사항 확인

## **5. 장점**

*   **버전 관리:** Git을 통해 프로비저닝 파일의 변경 사항을 추적하고 이전 버전으로 롤백할 수 있습니다.
*   **협업:** 여러 개발자가 프로비저닝 파일을 협업하여 관리할 수 있습니다.
*   **자동화:** CI/CD 파이프라인을 사용하여 프로비저닝 파일을 자동으로 배포할 수 있습니다.
*   **재현성:** 동일한 프로비저닝 파일을 사용하여 여러 Grafana 인스턴스를 일관되게 설정할 수 있습니다.

## **6. 추가 고려 사항**

*   **Secret 관리:** 프로비저닝 파일에 비밀 정보 (예: API 키, 암호)를 저장하지 마십시오.  Secret 관리 도구 (예: HashiCorp Vault, AWS Secrets Manager)를 사용하여 비밀 정보를 안전하게 관리하십시오.
*   **CI/CD 파이프라인:** CI/CD 파이프라인을 사용하여 프로비저닝 파일 변경 사항을 자동으로 테스트하고 배포하십시오.  
*   **Infrastructure as Code (IaC):** Terraform과 같은 IaC 도구를 사용하여 Grafana 인프라를 관리하고 프로비저닝 파일을 통합하십시오.

```ad-info
이 구조를 사용하면 Git을 사용하여 Grafana 프로비저닝 파일을 관리하고 Docker Compose를 사용하여 Grafana 컨테이너를 실행할 수 있습니다. 이를 통해 버전 관리, 협업, 자동화, 재현성을 확보하고 Grafana 인프라를 효율적으로 관리할 수 있습니다.
```

