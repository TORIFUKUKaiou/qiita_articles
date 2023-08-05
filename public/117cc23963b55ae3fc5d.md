---
title: Elixir meets SORACOM (2021/12/06)
tags:
  - Elixir
  - SORACOM
  - Nerves
private: false
updated_at: '2021-12-19T03:57:13+09:00'
id: 117cc23963b55ae3fc5d
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/advent-calendar/2021/soracom

2021/12/06(月)の回です。

前日は、@takiponeさんによる「[SORACOM IoT SIM planX1がHuawei MS2372h-607でも使えるようになっていた](https://zenn.dev/takipone/articles/3dc390025412d7)」でした。
**planX1 x MS2372h-607を試してみた様子**をレポートされています。



# はじめに
[Elixir](https://elixir-lang.org/)を楽しんでいますか :bangbang::bangbang::bangbang: 

- [Elixir](https://elixir-lang.org/) meets [SORACOM](https://soracom.jp/).
- [Nerves](https://www.nerves-project.org/) meets [SORACOM](https://soracom.jp/).

な記事をお届けします:gift::gift::gift:

https://soracomug-tokyo.connpass.com/event/231532/

2021/12/14(火) 19:30〜21:00開催の「[SORACOM UG x NervesJP #1 ~Hello, world!~](https://soracomug-tokyo.connpass.com/event/231532/)」にて、[NervesJP](https://nerves-jp.connpass.com/)枠で少ししゃべらせてもらう時間を私はいただいております。
この記事自体がそのイベントでご説明する資料です。

# サマリ

:::note info
We are the Alchemists, my friends!
:::

:::note info
Nervesはナウでヤングなcoolなすごいやつです🚀
:::

# What's [Elixir](https://elixir-lang.org/)?

[Elixir](https://elixir-lang.org/)は関数型言語に分類されるプログラミング言語です。
Erlang VM上でイゴいています[^1]。
Rubyになんとなく文法が似ています。[^2]

[Elixir](https://elixir-lang.org/)は、日本語に訳すと**不老不死の霊薬**です。
その[Elixir](https://elixir-lang.org/)と名付けられたプログラミング言語の使い手は、**Alchemist(錬金術師)**と尊称されます。


[^1]: 「動いています」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^4]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg=

[^4]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。


[^2]: [Elixir](https://elixir-lang.org/)がRubyに似ているというのは私だけの感じ方ではなく、作者である[José Valim](https://twitter.com/josevalim)さん自身が"[The main, the top three influences are Erlang, Ruby, and Clojure.](https://cognitect.com/cognicast/120)"とおっしゃっており、[Elixir](https://elixir-lang.org/)に影響を与えた言語としてRubyが挙げられています。またRuby on Railsを使われたことがある方ならご存知だとおもいます、あの[devise](https://github.com/heartcombo/devise)の[最初のコミット](https://github.com/heartcombo/devise/commit/673fda9725b3a0b5522afdbe4fc9c0608243723c)は[José Valim](https://twitter.com/josevalim)さんによるものです。


# What's [Nerves](https://www.nerves-project.org/)?

[Nerves](https://www.nerves-project.org/)は[Elixir](https://elixir-lang.org/)のIoTで
<font color="purple">$\huge{ナウでヤングなcoolなすごいヤツです🚀}$</font>

https://www.slideshare.net/takasehideki/elixirnervescool-249038510


# [Elixir](https://elixir-lang.org/) meets [SORACOM](https://soracom.jp/)

[AK-020](https://soracom.jp/store/5274/)で接続します。
私は、Raspberry Pi 4を使いました。

![IMG_20211204_151525.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6f1854f8-ac1e-2e98-671c-af1c11fe8efe.jpeg)




## [Raspberry Pi OS](https://www.raspberrypi.com/software/)

- まずは基本に則って、[Raspberry Pi OS](https://www.raspberrypi.com/software/)上で、[Elixir](https://elixir-lang.org/)を動かします。
- [SORACOM](https://soracom.jp/)さんのSIMを使って、インターネットの世界へ飛び出してみますの例です:rocket::rocket::rocket:


リンク先に従って、[Raspberry Pi OS](https://www.raspberrypi.com/software/)を焼きましょう。
以下、Raspberry Pi上での操作です。

```
pi@raspberrypi:~ $ uname -a
Linux raspberrypi 5.10.17-v7l+ #1403 SMP Mon Feb 22 11:33:35 GMT 2021 armv7l GNU/Linux
```

## [Elixir](https://elixir-lang.org/)をインストールする

まずは普通(?)のネットワーク[^3]でRaspberry Piに、[Elixir](https://elixir-lang.org/)のインストールを進めましょう。

[^3]: ご家庭のルータにLANケーブルやWi-Fiで接続している使い方を指しています。

```bash
$ sudo apt-get update
($ sudo apt-get update --allow-releaseinfo-change)
$ sudo apt install build-essential automake autoconf git squashfs-tools ssh-askpass pkg-config curl
$ sudo apt install libssl-dev libncurses5-dev default-jdk unixodbc-dev fop xsltproc libxml2-utils
$ sudo apt install libwxgtk-webview3.0-gtk3-dev
$ sudo apt install libwxgtk3.0-gtk3-dev

$ git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.0
$ echo -e '\n. $HOME/.asdf/asdf.sh' >> ~/.bashrc
$ echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ~/.bashrc
$ source ~/.bashrc
$ asdf plugin-add erlang
$ asdf plugin-add elixir
$ asdf install erlang 24.1.4
```

:coffee::coffee::coffee::coffee::coffee:
I have five cups of coffee.

```
Building Erlang/OTP 24.1.4 (asdf_24.1.4), please wait...
APPLICATIONS INFORMATION (See: /home/pi/.asdf/plugins/erlang/kerl-home/builds/asdf_24.1.4/otp_build_24.1.4.log)
 * wx             : wxWidgets was not compiled with --enable-webview or wxWebView developer package is not installed, wxWebView will NOT be available
```

:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:こんな警告がでていました。
よくはないけどとりあえず放っておきます。

[Elixir](https://elixir-lang.org/)のインストールはけっこうあっけなくすぐおわります。

```bash
$ asdf install elixir 1.12.3-otp-24
$ asdf global erlang 24.1.4
$ asdf global elixir 1.12.3-otp-24
``` 

## [Qiita API](https://qiita.com/api/v2/docs)

普通(?)のネットワーク[^1]でイゴかしておきます[^2]。
このプログラムは、[Elixir](https://elixir-lang.org/)界で[Hex](https://hex.pm/)と呼ばれるライブラリを初回実行時にダウンロードしています。
その意味(通信費の節約、ダウンロード時間の短縮)でも普通(?)のネットワーク[^1]でイゴかしておくことをオススメします。
Qiitaの場ですので、通信は[Qiita API](https://qiita.com/api/v2/docs)を使ってみることにします。


```elixir:qiita_api.exs
Mix.install([{:jason, "~> 1.2"}, {:httpoison, "~> 1.8"}])

"https://qiita.com/api/v2/items?query=elixir"
|> HTTPoison.get!([], [timeout: 50_000, recv_timeout: 50_000])
|> Map.get(:body)
|> Jason.decode!()
|> Enum.map(& Map.take(&1, ["title", "url"]))
|> IO.inspect()
```

- QiitaのAPIエンドポイントがありまして
    - **|>** GETするでしょ、いつやるの？　今でしょ！
    - **|>** bodyを取り出します、いつやるの？　今でしょ！
    - **|>** JSONデーコードするでしょ、いつやるの？　今でしょ！
    - **|>** そうすると各要素がマップのリストが得られるので、情報量が多いからとりあえずタイトルとURLだけにするでしょ、いつやるの? 今でしょ！
    - **|>** 取得したものは表示するでしょ、いつやるの？　今でしょ！

ってな感じの<font color="purple">$\huge{Awesome}$</font>なプログラムを書くことができます。
[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)は、**パイプ演算子**と言いまして、前の計算結果を次の関数の第一引数にいれて計算をしてくれます。
**パイプ演算子**は、[Elixir](https://elixir-lang.org/)のプログラムでよく使います。




```bash
$ elixir qiita_api.exs
```

実行結果例は、後述します。


## [AK-020](https://soracom.jp/store/5274/)をセットアップする

![IMG_20211204_151525.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6f1854f8-ac1e-2e98-671c-af1c11fe8efe.jpeg)

[MS2372h-607 をセットアップする](https://users.soracom.io/ja-jp/guides/usb-dongles/ms2372h-607/)を参考にするとよいです。

```bash
$ curl -O https://soracom-files.s3.amazonaws.com/setup_air.sh
$ sudo bash setup_air.sh
```

[setup_air.sh](https://soracom-files.s3.amazonaws.com/setup_air.sh)を読むと、[AK-020](https://soracom.jp/store/5274/)のことも書いてあります。
だからいいんです:+1::+1::+1::+1::+1:

## Run:rocket::rocket::rocket:

```
$ ping pong.soracom.io
PING pong.soracom.io (100.127.100.127) 56(84) bytes of data.
64 bytes from 100.127.100.127 (100.127.100.127): icmp_seq=14 ttl=64 time=94.1 ms
64 bytes from 100.127.100.127 (100.127.100.127): icmp_seq=15 ttl=64 time=98.8 ms
64 bytes from 100.127.100.127 (100.127.100.127): icmp_seq=16 ttl=64 time=101 ms
64 bytes from 100.127.100.127 (100.127.100.127): icmp_seq=17 ttl=64 time=481 ms
64 bytes from 100.127.100.127 (100.127.100.127): icmp_seq=18 ttl=64 time=111 ms
```

:ping_pong: のやりとりができています。

```elixir
$ elixir qiita_qpi.exs 
[
  %{
    "title" => "Elixir + SendGrid でメール送信してみる",
    "url" => "https://qiita.com/koyo-miyamura/items/34e369200fe1aeafb0af"
  },
  %{
    "title" => "[LiveView] phx_gen_authで認証したcurrent_userをLiveViewで取得する方法",
    "url" => "https://qiita.com/omini/items/0fd2ab3be79ecb42dccd"
  },
  %{
    "title" => "UnityEngine.Localizationをスクリプトから呼ぶ",
    "url" => "https://qiita.com/ELIXIR/items/91bd827cfc312e38b1b8"
  },
  %{
    "title" => "[liveview] ** (UndefinedFunctionError) function Phoenix.LiveView.Helpers.__component__/3 is undefined or privateに対する対応",
    "url" => "https://qiita.com/omini/items/946841ece651cb671e5f"
  },
  %{
    "title" => "MacBookでElixirの２ノード間通信を試してみる",
    "url" => "https://qiita.com/electronics_diy721/items/0817a449344201f03cc7"
  },
  %{
    "title" => "Elixirのobserver.start（ ）で、マシンの論理コア数を確認する",
    "url" => "https://qiita.com/electronics_diy721/items/9b815286f43d9f486a52"
  },
  %{
    "title" => "Erlang：プロセス間の並行プラミング入門１",
    "url" => "https://qiita.com/electronics_diy721/items/91f8075bf4f5da05854f"
  },
  %{
    "title" => "ElixirをMacbookに入れて、IExを動かした",
    "url" => "https://qiita.com/electronics_diy721/items/6ff0c60d32ab0a9cbc5c"
  },
  %{
    "title" => "MAKER PI RP2040をPlatformIOからArduinoとして使う",
    "url" => "https://qiita.com/ELIXIR/items/a00a8e0d9c9b9fcf1942"
  },
  %{
    "title" => "ElixirのIExをElixirカラーにする",
    "url" => "https://qiita.com/mnishiguchi/items/a339850b0fadeecc6632"
  },
  %{
    "title" => "Phx.gen.liveで作成したスキーマにJSON APIを作成する方法",
    "url" => "https://qiita.com/omini/items/a157960ebe24cf890091"
  },
  %{
    "title" => "elixirでtupleとlistの要素の取り出し",
    "url" => "https://qiita.com/omini/items/3cc16f94e70e60b91e62"
  },
  %{
    "title" => "Liveviewで作るスロットゲーム",
    "url" => "https://qiita.com/omini/items/9ae9063c8fe51a5f3ff2"
  },
  %{
    "title" => "【毎日自動更新】Azure Kubernetes Serviceに関する記事を投稿しよう！(2021/10/10–2021/11/10) LGTMランキング！",
    "url" => "https://qiita.com/torifukukaiou/items/2db585bf7dbe39ed6f5d"
  },
  %{
    "title" => "Phoenix 1.6、devでSQLite3、prodではPostgres",
    "url" => "https://qiita.com/mnishiguchi/items/6b29314edcb4157f5e18"
  },
  %{
    "title" => "おまけ: LiveViewでエラー通知編【Sentryを使ったElixir/Phoenixアプリのエラー監視】",
    "url" => "https://qiita.com/koyo-miyamura/items/24757fbae5dfc5cde602"
  },
  %{
    "title" => "特定ユーザーのQiita記事一覧を得る(5)",
    "url" => "https://qiita.com/ELIXIR/items/9a582ae2eb75909acdab"
  },
  %{
    "title" => "[Liveview] LiveviewとLiveComponent間の状態管理",
    "url" => "https://qiita.com/omini/items/ab70e2a300df78e36c41"
  },
  %{
    "title" => "⑤Elixirユーザ認証ライブラリ「phx_gen_auth」の本番向け改造ポイント：コントローラ内／テンプレート内のメッセージのカスタマイズ",
    "url" => "https://qiita.com/piacerex/items/6d6963e18463eb920971"
  },
  %{
    "title" => "【初心者QiitaAPI練習】Qiita内の麻雀関連記事リンク集を作ってみた。",
    "url" => "https://qiita.com/yurisg/items/f1c5d4da7cf423894d05"
  }
]
```

:tada::tada::tada:

[SORACOM](https://soracom.jp/)さんのSIMを挿した[AK-020](https://soracom.jp/store/5274/)を通じて、[Elixir](https://elixir-lang.org/)のプログラムが[Qiita API](https://qiita.com/api/v2/docs)をたたくことができました :rocket::rocket::rocket: 



## 参考(受信の参考)
- [ElixirとSORACOM Beamを使用して、Raspberry Pi 4 と Azure IoT Hub との間でデータを送受信します せっかくなのでウェブチカします](https://qiita.com/torifukukaiou/items/3514bb6331de8187e1f7)

---

# [Nerves](https://www.nerves-project.org/) meets [SORACOM](https://soracom.jp/)

復習です。
[Nerves](https://www.nerves-project.org/)は[Elixir](https://elixir-lang.org/)のIoTで
<font color="purple">$\huge{ナウでヤングなcoolなすごいヤツです🚀}$</font>

[Raspberry Pi OS](https://www.raspberrypi.com/software/)と[Nerves](https://www.nerves-project.org/)の違いです。

|  | [Raspberry Pi OS](https://www.raspberrypi.com/software/) | [Nerves](https://www.nerves-project.org/) |
|:-|:-|:-|
| ベースのOS  | Linux  | 最小規模のLinuxカーネル(※)  |
| パッケージの追加  | apt install等でいつでも  | ビルド時(必要なものはBuildrootで予め追加)  |
| デスクトップ(GUI)  | アリ  | ナシ(sshしたら、IExというElixirの世界)  |

(※)どのくらい最小規模なのかというと、デフォルトでは[SORACOM](https://soracom.jp/)さんのSIM入りドングルを挿しても何も通信ができません。
`wvdial`有りません。

- pppdありません
- usb_modeswitchありません

ではどうするかというと、必要なものは[Buildroot](https://buildroot.org/)であらかじめ自分でインストールしましょうという寸法です。

## [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)

![IMG_20211204_151423.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ec7725cb-b6a7-a472-65b6-0c2bd7a127fa.jpeg)

[SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のSIMをセットした[L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)を[Nerves](https://www.nerves-project.org/)がイゴいているRaspberry Pi 4に挿してセルラー通信を楽しんだことがあります。

https://qiita.com/torifukukaiou/items/efe528f8dbd1012ba37e

上の記事は、多少強引なところはあります。
たぶんいまでもイゴくとはおもいますが、最新の[Nerves](https://www.nerves-project.org/)と組み合わせて動作するかどうかはわかりません。
じゃあ、確かめろよ！　という話ですが、年の瀬でいろいろ詰まっておりまして手を出せていません(言い訳)。
だってめちゃくちゃ時間かかるのですもの……
ご興味のある方は[上記記事](https://qiita.com/torifukukaiou/items/efe528f8dbd1012ba37e)をご参考にトライしていただいて、忌憚のないご批正を賜り得ば大幸の至りでございます。

記事を書いたのが、2021/06です。
いまが2021/12なので、それから**半年**というのは、[Nerves](https://www.nerves-project.org/)の世界では**もう随分昔の話**なのです。
だって、なんてったって、<font color="purple">$\huge{ヤング！}$</font>ですから進化のスピードが速いのです:rocket::rocket::rocket:

https://algyan.connpass.com/event/228467/

に書いてありました。
IoTつながりということで、

**Don’t sleep through life!**
ぼーっと生きてんじゃねえよ！

まさにコレです。

ですから、[Nerves](https://www.nerves-project.org/)のことは[公式ドキュメント](https://hexdocs.pm/nerves/getting-started.html)を必ずご確認ください。
朗報です。
もしも詰まったことがあったら、ぜひぜしぜひぜひぜし、[NervesJPのSlackワークスペース](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)にご参加ください。
IoTや[Nerves](https://www.nerves-project.org/)のことが好きな愉快なfolksたちがあなたの訪れを**熱烈歓迎**します。

<font color="purple">$\huge{れっつじょいなす}$</font>

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/efe3084e-4891-9aa2-0ee3-e053c990ba4c.png)  




## [SORACOM Arc](https://soracom.jp/services/arc/) x [Nerves](https://www.nerves-project.org/)

_これからやってみます。_
_たぶんできそうな気がしています。_
_イベント当日までには更新します。_
_記事はわけるとおもいます。_

**追記**

書きました。

https://qiita.com/torifukukaiou/items/3a77efc82c48dc0ff61e


---

https://users.soracom.io/ja-jp/docs/arc/create-virtual-sim-and-connect-with-wireguard/

まずは基本通り:interrobang:、Raspberry Pi OSにWireGuardをインストールして、イゴく[^1]ことを確認できました。(ElixirのプログラムがQiita APIのコールに成功:rocket::rocket::rocket:)
応用編として[Nerves](https://www.nerves-project.org/)上でやってみます。
ビルドをしかけていますが、なかなか終わりません :sob:
ということで後日、更新します。

---

# [Nerves](https://www.nerves-project.org/)はじめてみる

[Nerves](https://www.nerves-project.org/)に興味を持っていただけましたでしょうか。
一点難点とでも申しますか、ちょっと準備(開発環境の構築)がたいへんなところがあります。
**俺コマンドバリバリっす**、みたいな人には全然たいしたことはないとおもいます。
ですが、GUIでポチポチやることが主みたいな人には最初はつらいかもしれません。

楽しむためには最初に越えなければならないハードルというものは何にでもあるものです。
それを越えた先に楽しみは必ず待っています!!!

だって私は、
<font color="purple">$\huge{日本マイクロソフト④}$</font>を[受賞](https://qiita.com/chomado/items/7d1f757f18c5b442fadd#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93)しまして、日本マイクロソフトのYouTubeチャンネルに出させてもらったことがあります。

https://www.youtube.com/watch?v=R3o8vR1A9ao

[Nerves](https://www.nerves-project.org/)をはじめて、楽しんで、Qiitaに記事投稿を続けたから受賞できたのだとおもっています。
そうして私は欲張りですから、こんなところで満足はしていません。
もっともっと楽しいことを引き寄せようとおもっています。
これは私の身に起きた楽しみです。

話を[Nerves](https://www.nerves-project.org/)に戻します。
開発環境の構築が、人によってはたいへんなことがあるのですが、<font color="purple">$\huge{朗報}$</font>です。
3つお示しします。


## ①高瀬先生の記事を参考にしながら公式を読み込む

高瀬先生の記事の通りにやればできるはずです！

https://hexdocs.pm/nerves/installation.html#content

https://qiita.com/takasehideki/items/88dda57758051d45fcf9

https://qiita.com/takasehideki/items/b8ea8b3455c70398178a

https://qiita.com/takasehideki/items/8f43f1853ce88cbbe82e#elixir%E3%81%A7iot4nerves%E3%81%A7iot%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0%E9%96%8B%E7%99%BA%E3%81%AB%E3%83%88%E3%83%A9%E3%82%A4%E7%AF%87


## ②[NervesJPのSlackワークスペース](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)に参加する

さきほどもご紹介した通り、愉快なfolksたちがあなたの訪れを熱烈歓迎します:tada::tada::tada:

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/efe3084e-4891-9aa2-0ee3-e053c990ba4c.png)  

## ③[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)

これがいま一番オススメです。
2021/12/04現在、一番簡単に[Nerves](https://www.nerves-project.org/)を体験できます。

準備するものは以下の通りです。

- パソコン(Windows or macOS)
- [Raspberry Pi Imager](https://www.raspberrypi.com/software/)
- **ヤル気**
- Raspberry Pi本体
- microSDカード
- USBカードリーダ
- LANケーブル
- 電源ケーブル

**ヤル気**から下のものは皆様お持ちでしょうし、パソコンもお持ちでしょうから、実質必要なものは[Raspberry Pi Imager](https://www.raspberrypi.com/software/)のインストールだけです。
インストーラをダウンロードしてきてポチポチやってくだされ。


# [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)

説明が面倒になってきた(ごめん:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)ので、動画を撮っておきました。
こちらを御覧ください。
動画の中で使っているソースコードはここに掲載しておきます。
細かいことはアレコレいいません。

<font color="purple">$\huge{感じてください!}$</font>

君は小宇宙(コスモ)を感じたことがあるか:interrobang:

## 基礎知識

動画をみてもらう前に少し基礎知識をご伝達いたします。
[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)を説明する前に話はWebアプリケーション開発に飛びます。


### [Phoenix](https://www.phoenixframework.org/)

- 日本のかたは、**聖闘士星矢**の一輝にならって「フェニックス」と発音しています
- 海外のかたの言い方は「フィーニックス」みたいに言っているように私には聞こえます
- [Phoenix](https://www.phoenixframework.org/)は、[Elixir](https://elixir-lang.org/)でWebアプリケーション開発を楽しむフレームワークです。
- Rubyで言うところのRuby on Rails、PHPで言うところのLaravel、Pythonで言うところのDjangoに相当します

### [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)

> Phoenix LiveView enables rich, real-time user experiences with server-rendered HTML.

### [Phoenix Livebook](https://github.com/livebook-dev/livebook)

> Livebook is a web application for writing interactive and collaborative code notebooks for Elixir, built with Phoenix LiveView. 

Pythonの[Jupyter Notebook](https://jupyter.org/)をイメージしていただけるとよいです。

### [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)

なんと、[Phoenix Livebook](https://github.com/livebook-dev/livebook)が[Nerves](https://www.nerves-project.org/)の上でイゴきます[^1]。
ざっくり別の言い方をするとRaspberry Piの上でイゴかすことができます。


## 動画

前置きが長くなりました。
動画です。

<iframe width="831" height="467" src="https://www.youtube.com/embed/-c4VJpRaIl4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



## 手順

### ファームウェアを焼く :fire::fire::fire:

1. [Raspberry Pi Imager](https://www.raspberrypi.com/software/)を開発マシンにインストールしておきます
1. https://github.com/livebook-dev/nerves_livebook/releases からお使いのターゲット(ハードウェア)に合致するファームウェアの`.zip`をダウンロードします
1. microSDカードを開発マシンに接続し、[Raspberry Pi Imager](https://www.raspberrypi.com/software/)を起動します
1. [Raspberry Pi Imager](https://www.raspberrypi.com/software/)を起動し、**CHOOSE OS** > **Use custom**と進み、ダウンロードした`.zip`ファイルを指定します
1. **CHOOSE STORAGE**にて、これからファームウェアの焼き込みをするmicroSDカードを選択
1. WRITE:fire::fire::fire:

### Livebook

1. こんがり焼き上がったmicroSDカードをターゲット(ハードウェア)に差し込んで、LANケーブルでネットワークに接続して、ターゲット(ハードウェア)の電源をON
1. 10秒〜30秒程度待って、`ping nerves.local`が通ることを確認する
1. ブラウザで`http://nerves.local`へアクセス
1. パスワードは`nerves`
1. `New notebook`から[Elixir](https://elixir-lang.org/)のプログラミングを楽しむ

## ソースコード

動画で使ったソースコードを掲載しておきます。

### メモリ使用量のグラフを描く

```elixir
alias VegaLite, as: Vl

memory = [
  total: :red,
  processes: :yellow,
  atom: :green,
  binary: :pink,
  code: :orange,
  ets: :blue
]

layers = 
  for {layer, color} <- memory do
    Vl.new()
    |> Vl.mark(:line)
    |> Vl.encode_field(:x, "iteration", type: :quantitative)
    |> Vl.encode_field(:y, Atom.to_string(layer), type: :quantitative, title: "Memory usage (MB)")
    |> Vl.encode(:color, value: color, datum: Atom.to_string(layer))
  end

widget = Vl.new(width: 500, height: 200)
  |> Vl.layers(layers)
  |> Kino.VegaLite.new()
```

```elixir
Kino.VegaLite.periodically(widget, 200, 0, fn i ->
  point =
    :erlang.memory()
    |> Enum.map(fn {type, bytes} -> {type, bytes / 1_000_000} end)
    |> Map.new()
    |> Map.put(:iteration, i)

  Kino.VegaLite.push(widget, point, window: 1000)
  {:cont, i + 1}
end)
```

```elixir
for i <- 1..1_000_000 do
  :"atom#{i}"
end
```


### Lチカ

```elixir
defmodule Example do
  use GenServer

  @pin_number 18

  def init(state) do
    {:ok, gpio} = Circuits.GPIO.open(@pin_number, :output)
    set_interval()
    {:ok, {gpio, state}}
  end

  defp set_interval() do
    Process.send_after(self(), :tick, 1000)
  end

  def handle_info(:tick, {gpio, state}) do
    Circuits.GPIO.write(gpio, state)
    set_interval()
    {:noreply, {gpio, flip(state)}}
  end

  defp flip(1), do: 0
  defp flip(0), do: 1
end

GenServer.start_link(Example, 0)
```



# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

まとめます。

2021/12/14(火) 19:30〜21:00開催の「[SORACOM UG x NervesJP #1 ~Hello, world!~](https://soracomug-tokyo.connpass.com/event/231532/)」でご説明します。


## サマリ

:::note info
We are the Alchemists, my friends!
:::

:::note info
Nervesはナウでヤングなcoolなすごいやつです🚀
:::


[Elixir](https://elixir-lang.org/)は、日本語に訳すと**不老不死の霊薬**です。
その[Elixir](https://elixir-lang.org/)と名付けられたプログラミング言語の使い手は、**Alchemist(錬金術師)**と尊称されます。

|  || 説明 |
|:-:|:-|:-|
| [Elixir](https://elixir-lang.org/)  | Fun | Elixir is a dynamic, functional language for building scalable and maintainable applications.  |
| [Nerves](https://www.nerves-project.org/)  | IoT | Nerves is the open-source platform and infrastructure you need to build, deploy, and securely manage your fleet of IoT devices at speed and scale.  |
| [Phoenix](https://www.phoenixframework.org/)  |Web| Build rich, interactive web applications quickly, with less code and fewer moving parts. Join our growing community of developers using Phoenix to craft APIs, HTML5 apps and more, for fun or at scale.  |
| [LiveView](https://github.com/phoenixframework/phoenix_live_view) |Web| Phoenix LiveView enables rich, real-time user experiences with server-rendered HTML.  |
| [Livebook](https://github.com/livebook-dev/livebook) |Web| Livebook is a web application for writing interactive and collaborative code notebooks for Elixir, built with Phoenix LiveView.  |
| [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook) |IoT| The Nerves Livebook firmware lets you try out the Nerves projects on real hardware without needing to build anything. Within minutes, you'll have a Raspberry Pi or Beaglebone running Nerves. You'll be able to run code in Livebook and work through Nerves tutorials from the comfort of your browser.|
| [Nx](https://github.com/elixir-nx/nx) |AI| Multi-dimensional arrays (tensors) and numerical definitions for Elixir|

## [NervesJP](https://nerves-jp.connpass.com/)

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

## IoTを楽しむなら

[Nerves](https://www.nerves-project.org/)

## Webアプリケーションを楽しむなら

[Phoenix](https://www.phoenixframework.org/)

## AIを楽しむなら

[Nx](https://github.com/elixir-nx/nx) + [Livebook](https://github.com/livebook-dev/livebook)


そうです。
[Elixir](https://elixir-lang.org/)でぜーんぶできちゃいます。


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">そうです！<br>大事なことを言い忘れてしまった！このデモの仕込みは <a href="https://twitter.com/torifukukaiou?ref_src=twsrc%5Etfw">@torifukukaiou</a> さんにめっちゃ助けてもらいました．awesome!! あざまっす！！ <a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> <a href="https://twitter.com/hashtag/DSF2021?src=hash&amp;ref_src=twsrc%5Etfw">#DSF2021</a> <a href="https://t.co/IlbfpPu8dI">https://t.co/IlbfpPu8dI</a></p>&mdash; Hideki Takase (@takasehideki) <a href="https://twitter.com/takasehideki/status/1456145709481148420?ref_src=twsrc%5Etfw">November 4, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

---

# 追記


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">ふとひらめき、.vmdkからrawimageファイルをlinkして、ストレージとして認識すればよいのでは？ → 成功<br>これでラズパイとかデバイス本体がなくともNervesを使えますよー。 <a href="https://t.co/mqIuQ1ATl7">pic.twitter.com/mqIuQ1ATl7</a></p>&mdash; 松下(Max)@ソラコム (@ma2shita) <a href="https://twitter.com/ma2shita/status/1468882184409075714?ref_src=twsrc%5Etfw">December 9, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

一体、ぜんたいどういうことか、私にはさっぱりわかりませんが、Raspberry Piなどのデバイスがなくても[Nerves](https://www.nerves-project.org/)をはじめられるとうのは、

![スクリーンショット 2021-12-10 8.15.09.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/db40a2a1-a96c-b5b1-af4d-6acb9cc724e2.png)

<font color="purple">$\huge{すぎょい！！}$</font>

です。
イベント当日、@ma2shita さんからお話を聞けることを楽しみにしています！

---

明日は、@ciniml さんによる「[WireGuard for ESP32あたり？](https://qiita.com/advent-calendar/2021/soracom)」です。
WireGuardの話とのことで、興味津々です:bangbang::bangbang::bangbang:
楽しみにしています〜:+1::+1::+1::+1::+1::thumbsup::thumbsup_tone1::thumbsup_tone2::thumbsup_tone3::thumbsup_tone4::thumbsup_tone5:

