---
tags:
  - 옵시디언
  - 코드편집지원
  - 플러그인
description: 옵시디언 코드 편집 플러그인
---


# 기본 기능
- VSCode에서 코드를 편집하는 것처럼 다양한 코드 형식의 파일을 보고 편집하는 것을 지원
- 마크다운 문서에서든 개별 코드 블록을 편집
## 다양한 코드 파일 지원
- `ts`, `js`, `py`, `css`, `c`, `cpp`, `go`, `rs`, `java`, `lua`, `php` 기본 지원

| 단축키                        | 기능                 |
| -------------------------- | ------------------ |
| `ctrl + c`                 | 복사                 |
| `ctrl + x`             | 잘라내기               |
| `ctrl + v`                 | 붙여넣기               |
| `ctrl + s`             | 저장                 |
| `ctrl + a`             | 전체 선택              |
| `ctrl + f`             | 찾기                 |
| `ctrl + h`             | 바꾸기                |
| `ctrl + z`             | 실행 취소              |
| `ctrl + y`             | 다시 실행              |
| `ctrl + /`             | 주석 토글              |
| `ctrl + d`             | 줄 복제               |
| `ctrl + [`             | 들여쓰기 감소            |
| `ctrl + ]`             | 들여쓰기 증가            |
| `ctrl + ↑`             | 줄 위로 이동            |
| `ctrl + ↓`             | 줄 아래로 이동           |
| `ctrl + ←`                 | 단어 단위로 왼쪽으로 커서 이동  |
| `ctrl + →`                 | 단어 단위로 오른쪽으로 커서 이동 |
| `ctrl + Backspace`     | 왼쪽 단어 삭제           |
| `ctrl + Delete`            | 오른쪽 단어 삭제          |
| `ctrl + shift + z`         | 다시 실행              |
| `ctrl + shift + k`     | 현재 줄 삭제            |
| `ctrl + shift + [`     | 코드 블록 접기           |
| `ctrl + shift + ]`     | 코드 블록 펼치기          |
| `ctrl + shift + enter` | 위에 줄 삽입            |
| `ctrl + enter`         | 아래에 줄 삽입           |
| `alt + z`              | 단어 줄바꿈 토글          |

```c++
#include <iostream>
int main() {
    std::cout << "Hello, C++!" << std::endl;
}
```

```python
print("Hello, Python!")
```

```js
console.log("Hello, JavaScript!");
```

```ts
let msg: string = "Hello, TypeScript!";
console.log(msg);
```

```java
class Main {
  public static void main(String[] args) {
    System.out.println("Hello, Java!");
  }
}
```


## 내부 링크 추가 및 Preview
- [js_example](vscode_editor.js)

![[vscode_editor.png]]![[vscode_editor2.png]]