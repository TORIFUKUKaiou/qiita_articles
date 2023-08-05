---
title: Nerves超入門 ーー Nervesを使った開発の日常風景（景色）、ElixirでIoTを楽しむ
tags:
  - Elixir
  - Nerves
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2023-03-23T21:27:45+09:00'
id: 91441a14dcf66472af39
organization_url_name: fukuokaex
slide: false
---
# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

今日は、[Elixir](https://elixir-lang.org/)でIoTを楽しめる[ナウでヤングでcool](https://www.slideshare.net/takasehideki/elixirnervescool-249038510)な[Elixir](https://elixir-lang.org/)専用OS:interrobang:といっても過言ではない[Nerves](https://www.nerves-project.org/)の楽しみ方をご紹介します。

以下のような方を想定しています。

- [Elixir](https://elixir-lang.org/)をすでに楽しんでいて、[Nerves](https://www.nerves-project.org/)やってみようかなあとおもっている人
- IoTバリバリです！　世俗派関数型言語[^6][Elixir](https://elixir-lang.org/)で、IoTを楽しんでみたい人

[^6]: @kikuyuta 先生の「[世俗派関数型言語 Elixir を関数型言語風に使ってみたらやっぱり関数型言語みたいだった](https://qiita.com/kikuyuta/items/afa4c264720eb29d9760)」より。[Elixir](https://elixir-lang.org/)はコワくないですよ〜。

つまりは
<font color="purple">$\huge{全人類}$</font>
が対象です！！！

# 最低限必要なもの

最低限必要なものをご紹介します。

- Raspberry Pi 4 (4GBモデル)[^1]
- microSDカード 16GB[^2]
- AC-DCアダプタ（Type-C, 5V3A）
- （必要に応じて）メモリカードリーダ

ここでは、何も持っていない人が０からはじめてみようというその**心意気**に応えたいとおもっています。
Raspberry Pi 4じゃなくてもよいのですが、そういうことを言い出すとはじめての方は迷うでしょうし、私自身はすべてのハードウェアで試したわけではございませんので、私自身が持っているものの中で最高の性能を誇るものをオススメしております。

メモリカードリーダは、PCにつないでmicroSDカードにファームウェアを焼き込むときに使います。
お使いの開発マシンに適合するものをお選びください。
PCにSDカードを差し込める機器の場合は不要です。

そのほか使用できるものについては、注釈に補足をしています。

以下、Raspberry Pi 4前提で書きます。

[^1]: [Nerves](https://www.nerves-project.org/)がデフォルトで対応しているハードウェアの一覧は、 https://hexdocs.pm/nerves/targets.html#supported-targets-and-systems です。カスタマイズ次第でどんなハードウェアでも動作させることは可能です。ただ、私は移植する腕は持っていません。

[^2]: microSDカードのサイズはもっと小さくてもよいはずです。なんとなくみなさん16GBを購入して使っているようですので、この記事では16GBをオススメしておきます。

# 手軽に、[Nerves](https://www.nerves-project.org/)を楽しみたい

奥さん、**朗報**です。
[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)というものがありまして、これを使うのがいま一番簡単に[Nerves](https://www.nerves-project.org/)を楽しめます。

まずはこちらの動画をご覧ください。

<iframe width="866" height="487" src="https://www.youtube.com/embed/-b5TPb_MwQE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[公開されているファームウェア](https://github.com/livebook-dev/nerves_livebook/releases)をダウンロードしてmicroSDカードに焼き込んだあとは、それをRaspberry Piに挿し込むだけで、PCのブラウザ経由で[Nerves](https://www.nerves-project.org/)を楽しめます。
いま**一番簡単**に、[Nerves](https://www.nerves-project.org/)を**楽しめる方法**です。

ただし、上記の動画の通りに進めるには、事前に[fwup](https://github.com/fwup-home/fwup)のインストールが必要です。

[fwup](https://github.com/fwup-home/fwup)をインストールなしにGUIツールだけで！　楽しむ方法は次のビデオです。
次のビデオは、私がつくったものでして、いろいろと雑なところは申し訳ないです:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
LANケーブルでRaspberry Pi 4をご家庭のネットワークに参加させることがポイントです。（動画では抜けています :sweat_smile:）

<iframe width="866" height="487" src="https://www.youtube.com/embed/-c4VJpRaIl4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

この2つをみていただくと、だいたい雰囲気を掴んでいただけるとおもいます。

---

# 本格的に、[Nerves](https://www.nerves-project.org/)を楽しみたい!!!

本格的に、[Nerves](https://www.nerves-project.org/)を楽しみたい方は以下を参考にしてください。

## インストール

本格的に、楽しむためには少しの準備が必要です。
詳細は下記のリンクをご参照ください。

- 公式の[Installation](https://hexdocs.pm/nerves/installation.html)

日本語の記事は、 @takasehideki 先生の記事がオススメです。

- macOS, Linuxの方: [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
- Windowsの方: [ElixirでIoT#4.1.1：WSL 2でNerves開発環境を整備する](https://qiita.com/takasehideki/items/b8ea8b3455c70398178a)


## 日常風景（景色）

開発マシンにて以下のような操作の流れで開発を進めます。
これを日常風景はたまた**景色**と呼んでいます。

```bash
$ mix nerves.new hello_nerves
$ cd hello_nerves
$ export MIX_TARGET=rpi4
$ mix deps.get
(機能追加などをします)
$ mix firmware
```

以上で、ファームウェアがビルドできました。
microSDカードをPCと接続して以下のコマンドで焼き込みをします。

```bash
$ mix burn
```

[Nerves](https://www.nerves-project.org/)ファームウェアがこんがりと焼き上がったmicroSDカードをRaspberry Pi 4に挿し、LANケーブルでご家庭のネットワークに接続[^4]して、電源ONです。
10秒ほど待つと、`ssh`できます。

```elixir
$ ssh nerves.local
```

`IEx`が立ち上がってきます。
[Elixir](https://elixir-lang.org/)を一生楽しめます！
めでたしめでたし :tada::tada::tada: 

[^4]: WiFiで接続したい場合は、[ココ](https://github.com/nerves-networking/vintage_net/blob/main/docs/cookbook.md#wifi)をご参照ください。

さてさて、[Elixir](https://elixir-lang.org/)を楽しんでいる、あなたはさらに機能追加をしました。
たとえば、モジュールの追加、関数の追加などです。

もちろん変更内容を反映させたいですよね!!!

_Raspberry Pi 4の電源を切って、microSDカードを抜いて、PCに挿し込んで……_
いやいや、**ちょっと待ってください!!!**

奥さん、
<font color="purple">$\huge{朗報}$</font>
です!!!
次のコマンドにてRaspberry Pi 4で動いている[Nerves](https://www.nerves-project.org/)ファームウェアを更新できます:rocket::rocket::rocket:

```bash
$ mix upload
```

ここでご紹介した上記の手順（日常風景）は、公式の[Getting Started](https://hexdocs.pm/nerves/getting-started.html)が該当します。








# わからないことがあったら、ご不明な点がございましたら [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2) [NervesJP](https://nerves-jp.connpass.com/)コミュニティ

[NervesJP](https://nerves-jp.connpass.com/)コミュニティに飛び込んできてください。
あなたの訪れを**熱烈歓迎**します!!!
[Slackをご用意](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)しております。
参加は[コチラ](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)からできます。

Twitterのハッシュタグは[#NervesJP](https://twitter.com/hashtag/NervesJP)です。

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>
<font color="purple">$\huge{Enjoy\ Nerves🚀}$</font>

今回は、以下を書きました。

- [Nerves](https://www.nerves-project.org/)を手軽に始めるには、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)がオススメです
- [Nerves](https://www.nerves-project.org/)で開発する日常風景（景色）をご紹介しました

ここまで読んでくださいまして、
<font color="purple">$\huge{ありがとうございます！}$</font>


以上です。

---

