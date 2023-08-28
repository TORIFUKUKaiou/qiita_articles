---
title: Livebookの基礎知識 ーー LiveView JP#4：Livebook始めよう＋Fly.ioでモブプロのLT資料
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-02-22T22:21:03+09:00'
id: d1f2e8e3ec2869566b93
organization_url_name: fukuokaex
slide: false
---
**春すぎて夏来にけらし白たへのころもほすてふあまの香具山**

Advent Calendar 2022 51日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
2月22日(火)に行われる**LiveView JP#4：Livebook始めよう＋Fly.ioでモブプロ**のLT資料です。

https://liveviewjp.connpass.com/event/237625/

# 説明すること

この資料で説明すること（もくじ）です。

- What's [Livebook](https://github.com/livebook-dev/livebook)?
- [Livebook](https://github.com/livebook-dev/livebook)の動かし方
- Notebookデモ


# What's [Livebook](https://github.com/livebook-dev/livebook)?

[Livebook](https://github.com/livebook-dev/livebook)とは、**Elixir's version of Jupyter Notebooks**です。

> Livebook is an exciting advancement in the Elixir community. It was created for the Elixir machine learning library nx. You can think of it as Elixir's version of Jupyter Notebooks.

[https://fly.io/docs/app-guides/elixir-livebook-connection-to-your-app/](https://fly.io/docs/app-guides/elixir-livebook-connection-to-your-app/)

以下、**ド派手な**（象徴的な）サンプルです。

![スクリーンショット 2022-02-20 21.07.41.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/86b8811d-5cb3-bb2b-fa85-9a91530fbeda.png)



## 私の感じ方、ざっくりとした説明

私の感じ方、ざっくりとした説明をご紹介します。

|  | 私の感じ方、ざっくりとした説明 |
|:-|:-|
| [Elixir](https://elixir-lang.org/)  | 世俗派関数型言語[^2]。なんとなく知らない間にゆるふわで「アタシ、関数型言語でプログラミングしちゃってました」 てな具合にプログラミングを楽しめます。 |
| [Phoenix](https://www.phoenixframework.org/)  | Webアプリケーションの開発を楽しめます  |
| [LiveView](https://github.com/phoenixframework/phoenix_live_view)  | 高性能なバックエンド開発もリッチなフロントエンド開発も[Elixir](https://elixir-lang.org/)一本で楽しめます！  |
| [Livebook](https://github.com/livebook-dev/livebook)  | [Jupyter](https://jupyter.org/)に相当するもの。[LiveView](https://github.com/phoenixframework/phoenix_live_view)を利用したアプリケーションの代表例ともいうべき金字塔。[LiveView](https://github.com/phoenixframework/phoenix_live_view)を利用したアプリケーションのお手本であり、最高峰。  |
|[Nerves](https://www.nerves-project.org/)| [Elixir](https://elixir-lang.org/)でIoTを楽しめるフレームワークです。(誤解を恐れずにいえば)[Nerves](https://www.nerves-project.org/)は、[Elixir](https://elixir-lang.org/)専用OSです!!! sshで中に入ったら`iex>`~~しかできません~~だけができて**一生[Elixir](https://elixir-lang.org/)だけを楽しめます:rocket::rocket::rocket:**　|
|[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook) |[Livebook](https://github.com/livebook-dev/livebook)は、[Nerves](https://www.nerves-project.org/)の上でイゴきます[^3]|

[^2]: @kikuyuta 先生の「[世俗派関数型言語 Elixir を関数型言語風に使ってみたらやっぱり関数型言語みたいだった](https://qiita.com/kikuyuta/items/afa4c264720eb29d9760)」より。[Elixir](https://elixir-lang.org/)はコワくないですよ〜。

[^3]: 「動きます」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^4]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg=

[^4]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。



# [Livebook](https://github.com/livebook-dev/livebook)の動かし方

[Livebook](https://github.com/livebook-dev/livebook)の動かし方を説明します。
[Docker](https://www.docker.com/)をインストールしておいてください。

## ローカルマシン

ローカルマシンで動かす手順を説明します。

[https://github.com/livebook-dev/livebook](https://github.com/livebook-dev/livebook) に書いてあるコマンド例に従ってください。
2022/02/20時点で書いてある内容を転載しておきます。
お使いになるときの最新の情報でお試しください。

```
docker run -p 8080:8080 -p 8081:8081 --pull always livebook/livebook
```


## [fly.io](https://fly.io/)

[fly.io](https://fly.io/)で動かす手順を説明します。
いつでもどこでもElixirを楽しめるようになります。

[fly.io](https://fly.io/)は、[Phoenix](https://www.phoenixframework.org/)とめちゃくちゃ相性のいいPaaSです。
2つ紹介します。

### ① https://fly.io/launch/livebook

この[ページ](https://fly.io/launch/livebook)からポチポチやるとすぐにできます。

https://fly.io/launch/livebook

![スクリーンショット 2022-02-20 21.23.18.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/56debfa2-6007-464c-5c48-0d1e81c08f58.png)




注意点としては、`LIVEBOOK_PASSWORD`を覚えておいてください。
もし忘れちゃった場合は、以下のように値を上書きしてください。

```
flyctl --app your-app-name secrets set LIVEBOOK_PASSWORD="securesecret"
```

- `--app your-app-name`はアプリ名で上書きしてください
    - アプリ名が不明な場合は、`flyctl list apps`で一覧から確認してください
- 説明が前後しますが、「[Installing flyctl](https://fly.io/docs/getting-started/installing-flyctl/)」に従って`flyctl`コマンドをインストールしておいてください

### ② Dockerfile

Dockerfileを用意するだけの方法を紹介します。

[Deploy Your Application via Dockerfile](https://fly.io/docs/getting-started/dockerfile/)
が参考になります。

Dockerfileは以下の1行だけです。

```Dockerfile:Dockerfile
FROM livebook/livebook:0.5.2
```

- `0.5.2`は2022/02/20時点の最新です。
- [DockerHub](https://hub.docker.com/r/livebook/livebook/tags)にて最新のバージョンをご確認ください。

上記の`Dockerfile`をおいたディレクトリにて以下のように操作します。
説明が前後しますが、「[Installing flyctl](https://fly.io/docs/getting-started/installing-flyctl/)」に従って`flyctl`コマンドをインストールしておいてください。

#### flyctl launch -- Launch a new app

[fly.io](https://fly.io/)上のアプリを作ります。

```
flyctl launch
```

- `App Name (leave blank to use an auto-generated name):`はお好きな名前か自動生成に任せましょう
- `Would you like to setup a Postgresql database now?`は`No`でよいです
- `Would you like to deploy now?`は`No`でよいです

この操作でローカルには、`fly.toml`ファイルができあがります。

#### 環境変数の設定

続いて環境変数`LIVEBOOK_PASSWORD`を設定しておきます。


```
flyctl --app dark-river-20 secrets set LIVEBOOK_PASSWORD="securesecret"
```

- `--app dark-river-20`は、ご自身のアプリ名に書き換えてください。
- アプリ名を忘れちゃった場合は、`fly.toml`ファイルの中身を確認してください

#### flyctl deploy --detach

さあ、デプロイです。

```
flyctl deploy --detach
```

デプロイできました。
:tada::tada::tada:

私が[作ったもの](https://dark-river-20.fly.dev/)を公開しておきます。
どうぞご自由にお使いください。

[https://dark-river-20.fly.dev/](https://dark-river-20.fly.dev/)

https://dark-river-20.fly.dev/

パスワードは、`securesecret`です。






# Notebookデモ

当日、Notebookのデモをします。
[Elixir](https://elixir-lang.org/)を楽しみます。

**Welcome to Livebook**を説明しながら動かします。


---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>
<font color="purple">$\huge{Enjoy\ Livebook🚀}$</font>

この記事では、Livebookの基礎知識をまとめました。

さあ、このあとも[**LiveView JP#4：Livebook始めよう＋Fly.ioでモブプロ**](https://liveviewjp.connpass.com/event/237625/)をお楽しみください:rocket::rocket::rocket:


---


# 付録

以下、付録です。





[Elixir](https://elixir-lang.org/)の誕生日は、2012年5月24日です。
そのため、今年の2022年5月24日は10周年を迎えます。

```elixir
iex> Date.diff(~D[2022-05-24], ~D[2022-02-18])
95
```


そうそう！
2月24日発売予定の[WEB+DB PRESS](https://gihyo.jp/magazine/wdpress)で、[Elixir](https://elixir-lang.org/)と[Phoenix](https://www.phoenixframework.org/)の特集がでますよ〜

[Elixir](https://elixir-lang.org/)、[Phoenix](https://www.phoenixframework.org/)をはじめられたばかりの方も、腕におぼえがある方も、どんなものなのかなあと様子見をきめこんでいる方も、
つまりは
<font color="purple">$\huge{全人類のみなみなさま！！！}$</font>
**お手にとって、お楽しみください!!!**

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">We, <a href="https://twitter.com/tamanugi?ref_src=twsrc%5Etfw">@tamanugi</a> <a href="https://twitter.com/torifukukaiou?ref_src=twsrc%5Etfw">@torifukukaiou</a> <a href="https://twitter.com/the_haigo?ref_src=twsrc%5Etfw">@the_haigo</a> <a href="https://twitter.com/mokichi_s12m?ref_src=twsrc%5Etfw">@mokichi_s12m</a> including me, wrote featured articles for WEB+DB PRESS Vol.127 about Elixir and Phoenix! It&#39;s being published on 24, Feb.<a href="https://t.co/UPNiVU1zG9">https://t.co/UPNiVU1zG9</a></p>&mdash; 栗林健太郎 (@kentaro) <a href="https://twitter.com/kentaro/status/1489441847130746880?ref_src=twsrc%5Etfw">February 4, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

## [fukuoka.ex特別編:WEB+DB PRESS vol127 Phoenix特集こたつで座談会](https://fukuokaex.connpass.com/event/239094/)

https://fukuokaex.connpass.com/event/239094/

出版記念イベントが開催されます。
ぜひご参加ください。

**2022/03/08(火) 19:30 〜 21:00**
**この本を多くの方に知っていただき、出版という ”おめでたい” イベントを、執筆陣全員と皆さまで、ぜひ同じこたつに入ってのんびり座談会するかのように楽しんでいただきたいと思います。**


---


# [Elixir](https://elixir-lang.org/)

最後の最後に、[Elixir](https://elixir-lang.org/)について紹介します。

- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)でスイスイ、プログラミングしていくことができる素敵なプログラミング言語です
- さっそくプログラムの例を示します
- [Qiita API](https://qiita.com/api/v2/docs)を使わせていただいて、`Elixir`タグがついた最新の記事を20件取得しています
- ここでは雰囲気をつかんでいただければ大丈夫です

```elixir
Mix.install [{:req, "~> 0.2.1"}]

"https://qiita.com/api/v2/items?query=tag:Elixir"
|> URI.encode()
|> Req.get!(finch_options: [pool_timeout: 50000, receive_timeout: 50000])
|> Map.get(:body)
|> Enum.map(& Map.take(&1, ["title", "url"]))

```

## Webアプリケーションを楽しむなら
- [Phoenix](https://www.phoenixframework.org/)

## IoTを楽しむなら
- [Nerves](https://www.nerves-project.org/)

## AIを楽しむなら
- [Nx](https://github.com/elixir-nx/nx) + [Livebook](https://github.com/livebook-dev/livebook)

## もっと[Elixir](https://elixir-lang.org/)のことを知りたい方へオススメの書籍 :books: 
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/) -- オーム社
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス
- [アルケミスト − 夢を旅した少年](https://www.kadokawa.co.jp/product/199999275001/) -- KADOKAWA

## コミュニティ
- [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slack workspaceに参加してみてください
    - マヂ、やさしい人ばっかりのコミュニティ
    - あなたの**困った**をきっと解決してくれるでしょう
- [NervesJP Slack](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA) workspaceでは、NervesやIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
- たくさんのコミュニティがあります
![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)
([EDI／fukuoka.ex／kokura.ex](https://fukuokaex.connpass.com/) ＆ [LiveView JP](https://liveviewjp.connpass.com/) の @piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)



# <u><b>Elixirコミュニティに初めて接する方は下記がオススメです</b></u>

**Elixirコミュニティ の歩き方 －国内オンライン編－**<br>
https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian
[![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/155423/f891b7ad-d2c4-3303-915b-f831069e28a4.png)](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian)
([piyopiyo.ex](https://piyopiyoex.connpass.com/) ＆ [エリジョ](https://elijo.connpass.com/) の nakoさん(@kn339264) 作、素敵な資料:clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:)

# [Elixir](https://elixir-lang.org/)のイベント情報

@koga1020 さんが作成されたイベントカレンダーがあります。
[https://elixir-jp-calendar.fly.dev/](https://elixir-jp-calendar.fly.dev/)

https://elixir-jp-calendar.fly.dev/

気になるイベントにはぜひ参加してみましょう!!!

上記サイトの解説記事は[こちら](https://zenn.dev/koga1020/articles/6e67765cc53539)です。

https://zenn.dev/koga1020/articles/6e67765cc53539


---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)






