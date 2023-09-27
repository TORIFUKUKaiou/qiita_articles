---
title: 「LiveView JP#10：LivebookでキャッチーにElixirを楽しもう」レポート
tags:
  - Elixir
  - LiveView
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-09-29T22:36:26+09:00'
id: 65cb4fa0b7875d5e4426
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
Advent Calendar 2022 148日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの『[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)』から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

2022/09/27(火)は、「[LiveView JP#10：LivebookでキャッチーにElixirを楽しもう](https://liveviewjp.connpass.com/event/260861/)」が開催されました。


# 19:35 Let's get started!

はじまりました〜

![スクリーンショット 2022-09-27 19.39.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f38c246a-8fea-654a-0c17-0a16788eff02.png)

# [LiveView JP](https://liveviewjp.connpass.com/)の紹介

@tuchiro さんから、[LiveView JP](https://liveviewjp.connpass.com/)を紹介してくださいました。

![スクリーンショット 2022-09-27 19.40.06.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/94d60167-d96f-7b9f-13c8-c25187fcf8d7.png)


![スクリーンショット 2022-09-27 19.42.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/caf07bf4-450e-7657-d472-0d8d0a9d9bc5.png)

### Install Livebook below

```
git clone https://github.com/elixir-nx/livebook.git -b v0.6.2
cd livebook
mix deps.get --only prod
MIX_ENV=prod mix phx.server
```

### Introduce Livebook below

```elixir:
Mix.install([{:kino, "~> 0.3.1"}, {:download, "~> 0.0.4"}])

Download.from("https://upload.wikimedia.org/wikipedia/en/7/7d/Lenna_%28test_image%29.png")
|> elem(1)
|> File.read!
|> Kino.Image.new(:jpeg)
```



# Lightning Talks


## [LivebookのSmart cellsでPostgreSQLの接続とグラフ描画を楽しむ（Elixir）](https://qiita.com/torifukukaiou/items/8332fc2bac0778f40d8c)

@torifukukaiou さん

https://qiita.com/torifukukaiou/items/8332fc2bac0778f40d8c

psqlでデータを愚直に入れていたところは、以下のコメントを頂戴しました。
ありがとうございました。

```
initdb とかローカルフォルダに sql ファイルを置いておき、
volume ./initdb:/docker-entrypoint-initdb.d と設定しておくと、
自動的にテーブル作成とかデータ投入とかできるよー
```

さっそく記事にしておきました。

https://qiita.com/torifukukaiou/items/24ab8b4b313b6f5171d9

## [Explorer: LiveBookでTidyverse](https://qiita.com/westbaystars/items/6d70d06540f9ce2e324b)

@westbaystarsさん

https://qiita.com/westbaystars/items/6d70d06540f9ce2e324b


# @piacerex さんによるLiveView JP恒例「Livebookモブプロ！」

@piacerex さんによるLiveView JP恒例「Livebookモブプロ！」が行われました。

## [dbg/2](https://hexdocs.pm/elixir/Kernel.html#dbg/2)のデモの様子

![スクリーンショット 2022-09-27 20.41.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8f25f975-e0c2-0b12-a212-8bc0a3451771.png)


## メモリ利用量のLivebookリアルタイムグラフ描画

<iframe width="640" height="360" src="https://www.youtube.com/embed/KmLw58qEtuM" title="ElixirConf 2022 - José Valim - Elixir v1.14" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

https://youtu.be/KmLw58qEtuM?t=2000

![スクリーンショット 2022-09-27 20.48.20.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ccb92a15-031e-43b1-e507-22aff0134ece.png)

## シーケンス図

![スクリーンショット 2022-09-27 20.50.19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/da0e742b-99f2-59d6-468b-a0a1b8a24429.png)

![スクリーンショット 2022-09-27 20.51.53.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/bb556df9-d041-da4c-0a8a-c388927510c1.png)

裏では
[mermaid](https://mermaid-js.github.io/mermaid/#/)
が使われています。


## Map

![スクリーンショット 2022-09-27 20.53.14.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/262d65cf-3b72-0922-59e2-0f740cf0359e.png)

![スクリーンショット 2022-09-27 20.53.39.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/cae16d99-ea69-9e4d-a17d-ef83e29b9ccb.png)

## ゴミ箱


![スクリーンショット 2022-09-27 20.57.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6222c31e-e413-85a0-fb65-2aa66c09de6e.png)





# Twitter

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">本日19:30からLiveView JP#10開催でっす😉 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a><a href="https://t.co/G661NoISvi">https://t.co/G661NoISvi</a><br><br>2021年11月にスタートしたLiveView JPも、とうとう二桁開催に突入したんですねー（しみじみ）😌<br><br>Elixir生誕10周年の今年、LiveView／Livebookとその周辺（ElixirDesktop、Nx等）は、とても熱いカテゴリで嬉しい限り😆</p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1574681890149507072?ref_src=twsrc%5Etfw">September 27, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">滑り込み～、息抜きに参加してます。<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/reZLVOO9Jw">pic.twitter.com/reZLVOO9Jw</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1574710705173188608?ref_src=twsrc%5Etfw">September 27, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">LiveView JP#10、はじまったー😆 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a><a href="https://t.co/G661NoISvi">https://t.co/G661NoISvi</a> <a href="https://t.co/DDjBODm2Ws">pic.twitter.com/DDjBODm2Ws</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1574715673049436160?ref_src=twsrc%5Etfw">September 27, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">1人目のLT、 <a href="https://twitter.com/torifukukaiou?ref_src=twsrc%5Etfw">@torifukukaiou</a> さんで「LivebookのSmart cellsでPostgreSQLの接続とグラフ描画を楽しむ」😌 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a><br><br>ヤバい、割とネタかぶり😅 <a href="https://t.co/lNyPDv7KvT">pic.twitter.com/lNyPDv7KvT</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1574716336210841600?ref_src=twsrc%5Etfw">September 27, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">PostgreSQLの接続セットアップの方法が動画にまとめられているのでありがたい! <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/9NpXhqqP5f">pic.twitter.com/9NpXhqqP5f</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1574719575509577729?ref_src=twsrc%5Etfw">September 27, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">2人目のLT、 <a href="https://twitter.com/westbaystars?ref_src=twsrc%5Etfw">@westbaystars</a> さんで「LiveBookでTidyverse」😌 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a><br><br>RのdplryのElixir版を作ったみたい😜 <a href="https://t.co/D8bmIfBDZ0">pic.twitter.com/D8bmIfBDZ0</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1574718443710222337?ref_src=twsrc%5Etfw">September 27, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">普段野球は全然見ないけど、データとしてみるのはとても面白い。<br>\tタブ区切りのCSVを読み込んで変数dfに入れて、SQL感覚であれこれできちゃう。<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/hF8CySf1ID">pic.twitter.com/hF8CySf1ID</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1574722463535370240?ref_src=twsrc%5Etfw">September 27, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">普段野球は全然見ないけど、データとしてみるのはとても面白い。<br>\tタブ区切りのCSVを読み込んで変数dfに入れて、SQL感覚であれこれできちゃう。<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/hF8CySf1ID">pic.twitter.com/hF8CySf1ID</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1574722463535370240?ref_src=twsrc%5Etfw">September 27, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">3人目は、私、「LiveView JP恒例『Livebookモブプロ！』みんなでLivebookは入れ替え機能付きdbgを試します」😉 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a><br><br>ElixirConf 2022 USで発表されたLivebookの新フィーチャを紹介しつつ、Elixirパイプ処理をドラッグ＆ドロップで並べ替えたりできるdbg＋Livebookをみんなで一緒に遊びます😋 <a href="https://t.co/DkA8W2GQzZ">pic.twitter.com/DkA8W2GQzZ</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1574733361486368770?ref_src=twsrc%5Etfw">September 27, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">監視系を作れてしまう新機能。dbg機能も面白いけどこっちも大概面白い。<a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a> <a href="https://t.co/rl1eBF8AFX">pic.twitter.com/rl1eBF8AFX</a></p>&mdash; alice (@Alicesky2127) <a href="https://twitter.com/Alicesky2127/status/1574728957312012288?ref_src=twsrc%5Etfw">September 27, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">本日LiveView JP、環境習性祭り😜 <a href="https://twitter.com/hashtag/liveviewjp?src=hash&amp;ref_src=twsrc%5Etfw">#liveviewjp</a><a href="https://t.co/G661NoISvi">https://t.co/G661NoISvi</a><br><br>Livebookがerlang-os-mon無くて動かなかったり、ExplorerがUbuntu 18.04のglibcで動かなかったり、BraveでKino .DataTableが出なかったり…😅<br><br>p.s. <a href="https://twitter.com/torifukukaiou?ref_src=twsrc%5Etfw">@torifukukaiou</a> さんが会をコラム化、ありがたや🙇‍♂️<a href="https://t.co/mUdFmaIVbz">https://t.co/mUdFmaIVbz</a> <a href="https://t.co/TIcUfh2CAh">pic.twitter.com/TIcUfh2CAh</a></p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1574755006439653377?ref_src=twsrc%5Etfw">September 27, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


# 2次会

モブプロ！

![スクリーンショット 2022-09-27 21.12.42.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/cb54fe70-6d0b-4914-e685-9f84279906fa.png)


![スクリーンショット 2022-09-27 21.48.50.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/75b87b9d-cf6b-8801-2914-0be6fe777fbf.png)

![スクリーンショット 2022-09-27 21.49.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ad79cd08-b945-3cdb-20b7-84d9653052cf.png)

![スクリーンショット 2022-09-27 21.50.19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b7d61d02-4e4f-f3f6-39a6-ac55532cb313.png)




---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

2022/09/27(火)に開催された、「[LiveView JP#10：LivebookでキャッチーにElixirを楽しもう](https://liveviewjp.connpass.com/event/260861/)」のレポートを書きました。



以上です。


# 動画

動画が公開されておりました。

<iframe width="1044" height="587" src="https://www.youtube.com/embed/y1OeQMmQk9c" title="LiveView JP#10：LivebookでキャッチーにElixirを楽しもう" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

