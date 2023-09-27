---
title: Nerves meets SORACOM (Elixir)
tags:
  - Elixir
  - SORACOM
  - Nerves
  - 40代駆け出しエンジニア
  - autoracex
private: false
updated_at: '2021-12-08T11:41:25+09:00'
id: 3a77efc82c48dc0ff61e
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/advent-calendar/2021/nervesjp

2021/12/08(水)の回です。
前日は、@mnishiguchi さんによる「[Elixir Circuits.I2CをMoxする](https://qiita.com/mnishiguchi/items/7fda38e6becfd57d6d8a)」でした。
私が見てみぬふりをして、避けて通ってきてしまった[Behaviours](https://elixirschool.com/en/lessons/advanced/behaviours/)をしっかり理解されています。
すごい:rocket:
@mnishiguchiの背中を追います。

# はじめに
[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang:
[Nerves](https://www.nerves-project.org/)を楽しんでいますか:bangbang:

https://qiita.com/torifukukaiou/items/117cc23963b55ae3fc5d

の続きです。

[SORACOMさん](https://soracom.jp/) with [Nerves](https://www.nerves-project.org/)を楽しむためには、3つの方法があります。

1. [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のSIM + ドングルを使う(ただし、Nerves Systemをカスタマイズする必要がある)
1. WiFiルータに[SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)を差し込み、[Nerves](https://www.nerves-project.org/)アプリはふつうのWiFi接続でイゴかす[^1]
1. **[SORACOM Arc](https://soracom.jp/services/arc/)を利用する(SIMやドングルは不要。ただし、Nerves Systemをカスタマイズする必要がある。WireGuardさえ追加できればいいはず)**

3番を推していきたいです。
SIMやドングルなしに[SORACOM Arc](https://soracom.jp/services/arc/)さんと接続して、いろいろなサービスを楽しんでいくことができます。

推していきたいのですが、私の[Buildroot](https://buildroot.org/)力ではビルドができませんでした:sob:
**できませんでした、エラーログ貼っておくから、あとはだれか俺の屍を無駄にしないでくれ、よろしゅうたのんます** みたいな〜記事です。

本当によろしくお願いたします！

[^1]: 「イゴかす」の意。おそらく西日本の方言、たぶん。NervesJPではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^2]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg=

[^2]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。


# [SORACOM Arc](https://soracom.jp/services/arc/)

> SORACOM Arc は任意の IP ネットワークから SORACOM プラットフォームへのセキュアなリンクを提供するサービスです。 お客様は SORACOM Air だけでなく、WiFi や有線通信、衛星通信といったあらゆる IP ネットワークから SORACOM の各種プラットフォームサービスをセキュアにご利用いただけます。

---
> 1 アカウントあたりバーチャル SIM/Subscriber 1契約分の基本使用料(月額)、1GB 分のデータ通信料を無料枠としてご提供いたします。
なお、1 アカウントあたり 1 回に限り、バーチャル SIM/Subscriber の初期費用が無料となります。

![arc-overview01.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c396b062-0da7-902e-7eec-c3200119dd00.png)

(https://soracom.jp/services/arc/ :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)

https://users.soracom.io/ja-jp/docs/arc/
に詳しく書いてあります。

# [SORACOMさん](https://soracom.jp/) with [Nerves](https://www.nerves-project.org/)を楽しむ3つの方法

## 1. [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のSIM + ドングルを使う(ただし、Nerves Systemをカスタマイズする必要がある)

https://qiita.com/torifukukaiou/items/efe528f8dbd1012ba37e

をご参照ください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

上記の記事のサマリです。
まず[Nerves](https://www.nerves-project.org/)の基礎知識を身につけた上で、

https://hexdocs.pm/nerves/customizing-systems.html#content

https://github.com/nerves-networking/vintage_net_mobile#system-requirements

の２つをよく読んで進めればやっていることはだいたい理解できます。


### [Nerves](https://www.nerves-project.org/)の基礎知識

以下のコマンドの意味がわかれば十分です。
プロジェクトつくって、ビルドして焼いているだけです。

```
$ mix nerves.new hello_nerves
$ cd hello_nerves
$ export MIX_TARGET=rpi4
$ mix deps.get
$ mix firmware
$ mix burn
```

`mix burn`でmicroSDカードにファームウェアを焼き込んでいます:fire::fire::fire:
そのこんがり焼き上がったmicroSDカードをRaspberry Pi 4にでも差し込んで電源ONするだけです。
簡単です:rocket::rocket::rocket::rocket::rocket:



## 2. WiFiルータに[SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)を差し込み、[Nerves](https://www.nerves-project.org/)アプリはふつうのWiFi接続でイゴかす[^1]

https://qiita.com/torifukukaiou/items/a7694edb3cc86af062f0

をご参照ください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

![IMG_20210612_132129.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/10e0ed5e-082c-ab37-d225-c7a159090370.jpeg)


## 3. [SORACOM Arc](https://soracom.jp/services/arc/)を利用する(SIMやドングルは不要。ただし、Nerves Systemをカスタマイズする必要がある。WireGuardさえ追加できればいいはず)

:::note warn
私にはできませんでした。
:::

:::note
どなたか私の屍を踏みつけにして「できたよ〜」記事を書いてください:bow::bow::bow::bow::bow:
:::

まず[Nerves](https://www.nerves-project.org/)でやる前に、基本?の[Raspberry Pi OS](https://www.raspberrypi.com/software/)にて[SORACOM Arc](https://soracom.jp/services/arc/)を試してみました。
**これはできました**:rocket::rocket::rocket:

https://users.soracom.io/ja-jp/docs/arc/create-virtual-sim-and-connect-with-wireguard/

:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:の記事の通りに進めるとよいです。

あとは

https://hexdocs.pm/nerves/customizing-systems.html#content

https://www.wireguard.com/install/#buildroot-module-tools

の通りにやればよいはずです。
**はず**です。
私にはできませんでした:sob::sob::sob::sob::sob::sob::sob:

### やったことの詳細

- 開発マシンで[Docker](https://www.docker.com/)をイゴかして[^1]おきます。
- [Nerves](https://www.nerves-project.org/)アプリが作れるように各種ミドルウェア? を開発マシンに[セットアップ](https://hexdocs.pm/nerves/installation.html#content)しておきます。

https://hexdocs.pm/nerves/customizing-systems.html#content

の通りに進めます。
[SORACOM](https://soracom.jp/)さんからもらった接続情報(`wg0.conf`)は以下のように配置しておけばいいはずです。(あくまでも**はず**です)

```
~/projects
├── custom_rpi4
│   └── nerves_defconfig ※ WireGuard追加してみた
└── your_project
│   └── etc
│       ├── iex.exs
│       └── wireguard
│           └── wg0.conf
```

**`custom_rpi4`**は、ビルドできないもの:sob:で情けないですが参考になるかもしれないので醜態をさらしておきます。

https://github.com/TORIFUKUKaiou/custom_rpi4/tree/update-wireguard

`update-wireguard`というなぞのブランチ名がこれまた**にくい**です。

てな感じにして

```
$ export MIX_TARGET=custom_rpi4
$ mix deps.get
$ mix firmware
```

です。
マシンスペックにもよるとおもいますが丸1日くらいかかるとみておいたほうがいいです。
必要なのは**覚悟**です。

途中、こんなログがでていたので期待大です！

```
>>> rpi-firmware 1.20211007 Downloading.....
>>> rpi-userland 97bc8180ad682b004ea224d1db7b8e108eda4397 Downloading.
>>> uboot-tools 2021.07 Downloading..
>>> wireguard-linux-compat 1.0.20210606 Downloading
```

ですが、最終結果は失敗でした。

```
>>> wireguard-linux-compat 1.0.20210606 Extracting
>>> wireguard-linux-compat 1.0.20210606 Patching
>>> wireguard-linux-compat 1.0.20210606 Configuring
>>> wireguard-linux-compat 1.0.20210606 Building
>>> wireguard-linux-compat 1.0.20210606 Building kernel module(s)could not compile dependency :custom_rpi4, "mix compile" failed. You can recompile this dependency with "mix deps.compile custom_rpi4", update it with "mix deps.update custom_rpi4" or clean it with "mix deps.clean custom_rpi4"
==> your_project
** (Mix) The Nerves Docker build_runner encountered an error while building:

-----
      |  ^~~~~
In file included from <command-line>:
/nerves/build/build/wireguard-linux-compat-1.0.20210606/src/compat/compat.h:43:2: error: #error "WireGuard has been merged into Linux >= 5.6 and therefore this compatibility module is no longer required."
   43 | #error "WireGuard has been merged into Linux >= 5.6 and therefore this compatibility module is no longer required."
      |  ^~~~~
In file included from <command-line>:
/nerves/build/build/wireguard-linux-compat-1.0.20210606/src/compat/compat.h:43:2: error: #error "WireGuard has been merged into Linux >= 5.6 and therefore this compatibility module is no longer required."
   43 | #error "WireGuard has been merged into Linux >= 5.6 and therefore this compatibility module is no longer required."
      |  ^~~~~
make[3]: *** [scripts/Makefile.build:280: /nerves/build/build/wireguard-linux-compat-1.0.20210606/src/main.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[3]: *** [scripts/Makefile.build:280: /nerves/build/build/wireguard-linux-compat-1.0.20210606/src/device.o] Error 1
make[3]: *** [scripts/Makefile.build:280: /nerves/build/build/wireguard-linux-compat-1.0.20210606/src/noise.o] Error 1
make[2]: *** [Makefile:1825: /nerves/build/build/wireguard-linux-compat-1.0.20210606/src] Error 2
make[1]: *** [package/pkg-generic.mk:271: /nerves/build/build/wireguard-linux-compat-1.0.20210606/.stamp_built] Error 2
make: *** [Makefile:23: _all] Error 2

-----

See /Users/yamauchi/nervesProjects/soracom/custom_rpi4/build.log.
```

失敗している:sob::sob::sob::sob::sob:

[Buildroot](https://buildroot.org/)力が無さすぎてググろうにもググれないです。
人は想像力の範囲内で生きています。
知らないことには想像力が及ばないのです。
だから謙虚に誰からも教えを乞う、そういう姿勢で処世していけば大方誤りは少ないものです。

@Yametaro さんの「[ググって解決しづらかったこと](https://qiita.com/advent-calendar/2021/gseach)」カレンダーへの投稿が一瞬頭をよぎったのですが、私は解決できていないので[#NervesJP](https://qiita.com/advent-calendar/2021/nervesjp)が空いていたし、こちらに投稿しました。

エラーログをもう一度、よ〜く眺めてみると、

> "WireGuard has been merged into Linux >= 5.6 and therefore this compatibility module is no longer required."

えっ、まさか最初から入っているの？　と期待をして、[Nerves](https://www.nerves-project.org/)にsshで入って以下のようにして`wg-quick`コマンドがあるのか調べてみました。
期待した私が馬鹿でした。
当然そんなシロモノは入っていませんでした。

```elixir
$ ssh nerves.local

iex> System.find_executable("wg-quick")
nil

iex> System.find_executable("wg")
nil

System.find_executable("ip")      
"/sbin/ip"
```

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[SORACOMさん](https://soracom.jp/) with [Nerves](https://www.nerves-project.org/)を楽しむためには、3つの方法があります。

1. [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のSIM + ドングルを使う(ただし、Nerves Systemをカスタマイズする必要がある)
1. WiFiルータに[SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)を差し込み、[Nerves](https://www.nerves-project.org/)アプリはふつうのWiFi接続でイゴかす[^1]
1. **[SORACOM Arc](https://soracom.jp/services/arc/)を利用する(ただし、Nerves Systemをカスタマイズする必要がある。WireGuardさえ追加できればいいはず)**

私には解決できませんでしたが、
**俺、わたし、[Buildroot](https://buildroot.org/)バリバリっす。[Nerves](https://www.nerves-project.org/)楽しそうですね！** ってな具合でスゴイ人が解決してくださることを祈って、筆をおきます。

https://soracomug-tokyo.connpass.com/event/231532/

このイベントがすんごく楽しみです。

---

# [NervesJP](https://nerves-jp.connpass.com/)

最後に[NervesJP](https://nerves-jp.connpass.com/)コミュニティをご紹介します。

[NervesJPのSlackワークスペース](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)にご参加ください。
IoTや[Nerves](https://www.nerves-project.org/)のことが好きな愉快なfolksたちがあなたの訪れを**熱烈歓迎**します!!!
<font color="purple">$\huge{れっつじょいなす}$</font>

朗報です。

https://qiita.com/advent-calendar/2021/nervesjp

[#NervesJP](https://qiita.com/advent-calendar/2021/nervesjp)アドベントカレンダーにはまだ若干の空きがございます。

> ぶっちゃけNerves関係ないけど，こんなんやってみたよ！ (ElixirかIoTくらいは絡んでいればおけ

ですので、みなさま奮ってご参加ください。
ネタがかぶったとか全然おけ:ok:です。
2番煎じ、3番煎じ、N番煎じ万歳です。
そんな細かいことは気にしなくていいです。
その積み重ねは発展です。進展です。:rocket::rocket::rocket:
そうやって人類は進化を続けているのです。





