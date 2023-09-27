---
title: '[Elixir][LINE] ごみ出し日に LINE で通知する'
tags:
  - Elixir
  - LINE
  - Nerves
  - 40代駆け出しエンジニア
private: false
updated_at: '2021-02-26T23:05:46+09:00'
id: 2757b5685cb215809fe9
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- @QUANONさんの「[[Ruby][LINE] ごみ出し日に LINE で通知する](https://qiita.com/QUANON/items/ccfe650a30bd6068a5f4)」をみまして、私は[Nerves](https://nerves-project.org/)でぜひやってみようとおもいました
- [Line Notify](https://notify-bot.line.me/ja/)を使うためのトークン取得は、これまた@QUANONさんの「[自分の LINE に Ruby で通知を送る](https://qiita.com/QUANON/items/94f8835e923c76188f66)」という記事が詳しいです
- 2021/03/08(月)開催予定の[autoracex #N](https://autoracex.connpass.com/event/205982/)の成果としておきます

# What is [Nerves](https://nerves-project.org/) ?
- [Elixir](https://elixir-lang.org/)のIoTで、[ナウでヤングでcoolなすごいやつ](https://www2.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)です

# 環境構築
- 楽しむためには少しの準備が必要です
- [Nerves](https://nerves-project.org/)の準備をしましょう
- @takasehideki 先生の記事がオススメです
  - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
  - [ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9)

# [Nerves](https://nerves-project.org/)アプリの開発
- ここから先は、Nervesアプリ開発の経験がおアリ:ant:の前提で書きます
- おいて行かないでくれ〜　これからだよ〜　という方は、@kentaroさんの「[ウェブチカでElixir/Nervesに入門する](https://qiita.com/kentaro/items/e8df79aa93b9fe9a567e)」がオススメです

# いつものおなじみごった煮プロジェクト[TORIFUKUKaiou/hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)プロジェクトにおしこみます


## 依存している[Hex](https://hex.pm/)
- [Timex](https://github.com/bitwalker/timex)
- [HTTPoison](https://github.com/edgurgel/httpoison)
- [Quantum](https://github.com/quantum-elixir/quantum-core)


## 今日は何が捨てられるの？

```elixir:lib/hello_nerves/trash_day.ex
defmodule HelloNerves.TrashDay do
  def run do
    now = Timex.now() |> Timex.shift(hours: 9)
    day_of_week = Date.day_of_week(now)
    week_of_month = Timex.week_of_month(now)

    do_run(day_of_week, week_of_month)
  end

  defp do_run(day_of_week, _week_of_month) when day_of_week == 1 or day_of_week == 4 do
    msg("可燃ごみ")
    |> post()
  end

  defp do_run(3, week_of_month) when week_of_month == 2 or week_of_month == 4 do
    msg("空き缶・空き瓶")
    |> post()
  end

  defp do_run(3, 1) do
    msg("不燃ごみ")
    |> post()
  end

  defp do_run(_day_of_week, _week_of_month), do: nil

  defp msg(trash), do: "#{trash}の日です。忘れずに捨てましょう！"

  defp post(msg), do: HelloNerves.LineNotify.post(msg)
end
```
- `day_of_week`は曜日で、1が月曜日〜7が日曜日です
- `week_of_month`は月の何週目かを表しています
- 私が住んでいる地域ではこれらの2つでゴミ収集の内容がきまるので`do_run/2`でパターンを書きました

## Lineで通知

```elixir:lib/hello_nerves/line_notify.ex
defmodule HelloNerves.LineNotify do
  @url "https://notify-api.line.me/api/notify"
  @token System.get_env("HELLO_NERVES_LINE_NOTIFY_TOKEN")
  @headers [Authorization: "Bearer #{@token}"]

  def post(msg) do
    HTTPoison.post(@url, {:form, [message: msg]}, @headers)
  end
end
```

- @eielhさんの「[HTTPoisonでx-www-form-urlencodedでPOST](https://qiita.com/eielh/items/8eb8302b4b75758764c9)」を参考にしました
    - ありがとうございます！

## cronライク
```elixir:config/config.exs
config :hello_nerves, HelloNerves.Scheduler,
  jobs: [
    {"1 22 * * *", {HelloNerves.TrashDay, :run, []}}
  ]
```

- 今回の記事の肝は上記3つのファイルです
    - とはいえ、すでにあるプロジェクトに足したのでいろいろ省略しているところがあります
- 省略しているところは、ごった煮プロジェクト[TORIFUKUKaiou/hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)をご参照ください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- `config`でゴミ収集日を変更したりできるようにすれば汎用的になるのかもしれませんが、私の家だけで使っているごった煮プロジェクトですので一番簡単な実装方法を採りました
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket:


# (最後の最後に)[Elixir](https://elixir-lang.org/)ってなによ？、[Nerves](https://nerves-project.org/)ってなによ? という方へ

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/601aeb87-9d1d-6a9d-b30b-338507dc593e.png)

- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: 2020/12/26時点くらいのスクリーンショット
- [Elixir](https://elixir-lang.org/)についてもっと知りたい方は下記の本:books:をオススメします
    - [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/)
    - [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021)
- 手前味噌ですが、毎週月曜日に[autoracex](https://autoracex.connpass.com/)というもくもく会を開催しております
    - [Slack elixirjp.slack.com](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w)の`#autoracex`というチャンネルにおります
    - わからないことなどお気軽におたずねください
    - そのほか[connpass](https://connpass.com/dashboard/)を`Elixir`で検索していただくといろいろなコミュニティがみつかります


**ありがとナイス:flag_cn:！**


## [Nerves](https://nerves-project.org/)が気になったあなたへ

れっつじょいなす(Let's join us) :bangbang::bangbang::bangbang:
:point_down::point_down_tone1::point_down_tone2::point_down_tone3::point_down_tone4::point_down_tone5: 
[NervesJP Slackへの参加URL](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)
:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: 

愉快なfolksたちがあなたの訪れをお待ちしております :tada::tada::tada::tada::tada:


![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/447253f9-3060-8bb7-7132-7754ef4aead5.png)

