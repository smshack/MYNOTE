## Prometheus & Grafana: 오픈소스 모니터링 시스템 구축 가이드

본 문서는 오픈소스 모니터링 시스템 구축을 위한 Prometheus와 Grafana에 대한 설명, 연결 구조, 동작 방식, 사용법 등을 제공합니다. 본 내용은 리드미 파일에 붙여넣어 사용할 수 있도록 구성되었습니다.

### 1. Prometheus 개요

**Prometheus**는 CNCF(Cloud Native Computing Foundation)에서 개발한 오픈소스 시스템 모니터링 및 경고 도구입니다. 시계열 데이터베이스를 기반으로 메트릭을 수집, 저장하고, PromQL이라는 강력한 쿼리 언어를 사용하여 데이터를 분석합니다.

* **주요 특징:**
    * **다차원 데이터 모델:** 메트릭을 키-값 쌍으로 저장하여 유연하게 분석 가능
    * **PromQL:** 강력한 쿼리 언어를 사용하여 복잡한 분석 수행 가능
    * **Pull 기반:** 모니터링 대상에서 데이터를 가져오는 방식 (Push 방식도 지원)
    * **Service Discovery:** Kubernetes, Consul 등 다양한 서비스 디스커버리 도구와 연동 가능
    * **Alertmanager:** 알람 규칙을 정의하고 알람을 관리하는 기능 제공

* **사용법:**
    * **설치:** 운영체제에 맞는 바이너리를 다운로드하여 설치하거나, Docker를 사용하여 간편하게 설치 가능
    * **설정:** `prometheus.yml` 파일을 사용하여 모니터링 대상, 스크래핑 간격, 알람 규칙 등을 설정
    * **데이터 수집:** Exporter를 사용하여 모니터링 대상의 메트릭을 수집
    * **데이터 분석:** PromQL을 사용하여 수집된 데이터를 분석하고 시각화

### 2. Grafana 개요

**Grafana**는 시계열 데이터 시각화 도구입니다. Prometheus, InfluxDB, Elasticsearch 등 다양한 데이터 소스를 지원하며, 대시보드를 통해 데이터를 시각적으로 표현합니다.

* **주요 특징:**
    * **다양한 데이터 소스 지원:** Prometheus, InfluxDB, Elasticsearch, Graphite 등 다양한 데이터 소스 지원
    * **유연한 대시보드:** 사용자 정의 가능한 대시보드를 통해 데이터를 시각적으로 표현
    * **알림 기능:** 데이터 값이 특정 임계값을 초과할 경우 알림을 발생시키는 기능 제공
    * **플러그인 지원:** 다양한 플러그인을 통해 기능을 확장 가능
    * **팀 협업:** 대시보드 공유 및 팀 협업 기능 제공

* **사용법:**
    * **설치:** 운영체제에 맞는 바이너리를 다운로드하여 설치하거나, Docker를 사용하여 간편하게 설치 가능
    * **데이터 소스 설정:** Prometheus 서버 주소를 입력하여 데이터 소스를 설정
    * **대시보드 생성:** 그래프, 테이블, 게이지 등 다양한 패널을 사용하여 대시보드를 생성
    * **패널 설정:** 데이터 소스, 쿼리, 시각화 옵션을 설정하여 패널을 구성

### 3. Prometheus & Grafana 연결 구조 및 동작 방식

Prometheus는 메트릭을 수집하고 저장하는 역할을 수행하고, Grafana는 Prometheus에 저장된 데이터를 가져와 시각적으로 표현하는 역할을 수행합니다.

1.  **Prometheus:** 모니터링 대상에서 메트릭을 주기적으로 스크래핑합니다.
2.  **Exporter:** 모니터링 대상의 메트릭을 Prometheus가 이해할 수 있는 형식으로 변환합니다.
3.  **Prometheus:** 수집된 메트릭을 시계열 데이터베이스에 저장합니다.
4.  **Grafana:** Prometheus 서버에 쿼리를 보내 데이터를 가져옵니다.
5.  **Grafana:** 가져온 데이터를 시각적으로 표현하여 대시보드를 구성합니다.

**머메이드 다이어그램:**

```mermaid
graph LR
    A[Monitoring Target] --> B(Exporter)
    B --> C(Prometheus)
    C --> D(Grafana)
    D --> E[User]
    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#ccf,stroke:#333,stroke-width:2px
    style C fill:#fcf,stroke:#333,stroke-width:2px
    style D fill:#cfc,stroke:#333,stroke-width:2px
    style E fill:#eee,stroke:#333,stroke-width:2px
```

### 4. 주요 설정 파일

*   **Prometheus 설정 파일 (`prometheus.yml`):**
    *   `global:` 전역 설정 (스크래핑 간격, 외부 레이블 등)
    *   `scrape_configs:` 스크래핑 대상 설정 (job\_name, static\_configs, service\_discovery\_configs 등)
    *   `rule_files:` 알람 규칙 파일 경로
*   **Grafana 설정 파일 (`grafana.ini`):**
    *   `[server]:` 서버 설정 (포트, HTTP 인증 등)
    *   `[database]:` 데이터베이스 설정 (데이터베이스 종류, 연결 정보 등)
    *   `[auth.basic]:` 기본 인증 설정 (사용자 이름, 비밀번호 등)

### 5. 추가 정보

*   **Prometheus 공식 문서:** [https://prometheus.io/docs/](https://prometheus.io/docs/)
*   **Grafana 공식 문서:** [https://grafana.com/docs/](https://grafana.com/docs/)
*   **Prometheus & Grafana 튜토리얼:** [https://prometheus.io/docs/guides/](https://prometheus.io/docs/guides/)

본 가이드는 Prometheus와 Grafana를 활용하여 시스템 모니터링 시스템을 구축하기 위한 기본적인 내용을 제공합니다. 더 자세한 내용은 공식 문서를 참고하시기 바랍니다.