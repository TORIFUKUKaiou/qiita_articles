---
title: '団長！　いつでもどこでも温度・湿度が測れるのであります！ (Elixir, SORACOM Air for セルラー)'
tags:
  - Azure
  - RaspberryPi
  - Elixir
  - SORACOM
  - L-02C
private: false
updated_at: '2021-06-13T18:49:55+09:00'
id: ed0d80c2af8699875f54
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://www.lp.soracom.jp/202104-soracom-raspberry-pi-contest

# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか:bangbang::bangbang::bangbang:
- この記事は[2021年4月19日〜5月31日 | ソラコム主催 ラズパイコンテスト](https://www.lp.soracom.jp/202104-soracom-raspberry-pi-contest)の応募記事です
- いつでもどこでも温度・湿度を測ってみたくなりました

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr"><a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a><br>いつでもどこでも温度・湿度が測れます！<br>Raspbian OS + Elixirアプリ(Nervesじゃないよ...) + L-02C(モデム) + SORACOM Air for セルラー(SIM) + ANKERのバッテリー + Phoenixアプリ on Azure VM <a href="https://t.co/ePpnAu5iZE">pic.twitter.com/ePpnAu5iZE</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1388857248173092865?ref_src=twsrc%5Etfw">May 2, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# IoTシステムを作った背景
- <font color="purple">$\huge{いつでもどこでも}$</font>
- <font color="purple">$\huge{温度・湿度を測りたくなりました}$</font>
- `I want`なのです
- `I enjoy`なのです
- それ以上の理由はありません
- やりたくなってしまったことはもう仕方ありません
- 誰にも止められません
- なにか問題があってそれを解決しましたというようなことは私の場合にはありません
- この記事がヒントとなって、どなたかのsomething badを改善することになればそれは望外の喜びです
- あえて探すとすれば、私は[Elixir](https://elixir-lang.org/)というプログラミング言語が好きです
    - 分類すると関数型言語にあたるのだそうです
    - そんな小難しそうなことを私は説明できませんが、そんなことを意識することなしに、楽しめる素敵なプログラミング言語ーーそれが[Elixir](https://elixir-lang.org/)なのです
- その[Elixir](https://elixir-lang.org/)製のIoTフレームワークである[**ナウでヤングでcoolな**](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)[Nerves](https://www.nerves-project.org/)というものがあります
- 当面の目標は、この[Nerves](https://www.nerves-project.org/)にデータ通信端末を差し込んで、いつでもどこでも通信を楽しみたいとおもっています
- `I want to enjoy`なのです
- ただ、いきなり[Nerves](https://www.nerves-project.org/)アプリとして作るのはいろいろハードルがありそうでまずは先人の方々の記事が豊富にある[Raspberry Pi OS](https://www.raspberrypi.org/software/operating-systems/)にてはじめてみたいとおもいます
    - (そうしないとコンテストの締め切りに間に合う気がしないので……)

## 実際の使用例
- Raspberry Pi 4(with [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/))を持って外へ出よう
- 私は**進撃の巨人**を[Netflix](https://www.netflix.com/)でみました
- みてしまいました
    - 巨人の方々に注目してみています
- 日田の[大山ダム](https://shingeki-hita.com/spot/001.html)というところに超大型巨人が出現するということを聞きました[^1]
- 私は調査兵団に期待する善良な一般市民です
- もしかすると巨人の出現と気温・湿度にはなにかしらの関連があるのではないかという**仮説**をたてました
- 塀の内側からではありますが測定を実施したいとおもいました
- この記事は言わば地下室の資料に相当するものであり、この記録が人類滅亡の危機を救う一助となることを切に願っています

![02-Anywhere-can-be-measuredのコピー.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7937cc1c-4e96-7876-d102-8cb0f0e3e3cf.png)



![スクリーンショット 2021-05-08 18.38.49.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4b74de43-26fa-f751-ac7e-8149b5e40f70.png)

- 出不精のデブな私がdevをして、そして外にでたということで、そうです! まさに**普段の(※私の)生活を豊かにした**作品なのです


[^1]: [進撃の日田](https://shingeki-hita.com/guidance.html)というスマホアプリ

# 必要なパーツの紹介

| パーツ | 必須? | 価格(おおよそ) |備考|
|:-----------|------------:|------------:|:--------|
| [特定地域向け IoT SIM (plan-D)](https://soracom.jp/store/5261/) | Yes | 903円 | いの一番に持ってきました。もちろん必須です。[L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)で使う場合には標準サイズです。価格は初期費用です。別途、月額費用(基本料金とデータ通信量に応じた従量課金)が必要です。詳細は、 https://soracom.jp/services/air/cellular/price_specific_area_sim/ をご参照ください。あとで[SORACOM BEAM](https://soracom.jp/services/beam/)も使ってみますので必須です。まず[SORACOM IoTストア](https://soracom.jp/store/)で買い求めましょう。|
| [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html) | Yes | 生産終了(600円〜6,000円) | 他のデータ通信端末でも可。むしろ[SORACOM IoTストア](https://soracom.jp/store/)で取り扱っているものを使ったほうがいろいろ詰まるところは少ないのかもしれません。そういう意味では必須ではないのですがこの記事ではL-02Cでのことのみを取り扱いますので必須としておきます。発売初期のころに買いました。なぜ買ったのかは忘れました。その後、SIMは解約しました。父に言われたことを思い出して、地下室の奥に眠っていたものを引っ張り出してきました。|
| Raspberry Pi 4 / 4GB       | Yes       |   7,700円       | |
| microSD       | Yes       |   1,500円       | 8GBを使いました。 Class 10。|
| [Anker PowerCore 10000](https://www.amazon.co.jp/dp/B019GNUT0C)       | Yes       | 2,799円         | モバイルバッテリー|
|USB-C & USB-A ケーブル|Yes|1,000円|Raspberry Pi 4とモバイルバッテリーを接続 |
| [Grove AHT20 I2C温度および湿度センサー 工業用グレード](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html) | Yes | 513円 | |
| [Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html) | Yes | 1,037円 | 手先が器用な方には不要だったりするのかもしれませんが、[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40s)な私でも、はめ込み式でIoTを楽しめます! |
|[Azure 仮想マシン](https://azure.microsoft.com/ja-jp/services/virtual-machines/)|Yes||データ打ち上げ先を自作しました。もちろん、[Elixir](https://elixir-lang.org/)製のWebアプリケーションフレームワーク[Phoenix](https://www.phoenixframework.org/)を使いました。|
|[ヒートシンク](https://www.switch-science.com/catalog/5986/)| No |374円| ある意味、必須なのかも。まじRaspberry Pi 4ってアチチ:fire:になるので。 |
|[ケース](https://www.switch-science.com/catalog/5987/) | No |1,298円 |外に連れ出すならケースをつけておいたほうが持ち運びやすいかも。お好みで。|
|スピーカー|No||外に持ち出さないときに目覚ましアラームとしてがんばってもらいます。音は、お家のネットワークにつないでおいてニュースと天気予報を取得して、それを音声データにして流します。|


## 開発時にあったほうがよいもの
- パソコン
    - 私はmacOS 10.15.7を使いました
    - パソコンは必須です
- SDカードリーダー 
    - microSDカードに[Raspberry Pi OS](https://www.raspberrypi.org/software/operating-systems/)をPCで焼くときに使います
- AC-DCアダプタ（Type-C, 5V3A）
    - 開発時にRaspberry Pi 4の給電に使います
- LANケーブル
    - 開発時にRaspberry Pi 4をお家LANにつながってもらうために使います

# IoTシステムの構成図

![スクリーンショット 2021-05-08 17.35.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/79fa947c-66e3-e9ad-8c80-201b4ee74851.png)

- Raspberry Pi OS上では[Elixir](https://elixir-lang.org/)のプログラムが、[Grove AHT20 I2C温度および湿度センサー 工業用グレード](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)を使って温度・湿度を取得しています
- 温度・湿度データは、[SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)の回線を使って[SORACOM Beam](https://soracom.jp/services/beam/)へhttpで送ります
- [Azure仮想マシン](https://azure.microsoft.com/ja-jp/services/virtual-machines/)では[Phoenix](https://www.phoenixframework.org/)を使って自作したWebアプリケーションがhttpsのAPIを公開しています
- [SORACOM Beam](https://soracom.jp/services/beam/) -> [Azure仮想マシン](https://azure.microsoft.com/ja-jp/services/virtual-machines/)間は、[SORACOM Beam](https://soracom.jp/services/beam/)のおかげでhttps通信となります
- [Phoenix](https://www.phoenixframework.org/)アプリケーションは表示用のURLを公開していてそこにアクセスすると、温度・湿度のデータを読み取ることができます
    - [Phoenix](https://www.phoenixframework.org/)アプリとブラウザ(図ではスマホ)の間はWebSocketで通信しています
    - そんなまわりくどいことせんでRaspberry Piに表示モジュールくっつけたらいいんじゃないの? というご指摘はごもっともです
    - 繰り返しになりますが、私は`I enjoy`、`I want`でやっているだけでなにかの解決を目指しているわけではありません
    - IoT機器は測定だけしてそこからのさきの分析やらなんとかやらはクラウドに任せるという構成はよくある例だとおもいますのでそれをやってみたかったのです
    - またなんの自慢にもなりませんが、表示モジュールを使いこなせていないという事情もあります……
        - 自分のできることを組み合わせて作品にする
        - 「そこがいいんじゃない!」と聞こえてきそうです[^2]

[^2]: https://www.hontai.or.jp/find/vote2021.html

## 画像
- https://users.soracom.io/ja-jp/resources/icon-set/
- https://docs.microsoft.com/ja-jp/azure/architecture/icons/
- https://elixir-lang.org/
- https://www.phoenixframework.org/

# 簡単な手順書
- 募集要項に従ってつけたタイトルです
    - だって参加賞は絶対にもらいたいですもん
- ここから少々長いですが、できあがりを持っている私には間違いなく、すべからく**簡単な手順**です

## 手順のもくじ(たったの8ステップ!!!)
- ① パーツを組み立てる
- ② Raspberry Pi OSを焼く
- ③ ssh接続、I2C有効化
- ④ Elixirのインストール
- ⑤ [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のアクティベート
- ⑥ PhoenixアプリをAzureにデプロイ
- ⑦ Raspberry Pi 4 で動かすElixirプログラムを書く
- ⑧ Run (イゴかす)

## ① パーツを組み立てる
- [Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)は真っ直ぐグイっとさしてください
    - ピンを折りやしないかと不安になってしまうかもしれませんが迷わず、真っ直ぐグイっとさしてください
    - 首の裏にたたきこむ要領です

![IMG_20201203_212332.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ababea10-c620-6cd8-7ae9-bbf9c4190a6b.jpeg)

- [Grove AHT20 I2C温度および湿度センサー 工業用グレード](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)はI2Cと書いてあるところに挿してください
    - この記事、先頭の写真を参考にしてください

## ② Raspberry Pi OSを焼く
- パソコンでの操作です
- [Raspberry Pi OS](https://www.raspberrypi.org/software/)
- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:にRaspberry Pi Imagerというツールがあるのでインストールします 
- あとはmicroSDカードをパソコンに挿して、Raspberry Pi Imagerをなんとなく雰囲気で触ってもらえればこんがり焼き上がります
- OSは`Raspberry Pi OS (32-bit)`を選びました
    - Recommendedと書いてある一番上のやつです

### HDMIケーブルを持っていないのでsshでつないで作業ができるようにします
- 焼き上がったら一度microSDカードを抜いてまた挿します
- 私のmacOSではmicroSDカードが`/Volumes/boot`というところにマウントされました
- `ssh`という空のファイルをつくっておきます
    - Could you please refer to [SSH (Secure Shell)](https://www.raspberrypi.org/documentation/remote-access/ssh/README.md) ?
    - 空の`ssh`ファイルをつくるというのは、:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: をご参照ください

```
$ cd /Volumes/boot
$ touch ssh
```

- microSDカードをRaspberry Pi 4に挿しこみ、LANケーブルもつないで電源ON!
- この時点では、はやる気持ちをおさえて、[L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)をまだ取り付けないほうが吉です
    - 私はこわくて試してはいませんが、うまくブートできないといった記事を見ました

## ③ ssh接続、I2C有効化
- パソコンでの操作です
- `ping raspberrypi.local`で反応があったらssh接続をします

```
$ ssh pi@raspberrypi.local

pi@raspberrypi:~ $ 
pi@raspberrypi:~ $ uname -a
Linux raspberrypi 5.10.17-v7l+ #1403 SMP Mon Feb 22 11:33:35 GMT 2021 armv7l GNU/Linux
```
- 初期パスワードは`raspberry`です
- このまま進めるのもアレなのでsshの設定を変更しておきます

### sshの設定変更
- この記事を読んでいる人ならお持ちであろう`id_rsa`で接続できるようにします
    - お持ちではない場合は、
    - macOSの場合、`man ssh-keygen`と聞いてみてください
    - けっこうながいので、`ssh-keygen`でググってみるとよいです
    - 「`man ssh-keygen`と聞いてみだくだい」と一次情報にあたることをすすめておきながら、私自身はちゃんと読んだことはありません :sweat: 
- まずパソコン側で

```
$ cat ~/.ssh/id_rsa.pub | pbcopy
```
- とでもして、公開カギをコピーします
- この内容をRaspberry Piのほうの`/home/pi/.ssh/authorized_keys`に書き込みます

```
pi@raspberrypi:~ $ cd /home/pi
pi@raspberrypi:~ $ mkdir .ssh
pi@raspberrypi:~ $ nano .ssh/authorized_keys
```

```
pi@raspberrypi:~ $ chmod 600 ~/.ssh/authorized_keys 
pi@raspberrypi:~ $ chmod 700 ~/.ssh
pi@raspberrypi:~ $ sudo nano /etc/ssh/sshd_config
```

- `/etc/ssh/sshd_config`にはたくさんの設定があるのですが以下のような設定をしました

```:/etc/ssh/sshd_config
PermitRootLogin no
PasswordAuthentication no 
PermitEmptyPasswords no
UsePAM no 
```

```
pi@raspberrypi:~ $ sudo service ssh reload
```
- これで`/home/pi/.ssh/authorized_keys`に書き込まれた公開カギに対応する秘密鍵をもっているマシンからのみsshできるようになりました
- 詳しくは[Securing your Raspberry Pi](https://www.raspberrypi.org/documentation/configuration/security.md)をご参照ください
    - よく読むと`pi`ユーザーも消して、新しくユーザを作るともっと安全だよとかいろいろ書いてあります
    - この記事ではこのまま`pi`で行きます

## I2Cを有効化
- [Grove AHT20 I2C温度および湿度センサー 工業用グレード](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)を使います
- 商品名にもある通りI2Cを使います

```
pi@raspberrypi:~ $ sudo raspi-config
```
- 使い方は、[raspi-config](https://www.raspberrypi.org/documentation/configuration/raspi-config.md)をご参照ください
- [3 Interface Options] > [P5 I2C] > [Yes]
- 横→キーを2回おしてFinish

## スピーカーから音が鳴ることを確かめておく(オプション)
- Raspberry Piを外へ持ち出さないときは家のネットワークにつないで目覚ましアラームをしてもらいます
- Raspberry Piにスピーカーを接続して音が鳴ることを確かめておきます
- https://github.com/raspberrypi/documentation/blob/master/usage/demos/README.md
- https://github.com/raspberrypi/documentation/blob/master/usage/demos/hello-audio.md

```
pi@raspberrypi:~ $ cd /opt/vc/src/hello_pi
pi@raspberrypi:/opt/vc/src/hello_pi $ ./rebuild.sh

pi@raspberrypi:/opt/vc/src/hello_pi $ cd hello_audio/
pi@raspberrypi:/opt/vc/src/hello_pi/hello_audio $ ./hello_audio.bin
```

- 鳴りました :speaker: 
- Ctl + C

## ④ Elixirのインストール
- ssh越しにRaspberry Piに[Elixir](https://elixir-lang.org/)をインストールします
- @takasehideki 先生の「[ElixirでIoT#1.1：IoTボードへのElixir環境の構築とEEloTツールキットの紹介 - ソースからビルド](https://qiita.com/takasehideki/items/fc570ae92a895caed213#%E3%82%BD%E3%83%BC%E3%82%B9%E3%81%8B%E3%82%89%E3%83%93%E3%83%AB%E3%83%89)」を参考に適宜最新バージョンなどで読み替えてインストールを進めます

```
pi@raspberrypi:~ $ sudo apt-get update
pi@raspberrypi:~ $ sudo apt-get install m4 libncurses5-dev libssl-dev git fop openjdk-8-jdk xsltproc libxml2-utils unixodbc-dev libwxgtk3.0-dev
pi@raspberrypi:~ $ wget http://erlang.org/download/otp_src_23.3.tar.gz
pi@raspberrypi:~ $ tar xzvf otp_src_23.3.tar.gz
pi@raspberrypi:~ $ cd otp_src_23.3/
pi@raspberrypi:~/otp_src_23.3 $ ./configure --enable-hipe
pi@raspberrypi:~/otp_src_23.3 $ make -j4
pi@raspberrypi:~/otp_src_23.3 $ sudo make install
pi@raspberrypi:~/otp_src_23.3 $ cd ../
pi@raspberrypi:~ $ git clone https://github.com/elixir-lang/elixir.git
pi@raspberrypi:~ $ cd elixir/
pi@raspberrypi:~/elixir $ git checkout v1.11.4
pi@raspberrypi:~/elixir $ make clean test
pi@raspberrypi:~/elixir $ sudo make install
```

## ⑤ [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のアクティベート

- この記事のメインコンテンツです
- 先人の方々の記事に助けられました
- ありがとうございます
    - https://www.ingenious.jp/articles/howto/raspberry-pi-howto/l-02c/
    - https://www.totalsolution.biz/raspberry-pi-2_soracomair/
    - https://sakura.io/blog/2019/02/22/smc-catm1/
- [SORACOMユーザーコンソール](https://console.soracom.io/)にログインして「受け取り確認」をしておきます

![soracom-0.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3eccb761-e348-667c-3b79-8f022ae9a202.png)

![soracom-1.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0c8fb511-6ab7-09ab-9607-b64474acfaa1.png)

- 速度クラスは一番料金のかからない「s1.minimum」にしておきました


```
pi@raspberrypi:~ $ sudo apt-get install wvdial cu
```
- `usb_modeswitch`のインストールが必要とされている記事もありますが、最近のRaspberry Pi OSの場合は必要ないようです
- `/etc/wvdial.conf`を編集します

```
pi@raspberrypi:~ $ sudo nano /etc/wvdial.conf
```

```:/etc/wvdial.conf
[Dialer Defaults]
Init1 = ATH
Init2 = ATZ
Init2 = ATQ0 V1 E1 S0=0 &C1 &D2
Init3 = AT+CGDCONT=1,"IP","soracom.io"
Modem Type = Analog Modem
Baud = 9600
Modem = /dev/ttyUSB2
Phone = *99***1#
Username = sora
Password = sora
New PPPD = yes
Dial Attempts = 3
Dial Command = ATD
Stupid Mode = yes
Carrier Check = no
Auto DNS = yes
Check DNS = yes
Check Def Route = yes
Auto Reconnect = yes
```

- APN設定は、https://soracom.jp/start/ に書いてあります
    - ちなみに[SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のSIMが到着するまで待てなくて、手元にある[AEON MOBILE](https://aeonmobile.jp/)のnanoSIMにアダプタをつけてやってみたところ通信できました
    - [AEON MOBILE](https://aeonmobile.jp/)のAPN設定は、https://aeonmobile.jp/apn/#type1 をご参照ください
- [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)にSIMを挿して、Raspberry Pi 4にさしこみます
- 側面が白く光ったら、ATコマンドを打ち込みます

```
pi@raspberrypi:~ $ cu -l /dev/ttyUSB2
```

```
ATZ

AT+COPS=1,2,"44010"
```

- `AT+COPS=1,2,"44010"`は反応が戻ってくるまで少し時間がかかります
- これを紹介している記事は見当たらなかったので効果のほどは怪しいのですが、`AT+COPS=1,2,"44010"`をしておくと後ほど行う接続にてIPアドレスが振られることが多くなったようにおもいます
    - 私の家の電波状況とかそういうものが関係しているのかもしれませんが、`AT+COPS=1,2,"44010"`をしていない場合はちっともIPアドレスがふられる気配はありませんでした
    - `AT+COPS=1,2,"44010"`を行ったあとからは、IPアドレスがすぐにふられるようになったので私には意味のあるもののようにみえています
- ちなみに440がMCC(Mobile Country Code)=日本で、10がMNC(Mobile Network Code)=docomoの意味です
    - https://economical.zendesk.com/hc/ja/articles/900001145186-MCC-MNC%E3%81%AB%E5%85%A5%E3%82%8C%E3%82%8B%E6%95%B0%E5%AD%97%E3%82%92%E6%95%99%E3%81%88%E3%81%A6%E3%81%8F%E3%81%A0%E3%81%95%E3%81%84-
- しばらくまって`OK`が返ってきたら、`~.`と入力してください
- これでATコマンドを入力するモードから抜けます
    - `ssh`がきれてしまう場合がありましたがまた`ssh`で入り直しましょう

```
pi@raspberrypi:~ $ sudo wvdial &
```

```
pi@raspberrypi:~ $ --> WvDial: Internet dialer version 1.61
--> Initializing modem.
--> Sending: ATH
ATH
OK
--> Sending: ATQ0 V1 E1 S0=0 &C1 &D2
ATQ0 V1 E1 S0=0 &C1 &D2
OK
--> Sending: AT+CGDCONT=1,"IP","soracom.io"
AT+CGDCONT=1,"IP","soracom.io"
OK
--> Modem initialized.
--> Sending: ATD*99***1#
--> Waiting for carrier.
ATD*99***1#
CONNECT
--> Carrier detected.  Starting PPP immediately.
--> Starting pppd at Sat May  8 14:18:42 2021
--> Pid of pppd: 13193
--> Using interface ppp0
--> local  IP address xx.xx.xx.xx
--> remote IP address xx.xx.xx.xx
--> primary   DNS address xx.xx.xx.xx
--> secondary DNS address xx.xx.xx.xx
```

- こんな感じの表示がでたら成功です

```
pi@raspberrypi:~ $ sudo route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         192.168.1.1     0.0.0.0         UG    202    0        0 eth0
10.64.64.64     0.0.0.0         255.255.255.255 UH    0      0        0 ppp0
192.168.1.0     0.0.0.0         255.255.255.0   U     202    0        0 eth0
```

- こんな感じになっているとおもいます
- [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)で外と通信するように設定変更します
    - 詳しいことはあんまりわかっておりません :sweat_smile: 
    - [大山ダム](https://shingeki-hita.com/spot/001.html)でデータが打ち上がっていたので大丈夫でしょう

```
pi@raspberrypi:~ $ sudo route del default
pi@raspberrypi:~ $ sudo route add default dev ppp0
pi@raspberrypi:~ $ sudo route
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
default         0.0.0.0         0.0.0.0         U     0      0        0 ppp0
10.10.10.10     0.0.0.0         255.255.255.255 UH    0      0        0 ppp0
192.168.1.0     0.0.0.0         255.255.255.0   U     202    0        0 eth0
```

```
pi@raspberrypi:~ $ curl https://soracom.jp/
```

- と、でもさせてもらいましょう
- [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)の上側が青く光ったら、[SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)での通信が行われています
- [SORACOMユーザーコンソール](https://console.soracom.io/)でも表示が変わっていることでしょう
    - 緑の文字で「オンライン」

![soracom-2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b2fe404d-3cc2-b283-b842-995a363766c2.png)



- :tada::tada::tada:
- あとは[Elixir](https://elixir-lang.org/)でアプリケーションを書きます
- [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)を抜いて、一旦Raspberry Pi 4の電源OFF -> ONしておきます


## ⑥ PhoenixアプリをAzureにデプロイ
- 今回の記事では、この手順の位置付けはおまけですので手前味噌な記事をご紹介しておきます
    - [Phoenixアプリの作成](https://qiita.com/torifukukaiou/items/5876bc4576e7b7991347#phoenix%E3%82%A2%E3%83%97%E3%83%AA%E3%81%AE%E4%BD%9C%E6%88%90)
    - ソースコード
        - https://github.com/TORIFUKUKaiou/aht20_phoenix
- [Phoenix](https://www.phoenixframework.org/)アプリケーションは、[Azure仮想マシン](https://azure.microsoft.com/ja-jp/services/virtual-machines/)で動かしています
    - 簡単にさわりだけ書いておきます
        - アプリケーションとPostgreSQLはDocker上で動かしています
        - [Nginx](https://www.nginx.com/)は直接OSにインストールしてhttpsを処理してもらっています
        - [Nginx](https://www.nginx.com/) -> アプリケーションはhttpです
            - リバースプロキシしているといえばいいんですかね
        - SSL証明書は[Let's Encrypt](https://letsencrypt.org/ja/)で取得させていただきました
- Dockerを使うなら[Container Instances](https://azure.microsoft.com/ja-jp/services/container-instances/)のほうがいいんじゃないの? というのはごもっともで、「[Phoenixで実装した湯婆婆をAzureで動かす。Azure Virtual Machinesを使うとEC2やVPSでやったことがあることとなんらの変わり無しになりそうで、せっかくDockerと仲良くなりはじめたのでAzureコンテナーで動かしてみる。もちろんHTTPS緑にしたいのでアプリケーションゲートウェイも使ってみる。](https://qiita.com/torifukukaiou/items/c468a228f9d0ba13ffb9)」という記事で試したことはあります
    - 上記記事を書いた当時は初回登録のクレジットが利用可能でした
    - ただその期間をすぎたあと、私の使い方なのか選択したものが高スペックすぎたとかいろいろ要因はあるとおもうのですが、私個人が支払い続けるにはちょっと厳しかったので、[Azure仮想マシン](https://azure.microsoft.com/ja-jp/services/virtual-machines/)を自分で育てていっています
- 完成品
    - https://aht20.torifuku-kaiou.tokyo/aht20-dashboard
    - 時刻のところが動いていないときはプログラムが止まっていまして、動かざること山の如しです
    - Raspberry Pi 4の電源を落としていたりなど


## ⑦ Raspberry Pi 4 で動かすElixirプログラムを書く
- この記事のもうひとつのメイン記事です
- 完成品
    - https://github.com/TORIFUKUKaiou/honeko_pack
- 作り方はいろいろあります
    - ローカル開発マシンに[Elixir](https://elixir-lang.org/)をインストールして開発する
        - 私はこれ
        - GitHubにあげておいてRaspberry Pi OSで`git clone`
    - ローカル開発マシンからsshがつながっているのでRaspberry Pi OSの上で直接開発する
        - VSCode + https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack
        - 参考: https://code.visualstudio.com/docs/remote/ssh

### 1. プロジェクトの雛形をつくる
```
$ mix new honeko_pack
```
- `honeko_pack`はアプリケーションの名前です
- `honeko`は私が使っているネコのアイコンの名前です
- 適当な名前をつけてください

### 2. mix.exsに依存ライブラリを追加する

```elixir:mix.exs
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:circuits_i2c, "~> 0.1"},
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:quantum, "~> 3.0"}
    ]
  end
```

```
$ mix deps.get
```

### 3. [Grove AHT20 I2C温度および湿度センサー 工業用グレード](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)から温度・湿度を読み取るモジュールをつくる

```elixir:lib/aht20/reader.ex
defmodule Aht20.Reader do
  alias Circuits.I2C

  @i2c_bus "i2c-1"
  @i2c_addr 0x38
  @initialization_command <<0xBE, 0x08, 0x00>>
  @trigger_measurement_command <<0xAC, 0x33, 0x00>>
  @two_pow_20 :math.pow(2, 20)

  def read do
    {:ok, ref} = I2C.open(@i2c_bus)

    I2C.write(ref, @i2c_addr, @initialization_command)
    Process.sleep(10)

    I2C.write(ref, @i2c_addr, @trigger_measurement_command)
    Process.sleep(80)

    ret = I2C.read(ref, @i2c_addr, 7)

    I2C.close(ref)

    value(ret)
  end

  defp value({:ok, val}), do: {:ok, convert(val)}

  defp value(_), do: :error

  defp convert(<<_, raw_humi::20, raw_temp::20, _>>) do
    humi = Float.round(raw_humi * 100 / @two_pow_20, 1)
    temp = Float.round(raw_temp * 200 / @two_pow_20 - 50.0, 1)

    {temp, humi}
  end
end
```

#### 実行結果
- ここまでを動かしてみましょう

```
pi@raspberrypi:~/projects/honeko_pack $ iex -S mix

iex> Aht20.Reader.read
{:ok, {26.3, 50.4}}
```

- 気温26.3度、湿度50.4%、うん正しそうです！
- :tada::tada::tada:
- https://files.seeedstudio.com/wiki/Grove-AHT20_I2C_Industrial_Grade_Temperature_and_Humidity_Sensor/AHT20-datasheet-2020-4-16.pdf
- をみながら計算式を組み立てます
- `<<_, raw_humi::20, raw_temp::20, _>>`
- 湿度と温度の計算のもとになるあたいは、それぞれ20bit分なのですが、[Elixir](https://elixir-lang.org/)だとこんな感じで簡単に取り出せます
- IoTをいつもやっている方にはシフト演算とかなんのことないのでしょうが、たまにしかやらない私のようなタイプにはこれはとてもたすかります!
- [Elixir](https://elixir-lang.org/)でIoTをやる利点のひとつに挙げてよいとおもっています
    - 手前味噌の記事ではありますが、Suicaの履歴読み取りを例にもう少し詳しく説明した記事をご紹介しておきます
    - [先頭から7bitが年、4ビットが月、残り5ビットが日 (Elixir)](https://qiita.com/torifukukaiou/items/a273565bd2643c4017c1)
    - 公式の説明は https://hexdocs.pm/elixir/Kernel.SpecialForms.html#%3C%3C%3E%3E/1
- あとはいくつかおまけをつくります

### 4. 天気予報を取得 (おまけ)

```elixir:lib/weather/forecast.ex
defmodule Weather.Forecast do
  @options [timeout: 50_000, recv_timeout: 50_000]
  def get(area \\ 400_000) do
    "https://www.jma.go.jp/bosai/forecast/data/overview_forecast/#{area}.json"
    |> HTTPoison.get!([], @options)
    |> Map.get(:body)
    |> Jason.decode!()
  end
end
```

#### 実行結果
- ここまでを動かしてみましょう

```elixir
iex> Weather.Forecast.get 
%{
  "headlineText" => "福岡、北九州地方では、９日明け方まで強風に注意してください。",
  "publishingOffice" => "福岡管区気象台",
  "reportDatetime" => "2021-05-08T16:34:00+09:00",
  "targetArea" => "福岡県",
  "text" => "　福岡県は、気圧の谷の影響により概ね曇りとなっています。また、福岡県では、黄砂を観測しています。\n\n　８日は、高気圧に覆われて晴れる所もありますが、気圧の谷や湿った空気の影響により概ね曇りとなるでしょう。\n\n　９日は、はじめ気圧の谷や湿った空気の影響により曇りで、雨が降る所がありますが、高気圧に覆われて次第に晴れとなるでしょう。\n\n　また、上空の風の予想から９日にかけて黄砂の飛来が予想されます。"
}
```

### 6. [Bing](https://docs.microsoft.com/ja-jp/azure/cognitive-services/bing-news-search/search-the-web)でとれたて新鮮ニュースを取得 (おまけ)
- https://docs.microsoft.com/ja-jp/azure/cognitive-services/bing-news-search/search-the-web
- をみながら[Elixir](https://elixir-lang.org/)で書いてみます

```elixir:lib/azure/bing/news_search.ex
defmodule Azure.Bing.NewsSearch do
  @subscription_key "ひみつ"
  @options [timeout: 50_000, recv_timeout: 50_000]

  def top_news do
    search()
    |> Map.get("value")
    |> Enum.at(0)
  end

  def search do
    "https://api.bing.microsoft.com/v7.0/news/search?q=&setLang=ja-JP&mkt=ja-JP"
    |> HTTPoison.get!(["Ocp-Apim-Subscription-Key": @subscription_key], @options)
    |> Map.get(:body)
    |> Jason.decode!()
  end
end
```
- ソースコードたったこれだけ!

#### 実行結果
- ここまでを動かしてみましょう

```elixir
iex> Azure.Bing.NewsSearch.search
%{
  "_type" => "News",
  "queryContext" => %{"originalQuery" => ""},
  "readLink" => "https://api.bing.microsoft.com/api/v7/news/search?q=&setLang=ja-JP",
  "value" => [
    %{
      "ampUrl" => "https://mainichi.jp/articles/20210508/k00/00m/030/247000c.amp",
      "category" => "World",
      "datePublished" => "2021-05-08T13:46:00.0000000Z",
      "description" => "李　漢東氏（イ・ハンドン＝元韓国首相）韓国メディアによると8日、持病のため自宅で死去、86歳。 　34年、京畿道抱川生まれ。ソウル大卒業後、判事や検事などを経て政界入りし、81年から国会議員に6回当選した。金大中政権時代の00～02年に首相を務めた。（共同）",
      "headline" => true,
      "image" => %{
        "thumbnail" => %{
          "contentUrl" => "https://www.bing.com/th?id=OVFT.IEpej2yPYyaDwnpj9O_KzC&pid=News",
          "height" => 367,
          "width" => 700
        }
      },
      "name" => "李漢東氏さん死去 86歳 金大中政権時代の元韓国首相",
      "provider" => [%{"_type" => "Organization", "name" => "mainichi.jp"}],
      "url" => "https://mainichi.jp/articles/20210508/k00/00m/030/247000c"
    },
    %{
      "about" => [
        %{
          "name" => "Yahoo!",
          "readLink" => "https://api.bing.microsoft.com/api/v7/entities/420cd466-c4de-0a7c-0139-d304079cd3e3?setLang=ja-JP"
        }
      ],
      "category" => "Japan",
      "datePublished" => "2021-05-08T13:22:00.0000000Z",
      "description" => "新型コロナウイルスについて県と宇都宮市は8日、新たに51人の感染を発表しました。 1日当たりの感染者の発表が50人を超えるのは今年1月22日以来で、およそ3カ月半ぶりです。 新たに感染が確認されたのは宇都宮市、小山市、栃木市、佐野市、さくら市、日光市、那須塩原市、大田原市、真岡市、下野市、上三川町、茨城県の10代から80代までの男女51人です。 このうち、23人が今のところ、感染経路が分かっていま",
      "headline" => true,
      "name" => "栃木県内 新たに51人感染 3ヵ月半ぶり50人超 新型コロナ 8日発表",
      "provider" => [
        %{"_type" => "Organization", "name" => "Yahoo!ニュース"}
      ],
      "url" => "https://news.yahoo.co.jp/articles/b6b021f884fc9b10ebc6979e0d5806cda45004e3"
    },
    %{
      "about" => [
        %{
          "name" => "Tokyo",
          "readLink" => "https://api.bing.microsoft.com/api/v7/entities/cb44a92f-6c6f-99c4-2ae3-51601fdc919a?setLang=ja-JP"
        }
      ],
      "ampUrl" => "https://www.tokyo-np.co.jp/amp/article/102969",
      "category" => "Entertainment",
      "datePublished" => "2021-05-08T09:20:00.0000000Z",
      "description" => "人気アイドルグループ「関ジャニ∞」の元メンバーで、ソロアーティストの渋谷すばるさん（３９）が８日、ファンクラブ向けのブログで結婚したことを発表した。 渋谷さんは２００４年から「関ジャニ∞」のメインボーカルとして活躍し、１８年にジャニーズ事務所を退所すると発表。１９年からソロアーティストとして活動している。 電子版ログイン",
      "headline" => true,
      "image" => %{
        "thumbnail" => %{
          "contentUrl" => "https://www.bing.com/th?id=OVFT.FBHZ-rI1S27zQB0KzCKR5i&pid=News",
          "height" => 367,
          "width" => 700
        }
      },
      "name" => "渋谷すばるさんが結婚を発表 「関ジャニ∞」元メンバー",
      "provider" => [%{"_type" => "Organization", "name" => "東京新聞"}],
      "url" => "https://www.tokyo-np.co.jp/article/102969"
    },
    %{
      "datePublished" => "2021-05-08T08:36:00.0000000Z",
      "description" => "通算１５００奪三振を達成したオリックス・能見＝ＺＯＺＯマリンスタジアム（撮影・田村亮介） 11. 禁煙できぬ夫 妻の「最終手段」 12. 無印の紙ナプキン コロナ対策に? 13. みりんで作る生キャラメルが旨い 14. 痛快報復 サレ妻「執念」の復讐 15. アットホーム? ブラック企業経験 16. しまむらにカリスマモデルの新作 17. 毛穴の黒ずみ やりがちNG行為 18. 買ってよかった無印",
      "headline" => true,
      "image" => %{
        "thumbnail" => %{
          "contentUrl" => "https://www.bing.com/th?id=OVFT.z7pyv9yBM4DPN6Sx5FvRUi&pid=News",
          "height" => 450,
          "width" => 294
        }
      },
      "name" => "オリックス・能見がプロ通算1500奪三振",
      "provider" => [%{"_type" => "Organization", "name" => "livedoor NEWS"}],
      "url" => "https://news.livedoor.com/article/image_detail/20157727/?img_id=29146641"
    },
    %{
      "about" => [
        %{
          "name" => "Yahoo!",
          "readLink" => "https://api.bing.microsoft.com/api/v7/entities/420cd466-c4de-0a7c-0139-d304079cd3e3?setLang=ja-JP"
        }
      ],
      "category" => "Japan",
      "datePublished" => "2021-05-08T13:59:00.0000000Z",
      "description" => "5月8日夜、北海道札幌市中央区で、灯油タンク周辺が燃える火事があり、現場は一時騒然となりました。 火事があったのは、札幌市中央区宮の森2条14丁目の住宅です。 5月8日午後9時30分ごろ、「住宅の灯油タンクが燃えている」と目撃者から消防に通報がありました。 消防車8台が駆け付け、火は約20分後に消し止められ、住宅の外壁が一部焼けました。ケガをした人はいませんが、住宅街は一時騒然となりました。 警察",
      "headline" => true,
      "name" => "「灯油タンクが燃えている」目撃者から通報…\"たばこ\"不始末か ...",
      "provider" => [
        %{"_type" => "Organization", "name" => "Yahoo!ニュース"}
      ],
      "url" => "https://news.yahoo.co.jp/articles/c5043a26572f14d8984c5562b67abc2e4cbec8ff"
    },
    %{
      "category" => "Japan",
      "datePublished" => "2021-05-08T10:38:00.0000000Z",
      "description" => "8日午後、長野県軽井沢町で、走行中の北陸新幹線がクマと衝突し緊急停止しました。JR東日本によりますとけが人はなく、30分ほどで運転を再開しました。",
      "headline" => true,
      "name" => "北陸新幹線がクマと衝突 けが人なし 冬眠終え活動時期入りか",
      "provider" => [%{"_type" => "Organization", "name" => "NHK"}],
      "url" => "http://www.nhk.or.jp/knews/20210508/k10013019591000.html"
    },
    %{
      "ampUrl" => "https://www.nikkansports.com/m/entertainment/news/amp/202105080000626.html",
      "datePublished" => "2021-05-08T08:30:00.0000000Z",
      "description" => "5人組アイドルユニットsherbetが8日、都内で、全国11都市ワンマンツアー「CrystalMemories」初日公演を開催し、全16曲を披露した。同ユニッ… - 日刊スポーツ新聞社のニュースサイト、ニッカンスポーツ・コム（nikkansports.com）",
      "headline" => true,
      "image" => %{
        "thumbnail" => %{
          "contentUrl" => "https://www.bing.com/th?id=OVFT.7_vLqepXPQbHIVT3o25NOi&pid=News",
          "height" => 427,
          "width" => 500
        }
      },
      "mentions" => [%{"name" => "Puerto Rico"}],
      "name" => "アイドルユニットsherbetが全国ツアー初日公演、全16曲を披露",
      "provider" => [%{"_type" => "Organization", "name" => "nikkansports.com"}],
      "url" => "https://www.nikkansports.com/entertainment/news/202105080000626.html"
    },
    %{ 
      "datePublished" => "2021-05-08T02:00:00.0000000Z",
      "description" => "米女子ゴルフのホンダLPGAは7日、タイ南部パタヤのサイアムCC（パー72）で第2ラウンドが行われ、20位で出た畑岡奈紗が7バーディー、2ボギーの67で回り、通算8アンダ... アプリで開く この記事は会員限定です。登録すると続きをお読みいただけます。",
      "headline" => true,
      "image" => %{
        "thumbnail" => %{
          "contentUrl" => "https://www.bing.com/th?id=OVFT.tNhV2rUr6U9W-nTSGFFtaC&pid=News",
          "height" => 430,
          "width" => 700
        }
      },
      "name" => "（短信）畑岡10位、渋野は28位 米女子ゴルフ",
      "provider" => [%{"_type" => "Organization", "name" => "NIKKEI"}],
      "url" => "https://www.nikkei.com/article/DGKKZO71678110X00C21A5UU8000/"
    },
    %{
      "ampUrl" => "https://www.nikkansports.com/m/battle/news/amp/202105080000409.html",
      "datePublished" => "2021-05-08T05:25:00.0000000Z",
      "description" => "「カネロ」の愛称を持つボクシングの人気スター選手のWBAスーパー、WBC世界スーパーミドル級王者サウル・アルバレス（30＝メキシコ）が約5000人のファンに向… - 日刊スポーツ新聞社のニュースサイト、ニッカンスポーツ・コム（nikkansports.com）",
      "headline" => true,
      "image" => %{
        "thumbnail" => %{
          "contentUrl" => "https://www.bing.com/th?id=OVFT.OS2IZgB2W7djo3U5pa3CYC&pid=News",
          "height" => 316,
          "width" => 500
        }
      },
      "name" => "アルバレス、3団体統一戦の前日計量パス ファンの赤ちゃんにキス ...",
      "provider" => [%{"_type" => "Organization", "name" => "nikkansports.com"}],
      "url" => "https://www.nikkansports.com/m/battle/news/202105080000409_m.html"
    },
    %{
      "ampUrl" => "https://www.47news.jp/amp/6220661.html",
      "datePublished" => "2021-05-08T04:09:00.0000000Z",
      "description" => "東京五輪の聖火リレーは7日、全国20府県目となる長崎県の初日を迎えた。",
      "headline" => true,
      "image" => %{
        "thumbnail" => %{
          "contentUrl" => "https://www.bing.com/th?id=OVFT.D6hg051vveFGuaNL1pJnyS&pid=News",
          "height" => 316,
          "width" => 474
        }
      },
      "name" => "石原さとみさん登場 聖火、長崎県1日目",
      "provider" => [%{"_type" => "Organization", "name" => "47NEWS"}],
      "url" => "https://www.47news.jp/6220661.html",
      "video" => %{
        "name" => "石原さとみさん登場　聖火、長崎県1日目",
        "thumbnail" => %{"height" => 200, "width" => 300},
        "thumbnailUrl" => "https://www.bing.com/th?id=OVF.3MCsMK4rpaB9tS%2Btev%2FHzA&pid=News"
      }
    }
  ]
}
```

### 7. [Text to Speech](https://docs.microsoft.com/ja-jp/azure/cognitive-services/speech-service/rest-text-to-speech)で文字列を音声データにする (おまけ)
- https://docs.microsoft.com/ja-jp/azure/cognitive-services/speech-service/rest-text-to-speech
- をみながら[Elixir](https://elixir-lang.org/)で書いてみます
- こんどはちょっと長いです

```elixir:cognitive_services/text_to_speech.ex
defmodule Azure.CognitiveServices.TextToSpeech do
  @moduledoc """
  Documentation for `Azure.TextToSpeech`.
  """

  @region "japaneast"
  @subscription_key "ひみつ"
  @audio_list ~w(
    raw-16khz-16bit-mono-pcm            raw-8khz-8bit-mono-mulaw
    riff-8khz-8bit-mono-alaw            riff-8khz-8bit-mono-mulaw
    riff-16khz-16bit-mono-pcm           audio-16khz-128kbitrate-mono-mp3
    audio-16khz-64kbitrate-mono-mp3     audio-16khz-32kbitrate-mono-mp3
    raw-24khz-16bit-mono-pcm            riff-24khz-16bit-mono-pcm
    audio-24khz-160kbitrate-mono-mp3    audio-24khz-96kbitrate-mono-mp3
    audio-24khz-48kbitrate-mono-mp3     ogg-24khz-16bit-mono-opus
    raw-48khz-16bit-mono-pcm            riff-48khz-16bit-mono-pcm
    audio-48khz-96kbitrate-mono-mp3     audio-48khz-192kbitrate-mono-mp3)
  @user_agent "awesome"
  @options [timeout: 50_000, recv_timeout: 50_000]

  def voices_list do
    voices_list_endpoint()
    |> HTTPoison.get!(authorization_header(access_token()), @options)
    |> Map.get(:body)
    |> Jason.decode!()
  end

  def audio_list do
    @audio_list
  end

  def ssml(text, %{"Name" => name, "Locale" => locale, "Gender" => gender}) do
    """
    <speak version='1.0' xml:lang='#{locale}'>
      <voice xml:lang='#{locale}' xml:gender='#{gender}' name='#{name}'>
        #{text}
      </voice>
    </speak>
    """
  end

  def to_speech_of_standard_voice(ssml, audio \\ "riff-24khz-16bit-mono-pcm") do
    to_speech_of_neural_voice(ssml, audio)
  end

  def to_speech_of_neural_voice(ssml, audio \\ "riff-24khz-16bit-mono-pcm") do
    standard_and_neural_voice_endpoint()
    |> HTTPoison.post!(ssml, headers(audio), @options)
    |> Map.get(:body)
  end

  def to_speech_of_custom_voice do
    # TODO
  end

  def to_speech_of_long_audio do
    # TODO
  end

  defp access_token do
    %{token: token, time: time} = Azure.CognitiveServices.TextToSpeech.AccessTokenAgent.get()

    if DateTime.diff(DateTime.now!("Etc/UTC"), time) > 60 * 9 do
      get_access_token()
      |> Azure.CognitiveServices.TextToSpeech.AccessTokenAgent.update()

      access_token()
    else
      token
    end
  end

  defp get_access_token do
    headers = [
      "Ocp-Apim-Subscription-Key": @subscription_key,
      "Content-type": "application/x-www-form-urlencoded"
    ]

    issue_token_endpoint()
    |> HTTPoison.post!("", headers, @options)
    |> Map.get(:body)
  end

  defp issue_token_endpoint do
    "https://#{@region}.api.cognitive.microsoft.com/sts/v1.0/issueToken"
  end

  defp voices_list_endpoint do
    "https://#{@region}.tts.speech.microsoft.com/cognitiveservices/voices/list"
  end

  defp standard_and_neural_voice_endpoint do
    "https://#{@region}.tts.speech.microsoft.com/cognitiveservices/v1"
  end

  defp authorization_header(token) do
    [Authorization: "Bearer #{token}"]
  end

  defp headers(audio) do
    access_token()
    |> authorization_header()
    |> Keyword.merge(
      "Content-Type": "application/ssml+xml",
      "X-Microsoft-OutputFormat": audio,
      "User-Agent": @user_agent
    )
  end
end
```

```elixir:lib/azure/cognitive_services/text_to_speech/access_token_agent.ex
defmodule Azure.CognitiveServices.TextToSpeech.AccessTokenAgent do
  use Agent

  def start_link(_initial_value) do
    Agent.start_link(fn -> %{token: nil, time: DateTime.from_unix!(0)} end, name: __MODULE__)
  end

  def get, do: Agent.get(__MODULE__, & &1)

  def update(token) do
    Agent.update(__MODULE__, fn _ ->
      %{token: token, time: DateTime.now!("Etc/UTC")}
    end)
  end
end
```

```elixir:lib/honeko_pack/application.ex
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: HonekoPack.Worker.start_link(arg)
      # {HonekoPack.Worker, arg}
      Azure.CognitiveServices.TextToSpeech.AccessTokenAgent,
    ]
```

- Ctl + c を2回おして一度IExを終了させてください

#### 実行結果
- ここまでを動かしてみましょう

```elixir
pi@raspberrypi:~/projects/honeko_pack $ iex -S mix

iex> locale = "ja-JP"

iex> voice_type = "Neural"

iex> gender = "Female"

iex> voice = (
Azure.CognitiveServices.TextToSpeech.voices_list()
|> Enum.filter(fn %{"Locale" => l} -> l == locale end)
|> Enum.filter(fn %{"VoiceType" => vt} -> vt == voice_type end)
|> Enum.filter(fn %{"Gender" => g} -> g == gender end)
|> Enum.random()
)

iex> path = "output.wav"

iex> (
Azure.CognitiveServices.TextToSpeech.ssml("団長！　いつでもどこでも温度・湿度が測れるのであります！ (Elixir, SORACOM Air for セルラー)", voice)
|> Azure.CognitiveServices.TextToSpeech.to_speech_of_neural_voice()
|> (&File.write(path, &1)).()
)

iex> :os.cmd('aplay #{path}')
```

- 音声が読み上げられましたでしょうか！ :speaker: 

### 8. これまで作ったものを組み合わせたり、自動的に実行したりするようにします

```elixir:lib/honeko_pack.ex
defmodule HonekoPack do
  @default_voice_path "output"

  def run do
    me = self()

    [&make_top_news_voice_file/0, &make_weather_forecast_voice_file/0]
    |> Enum.map(fn f ->
      spawn_link(fn -> send(me, {self(), f.()}) end)
    end)
    |> Enum.map(fn pid ->
      receive do
        {^pid, result} ->
          result
      end
    end)
    |> Enum.map(&play/1)
  end

  def make_weather_forecast_voice do
    make_weather_forecast()
    |> make_voice()
  end

  def make_weather_forecast do
    Weather.Forecast.get()
    |> Map.get("text")
  end

  def make_weather_forecast_voice_file do
    do_something_and_create_file(:make_weather_forecast_voice)
  end

  def make_top_news_voice do
    make_top_news()
    |> make_voice()
  end

  def make_top_news do
    Azure.Bing.NewsSearch.top_news()
    |> Map.get("description")
  end

  def make_top_news_voice_file do
    do_something_and_create_file(:make_top_news_voice)
  end

  def play(path \\ @default_voice_path) do
    do_play(path, :os.type())
  end

  def make_voice(text) do
    Azure.CognitiveServices.TextToSpeech.ssml(text, select_voice())
    |> Azure.CognitiveServices.TextToSpeech.to_speech_of_neural_voice()
  end

  def select_voice(opts \\ []) do
    locale = Keyword.get(opts, :locale) || "ja-JP"
    voice_type = Keyword.get(opts, :voice_type) || "Neural"
    gender = Keyword.get(opts, :gender) || "Female"

    Azure.CognitiveServices.TextToSpeech.voices_list()
    |> Enum.filter(fn %{"Locale" => l} -> l == locale end)
    |> Enum.filter(fn %{"VoiceType" => vt} -> vt == voice_type end)
    |> Enum.filter(fn %{"Gender" => g} -> g == gender end)
    |> Enum.random()
  end

  defp do_play(path, {:unix, :darwin}) do
    :os.cmd('afplay #{path}')
  end

  defp do_play(path, _) do
    :os.cmd('aplay #{path}')
  end

  defp do_something_and_create_file(function_name) do
    path = Atom.to_string(function_name) <> ".wav"

    apply(__MODULE__, function_name, [])
    |> (&File.write(path, &1)).()

    path
  end
end
```

```elixir:lib/honeko_pack/worker/aht20_agent.ex
defmodule HonekoPack.Worker.Aht20Agent do
  use Agent

  def start_link(_initial_value) do
    Agent.start_link(fn -> %{temperature: 0, humidity: 0, time: 0} end, name: __MODULE__)
  end

  def get, do: Agent.get(__MODULE__, & &1)

  def update(temp, hum, time) do
    Agent.update(__MODULE__, fn _ ->
      %{temperature: temp, humidity: hum, time: time}
    end)
  end
end
```

```elixir:lib/honeko_pack/worker.ex
defmodule HonekoPack.Worker do
  @url "http://beam.soracom.io:8888"
  @headers [{"Content-Type", "application/json"}]
  @options [timeout: 50_000, recv_timeout: 50_000]

  def run do
    aht20()
  end

  defp aht20 do
    {:ok, {temperature, humidity}} = aht20_read(:os.type())
    time = DateTime.utc_now() |> DateTime.to_unix()
    HonekoPack.Worker.Aht20Agent.update(temperature, humidity, time)
    # post()
    if rem(time, 10) == 0, do: post()
  end

  defp aht20_read({:unix, :darwin}) do
    # debug on macOS
    temperature = 10..20 |> Enum.random()
    humidity = 20..50 |> Enum.random()
    {:ok, {temperature, humidity}}
  end

  defp aht20_read(_) do
    Aht20.Reader.read()
  end

  defp post do
    %{temperature: temperature, humidity: humidity, time: time} =
      HonekoPack.Worker.Aht20Agent.get()

    json = Jason.encode!(%{value: %{temperature: temperature, humidity: humidity, time: time}})
    HTTPoison.post(@url, json, @headers, @options)
  end
end
```
- 1秒に1回、[Grove AHT20 I2C温度および湿度センサー 工業用グレード](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)から温度・湿度を読み出しています
    - 後述の`HonekoPack.Ticker`モジュールでタイミングをとっています
- 10秒に1回、[SORACOM Beam](https://soracom.jp/services/beam/)へ向けてデータを打ち上げています[^3]

[^3]: [大山ダム](https://shingeki-hita.com/spot/001.html)で撮影したときはまだ[SORACOM Beam](https://soracom.jp/services/beam/)は使っておらず、直接[Azure 仮想マシン](https://azure.microsoft.com/ja-jp/services/virtual-machines/)へPOSTしていました

![04-soracom-beam.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/eb3db381-7b84-8c61-484e-b88dd6670094.png)

- [SORACOM Beam](https://soracom.jp/services/beam/)の設定をしておきます
- この設定により[SORACOM Beam](https://soracom.jp/services/beam/)に届いたデータはhttpsで[Azure仮想マシン](https://azure.microsoft.com/ja-jp/services/virtual-machines/)上の[Phoenix](https://www.phoenixframework.org/)アプリケーションにPOSTされます


```elixir:lib/honeko_pack/ticker.ex
defmodule HonekoPack.Ticker do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    :timer.send_interval(1000, self(), :tick)
    {:ok, state}
  end

  def handle_info(:tick, state) do
    spawn(HonekoPack.Worker, :run, [])

    {:noreply, state}
  end
end
```
- `HonekoPack.Worker.run/0`を1秒に1回動かすモジュール

```elixir:lib/honeko_pack/scheduler.ex
defmodule HonekoPack.Scheduler do
  use Quantum, otp_app: :honeko_pack
end
```

```elixir:lib/honeko_pack/application.ex
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: HonekoPack.Worker.start_link(arg)
      # {HonekoPack.Worker, arg}
      Azure.CognitiveServices.TextToSpeech.AccessTokenAgent,
      HonekoPack.Ticker,
      HonekoPack.Worker.Aht20Agent,
      HonekoPack.Scheduler
    ]
```

```elixir:config/config.exs
import Config

config :honeko_pack, HonekoPack.Scheduler,
  jobs: [
    {"30 21 * * *", {HonekoPack, :run, []}}
  ]
```

- 日本時間の06:30に`HonekoPack.run/0`が実行されます
- つまり、とれたて新鮮ニュースと今日の天気を読み上げてくれる目覚ましアラームです



## ⑧ Run (イゴかす)

- 電源をモバイルバッテリーにしましょう
- [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)はRaspberry Pi OSが立ち上がってから挿したほうがよいという記事をみましたので、私もそうしています
    - [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)を挿したまま立ち上げるとうまく立ち上がらないといった事象が起こる場合があるそうです

```
pi@raspberrypi:~ $ sudo wvdial &

pi@raspberrypi:~ $ sudo route del default
pi@raspberrypi:~ $ sudo route add default dev ppp0

pi@raspberrypi:~ $ cd /home/pi/projects/honeko_pack
pi@raspberrypi:~/projects/honeko_pack $ nohup iex -S mix &
```

- さあ、Raspberry Pi 4(with [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/))を持って外へ出よう

![E0Y2GqDVgAInS0U.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/73211af8-6946-3699-1e4a-0d729487000e.jpeg)

![02-Anywhere-can-be-measuredのコピー.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7937cc1c-4e96-7876-d102-8cb0f0e3e3cf.png)



# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:
- [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)で通信をする場合は、`AT+COPS=1,2,"44010"`しておくといいことあるかもしれません
    - まとめに書くにしてはあんまり自信がある書き方をできないのですが、少なくとも悪くなることはないとおもいます
    - だってNTTドコモさんから販売されたデータ通信端末なのですもの
- [Elixir](https://elixir-lang.org/)のプログラムを作るところは駆け足になりました
    - ちゃんと説明できていませんが感じてください!
    - コードの中でさらっと使っている[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)はパイプ演算子と呼ばれるもので、前の計算結果を次の関数の第一引数にいれてくれます
    - これが気持ちいいんですよ
    - 私は感覚でしか語れません
    - [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)のよさに関するちゃんとした説明は、@zacky1972先生の[大学でElixirを教えた話](https://qiita.com/zacky1972/items/0c2869f9f39f7bb917a5)をご参照ください
- この記事を書くために、取り組んだいろいろなこと(特にATコマンド)は、あーでもない、こーでもないと試行錯誤を繰り返しまして、間違いなく私の**普段の生活を豊か**にしてくれました
    - コンテストをきっかけにはじめて[SORACOM](https://soracom.com/ja-jp/)さんのサービスを触りました
    - そうしたきっかけをいただけて本当にありがとうございます!
- **あなたのIoT開発にも[Elixir](https://elixir-lang.org/)を使ってみませんか:bangbang:**
- [Elixir](https://elixir-lang.org/)を使ってみようとおもってくださった方がいらっしゃったらうれしいです
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:
- 心臓を捧げよ!
- 必ず星をあげる!
- はい!



