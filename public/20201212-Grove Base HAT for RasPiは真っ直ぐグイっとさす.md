---
title: Grove Base HAT for RasPiは真っ直ぐグイっとさす
tags:
  - RaspberryPi
  - Elixir
  - Nerves
  - Seeed
private: false
updated_at: '2021-05-08T15:22:38+09:00'
id: 81f2a75bee0f919224ad
organization_url_name: fukuokaex
slide: false
---
# はじめに
- @matsujirushi さんの[だれか書いてくれないかなー（過疎ってる](https://twitter.com/matsujirushi12/status/1334305032313786370) をみてしまいまして、
- 一種の**義侠心**です
- [Grove Base HAT for RasPi](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)は真っ直ぐグイっとさすのだということを書いておきます

![IMG_20201203_212332.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ababea10-c620-6cd8-7ae9-bbf9c4190a6b.jpeg)

# そんな当たり前のことをなぜ書いたの？
- 経緯を書きます
- ここからが長いです :smile: 
- [Seeed UG Advent Calendar 2020](https://qiita.com/advent-calendar/2020/seeed_ug)に参加していらっしゃる方にとっては、そしていまこの記事を書いている時点の私にとっても当たり前のことになりましたが、

![20201227p.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9e31c417-508f-6cee-cd02-9cdd0ed1aaf7.jpeg)

- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: このセットが手元に届いたとき**私は固まりました**
    - RasPi4
    - [Grove Base HAT for RasPi](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)
    - [Grove Button(P)](https://wiki.seeedstudio.com/Grove-Button/)
    - [Grove Green LED](https://wiki.seeedstudio.com/Grove-Red_LED/)
    - [Grove AHT20 I2C (温湿度センサ)](https://wiki.seeedstudio.com/Grove-AHT20-I2C-Industrial-Grade-Temperature%26Humidity-Sensor/)
    - AC-DCアダプタ（Type-C, 5V3A）
    - microSDカード（16 GB)
- かろうじて、`RasPi4`、`AC-DCアダプタ` 、`microSDカード`はわかります
    - 令和2年なのにいまだに**Raspberry Pi 2**を使っているからです
- そのくらいの経験はあるのですが他のものはさっぱりわかりませんでした
- 話が前後しますが私がこのセットをいただいたのは
- [【オンライン】豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/)でハンズオンのお手伝いをしているからです
    - [Seeed株式会社](https://www.seeed.co.jp/):santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:様からのクリスマスプレゼントとのことありがとうございます!!! 
- で、いろいろあって図入りの説明書(イベントの台本みたいなもの)をいただいたのですが、[Grove Base HAT for RasPi](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)を`RasPi4`にどこまで差し込んでいいものやらはじめわかりませんでした
    - あんまり力まかせにやるとピンを曲げやしないか
    - ふわっと乗せるだけでいいんかなあ？
    - どうして思い切る気になったのかは忘れました(画像検索した!?)
    - とにかくドキドキ、ヒヤヒヤしながら差し込みました
    - **スピード・スリル・サスペンス 飯塚オート**です
    - 素人は躊躇しがちなんです
- 長々と書きましたが無事、組み立てられました
- この記事のタイトルからするとここまでで終わりです
- それではちょっと寂しいので、
- ハードウェア的なことよりはやや私の得意な[Nerves](https://www.nerves-project.org/)の話を以下書きます

# [Nerves](https://www.nerves-project.org/)
- [NervesはElixirのIoTでナウでヤングなcoolなすごいヤツです:rocket:](https://twitter.com/torifukukaiou/status/1201266889990623233) です
    - [Nerves](https://www.nerves-project.org/)を作っている[Justin Schneckさん](https://twitter.com/mobileoverlord)が、:+1: しているので間違いないです
- [Grove Green LED](https://wiki.seeedstudio.com/Grove-Red_LED/)と[Grove Button(P)](https://wiki.seeedstudio.com/Grove-Button/)を差し込んで、`IEx`(Elixir's interactive shell)から光らせたり、ボタンの状態を取得してみます
- 軽くできる :rocket::rocket::rocket:


## 環境構築
以下ご参考にされてください。

- 公式の[Getting Started](https://hexdocs.pm/nerves/getting-started.html#content)
- @takasehideki先生の[ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
- @takasehideki先生の[ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9)
- @kentaroさんの[ウェブチカでElixir/Nervesに入門する](https://qiita.com/kentaro/items/e8df79aa93b9fe9a567e)

# mix nerves.new

```
$ export MIX_TARGET=rpi4
$ mix nerves.new good_evening_nerves
$ cd good_evening_nerves
```

```elixir:mix.exs
 defp deps do
    [
      # Dependencies for all targets
      {:nerves, "~> 1.7.0", runtime: false},
      {:shoehorn, "~> 0.7.0"},
      {:ring_logger, "~> 0.8.1"},
      {:toolshed, "~> 0.2.13"},

      # Dependencies for all targets except :host
      {:nerves_runtime, "~> 0.11.3", targets: @all_targets},
      {:nerves_pack, "~> 0.4.0", targets: @all_targets},

      # Dependencies for specific targets
      {:nerves_system_rpi, "~> 1.13", runtime: false, targets: :rpi},
      {:nerves_system_rpi0, "~> 1.13", runtime: false, targets: :rpi0},
      {:nerves_system_rpi2, "~> 1.13", runtime: false, targets: :rpi2},
      {:nerves_system_rpi3, "~> 1.13", runtime: false, targets: :rpi3},
      {:nerves_system_rpi3a, "~> 1.13", runtime: false, targets: :rpi3a},
      {:nerves_system_rpi4, "~> 1.13", runtime: false, targets: :rpi4},
      {:nerves_system_bbb, "~> 2.8", runtime: false, targets: :bbb},
      {:nerves_system_osd32mp1, "~> 0.4", runtime: false, targets: :osd32mp1},
      {:nerves_system_x86_64, "~> 1.13", runtime: false, targets: :x86_64},

      {:circuits_gpio, "~> 0.4"} # add
    ]
  end
```

```
$ mix deps.get
```

- Wi-Fiの設定
    - 必要に応じて(`ssh`接続して便利なので私はいつも設定している)
    - [https://hexdocs.pm/vintage_net/cookbook.html#wifi](https://hexdocs.pm/vintage_net/cookbook.html#wifi)

```elixir:config/target.exs
config :vintage_net,
  regulatory_domain: "US",
  config: [
    {"usb0", %{type: VintageNetDirect}},
    {"eth0",
     %{
       type: VintageNetEthernet,
       ipv4: %{method: :dhcp}
     }},
    {"wlan0",
     %{
       type: VintageNetWiFi,
       vintage_net_wifi: %{
         networks: [
           %{
             key_mgmt: :wpa_psk,
             ssid: System.get_env("MY_NETWORK_SSID"),
             psk: System.get_env("MY_NETWORK_PSK"),
           }
         ]
       },
       ipv4: %{method: :dhcp}
     }}
  ]
```

```
$ mix firmware
```

- microSDカードをパソコンに挿しまして

```
$ mix burn
```

- こんがり焼き上がりましたら、RasPi4に挿して、そうですね〜 1分くらい瞑想でもしながら待ちますか
- ポクポクちーん


```
$ ssh nerves.local
```

## `IEx`でLEDつけよう :bulb:
- `ssh`すると`IEx`(Elixir's interactive shell)が立ち上がるのでそこに[Elixir](https://elixir-lang.org/)のプログラム書きます

```elixir
iex> {:ok, gpio} = Circuits.GPIO.open(16, :output)
{:ok, #Reference<0.4009724731.268566546.204049>}
iex> Circuits.GPIO.write(gpio, 1)
:ok
```
- `D16`っちゆうところに挿しているので、`16`を[Circuits.GPIO.open/3](https://hexdocs.pm/circuits_gpio/Circuits.GPIO.html#open/3)しています

- ついた:bulb:

![IMG_20201212_225058.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/75d9ff9e-a1f2-48ec-b7f4-ad089d3dbd97.jpeg)


- 消すときは:point_down::point_down_tone1::point_down_tone2::point_down_tone3::point_down_tone4::point_down_tone5:

```elixir
iex> Circuits.GPIO.write(gpio, 0)
:ok
```

## ボタン押したときの入力を受け取ろう

```elixir
iex> {:ok, gpio} = Circuits.GPIO.open(5, :input)  
{:ok, #Reference<0.4009724731.268566546.204050>}  
iex> Circuits.GPIO.read(gpio)
0
```
- ボタンは、`D5`っちゆうところに挿しているので、`5`を[Circuits.GPIO.open/3](https://hexdocs.pm/circuits_gpio/Circuits.GPIO.html#open/3)しています
- 押していないときは0が返ります

```elixir
iex> Circuits.GPIO.read(gpio)
1
```

- 押しながら[Circuits.GPIO.read/1](https://hexdocs.pm/circuits_gpio/Circuits.GPIO.html#read/1)すると、`1`が返ります!!!
- ボタン押したら、光らせるとかももちろんできるのですが、**[Grove Base HAT for RasPi](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)は真っ直ぐグイっとさす**ことだけが言いたい記事で、それだと寂しいので[Nerves](https://www.nerves-project.org/)を引っ張りだしてきて、長々書きましたが、だんだん[^1]明後日の方向に行き始めたのでここらへんで筆を置きます
- 真っ直ぐグイっと挿した[Grove Base HAT for RasPi](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)のおかげで簡単にボタンとかLEDとか取り付けることができて、手先が不器用な私でもいろいろなものをつけたり外したりができそうで、いろいろやってみよう！　という気になってきました
- 私と同じように、ハードウェアに自信がなかったり、手先が不器用な方は、モジュール(っていえばいいんですかね)を探しに[https://www.seeedstudio.com/](https://www.seeedstudio.com/)へGo!!! :rocket::rocket::rocket:
- 私の不器用具合をご紹介 
    - 抵抗だなんだといろいろ不器用につなげたもの
    - [サイコロをつくる(Elixir, Nerves)](https://qiita.com/torifukukaiou/items/5577f7c79c0723f514d8)

![https___qiita-image-store.s3.ap-northeast-1.amazonaws.com_0_131808_bf1f08d7-5933-caf5-b5f9-6b4ef0a822b9.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/441231c6-71bc-99ec-2d01-1bb86a7c63d7.jpeg)

[^1]: はじめから！？

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- [Grove Base HAT for RasPi](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)は真っ直ぐグイっとさす
- [Seeed株式会社](https://www.seeed.co.jp/):santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:様ありがとうございます!!!
- Enjoy [Elixir](https://elixir-lang.org/)!!! :rocket::rocket::rocket:



