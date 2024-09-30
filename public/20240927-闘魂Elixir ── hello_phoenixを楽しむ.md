---
title: 闘魂Elixir ── hello_phoenixを楽しむ
tags:
  - Elixir
  - Phoenix
  - Nerves
  - 猪木
  - 闘魂
private: false
updated_at: '2024-09-29T10:22:09+09:00'
id: 19c9915ba648cf6f8d37
organization_url_name: haw
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


# はじめに

私達[ハウインターナショナル](https://www.haw.co.jp/)（福岡県飯塚市）は、毎月月末の金曜日に社内ハッカソンを開催しています。
社名に引っ掛けて **[ハウッカソン](https://www.haw.co.jp/office/hawckathon/)** と呼んでいます。

本日（2024-09-27）、私が取り組んだことをご紹介します。

私は[Elixir](https://elixir-lang.org/)というプログラミング言語が好きです。
理由を挙げればキリがありません。
端的に言うと、「好きなものは好きなのです」これしかありません。
これ以上の理由が必要でしょうか。

# [hello_phoenix](https://github.com/nerves-project/nerves_examples/tree/main/hello_phoenix)

今回、題材にした[hello_phoenix](https://github.com/nerves-project/nerves_examples/tree/main/hello_phoenix)を説明します。

[Elixir](https://elixir-lang.org/)にはIoT開発に特化した[Nerves](https://nerves-project.org/)というフレームワークがあります。簡単にRaspberry Piなどのデバイス上で動かすことができます。
また[Elixir](https://elixir-lang.org/)には、[Phoenix](https://www.phoenixframework.org/)という、これまたすんごいWebアプリケーションフレームワークがあります。

[Nerves](https://nerves-project.org/)の上で、[Phoenix](https://www.phoenixframework.org/)のアプリケーションを動かしてみましょうという欲張りなことをするサンプルプロジェクト ── それが、[hello_phoenix](https://github.com/nerves-project/nerves_examples/tree/main/hello_phoenix)です。

データベースは[SQLite](https://www.sqlite.org/)を使用してCRUDを楽しめるサンプルです。

# 実行環境

実行環境を記しておきます。

- macOS Sonoma 14.6.1
- Elixir: 1.17.2-otp-27
- Erlang: 27.0.1
- [Nervesを楽しむためのセットアップ](https://hexdocs.pm/nerves/installation.html)済
- Raspberry Pi 4

Elixirのインストールはいつも @zacky1972 先生の記事を参照しながらやっています。
常に最新版での手順を更新し続けられています。ありがとうーーーッ！！！ございます。

https://qiita.com/zacky1972/items/c94baef2ee9379c21fa1

# Run

[README](https://github.com/nerves-project/nerves_examples/blob/main/hello_phoenix/README.md)の通りにやればできました。

コマンドを羅列しておきます。

```
git clone https://github.com/nerves-project/nerves_examples.git
cd nerves_examples/hello_phoenix
export MIX_TARGET=rpi4
export NERVES_NETWORK_SSID=your_wifi_name
export NERVES_NETWORK_PSK=your_wifi_password
cd ui
mix deps.get
mix assets.deploy
cd ../firmware
mix deps.get
mix firmware
mix burn
```

以下、補足です。

- `MIX_TARGET`に指定する値はお使いのデバイスを指定してください
    - `rpi4`以外に指定できるものは、[Supported Targets and Systems](https://hexdocs.pm/nerves/supported-targets.html#supported-targets-and-systems)をご参照ください
- `NERVES_NETWORK_SSID`と`NERVES_NETWORK_PSK`の値はお使いのWi-Fiの認証情報で読み替えてください（Wi-Fiを使用せずにLANケーブルでネットワークに接続する場合は不要です)
- `mix burn`コマンドはファームウェアをmicroSDカードへ焼き込むコマンドです
- `mix burn`コマンドを実行するまえに、microSDカードを開発PCに差し込んでおいてください
- ファームウェアの更新は `mix upload` で、Over the Airで更新することができます
    - ここで言う **Over the Air** とは、例としては、Wi-Fiで開発PCをネットワークに接続しているとして、Raspberry Piが同じネットワークにあると、開発PCから`mix upload`コマンドを叩くだけでRaspberry Piを一切触らずにファームウェアを更新できることを指しています
    - microSDカードをデバイスから抜かずに更新できるのでけっこううれしい開発体験です
    - 仕組みが氣になる方は以下のドキュメントをご参照ください
        - https://hexdocs.pm/nerves_ssh/readme.html
        - https://hexdocs.pm/ssh_subsystem_fwup/readme.html
        - SSHが使われています。ファームウェアには開発PCが持っている公開鍵が焼き込まれていて、秘密鍵を持っているPCからの更新要求のみを受け付けているというのがざっくりとした説明です。

## microSDカードにファームウェアを焼き込んだあと

こんがり焼き上がったmicroSDカードをデバイスに装着し、 **迷わず** 電源ONです。
10秒程度まったあと、 http://nerves.local にブラウザでアクセスしてください。

![スクリーンショット 2024-09-27 14.05.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/35277828-2aed-879f-4d86-eb892faa004a.png)

こんな画面が表示されるはずです :tada::tada::tada:

（mDNSという仕組みで（ちゃんと説明できない、ごめん🙏）で、`nerves.local`でアクセスできるはずですが、うまくいかないときは `arp -a` とかでネットワークに新しく接続されたデバイスのIPでアクセスを危ぶむことなく、踏み出してみてください）

## CRUDを楽しむ！

http://nerves.local/users
にアクセスしてみてください。

### Create

Createを楽しめます。

![スクリーンショット 2024-09-27 10.52.25.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0fb1c892-22f6-8730-cf46-91341591302d.png)


### Read

Readを楽しめます。

![スクリーンショット 2024-09-27 10.53.00.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b119124d-05fa-10c7-0135-f4fb878c16f0.png)


### Update

Updateを楽しめます。

![スクリーンショット 2024-09-27 10.53.11.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c5704146-5173-00ce-0a85-47c43d49165b.png)

### Delete

Deleteをもちろん楽しめます。

![スクリーンショット 2024-09-27 10.53.20.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ecc9c395-61d6-f6d5-8dc1-6744ec99c60e.png)


## [Phoenix](https://www.phoenixframework.org/)アプリの開発

さらに機能を追加したい場合には、このあたりを参考にして機能追加をしてください。


https://hexdocs.pm/phoenix/overview.html

https://hexdocs.pm/phoenix_live_view/welcome.html

画面をここではお見せすることはできませんが、[Phoenix LiveView Course](https://pragmaticstudio.com/phoenix-liveview)というオンデマンドのビデオ教材（つまり通信教育）で学んだ、景気のいい売上ダッシュボード（Snappy Sales）を組み込んだら、もちろん動かすことができました。


---

# ランチ

福岡県飯塚市には、[レイダック](https://www.rayduck1986.com/)という、とてもおいしいハンバーガーショップ 🍔 があります。


![2024-09-27_12-31-27_419.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b1dacb1d-6fd9-d30b-9ba8-e7b67a4ac5ae.png)

ハウッカソンの日は、会社の経費で、ハンバーガーランチを食べています！！！


本当においしいです！　吉田松陰先生や坂本龍馬さんが長崎へ行く際にきっと立ち寄った、おそらく一泊くらいはしたはずの**飯塚**にお立ち寄りの際は[レイダック](https://www.rayduck1986.com/)のハンバーガーをぜひ食べてみてください！

---

# さいごに

「[Raspberry PiにRailsサーバーを立てて運用する](https://qiita.com/tsuruoka91/items/795912d44f821feadbfb)」という記事を会社のメンバーが書きました。
それをみて、「Ruby on Rails ON Raspberry Pi OSももちろんいいですけど、[hello_phoenix](https://github.com/nerves-project/nerves_examples/tree/main/hello_phoenix)もいいですよ。ぜひこちら（Elixir）がわの世界へお越しください」と誘いました。

ちょっと待てよ、と。自分自身が[hello_phoenix](https://github.com/nerves-project/nerves_examples/tree/main/hello_phoenix)を動かしたことがないことに愕然としました。そこで、[ハウッカソン](https://www.haw.co.jp/office/hawckathon/)で楽しんでみました。

ハンバーガーが本当においしかったので、そのこともお伝えしたく、記事をしたためました。

これからも、ハンバーガー片手に、[Nerves](https://nerves-project.org/)や[Phoenix](https://www.phoenixframework.org/)、つまりは[Elixir](https://elixir-lang.org/)を楽しんで行きます！！！


https://qiita.com/tsuruoka91/items/795912d44f821feadbfb

---

そうそう、ビッグニュースがありました！！！

paiza×Qiita記事投稿キャンペーン「[プログラミング問題をやってみて書いたコードを投稿しよう！](https://qiita.com/official-events/9ab96aa95d62fe3cbdd7)」というキャンペーンで、 @haw_ohnuma が最優秀賞（Apple Watch）を受賞しました :tada::tada::tada:

そして私もギリ！？、入賞（Amazonギフトカード500円分）を果たすことができました！

paizaさん、Qiitaさん、ありがとうーーーッございました！！！

https://zine.qiita.com/event/202409-paiza/

https://qiita.com/haw_ohnuma/items/534541678945d6b33fc0

https://qiita.com/torifukukaiou/items/966b71497f04c7fb5882

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
