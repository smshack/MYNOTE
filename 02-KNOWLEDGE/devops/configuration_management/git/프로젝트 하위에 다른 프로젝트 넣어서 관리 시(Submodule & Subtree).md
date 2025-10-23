

> 깃 프로젝트 하위에 깃 프로젝트를 넣어서 관리하는 방법은 크게 두 가지가 있습니다. Submodule과 Subtree 방식인데, 각각 장단점이 있으므로 프로젝트 상황에 맞춰 선택해야 합니다.

**1. Git Submodule**

*   **개념:**  Submodule은 다른 깃 저장소를 현재 저장소의 특정 디렉토리에 연결하는 방식입니다.  실질적으로 외부 저장소의 특정 커밋을 가리키는 포인터를 저장합니다.
*   **장점:**
    *   외부 프로젝트의 변경 사항을 독립적으로 관리할 수 있습니다.
    *   외부 프로젝트의 커밋 히스토리를 보존합니다.
*   **단점:**
    *   Submodule 관리가 다소 복잡할 수 있습니다. (초기화, 업데이트, 커밋 등)
    *   Submodule 디렉토리의 변경 사항을 커밋하려면 외부 저장소의 변경 사항을 먼저 커밋해야 합니다.

**Submodule 사용 방법:**

1.  **Submodule 추가:**

    ```bash
    git submodule add <외부 저장소 URL> <Submodule 저장될 디렉토리>
    ```

2.  **Submodule 초기화 및 업데이트:**  (처음 클론한 경우)

    ```bash
    git submodule init
    git submodule update
    ```

3.  **Submodule 변경 사항 커밋:**  Submodule 디렉토리의 변경 사항을 커밋하면, Submodule의 커밋 SHA가 부모 저장소에 기록됩니다.

**2. Git Subtree**

*   **개념:**  Subtree는 외부 저장소의 내용을 현재 저장소의 디렉토리에 병합하는 방식입니다.  외부 저장소의 내용을 현재 저장소의 히스토리에 통합합니다.
*   **장점:**
    *   관리가 간단합니다. (Submodule처럼 복잡한 과정이 필요 없습니다.)
    *   외부 프로젝트의 히스토리를 부모 저장소에 통합할 수 있습니다.
*   **단점:**
    *   외부 프로젝트의 변경 사항을 관리하기 어려울 수 있습니다.
    *   히스토리가 복잡해질 수 있습니다.

**Subtree 사용 방법:**

1.  **Subtree 추가:**

    ```bash
    git remote add <외부 저장소 이름> <외부 저장소 URL>
    git fetch <외부 저장소 이름>
    git merge --no-ff <외부 저장소 이름>/<브랜치> --allow-unrelated-histories
    ```

2.  **Subtree 업데이트:**

    ```bash
    git fetch <외부 저장소 이름>
    git merge --no-ff <외부 저장소 이름>/<브랜치> --allow-unrelated-histories
    ```

**어떤 방식을 선택해야 할까요?**

| 특징         | Git Submodule                            | Git Subtree                                |
| ---------- | ---------------------------------------- | ------------------------------------------ |
| **관리 복잡도** | 높음                                       | 낮음                                         |
| **독립성**    | 높음                                       | 낮음                                         |
| **히스토리**   | 보존                                       | 통합                                         |
| **적합한 상황** | 외부 프로젝트의 독립적인 관리가 필요하고, 히스토리를 보존해야 하는 경우 | 외부 프로젝트를 부모 프로젝트의 일부로 통합하고, 관리가 용이해야 하는 경우 |

**요약:**

*   **Submodule:** 외부 프로젝트를 독립적인 단위로 관리하고 싶을 때 사용합니다.
*   **Subtree:** 외부 프로젝트를 부모 프로젝트의 일부로 통합하고 싶을 때 사용합니다.

각 방식의 장단점을 고려하여 프로젝트 상황에 맞는 방식을 선택하시기 바랍니다.  더 자세한 정보는 다음 자료를 참고하시기 바랍니다.

*   **Git Submodule:** [https://git-scm.com/book/ko/v2/Git-Tools-Submodules](https://git-scm.com/book/ko/v2/Git-Tools-Submodules)
*   **Git Subtree:** [https://git-scm.com/book/ko/v2/Git-Tools-Subtree](https://git-scm.com/book/ko/v2/Git-Tools-Subtree)

---
```ad-info
현재 전체 공부 및 일정을 관리하기 위해 옵시디언을 사용중이고 깃으로 연결해 놓은 상태
해당 옵시디언 폴더에서 전체 프로젝트 및 정리를 하여 관리 하기 위해 submodule로 하위 디렉터리에서 관리해서 보고 각 프로젝트가 독립적으로 관리되기를 원하므로 submodule 형식으로 관리
```

### 실제 적용
```bash
git submodule add https://github.com/smshack/git-basic.git 02-KNOWLEDGE/devops/configuration_management/git/git-basic
```
- 현재 옵시디언으로 정리하는 곳 하위에 관리 원함