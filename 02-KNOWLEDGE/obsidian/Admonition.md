---
tags:
  - 옵시디언
  - info
  - 플러그인
description: 옵시디언 info 구역 나누는 플러그인
---

# 기본 사용
```ad-info

내용

```

# 제목 설정
```ad-info

title: 제목

내용

```

# 제목 없음
- title의 값을 비워두면 제목 부분이 출력되지 않습니다.
```ad-info

title:

내용

```

# 폴딩 기능
- collapse에 open, close를 추가합니다. open은 기본적으로 펴지게하고, close는 기본으로 접혀있습니다.
```ad-info

collapse: open

내용

```

# 아이콘 변경
- 기본 아이콘을 변경할 수 있습니다. 아이콘 이름은 FontAwesome 또는 RPGA wesome의 아이콘 이름이어야 하며 그렇지 않으면 작동하지 않습니다.
```ad-info

icon: triforce

내용

```

# 색상 변경
- 색상을 변경할려면 RGB 트라이어드 값을 사용하면 됩니다. RGB 트라이어드는 쉼표로 구분된 세 개의 정수로 입력해야 하며 0에서 255 사이여야 합니다.
```ad-info

color: 200, 200, 200

내용

```

# Admonition의 타입 식별자
- ad-note, ad-info, ad-todo (파란색)
- ad-abstract, ad-summary, ad-tldr, ad-tip, ad-hint, ad-important (하늘색)
- ad-success, ad-check, ad-done (녹색)
- ad-question, ad-help, ad-faq, ad-warning, ad-caution, ad-attention (주황색)
- ad-failure, ad-fail, ad-missing, ad-danger, ad-error, ad-bug (빨간색)
- ad-example (보라색)
- ad-quote, ad-cite (회색)
![[admonition.png]]