---
title: SORACOM x Nerves できたとはいえるとぼくおもいます
tags:
  - Elixir
  - SORACOM
  - Nerves
private: false
updated_at: '2021-12-08T09:25:04+09:00'
id: a7694edb3cc86af062f0
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
[【続】SORACOM x Nerves できたとはいえるとぼくおもいます](https://qiita.com/torifukukaiou/items/efe528f8dbd1012ba37e)
をぜひご参照ください。

# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか:bangbang::bangbang::bangbang:
- [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)と[Nerves](https://www.nerves-project.org/)で、データ通信を楽しみたいとおもいます

## [Nerves](https://www.nerves-project.org/)とは:interrobang:
- [Elixir](https://elixir-lang.org/)というプログラミング言語でIoTを楽しめる、**[ナウでヤングなcoolなすごいやつ](https://www.slideshare.net/takasehideki/elixirnervescool-249038510?ref=https://algyan.connpass.com/)**のことです

## はじめに、おことわり
- この記事でやっていることはあなたが望んでいることとは違うのかもしれません
    - うん、違うとおもいます
    - 私自身が本当にやりたかったこととは違うので...
    - 後半、試してみたこと、これからやってみたいことをまとめます
- わかってはいますが、現時点で私ではできなかったポイントをまとめておきます
    - 自分で解決したい気持ちもありつつ、どなたかから助言なりがないと詰まってしまっておりまして、もっと言うとこの中途半端な状態のままですが、あとを引き取ってくださることを期待して記事にしました

# できたこと
- モバイルWiFiーー[HUAWEI Mobile WiFi E5785](https://consumer.huawei.com/jp/routers/e5785/)に、[SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のSIMをいれて、[Nerves](https://www.nerves-project.org/)アプリと接続してデータ通信することです
    - 私は、[HUAWEI Mobile WiFi E5785](https://consumer.huawei.com/jp/routers/e5785/)を https://www.iijmio.jp/device/?DeviceType=r&DeviceType2=hikari で買いました
    - 家のインターネットが夜になると遅くなってですね、夜の時間帯だけ[HUAWEI Mobile WiFi E5785](https://consumer.huawei.com/jp/routers/e5785/)を使って動画をみたりしています
        - 1日1時間〜2時間で、見ない日もあったりでだいたい月20GBくらいの利用です
        - くしくも20ギガプランでなんとかなっています

![IMG_20210612_132129.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/10e0ed5e-082c-ab37-d225-c7a159090370.jpeg)

## SIMの購入
- [SORACOM Air for セルラーの利用方法（個人・法人）](https://soracom.jp/start/) を参考にSIMを購入します
- 私は、`plan-D`を選びました
- [HUAWEI Mobile WiFi E5785](https://consumer.huawei.com/jp/routers/e5785/)に合うサイズは、マイクロです

## APN設定
- [HUAWEI Mobile WiFi E5785](https://consumer.huawei.com/jp/routers/e5785/)と接続したパソコンのブラウザで、`http://192.168.8.1`にアクセスして、APN設定をします
- 設定方法の詳細は、 https://support.mineo.jp/contract/pdf/e5577_02.pdf などをご参照ください
- [SORACOM Air for セルラーの利用方法（個人・法人）](https://soracom.jp/start/)の値は、https://soracom.jp/start/ をご参照ください

## [Nerves](https://www.nerves-project.org/)アプリの作成
- この記事では割愛します :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
- いくつかリンクを示しておきます

### 公式
- https://hexdocs.pm/nerves/getting-started.html

### 環境構築
- [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
- [ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9)

### Nervesアプリの開発の流れがよくわかる記事
- [ウェブチカでElixir/Nervesに入門する](https://qiita.com/kentaro/items/e8df79aa93b9fe9a567e)

### WiFi設定
- https://hexdocs.pm/vintage_net/cookbook.html#wifi

# [Nerves](https://www.nerves-project.org/) とつないでみる 

## Raspberry Pi 2
- 令和3年なのに、`Raspberry Pi 2`です
    - 我が家では現役バリバリです
- WiFiはついていないので、[WN-G150U](https://www.iodata.jp/product/network/adp/wn-g150u/)をさしてつかいます
- 特に特殊なことは不要で、認識してくれます
- [HUAWEI Mobile WiFi E5785](https://consumer.huawei.com/jp/routers/e5785/)は、2GHzを使いました

## Raspberry Pi 4
- WiFiは搭載されています
- [HUAWEI Mobile WiFi E5785](https://consumer.huawei.com/jp/routers/e5785/)は、5GHzを使いました
    - もしかしたらもう少し待っておけば、2GHzでもつながったのかもしれません
        - 素のRaspberry Pi OSではつながっていたので
    - なかなかつながらなかった(1分くらいは待って待ちきれなくなった)ので、5GHzに変えてみたところすんなりつながりました

## Run
- [Nerves](https://www.nerves-project.org/)にsshして以下を実行しました

```elixir
iex> ifconfig

# wlan0 がそれっぽくあること
```

```elixir
iex> ping "nerves-project.org"
Press enter to stop
Response from nerves-project.org (185.199.110.153): time=3725.777ms
Response from nerves-project.org (185.199.110.153): time=2533.257ms
Response from nerves-project.org (185.199.110.153): time=740.385ms
Response from nerves-project.org (185.199.110.153): time=166.326ms
Response from nerves-project.org (185.199.110.153): time=175.369ms

iex> url = "http://beam.soracom.io:8888"

iex> headers = [{"Content-Type", "application/json"}]

iex> time = Timex.now() |> Timex.to_unix()

iex> json = Jason.encode!(%{value: %{temperature: 100, humidity: 100, time: time}})

iex> HTTPoison.post(url, json, headers)
```

- [Nerves](https://www.nerves-project.org/)アプリ -> [HUAWEI Mobile WiFi E5785](https://consumer.huawei.com/jp/routers/e5785/) -> [SORACOM Beam](https://soracom.jp/services/beam/) -> [Azure仮想マシン](https://azure.microsoft.com/ja-jp/services/virtual-machines/)へのデータ通信が通った様子です





### [Azure仮想マシン](https://azure.microsoft.com/ja-jp/services/virtual-machines/) に自作した[Phoenix](https://www.phoenixframework.org/)アプリ

![スクリーンショット 2021-06-12 12.47.35.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7de479bf-03c2-6681-a278-8e84e8000d3a.png)


# 本当にやりたいこと…… (ある意味ここからが本題)
- [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)等をRaspberry Piにさしてデータ通信する
- これが本当に私がやりたいことです
    - [NervesJP](https://nerves-jp.connpass.com/)の愉快なfolksが期待していることだとおもいます

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a><br>いつでもどこでも温度・湿度が測れます！<br>Raspbian OS + Elixirアプリ(Nervesじゃないよ...) + L-02C(モデム) + SORACOM Air for セルラー(SIM) + ANKERのバッテリー + Phoenixアプリ on Azure VM <a href="https://t.co/ePpnAu5iZE">pic.twitter.com/ePpnAu5iZE</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1388857248173092865?ref_src=twsrc%5Etfw">May 2, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## [wvdial](https://github.com/wlach/wvdial)
- たとえば https://users.soracom.io/ja-jp/guides/usb-dongles/ms2372h-607/raspberrypi/ のページで紹介されている[setup_air.sh](https://soracom-files.s3.amazonaws.com/setup_air.sh)スクリプトでは、[wvdial](https://github.com/wlach/wvdial)コマンドでセルラー通信を開始するように書かれています
- もちろんデータ通信端末が異なれば、ATコマンドのスクリプトも違ったものが必要にはなるのですが、その件については素のRaspberry Pi OSではありますが手前味噌の[団長！　いつでもどこでも温度・湿度が測れるのであります！ (Elixir, SORACOM Air for セルラー)](https://qiita.com/torifukukaiou/items/ed0d80c2af8699875f54)で解決しています
    - [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)に関しては数多くの先人たちの記事がありました
    - 感謝します:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
- ところが、公式に公開されているNerves System[^1]には、[wvdial](https://github.com/wlach/wvdial)なんて無いし、あとから追加することもできません
    - そもそも`pon`コマンドが公式のNerves Systemにはないんです

[^1]: 正確な呼び方とそれが表す範囲はよくわかっていませんが、[Customizing Your Own Nerves System](https://hexdocs.pm/nerves/customizing-systems.html#content)というタイトルからこの記事では`Nerves System`と呼ぶことにしました

## [Customizing Your Own Nerves System](https://hexdocs.pm/nerves/customizing-systems.html#content)
- では道は閉ざされているのかというとそんなことはなくて、リンク先の通りにカスタマイズしてやればいいわけです
- カスタマイズ内容は、https://github.com/nerves-networking/vintage_net_mobile のREADMEの通りにやると、`pon`コマンドが追加されたりします
    - もう少し具体的に試したことは、[Nerves + L-02C(データ通信端末)でデータ通信にトライ(モデムモードにはなりました) (Elixir)](https://qiita.com/torifukukaiou/items/218622e08992a226b540)に書いています
    - READMEの通りでは、[wvdial](https://github.com/wlach/wvdial)コマンドは入ってきません
- `pon`は使えるようになったので、素のRaspbian OS上でうごいた設定ファイルなどを配置して以下を実施してみました
- うんともすんともいわず、セルラー通信がはじまりそうな気配はありません
    - 文字通り、エラーもなにもでないので詰まっています

```
iex> :os.cmd 'mknod /dev/ppp c 108 0'
[]

iex> :os.cmd 'pon soracom'
[]
```

- **ち〜ん**
    - `mknod /dev/ppp c 108 0`はよくわかっていなのですが、`pon soracom`だけやるとエラーメッセージにでてくるので実行しました
    - https://github.com/nerves-networking/vintage_net_mobile/blob/06456c3bcf2e5d18dba21aed0b7452a0ff149c43/lib/vintage_net_mobile.ex#L148
    - にそれっぽい処理はあります
- 私が、コマンドの使い方を間違っている可能性もあります……


## [nerves-networking/vintage_net_mobile](https://github.com/nerves-networking/vintage_net_mobile)
- [Nerves](https://www.nerves-project.org/)的にはあとは、これを利用してデータ通信端末ごとにモデムを作ればいいらしいのですが、私の現時点の力量では作れませんでした
    - なんとなく作ってみたのですがうんともすんともいわず、詰まっている状態です
- あと、もしかしたら日本と海外では事情が若干違うところがあるのではないかとおもっています
    - それは、ユーザー名やパスワードの話が一切[vintage_net_mobile](https://github.com/nerves-networking/vintage_net_mobile)でてきていないことです
        - ユーザー名やパスワードが指定できていないから弾かれているといったところの段階までまだ到達はしていないとおもっていますが、のちのちぶつかりそうなポイントです
    - もちろん、私がちゃんと読めていない可能性はあります


## [wvdial](https://github.com/wlach/wvdial)
- もう一度これに戻ります
- [wvdial](https://github.com/wlach/wvdial)であれば、ユーザー名・パスワードを設定ファイルに指定できるし、https://soracom-files.s3.amazonaws.com/setup_air.sh でも使われているので一番近道な気がします
- 次は、[wvdial](https://github.com/wlach/wvdial)コマンドが使えるようにして試してみたいとおもっています
- **おもっています**
- ただ、いまの私では詰まってしまっています
- 不確かな情報で申し訳ありませんが、以前(2010年代前半)はBuildrootに[wvdial](https://github.com/wlach/wvdial)があったようですがいまはなくなっているようです
- https://hexdocs.pm/nerves/customizing-systems.html#adding-a-custom-buildroot-package をベースに応用問題をやればいいのでしょうが、いまの私には追加方法がわかりませんでした
- `buildroot wvdial`とかで検索すると、https://github.com/Metrological/buildroot/blob/master/package/wvdial/wvdial.mk などそれっぽいものが見つかります
    - 仮にこういったものがコピペで大部分が使えるものだとしても、
    - このファイルの中に書いてある`http://wvdial.googlecode.com/files`にアクセスしても404です
- `apt-get install wvdial`にて、素のRaspbian OSにインストールはできるのできっとなにか方法はあるのだとおもっています
- [wvdial](https://github.com/wlach/wvdial)をよく読んで中でやっていることを再現してしまうという方法もあるとはおもいます

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- [NervesJP](https://nerves-jp.connpass.com/)の愉快なfolksが期待していることとは違うとおもいますし、それはできるよね〜　感がいっぱいだとおもいます
- 引き続き本当にやりたいことを目指して精進をつづけるつもりです(**つもりです**)
- もし、こんなふうにやればいんじゃないのというアドバイス、もしくはもうできたぜ！　という方はぜひぜひお知らせください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

# NervesJP
- ここで[NervesJP](https://nerves-jp.connpass.com/)の紹介です
    - 月1回程度、ワイワイガヤガヤ オンラインで集まっています
    - 次回は、2021/6/23(水) 19:30〜 [NervesJP #18 テストどうやってやっていく回](https://nerves-jp.connpass.com/event/215428/) です
- 愉快なfolksたちがあなたの参加を待っています
- れっつじょいな〜す
- https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk
- ぜひぜひSlackにご参加ください :rocket::rocket::rocket::rocket::rocket:

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/efe3084e-4891-9aa2-0ee3-e053c990ba4c.png)  
