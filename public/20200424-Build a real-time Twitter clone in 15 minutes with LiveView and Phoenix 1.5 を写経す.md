---
title: >-
  Build a real-time Twitter clone in 15 minutes with LiveView and Phoenix 1.5
  を写経する
tags:
  - Elixir
  - Phoenix
  - fukuoka.ex
private: false
updated_at: '2020-04-29T20:46:52+09:00'
id: 860d027edbe5672ca53b
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
# はじめに
- [Build a real-time Twitter clone in 15 minutes with LiveView and Phoenix 1.5](https://www.youtube.com/watch?v=MZvmYaFkNJI) という[Phoenix](https://www.phoenixframework.org/)の作者[Chris McCord](https://github.com/chrismccord)さんのビデオがあります
    - [Mind blowing Phoenix (Elixir) Demo. Look how easy, quick and efficient it is to build something thanks to LiveViews (the Component system of Phoenix). LiveViews are a real game changer. What a time to be alive ! 😍 (Thanks 
@chris_mccord
) #myelixirstatus](https://twitter.com/sofianebaddag/status/1253009209484021760) で知りました
- 写経してみました
- 動画中06:30 くらいの `ChirpWeb.PostLive.PostComponent.render/1` のところが超速いです
- [fukuoka.ex#37](https://fukuokaex.connpass.com/event/173363/) のイベントでの成果です


# 準備
- [Elixir](https://elixir-lang.org/) 1.10.2

```
$ mix local.hex
$ mix archive.uninstall phx_new
$ mix archive.install hex phx_new 1.5.1
```

- node.js
- PostgreSQL
    - Would you please refer to [Installation](https://hexdocs.pm/phoenix/installation.html#content) ?

# 写したもの
- https://github.com/TORIFUKUKaiou/chirp_demo
  - https://github.com/dersnek/chirp を参考に見た目をお手本に近づけました
- `git clone`して使う場合は以下のようにしてください

```
$ git clone https://github.com/TORIFUKUKaiou/chirp_demo.git
$ cd chirp_demo
$ mix setup # see mix.exs
$ mix phx.server

Visit localhost:4000/posts
```

# 触れるところ
- https://elixir-is-beautiful.torifuku-kaiou.tokyo/posts
- しばらく公開しておきます
- ご自由に遊んでやってください

# 最初にやること
- `mix phx.new chirp --live`
- [phoenix_live_view](https://github.com/phoenixframework/phoenix_live_view)がプリセットされたアプリケーションがセットアップされます

# お手本
<img width="647" alt="スクリーンショット 2020-04-24 20.50.31.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/48e9be63-5f67-943e-43ed-57cdf0e8f395.png">

# できたもの
- 動画の中ではCSSと画像あたりのところの説明が省略されています
- なんとなくそれっぽくつくったもの

<img width="825" alt="スクリーンショット 2020-04-24 20.51.57.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7f06df7f-4da4-4cb7-f7c2-cfec5469cd8d.png">

# Wrapping Up
- [LiveView](https://github.com/phoenixframework/phoenix_live_view)を使おうとすると以前は準備がけっこうたいへんだったそうです
- [Phoenix v1.5](https://www.phoenixframework.org/blog/build-a-real-time-twitter-clone-in-15-minutes-with-live-view-and-phoenix-1-5)からは、`mix phx.new chirp --live` で準備万端です

# おまけ
- データベース作成忘れ(`$ mix ecto.create`)やマイグレーション(`$ mix ecto.migrate`)忘れがあると、Phoenix 1.5からは赤い画面にマイグレーションを促すボタンが表示されるようになりました

<img width="847" alt="スクリーンショット 2020-04-29 20.16.53.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e29160b3-6ee8-7ead-2fa4-8ba943f1308c.png">


# 参考
- [Where is the chirp repo for the real-time Twitter clone in 15 minutes by Chris McCord?](https://elixirforum.com/t/where-is-the-chirp-repo-for-the-real-time-twitter-clone-in-15-minutes-by-chris-mccord/30904)
    - ビデオのまま写した場合、削除ボタンを押しただけでは画面からPostがすぐには消えてくれません
    - 同じ疑問をもたれた方がいらっしゃったようで、私も自分が試したことを[書き込んだ](https://elixirforum.com/t/where-is-the-chirp-repo-for-the-real-time-twitter-clone-in-15-minutes-by-chris-mccord/30904/10)りしてみました

