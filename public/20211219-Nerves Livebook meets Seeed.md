---
title: Nerves Livebook meets Seeed
tags:
  - Elixir
  - Nerves
  - Seeed
  - autoracex
  - Livebook
private: false
updated_at: '2021-12-22T08:49:06+09:00'
id: 27abc5b84f6f55f85d71
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/advent-calendar/2021/seeed_ug

2021/12/18(土) の回です。
2021/12/19(日) 04:59 くらいに書き終わりました。
遅れて :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Nerves](https://www.nerves-project.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

タイトルはだいぶ**大上段**に構えました。
はじめに言っておくと、この記事の内容は、IoTの猛者だ！　という方には物足りない記事だとおもいます。
次のような人には合うとおもいます。
タンスの肥やしになってしまっているRaspberry Piをお持ちの方です。
そういう方は、久々に引っ張り出してきて電子工作を久しぶりにやってみようかなあという気持ちを湧き起こす、血湧き肉躍る内容にしています。
ついでに、コワくない関数型言語[Elixir](https://elixir-lang.org/)の世界にどっぷり浸かってください。

# What is [Elixir](https://elixir-lang.org/)?, What is [Nerves](https://www.nerves-project.org/)?

**いま**、日本で一番[Nerves](https://www.nerves-project.org/)を楽しんでいる三銃士です。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">今日はこんな感じで、nerves/elixirハンズオン“ライブ“やったよ！<br>（右の三人 <a href="https://twitter.com/hashtag/nervesjp?src=hash&amp;ref_src=twsrc%5Etfw">#nervesjp</a> 勢www<a href="https://twitter.com/hashtag/wwest?src=hash&amp;ref_src=twsrc%5Etfw">#wwest</a> <a href="https://t.co/zNEdwhXjPI">https://t.co/zNEdwhXjPI</a></p>&mdash; myasu🍊12/25Liella!1st福井,&#39;22/2虹4th,&#39;22/3Aqours6th (@etcinitd) <a href="https://twitter.com/etcinitd/status/1472175583379726343?ref_src=twsrc%5Etfw">December 18, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

[NervesJP](https://nerves-jp.connpass.com/)勢、左から @myasu さん、 @takasehideki 先生、 @pojiro さん。

[Nerves](https://www.nerves-project.org/)は、IoTを[Elixir](https://elixir-lang.org/)で楽しめる**[ナウでヤングでcoolなすごいやつ](https://speakerdeck.com/takasehideki/nerveshanaudeyangunacoolnasugoiyatu-for-soracom-ug)**です。

[Nerves](https://www.nerves-project.org/)は、誤解を恐れずに言えば**[Elixir](https://elixir-lang.org/)専用OS**!!! という言い方が一番しっくりきます。
だって、`ssh`で中に入ったら `iex>` ~~しかできないし~~ で一生[Elixir](https://elixir-lang.org/)だけを楽しめます:rocket::rocket::rocket:

なんだろう:interrobang:　と心がざわついた方、ワクワクが止まらない方、ロマンチックを止めたい方はぜひ、[NervesJPのSlackワークスペース](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)に飛び込んできてください。
IoTや[Nerves](https://www.nerves-project.org/)、[Elixir](https://elixir-lang.org/)が大好きなfolksたちが**熱烈歓迎**します :tada::tada::tada:

Let's join us!
<font color="purple">$\huge{れっつじょいなす！}$</font>

# 電子工作を楽しむ

ボタンを押したらLEDが光り、離したら消えるという動作をさせたいとおもいます。

[Seeed](https://www.seeed.co.jp/)さんの製品を使いまして、手先が「[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40s)」な私でもはめ込み式で電子工作を楽しめます。

LEDをつなげるところは、「[Raspberry Piで学ぶ電子工作](https://www.amazon.co.jp/dp/4065193397)[^1]」:book:を参考にしています。

[^1]: 本当のことを正確に言うと、私は古い本を持っています。奥付には、「2014年12月24日 第2刷発行」と書いてあります。

<iframe width="909" height="511" src="https://www.youtube.com/embed/76GrqrCYnTI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

| 部品 | 価格(2021/12/09) |
|:-|-:|
|[Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)  | 1,244円  |
|[Grove ボタン - Grove Button](https://jp.seeedstudio.com/Grove-Button-p-2809.html)   | 240円  |
| ブレッドボード、抵抗、LED、ジャンパーワイヤー  | 忘れました(詰め合わせセットみたいなものを買いました)  |

# Nerves Livebook Setup

簡単です。
動画を用意しました。
ご覧になってください。

<iframe width="831" height="467" src="https://www.youtube.com/embed/-c4VJpRaIl4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

詳しくは、[ココ](https://qiita.com/torifukukaiou/items/117cc23963b55ae3fc5d#nerves-livebook-1)をご参照ください。

わからないことがありましたらぜひ、[NervesJPのSlackワークスペース](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)に飛び込んできてください。
IoTや[Nerves](https://www.nerves-project.org/)、[Elixir](https://elixir-lang.org/)が大好きなfolksたちがあなたの訪れを**熱烈歓迎**します :tada::tada::tada:

# プログラム(Notebookを書く)

![スクリーンショット 2021-12-19 4.25.53.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0b3960ca-180a-a4aa-6ccc-f7fd42a34a32.png)

画像だと写経が苦行になるとおもいますので、コードを載せておきます。


## 点灯夫さん

巨人のエースナンバー18を背負っています。
私は世代的に桑田真澄投手を思い出します。

```elixir
defmodule Lamplighter do
  def on do
    run(1)
  end

  def off do
    run(0)
  end

  defp run(state) do
    {:ok, gpio} = Circuits.GPIO.open(18, :output)
    Circuits.GPIO.write(gpio, state)
  end
end
```

## ボタンを押した離しのイベントを受け止めるモジュール

「[思い切って僕の胸に飛び込んで来てほしい](http://www5.nikkansports.com/baseball/kiyohara/reprint/lions/entry-67779.html)」
巨人の背番号5番といえば、世代的に岡崎郁選手を思い出します。

が、ここは長嶋茂雄監督(当時)の胸に飛び込んできた清原和博選手の巨人時代の背番号5番を使います。

```elixir
defmodule HelloNerves.Observer do
  use GenServer

  require Logger

  @input_pin 5

  def start_link(state \\ %{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_info({:circuits_gpio, @input_pin, _timestamp, 1}, state) do
    Logger.debug("Received rising event on pin #{@input_pin}")
    Lamplighter.on()
    {:noreply, state}
  end

  @impl true
  def handle_info({:circuits_gpio, @input_pin, _timestamp, 0}, state) do
    Logger.debug("Received falling event on pin #{@input_pin}")
    Lamplighter.off()
    {:noreply, state}
  end
end
```

## モジュールは定義しただけでは動きませぬ、Runです :rocket: 

```elixir
HelloNerves.Observer.start_link()
```

## ボタン押したり、離したりしたら、`HelloNerves.Observer`に通知するプログラム

```elixir
{:ok, input_gpio} = Circuits.GPIO.open(5, :input)
Circuits.GPIO.set_interrupts(input_gpio, :both, receiver: HelloNerves.Observer)
```

駆け足で説明しました。

何度でもいいます。
わからないことがありましたらぜひ、[NervesJPのSlackワークスペース](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)に飛び込んできてください。
IoTや[Nerves](https://www.nerves-project.org/)、[Elixir](https://elixir-lang.org/)が大好きなfolksたちがあなたの訪れを**熱烈歓迎**します :tada::tada::tada:

<iframe width="909" height="511" src="https://www.youtube.com/embed/76GrqrCYnTI" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

:tada::tada::tada: 

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:
Enjoy [Nerves](https://www.nerves-project.org/) :bangbang::bangbang::bangbang:

**いま**、日本で一番楽しんでいる人たちです。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">今日はこんな感じで、nerves/elixirハンズオン“ライブ“やったよ！<br>（右の三人 <a href="https://twitter.com/hashtag/nervesjp?src=hash&amp;ref_src=twsrc%5Etfw">#nervesjp</a> 勢www<a href="https://twitter.com/hashtag/wwest?src=hash&amp;ref_src=twsrc%5Etfw">#wwest</a> <a href="https://t.co/zNEdwhXjPI">https://t.co/zNEdwhXjPI</a></p>&mdash; myasu🍊12/25Liella!1st福井,&#39;22/2虹4th,&#39;22/3Aqours6th (@etcinitd) <a href="https://twitter.com/etcinitd/status/1472175583379726343?ref_src=twsrc%5Etfw">December 18, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

ぜひ、[NervesJPのSlackワークスペース](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)に飛び込んできてください。
IoTや[Nerves](https://www.nerves-project.org/)、[Elixir](https://elixir-lang.org/)が大好きなfolksたちがあなたの訪れを**熱烈歓迎**します :tada::tada::tada:


## 追伸

上記の写真は、「次年度のSWESTのネタ試し！なWWEST(実行委員を中心とした内輪的なWinter Workshop Embedded System Technology)を下呂の水明館」での一コマです。
温泉、_うらまやしいです〜[^2]_

[^2]: 野暮なことは言わないでください。わかってて書いています。本当に**うらやましい**。うらやましすぎて、ちゃんと言えなくなった様を表しています。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">次年度のSWESTのネタ試し！なWWEST(実行委員を中心とした内輪的なWinter Workshop Embedded System Technology)を下呂の水明館で開催中です．今回のWWESTのテーマはハイブリッド！ <a href="https://twitter.com/hashtag/WWEST?src=hash&amp;ref_src=twsrc%5Etfw">#WWEST</a> <a href="https://t.co/1zph7k4hff">pic.twitter.com/1zph7k4hff</a></p>&mdash; SWEST_JP(SWEST23は無事終了しました) (@SWEST_JP) <a href="https://twitter.com/SWEST_JP/status/1472097521397039109?ref_src=twsrc%5Etfw">December 18, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>





