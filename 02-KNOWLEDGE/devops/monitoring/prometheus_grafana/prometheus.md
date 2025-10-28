## Prometheus UI 실무 활용 가이드

Prometheus UI는 강력한 쿼리 언어(PromQL)를 기반으로 실시간으로 메트릭을 확인하고 분석할 수 있는 강력한 도구입니다. 처음에는 다소 복잡하게 느껴질 수 있지만, 몇 가지 핵심적인 방법들을 익히면 실무에서 매우 유용하게 활용할 수 있습니다.

**1. 기본 UI 탐색 및 이해**

*   **Graph:** 가장 기본적인 시각화 방식으로, 시간 경과에 따른 메트릭의 변화를 그래프로 보여줍니다.
*   **Data source:** Prometheus 서버의 주소를 설정하여 데이터를 가져오는 설정입니다.
*   **Expression Browser:** PromQL 쿼리를 입력하고 실행하여 결과를 확인하는 영역입니다.
*   **Alerts:** 정의된 알람 규칙에 따라 발생한 알람을 확인하는 영역입니다.
*   **Status:** Prometheus 서버의 상태, 스크래핑 대상, 쿼리 실행 시간 등을 확인하는 영역입니다.

**2. PromQL 기초 및 실무 쿼리 예시**

PromQL은 Prometheus 데이터를 쿼리하는 강력한 언어입니다. 몇 가지 기초적인 개념을 이해하고 예시 쿼리를 익히면 실무에서 필요한 데이터를 효율적으로 추출할 수 있습니다.

*   **기본 문법:**
    *   `metric_name`: 메트릭 이름
    *   `{label_name="label_value"}`: 레이블 필터링
    *   `[duration]`: 쿼리 기간 설정
    *   `offset duration`: 과거 시간부터 쿼리 시작
    *   `rate(metric_name[duration])`: 지정된 기간 동안의 증가율 계산
    *   `sum(metric_name)`: 지정된 메트릭의 합계 계산
    *   `avg(metric_name)`: 지정된 메트릭의 평균 계산

*   **실무 쿼리 예시:**
    *   **CPU 사용률 확인:** `rate(node_cpu_seconds_total{mode!="idle"}[5m])` (최근 5분 동안의 CPU 사용률)
    *   **메모리 사용량 확인:** `node_memory_MemTotal - node_memory_MemFree` (총 메모리 - 사용 가능한 메모리)
    *   **디스크 공간 사용량 확인:** `node_filesystem_avail_bytes / node_filesystem_size_bytes` (사용 가능한 디스크 공간 / 총 디스크 공간)
    *   **HTTP 요청 응답 시간 확인:** `histogram_quantile(0.95, sum(rate(http_request_duration_seconds_bucket[5m])) by (le))` (95% 응답 시간)
    *   **특정 Pod의 CPU 사용량 확인:** `sum(rate(container_cpu_usage_seconds_total{pod=~"my-pod.*"}[5m]))`

**3. UI를 활용한 실시간 모니터링 및 문제 해결**

*   **실시간 그래프 확인:** 원하는 메트릭을 선택하여 실시간 그래프를 확인하고 시스템의 상태를 파악합니다.
*   **쿼리 결과 분석:** 쿼리 결과를 분석하여 특정 문제의 원인을 파악하고 해결 방안을 모색합니다.
*   **문제 발생 시 쿼리 활용:** 문제가 발생했을 때 관련된 메트릭을 쿼리하여 문제의 범위를 좁히고 원인을 찾습니다.
*   **Alertmanager 연동:** Alertmanager와 연동하여 정의된 임계값을 초과하는 경우 알람을 발생시키고 즉각적으로 대응합니다.

**4. UI를 활용한 문제 해결 팁**

*   **문제 상황 재현:** 문제가 발생한 시점의 그래프를 확인하여 문제 상황을 재현하고 원인을 파악합니다.
*   **관련 메트릭 비교:** 문제와 관련된 여러 메트릭을 비교하여 문제의 범위를 좁히고 원인을 찾습니다.
*   **레이블 필터링 활용:** 레이블 필터링을 활용하여 특정 Pod, Service, Node 등의 메트릭을 확인하고 문제의 범위를 좁힙니다.
*   **PromQL 함수 활용:** PromQL 함수를 활용하여 복잡한 분석을 수행하고 문제 해결에 필요한 정보를 추출합니다.

**5. UI 활용 시 주의 사항**

*   **쿼리 성능:** 복잡한 쿼리는 Prometheus 서버에 부하를 줄 수 있으므로 쿼리 성능을 고려하여 작성합니다.
*   **데이터 정확성:** Prometheus 서버에 수집되는 데이터의 정확성을 확인하고 필요에 따라 데이터 수집 설정을 조정합니다.
*   **보안:** Prometheus UI에 대한 접근 권한을 관리하고 보안 설정을 강화합니다.

**추가 정보:**

*   **Prometheus UI 공식 문서:** [https://prometheus.io/docs/visualization/](https://prometheus.io/docs/visualization/)
*   **PromQL 공식 문서:** [https://prometheus.io/docs/query/](https://prometheus.io/docs/query/)

Prometheus UI는 강력한 도구이지만, 처음에는 다소 복잡하게 느껴질 수 있습니다. 꾸준히 사용하고 익숙해지면 실무에서 매우 유용한 도구가 될 것입니다.