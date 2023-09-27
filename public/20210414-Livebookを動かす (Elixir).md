---
title: Livebookを動かす (Elixir)
tags:
  - Elixir
  - Phoenix
private: false
updated_at: '2021-04-16T10:56:46+09:00'
id: 3847c68293ed9b94ba2d
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか :bangbang::bangbang::bangbang:
- [Livebook](https://github.com/elixir-nx/livebook)というものがでてきたので動かしてみます
- 詳しい解説は、[Announcing Livebook](https://dashbit.co/blog/announcing-livebook)
- 恥ずかしながら、最初にみたのが4/1の[ツイート](https://twitter.com/josevalim/status/1377354990969233411)だったので、エイプリルフールのジョークだとおもいこんでしまっていました
    - 本当に実在しました！
- [English edition](https://dev.to/torifukukaiou/i-run-livebook-elixir-20cb)

# デモ
- https://livebook.torifuku-kaiou.tokyo/?token=pn6rnkqs44livrm2jgad5dkjof4wlgqe
    - 1ヶ月はそのまま動かしておくのでご自由に遊んでください
    - [Time4VPS](https://www.time4vps.com/)というVirtual Private Serverでイゴかしています
    - このためだけに専用に作ったものなのでナニされてもかまわないです
    - 裸形をさらしておきます
    - クーポンをつかって1ヶ月270円
    - RAM 2GB, Storage 20GB
- イゴかしているリビジョン
    - https://github.com/elixir-nx/livebook/commit/539cb8e2b188ab2d2ab3022b9b41c0d28a5a6a51
        - この記事を書いたあとにもコミットが増えていて、絶賛開発中:rocket::rocket::rocket:の模様

# 必要なもの
- Elixir 1.11

# イゴかし方
- [README](https://github.com/elixir-nx/livebook/blob/539cb8e2b188ab2d2ab3022b9b41c0d28a5a6a51/README.md)に書いてあるとおり

```
$ git clone https://github.com/elixir-nx/livebook.git
$ cd livebook
$ mix deps.get --only prod
$ MIX_ENV=prod mix phx.server
```

```
http://localhost:8080/?token=pn6rnkqs44livrm2jgad5dkjof4wlgqe
```
- 的なものが表示されるのでアクセスしてみる


# 試してみたこと
- Notebookなるものを作って
- Sectionつくって
- Markdown or Elixirを選んで
- 適当に書いてみる
- https://livebook.torifuku-kaiou.tokyo/?token=pn6rnkqs44livrm2jgad5dkjof4wlgqe
- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: Would you please play livebook? 
- Elixirは実行できます
- Elixir 1.12を使うと、スクリプトにHexのインストールを含めることができるそうです
    - :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 上記サーバは1.11.2のためこの機能は使えません 
    - [Scripting improvements: Mix.install/2 and System.trap_signal/3](https://github.com/elixir-lang/elixir/releases/tag/v1.12.0-rc.0)

![スクリーンショット 2021-04-14 21.46.57.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/214cbdef-405b-755c-828e-2b4085e5a75a.png)

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:
- とにかくなんだかすごいものがでてきたようにおもいます
- これからも機能追加されるそうですし、なんだかすんごいものの予感がします！



