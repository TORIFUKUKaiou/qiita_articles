---
title: Grove - Buzzer をNervesで鳴らす
tags:
  - RaspberryPi
  - Elixir
  - Nerves
  - Seeed
private: false
updated_at: '2020-12-20T19:39:42+09:00'
id: 19fecf95b9313b8a2b8a
organization_url_name: fukuokaex
slide: false
---
この記事は[Seeed UG Advent Calendar 2020](https://qiita.com/advent-calendar/2020/seeed_ug) 14日目です。
前日は、「[Grove Base HAT for RasPiは真っ直ぐグイっとさす](https://qiita.com/torifukukaiou/items/81f2a75bee0f919224ad)」でした。

---

# はじめに
- [Grove - Buzzer](https://www.seeedstudio.com/Grove-Buzzer.html)を[Nerves](https://www.nerves-project.org/)から鳴らしてみようとおもいます
- さっそくいろいろなものをつなげてやってみるの実践です
- `D16`に挿してみました

![IMG_20201213_233816.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/57011d77-7e12-119b-c636-e4d41d23bdd9.jpeg)


# 準備とかいろいろ
- 前回の「[Grove Base HAT for RasPiは真っ直ぐグイっとさす -- Nerves](https://qiita.com/torifukukaiou/items/81f2a75bee0f919224ad#nerves)」をご参照ください

# Run
- 今回もとりあえずssh接続して`IEx`(Elixir's interactive shell)でやってみます

```
$ ssh nerves.local 
```

```elixir
Interactive Elixir (1.11.2) - press Ctrl+C to exit (type h() ENTER for help)
Toolshed imported. Run h(Toolshed) for more info.
RingLogger is collecting log messages from Elixir and Linux. To see the
messages, either attach the current IEx session to the logger:

  RingLogger.attach

or print the next messages in the log:

  RingLogger.next

iex(1)> {:ok, gpio} = Circuits.GPIO.open(16, :output)
{:ok, #Reference<0.1045830398.268566543.199724>}
iex(2)> Circuits.GPIO.write(gpio, 1)
:ok
```

- けっこう大きい音がします
- 「**<font color="purple">フ、ピェ〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜</font>**」ってずーっと鳴ります :speaker: 
- 止めるには

```elixir
iex(3)> Circuits.GPIO.write(gpio, 0)
:ok
```

- 子供のときに夜中にフエをふくと :snake: がでるからやめなさい[^1]と注意されたことをおもいだしました

[^1]: いまこれを書いているの 23:31 :sleeping: で、記事にするからには本当に鳴るよねって確かめるために、静かな田舎の集合住宅でちょいちょい鳴らしています。ごめんなさい :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree: 
- 手先が不器用な私でも工作できる！
    - 目覚ましアラームでボタン押すまで鳴らし続けるとかにつかえそう
        - 他にはCI失敗だとか、サービスの監視で異常検知時にとか
    - ただ、たいがいの時間で止めないと家に不在のときにそこそこ近所迷惑になりそう
    - そのくらい音がけっこうでかい :speaker: っちいうことですね
    - 小っちゃなボディだけど音がパワフル :punch::punch_tone1::punch_tone2::punch_tone3::punch_tone4::punch_tone5:
- [GrovePi+ Starter Kit for Raspberry Pi A+,B,B+&2,3,4 (CE certified)](https://www.seeedstudio.com/GrovePi-Starter-Kit-for-Raspberry-Pi-A-B-B-2-3-CE-certified.html)
    - いろいろ入っていて楽しめそう！！！
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket: 
- (って、アドベントカレンダーこんなんでいいですよね！ :relaxed:)


次回は、@mongonta0716さんで「[初心者向けWioTerminalの始め方【VisualStudioCode+PlatformIO編】](https://raspberrypi.mongonta.com/howto-start-wioterminal-with-vscode/)」です。
引き続きお楽しみください。
