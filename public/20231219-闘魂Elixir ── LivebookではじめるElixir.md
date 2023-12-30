---
title: 闘魂Elixir ── LivebookではじめるElixir
tags:
  - Elixir
  - AdventofCode
  - 40代駆け出しエンジニア
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-20T02:01:36+09:00'
id: fd4abeef77790a61e7f5
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


https://qiita.com/advent-calendar/2023/elixir


# はじめに

今年もいよいよやってまいりました！ :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: 

本日2023/12/19(火)は、「[e-ZUKA Tech Night vol.60 -宇宙開発の今-](https://ezukatechnight.doorkeeper.jp/events/165473)」が開催されます。
そのLT資料であり兼アドベントカレンダー記事です。
LT中に投稿します。

現状の23記事が24記事にカウントアップするはずです。

![スクリーンショット 2023-12-19 14.44.57.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b886d726-db32-87f4-8299-1ff1c13ff308.png)

果たして！

![スクリーンショット 2023-12-20 1.49.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ec500349-d378-e774-1841-108289551eba.png)

:tada::tada::tada::tada::tada: 

# アドベントカレンダーとは?

> アドベントカレンダー (Advent calendar) は、クリスマスまでの期間に日数を数えるために使用されるカレンダーである。

> インターネット上などで、12月の1日から25日までに、特定のテーマに沿って毎日ブログなどに記事を投稿していくという企画がある。

(ウィキペディア [アドベントカレンダー](https://ja.wikipedia.org/wiki/%E3%82%A2%E3%83%89%E3%83%99%E3%83%B3%E3%83%88%E3%82%AB%E3%83%AC%E3%83%B3%E3%83%80%E3%83%BC) より)


## Qiita Advent Calendarとは？

![スクリーンショット 2023-12-19 14.46.12.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/495d3c9e-766a-523f-8a2e-0ec56adeafaa.png)

ざっくり言うと「祭り」だと私は解釈しています。
**あくまでも私個人の解釈です。**

## なんでいっぱい書くの？

お人形さんをもらえるからです。

https://qiita.com/advent-calendar/2023/present-calendar

![スクリーンショット 2023-12-19 15.09.02.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/244c458a-2d27-5df2-f2e3-bb2fe6e6cca9.png)

# 猪木さんと宇宙

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">アントニオ猪木の場合。<a href="https://twitter.com/hashtag/%E3%81%82%E3%81%AA%E3%81%9F%E3%81%8C%E8%80%83%E3%81%88%E3%81%A6%E3%81%84%E3%82%8B%E3%81%93%E3%81%A8%E3%81%AF?src=hash&amp;ref_src=twsrc%5Etfw">#あなたが考えていることは</a> <a href="https://twitter.com/hashtag/%E5%91%B3%E3%81%AE%E3%83%97%E3%83%AD%E3%83%AC%E3%82%B9?src=hash&amp;ref_src=twsrc%5Etfw">#味のプロレス</a> <a href="https://t.co/7TNGCVBOLG">pic.twitter.com/7TNGCVBOLG</a></p>&mdash; アカツキ☀味のプロレス (@buchosen) <a href="https://twitter.com/buchosen/status/1208232980637872128?ref_src=twsrc%5Etfw">December 21, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# AIブームですよね！

AI = artificial intelligence

<b><font color="red">$\huge{AI = アントニオ猪木！！！}$</font></b>

# それで

今日はきっと、北九大の @zacky1972 先生のお話のなかできっと[Elixir](https://elixir-lang.org/)というプログラミング言語がキーワードとしてでてくるとおもいます。
（**でてこなかったら、そういうことにしてください**）

[Elixir](https://elixir-lang.org/)というプログラミング言語、おもしろそうだなと思ったそこのあなたのために入門記事をささげます。

# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があるのですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

![スクリーンショット 2023-12-19 14.53.41.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e84ab0ef-28ec-0b71-475a-fffa3741e872.png)

# [Livebook](https://livebook.dev/)

[Livebook](https://livebook.dev/)とは、[Elixir](https://elixir-lang.org/)製のノートプックです。

![スクリーンショット 2023-12-19 14.57.05.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3004942e-f0cc-ef2a-16a7-2dbc0878a273.png)


## [Dockerで動かす方法](https://github.com/livebook-dev/livebook?tab=readme-ov-file#docker)

[Dockerで動かす方法](https://github.com/livebook-dev/livebook?tab=readme-ov-file#docker)を紹介します。

https://github.com/livebook-dev/livebook?tab=readme-ov-file#docker

リンク先のコマンドをご参照ください。

```bash
docker run -p 8080:8080 -p 8081:8081 --pull always ghcr.io/livebook-dev/livebook
```

# [Elixir](https://elixir-lang.org/)のプログラム例

[Elixir](https://elixir-lang.org/)のプログラム例を示します。

```elixir
Mix.install([{:req, "~> 0.4.8"}])

"https://qiita.com/api/v2/items?query=tag:Elixir&per_page=10"
|> Req.get!(pool_timeout: 50000, receive_timeout: 50000)
|> Map.get(:body)
|> Enum.map(fn post -> Map.take(post, ["title", "url"]) end)
```

[Qiita API v2](https://qiita.com/api/v2/docs)を使って、[Elixirタグ](https://qiita.com/tags/elixir)の記事を取得しています。
[|>](https://hexdocs.pm/elixir/1.15.7/Kernel.html#%7C%3E/2)はパイプ演算子といいます。前の計算結果を次の関数の第1引数にいれて、関数を評価(実行)してくれます(evaluate)。

@RyoWakabayashi さんが、[Livebook](https://livebook.dev/)に関する良記事をたくさんかかれています！
**ありがとうーーーーッ！！！　でございます。**

# アドベントカレンダーになにを書いたらいいのさ！？

[Advent of Code](https://adventofcode.com/2023)や競技プログラミングサイト[AtCoder](https://atcoder.jp/)の過去問なんていかがでしょうか。（**祭りなので**）

![スクリーンショット 2023-12-19 15.06.46.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0d964f35-54e0-0c16-c098-4acbe23d09b5.png)



# さいごに

「[e-ZUKA Tech Night vol.60 -宇宙開発の今-](https://ezukatechnight.doorkeeper.jp/events/165473)」のLTの場をお借りして、[Livebook](https://livebook.dev/)ではじめる[Elixir](https://elixir-lang.org/)をお届けしました。


人類は不老不死の霊薬を意味する素敵なプログラミング言語[Elixir](https://elixir-lang.org/)を手に入れました。並行処理を他のプログラミング言語よりも比較的容易に書くことができます。それはきっとコンピュータ資源を有効活用できることにつながるでしょう。巡り巡って世界平和に貢献できることでしょう。

さあ、そこのあなたも[Elixir](https://elixir-lang.org/)の世界へようこそ。
_手始めに[エリクサーチ](https://elixir-lang.info/)なんていかがでしょうか。私のオススメです。_

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
