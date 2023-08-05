---
title: HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get (Elixir)
tags:
  - Elixir
private: false
updated_at: '2020-12-09T07:08:20+09:00'
id: 3890d4ea8220f44c7e0a
organization_url_name: fukuokaex
slide: false
---

この記事は [Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2) 9日目です。
前回は、[CircleCIでmix testする、Gigalixirへデプロイする(Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/1e266c7b213cdd3fd58e) でした。

---

# はじめに
- みなさん！　[Elixir](https://elixir-lang.org/)を楽しんでいますか！
- `mix deps.get`が失敗して、`HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get` というメッセージがでたことありますか？
- 私の家のインターネット回線の速度が夜になると極端に遅くなるということがありまして、ちょくちょくおみかけします
- まったく見たことがないというアルケミストもいて、その方はインターネット回線がきっといいのでしょう！
    - うらやましい:relaxed:

# もしおみかけしたら

- メッセージの通り、**迷わず行けよ　行けばわかるさ　ありがとう！**

```
$ HEX_HTTP_CONCURRENCY=1 HEX_HTTP_TIMEOUT=120 mix deps.get
```

# 一体なになのさ

- [https://github.com/hexpm/hex/blob/v0.20.6/lib/mix/tasks/hex.config.ex#L44-L49](https://github.com/hexpm/hex/blob/v0.20.6/lib/mix/tasks/hex.config.ex#L44-L49) をご参照ください

# Wrapping Up :lgtm: :santa: :santa_tone1: :santa_tone2: :santa_tone3: :santa_tone4: :santa_tone5: :lgtm:
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket:  
