---
title: Nerves Livebook demo in e-ZUKA (Nerves LivebookでクリスマスLチカ ーー うまくイゴきますように)
tags:
  - Elixir
  - Nerves
  - LiveView
  - autoracex
  - Livebook
private: false
updated_at: '2022-02-20T21:09:33+09:00'
id: 173a6d86d7a15649c5b5
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/advent-calendar/2021/nervesjp

2021/12/23(木)の回です。
前の日は、2本の投稿がありました。

- @tatsuya6502 さんによる「[NervesでRustの関数をNIFとして呼び出す最小の手順（Rustlerを使用）](https://qiita.com/tatsuya6502/items/04d2bb1fbb05735be18b)」でした
    - Rustは、[Nerves](https://www.nerves-project.org/)との相性よさそうです
    - ごく個人的な話題ですが、Rust分厚い本が積ん読のままです :sweat_smile:
- @mnishiguchi さんによる「[NervesでUTCでなくローカルタイムで時間を表示したい](https://qiita.com/mnishiguchi/items/f2be3e393c2fb895fc94)」でした
    - @mnishiguchi さんは、[Nerves](https://www.nerves-project.org/)のこと何でも知っているなあって感じです！
        - すごいです！
    - この記事の内容は、すぐにでも活用する場面がありそうです！


---

https://ezukatechnight.com/etn53_open/

2021年12月23日(木) 19:00開催:tada:の**e-ZUKA Tech Night vol.53**の発表資料(LT)です。
テーマはメタバースで、 @piacerex さんの講演があります。


## メタバースとZoomと私

私のメタバース体験です。
メタバースの波に乗り遅れた人たちが、なんとかNeos VRの中にいる人たちと交流したくてZoomから参加していますの図です。


![FG0A_ySaMAIb81m.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a96a087c-f378-f1ad-25ad-6dbbf6991561.png)

ちょうど卒業写真撮影の当日にこれなくて別撮りになってしまった**アレ**と同じです。
昔から夢だったんです、あの別枠。
おかしなものでね、撮影当日に風邪引いちゃったとかなにかやんごとなき事情で出席できなくて別枠になってしまった人の中にはそのことを不本意に思う人もいる一方で、一度はあの別枠に居座りたいと思う人がいるわけですよ。

---

# はじめに

名乗るほどのものではありませんがAwesome YAMAUCHI([@torifukukaiou](https://twitter.com/home))です。
名刺がわりのYouTube動画はコチラです。
「くらでべ azure elixir 愛」で検索 :mag:

https://www.youtube.com/watch?v=R3o8vR1A9ao

---

今日は、私が主催している[autoracex](https://autoracex.connpass.com/)の由来となっております、[飯塚オートレース場](https://autorace.jp/iizuka/)がある**e-ZUKA**にて開催される[e-ZUKA Tech Night vol.53 -メタバース-](https://ezukatechnight.com/etn53_open/)にてLTを予定しています。

## e-ZUKAってどんなまち？
- [飯塚オートレース場](https://autorace.jp/iizuka/)があります
    - 元SMAPの森且行選手が[第52回SG日本選手権オートレース](https://autorace.jp/netstadium/Ondemand/asx/kawaguchi/2020-11-03_12)を制覇した、あのバイクによる競走です
- 嘉穂劇場があります
- 伊藤伝右衛門邸があります
- 九州工業大学情報工学部、近畿大学産業理工学部があり、理系の大学生が多い街です
- 名乗るほどのものではないAwesome YAMAUCHI生誕の地です(本当は平成の大合併で合併された、関の山が我が富士であり、琵琶湖よりも広い池ーー鳥羽池を擁する旧Shonai-machi)
- https://iizukashoutengai-drone.com/


![IMG_20211212_192234.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4f0ca589-9876-5ae4-8b46-c96a71c22797.jpeg)


---

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Nerves](https://www.nerves-project.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)を楽しんでいますか:bangbang::bangbang::bangbang:



|  | 私の感じ方、ざっくりとした説明 |
|:-|:-|
| [Elixir](https://elixir-lang.org/)  | 世俗派関数型言語[^1]。なんとなく知らない間にゆるふわで「アタシ、関数型言語でプログラミングしちゃってました」 てな具合にプログラミングを楽しめます。 |
| [Phoenix](https://www.phoenixframework.org/)  | Webアプリケーションの開発を楽しめます  |
| [LiveView](https://github.com/phoenixframework/phoenix_live_view)  | 高性能なバックエンド開発もリッチなフロントエンド開発も[Elixir](https://elixir-lang.org/)一本で楽しめます！  |
| [Livebook](https://github.com/livebook-dev/livebook)  | [Jupyter](https://jupyter.org/)に相当するもの。[LiveView](https://github.com/phoenixframework/phoenix_live_view)を利用したアプリケーションの代表例ともいうべき金字塔。[LiveView](https://github.com/phoenixframework/phoenix_live_view)を利用したアプリケーションのお手本であり、最高峰。  |
|[Nerves](https://www.nerves-project.org/)| [Elixir](https://elixir-lang.org/)でIoTを楽しめるフレームワークです。(誤解を恐れずにいえば)[Nerves](https://www.nerves-project.org/)は、[Elixir](https://elixir-lang.org/)専用OSです!!! sshで中に入ったら`iex>`~~しかできません~~だけができて**一生[Elixir](https://elixir-lang.org/)だけを楽しめます:rocket::rocket::rocket:**　|
|[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook) |[Livebook](https://github.com/livebook-dev/livebook)は、[Nerves](https://www.nerves-project.org/)の上でイゴきます[^2]|

# [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook) Demo

デモをします。 ーー うまくイゴき[^2]ますように
構成: パソコン - モバイルWiFiルータ(※) - Nerves Livebook Firmware on Raspberry Pi 4


![スクリーンショット 2021-12-23 7.45.28.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/14d01560-14db-1e3f-dc54-3c21ae4f9216.png)

(※) 外でデモができるように「モバイルWiFiルータ」を使っています。ご自宅のネットワーク環境に接続して楽しむことはもちろんできます。

# Let's get started!!! Yes we can.

あなたもやってみたくなりましたよね。

簡単です。
**[Raspberry Pi Imager](https://www.raspberrypi.com/software/)**というGUIツールでダウンロードしたファームウェアをmicroSDカードに差し込んで、Raspberry Piに差し込んで立ち上げると、あとはブラウザ上で[Elixir](https://elixir-lang.org/)のプログラミングを楽しめます。

Visit: http://nerves.local

動画を用意しました。
ご覧になってください。

<iframe width="924" height="520" src="https://www.youtube.com/embed/UyPnM3AZBDU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


## Setup

Setupについては、

https://qiita.com/torifukukaiou/items/117cc23963b55ae3fc5d#nerves-livebook-1

をご参照ください。

## コードスニペット

コードスニペットは、

https://qiita.com/torifukukaiou/items/27abc5b84f6f55f85d71#%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%A0notebook%E3%82%92%E6%9B%B8%E3%81%8F

をご参照ください。


## :worried::worried::worried::worried::worried:

わからないことがありましたらぜひ、[NervesJPのSlackワークスペース](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)に飛び込んできてください。
IoTや[Nerves](https://www.nerves-project.org/)、[Elixir](https://elixir-lang.org/)が大好きなfolksたちがあなたの訪れを**熱烈歓迎**します :tada::tada::tada:


# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

<font color="purple">$\huge{Enjoy\ Elixir🚀🚀🚀}$</font>

クリスマスプレゼント :gift: をいくつか持っていきます :bangbang::bangbang::bangbang:

- Amazonギフト券 1,000円(未使用)
    - [みんなのラズパイコンテスト 2021](https://project.nikkeibp.co.jp/pc/rpic/) スタートダッシュ**賞** によりいただきました 
    - :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:  
- 天領ひた クリアファイル(未使用)

---

_コロナに負けない！ GoTo飯塚商店街_

https://iizukashoutengai-drone.com/


---


# おまけ

[Elixir](https://elixir-lang.org/)を始めてみよう！　とおもった、あなたに参考情報(クリスマス🎄プレゼント)を贈ります。:gift::gift::gift:
**思い立ったが吉日です!!!**

## オススメの書籍 :books: 
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/) -- オーム社
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス
- [アルケミスト 夢を旅した少年](https://www.kadokawa.co.jp/product/199999275001/) -- 角川文庫

## Webアプリケーションを楽しむなら
- [Phoenix](https://www.phoenixframework.org/)

## IoTを楽しむなら
- [Nerves](https://www.nerves-project.org/)

## AIを楽しむなら
- [Nx](https://github.com/elixir-nx/nx) + [Livebook](https://github.com/livebook-dev/livebook)

## コミュニティ
-  [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slack workspaceに参加してみてください
    - マヂ、やさしい人ばっかりのコミュニティ
    - あなたの**困った**をきっと解決してくれるでしょう
- [NervesJP](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA) Slack workspaceでは、[Nerves](https://www.nerves-project.org/)やIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
- たくさんのコミュニティがあります
    - @kn339264 さん作の素敵な資料をご紹介します
    - [Elixirコミュニティ の歩き方〜国内オンライン編〜](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian) :clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:

![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)
@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:



---

明日は、次の2本の予定です。楽しみにしています〜 :christmas_tree::christmas_tree::christmas_tree:

- [オレオレハード＋Nervesの設計モデルを考えて実装したよ！](https://qiita.com/32hero/items/58c9d7d37786cb1fcd43)
- [NervesとPhoenixでPonchoしたい](https://qiita.com/mnishiguchi/items/99cb5dae38e4abcac326) 

(もう両方みております、です！！！)

---



[^1]: @kikuyuta 先生の「[世俗派関数型言語 Elixir を関数型言語風に使ってみたらやっぱり関数型言語みたいだった](https://qiita.com/kikuyuta/items/afa4c264720eb29d9760)」より。[Elixir](https://elixir-lang.org/)はコワくないですよ〜。

[^2]: 「動きます」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^3]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg=

[^3]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。
