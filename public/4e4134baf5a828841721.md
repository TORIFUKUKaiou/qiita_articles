---
title: 「NxでMNISTの手書き数字画像分類を試す」kentaro/jnnnx プロジェクトへのプルリクがマージしてもらえた話 (Elixir)
tags:
  - Elixir
  - Nerves
  - 40代駆け出しエンジニア
private: false
updated_at: '2021-02-25T20:34:56+09:00'
id: 4e4134baf5a828841721
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- 2021/02/25(木)に開催された[NervesJP #15 Nxを触ってみる回](https://nerves-jp.connpass.com/event/205125/)に参加してみました
    - @takasehideki 先生ありがとうございます！
- [Nx](https://github.com/elixir-nx/nx)です:bangbang::bangbang::bangbang:
- [Nx](https://github.com/elixir-nx/nx)です:bangbang::bangbang::bangbang:
- [Nx](https://github.com/elixir-nx/nx)です:bangbang::bangbang::bangbang:

# 会の中で @kentaro さんが「NxでMNISTの手書き数字画像分類を試す」という話をしてくださいました
- [NxでMNISTの手書き数字画像分類を試す](https://twitter.com/kentaro/status/1364894054832504834)
- [Introducing Nx - José Valim | Lambda Days 2021](https://www.youtube.com/watch?v=fPKMmJpAGWc) :video_camera: からみるとよいらしいです
- この動画 :video_camera: のライブコーディングを写経して再現されたそうです :thumbsup::thumbsup_tone1::thumbsup_tone2::thumbsup_tone3::thumbsup_tone4::thumbsup_tone5:   

# [kentaro/jnnnx](https://github.com/kentaro/jnnnx) :tada::tada::tada: 
- ライブコーディングの再現！
- READMEのサンプルの通りそのままやってみましょう
- けっこう時間がかかるみたい

# 私の[プルリク](https://github.com/kentaro/jnnnx/pull/1)が採用されました :tada::tada::tada: 
- https://github.com/kentaro/jnnnx/pull/1
- データダウンロード用の`tmp`フォルダがあることを期待しているようで、[File.mkdir_p/1](https://hexdocs.pm/elixir/File.html#mkdir_p/1)で作ることにしました
    - 元から`tmp`があってもよいように[File.mkdir_p/1](https://hexdocs.pm/elixir/File.html#mkdir_p/1)を使いました
- [Nx](https://github.com/elixir-nx/nx)の
- <font color="purple">$\huge{本筋ではありません}$</font>

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- 会の途中でプルリクだして、マージしてもらって、[Qiita](https://qiita.com/)の記事も書きました
- [Elixir](https://elixir-lang.org/)でやったことはなんでも[Qiita](https://qiita.com/)に書いていくスタイル
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket: 
