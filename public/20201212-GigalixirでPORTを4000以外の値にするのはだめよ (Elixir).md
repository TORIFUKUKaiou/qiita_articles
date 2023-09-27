---
title: GigalixirでPORTを4000以外の値にするのはだめよ (Elixir)
tags:
  - Elixir
  - Phoenix
  - Gigalixir
private: false
updated_at: '2020-12-13T22:31:11+09:00'
id: a570e8baa337c73f011a
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
この記事は [Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2) 13日目です。
前日は [String.replace/3 (Elixir)](https://qiita.com/torifukukaiou/items/71f4b80d8f7dddf87293) でした。

---

# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか！
- [Phoenix](https://www.phoenixframework.org/)でWebアプリケーション作ったら、[Gigalixir](https://www.gigalixir.com/)にデプロイするのが簡単です
    - [Deploying on Gigalixir](https://hexdocs.pm/phoenix/gigalixir.html#content)
    - 手前味噌ですが、[Hello Gigalixir (Phoenix/Elixir)](https://qiita.com/torifukukaiou/items/d2d0e9f56ffe3bb8eda1)
- **[Phoenix](https://www.phoenixframework.org/)アプリケーションをdeployした場合、環境変数`PORT`を4000以外の値で設定追加すると`Unhealthy`になってしまいます**

# `PORT`を3000にする設定を追加してみます

![スクリーンショット 2020-12-12 21.24.19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/dcd495da-46be-87c4-3ac7-3d465f862028.png)

- `Unhealthy`になっちゃいます

![スクリーンショット 2020-12-12 21.25.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d52609fb-2be6-0823-b5f4-9fabe7c033e2.png)

- `PORT`を4000へUpdateしてみましょう
- `Healthy`に戻ります

![スクリーンショット 2020-12-12 21.27.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7fb2b1ff-1650-9664-fa0e-d470f60ed5bf.png)

# [Gigalixir](https://www.gigalixir.com/)のドキュメント
- ここが該当します
    - [https://gigalixir.readthedocs.io/en/latest/troubleshooting.html#id1](https://gigalixir.readthedocs.io/en/latest/troubleshooting.html#id1)

> Our health checks simply check that your app is listening on port $PORT. If you’re running a non-HTTP Elixir app, but need to just get health checks to pass, take a look at https://github.com/jesseshieh/elixir-tcp-accept-and-close

- [Phoenix](https://www.phoenixframework.org/)アプリの場合、[Gigalixir](https://www.gigalixir.com/)のほうで環境変数`PORT`が4000に設定されていることを期待しています
- だから`PORT`を4000以外の値で、利用者自身が書き換えてしまうと`Unhealthy`になっちまうという流れです

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- [Gigalixir](https://www.gigalixir.com/)で環境変数`PORT`に443を設定して、アプリは動いているんだけどヘルスチェックが失敗しているなあ、なんだろうなあ :thinking: と考え込んだことがありました
- `PORT`は4000以外にしちゃだめよ
- Enjoy [Elixir](https://elixir-lang.org/)!!! :rocket::rocket::rocket::rocket:
- 一息つきます
- @mnishiguchi さん続きお願いします 


