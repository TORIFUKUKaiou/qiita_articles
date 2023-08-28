---
title: Graphing support via VegaLite has arrived to Livebook! をイゴかしてみる(Elixir)
tags:
  - Elixir
  - Livebook
private: false
updated_at: '2021-05-24T00:09:40+09:00'
id: d9813aad1d3f5790b9ae
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか :bangbang::bangbang::bangbang:
- [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slackで @kikuyuta 先生がおもしろそうなものを紹介されていたのでイゴかしてみます
- この記事は、2021/05/22(土) 00:00 - 2021/05/24(月) 23:59開催の[autoracex #29](https://autoracex.connpass.com/event/214090/)というもくもく会の成果です

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Graphing support via VegaLite has arrived to Livebook! <a href="https://t.co/ORd2PzQF5s">https://t.co/ORd2PzQF5s</a> - currently static but dynamic graphs are coming soon!<br><br>We are also working on a VegaLite library with support for JSON, PNG, SVG, and PDF exports.<a href="https://twitter.com/hashtag/MyElixirStatus?src=hash&amp;ref_src=twsrc%5Etfw">#MyElixirStatus</a> <a href="https://t.co/uVxaFLRkL3">pic.twitter.com/uVxaFLRkL3</a></p>&mdash; Dashbit (@dashbit) <a href="https://twitter.com/dashbit/status/1395763964215185409?ref_src=twsrc%5Etfw">May 21, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

https://autoracex.connpass.com/event/214090/

# 完成品
- https://livebook.torifuku-kaiou.tokyo/
- パスワードは`enjoyelixirwearethealchemists`です
- https://github.com/elixir-nx/livebook/tree/e10f43e5b53a75a857106df04bd45d37629f4ebf
- どうぞご自由にお使いください


![スクリーンショット 2021-05-23 11.21.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/30fd1442-e0dd-d72b-c0dc-8767e9d9af92.png)

- 上のバーに`/home/sammy/livebook/vega_lite_examples.livemd`と入力して、`Open`を押してください
    - https://github.com/elixir-nx/vega_lite/blob/5cea6289bb18e28376c72497df5a005833924fe3/notebooks/examples.livemd をコピーしておいています
- 動画と同じブックが開けますので、あとは見出しのすぐそばにカーソルをもっていくと`Evaluate`なるなんだか押せそうなものがでてきますので迷わず押してみてください
- あら、びっくりグラフが表示されます

![スクリーンショット 2021-05-23 11.34.57.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/80777027-00d2-9d03-2ac1-008843314943.png)




# ローカルでのイゴかしかた
- [Mix.install/2](https://hexdocs.pm/mix/Mix.html#install/2)という[Elixir](https://elixir-lang.org/) `1.12`から追加された関数を使いますので、`1.12`が必要です
- これまで[HTTPoison](https://hexdocs.pm/httpoison/readme.html)等の[Hex](https://hex.pm/)を使うさいに、`mix new hello`なんてやって`mix.exs`のdepsを変更して……　といった操作をする必要がありました
- [Mix.install/2](https://hexdocs.pm/mix/Mix.html#install/2)を使うことで、そういうことを必要なしに、`.exs`の書きなぐりのファイルにいきなり[HTTPoison](https://hexdocs.pm/httpoison/readme.html)を導入なんてことが可能になります
    - @MzRyuKa さんの「[Elixir1.12.0-otp-24のMix.install/2でNxライブラリを試してみる](https://qiita.com/MzRyuKa/items/eee022d97bdc117fa2eb)」に[nx](https://github.com/elixir-nx/nx/tree/main/nx)を用いた具体例がありますのでぜひご参照ください
    - 手前味噌な記事の「[Mix.install/2 で お手軽に依存ライブラリ(Hex) をインストールしてElixirプログラムをイゴかす](https://qiita.com/torifukukaiou/items/c600b6d496683442c254)」もよろしければご参照ください
- そろそろ、[Livebook](https://github.com/elixir-nx/livebook/tree/e10f43e5b53a75a857106df04bd45d37629f4ebf)をローカルでイゴかす手順を書きます
- [Docker](https://www.docker.com/)を使ってみます
    - Docker Hubにあるものは必ずしも最新のimageとはなっていないようなので`git clone`してきて、`Dockerfile`でビルドからしてみます

```
$ git clone https://github.com/elixir-nx/livebook.git
$ cd livebook
$ docker build -t livebook/livebook .
$ docker run -p 8080:8080 -e LIVEBOOK_PASSWORD="enjoyelixirwearethealchemists" livebook/livebook
```

- Visit: http://localhost:8080/
- `password: enjoyelixirwearethealchemists`
- 画面上のほうの`Import`ボタンを押下

![スクリーンショット 2021-05-23 13.23.35.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/376a9d9c-ff78-2b75-9a5f-ae27440e8560.png)

- `From clipboard`に、https://github.com/elixir-nx/vega_lite/blob/5cea6289bb18e28376c72497df5a005833924fe3/notebooks/examples.livemd の内容を貼り付けて、`Import`
- あとは`Evaluate`を押してお楽しみください

# Wrapping Up :lgtm::lgtm::lgtm::lgtm:
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:
