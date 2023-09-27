---
title: '「NervesJP #31 Code BEAM America 2022に行ってきた回」レポート（2022-11-11）'
tags:
  - Elixir
  - Nerves
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-11-11T22:06:49+09:00'
id: 4a930c89506c5c968c6f
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
Advent Calendar 2022 168日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの『[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)』から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

2022/11/11(金)は、「[NervesJP #31 Code BEAM America 2022に行ってきた回](https://qiita.com/torifukukaiou/items/927d9a0e8e2972e7bf08)」が開催されました。
この記事は、イベントのレポートです。



![スクリーンショット 2022-11-11 19.31.28.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/802c30e1-31b7-2ec0-7d79-03ea69bb2c56.png)

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}

iex> "Nerves" |> String.graphemes() |> Enum.frequencies()
%{"N" => 1, "e" => 2, "r" => 1, "s" => 1, "v" => 1}
```

[CODE BEAM AMERICA](https://codebeamamerica.com/)というカンファレンスに、 @takasehideki 先生、 @kikuyuta 先生が登壇されました。
その**凱旋報告会**です。
@Mnishiguchi さんも[CODE BEAM AMERICA](https://codebeamamerica.com/)に参加されたそうです！



# Let's get started!

定刻通り19:30には、はじまりませんでした :sob::sob::sob::sob::sob:
**いつものことです。**

5分くらい参加者の到着を待ちます。
その間、Googleドキュメントに自己紹介などを書くわけです。 

19:35から始まりました。
今日は11月11日つまり、
<font color="purple">$\huge{「ポッキーの日です」}$</font>

それを記念して、第31回を開催します。
出席者は、奇しくも11人です。

![スクリーンショット 2022-11-11 19.46.31.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0f713a6d-7a78-7c9d-6745-1256b1280f4a.png)

最終的には12人参加されていました。

# 自己紹介

まずは自己紹介からです。
新幹線からの参加、カナダのトロントからの参加、アメリカのワシントンDCから参加、NeosVRからの参加といろいろな場所から参加されています。

![スクリーンショット 2022-11-11 19.50.12.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/53037b85-9540-5006-bc08-ed8a5aaedbf5.png)

@piacerex ちゃん in NeosVR



# 資料

この記事で一番大事なところです。
ポイントです。
繰り返し書いておきます。
この記事で一番大事なところです。

**丸腰です。**

<font color="purple">$\huge{資料なしです。}$</font>

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/198295b3-5d4e-36be-cfb6-18a8bef06a8e.png)





---

# イベント本編

イベント本編のレポートです。

@takasehideki 先生の進行です。

## どうしてCODE BEAMでNerves?

CODE BEAMは、Erlangのカンファレンスではない。
[BEAM](https://en.wikipedia.org/wiki/BEAM_(Erlang_virtual_machine))で動く言語だったら何でもいい。
[Elixir](https://elixir-lang.org/)、[Gleam](https://gleam.run/)、[Nerves](https://www.nerves-project.org/)などが対象。

## 写真でふりかえる

久しぶりの海外出張

![スクリーンショット 2022-11-11 19.54.48.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9881b148-f865-9878-0c6d-6fe666befca2.png)

イベントではいろいろと他の写真をみせていただきなら、エピソードも交えておもしろおかしく話してくださいました。
300人中、100人は現地参加。200人はオンラインでの参加とのことです。

デモがうまくいくと聴衆が拍手してくれて、気持ちいいそうです。

## コンピュータの歴史

そろばんから始まる！！！

![スクリーンショット 2022-11-11 20.17.35.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/cf1adba3-4ed8-c9f1-7c14-dacd7fc44a1c.png)

[ENIAC](https://ja.wikipedia.org/wiki/ENIAC)！

たぶん、実物。本物。ものほん。
[ENIAC](https://ja.wikipedia.org/wiki/ENIAC)とは、アメリカで開発された黎明期の電子計算機のことです。

![スクリーンショット 2022-11-11 20.18.19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a5895f0d-1673-98f1-cd47-5d978a31cb11.png)


# いつもジャケット着用

カリフォルニアは寒かった。

![スクリーンショット 2022-11-11 20.26.54.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8a7e9f26-0d2e-db69-7122-aca6bb5197e0.png)


# カンファレンスの話

- updateの話はおもしろかった
- https://jasonaxelson.com/talks/codebeam2022/#/
- https://twitter.com/jj1bdx/status/1588310491910537217

<blockquote class="twitter-tweet"><p lang="en" dir="ltr"><a href="https://twitter.com/hashtag/CodeBEAM?src=hash&amp;ref_src=twsrc%5Etfw">#CodeBEAM</a> America 2022: very glad to see the talks that can be replayed later. Thanks <a href="https://twitter.com/ErlangSolutions?ref_src=twsrc%5Etfw">@ErlangSolutions</a> for let me join the virtual sessions!</p>&mdash; Kenji Rikitake (@jj1bdx) <a href="https://twitter.com/jj1bdx/status/1588310491910537217?ref_src=twsrc%5Etfw">November 3, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# 発表の一部をちらみせ

@kikuyuta 先生

![スクリーンショット 2022-11-11 21.23.51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/61213141-72b8-0ee4-42d6-399115dc5f4b.png)




---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

2022/11/11(金)に開催された、「[NervesJP #31 Code BEAM America 2022に行ってきた回](https://nerves-jp.connpass.com/event/265627/)」のレポートを書きました。

次回は未定です。
12月後半に計画中とのことです。

<font color="red">$\huge{ワクワク}$</font>
です。

![スクリーンショット 2022-11-11 20.23.59.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ca6daf08-ded2-44b1-b19d-b3f04747c75e.png)

![スクリーンショット 2022-11-11 21.09.23.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8720a5bc-2f75-7063-ca60-c61b7717aaa5.png)



以上です。



