---
title: ElixirのWebアプリケーションフレームワーク「Phoenix」の読み方
tags:
  - Elixir
  - ポエム
  - Phoenix
  - 40代駆け出しエンジニア
  - autoracex
private: false
updated_at: '2022-08-17T20:26:02+09:00'
id: c9671fded10d20bd2f31
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**たとえ後で罪を得ても座視しているわけにはいかない。**

Advent Calendar 2022 27日目[^1]の記事です。
I'm ready for 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I can't wait for 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Elixir](https://elixir-lang.org/)でWebアプリケーション開発を楽しむには、[Phoenix](https://www.phoenixframework.org/)を使います。

ところで、みなさんは[Phoenix](https://www.phoenixframework.org/)をどんなふうに発音していますか。

<font color="purple">$\huge{フェニックス}$</font>
と日本に住んでいる多くの方は発音しているとおもいます。
これは**聖闘士星矢**の影響だとおもいます[^2]。

[^2]: テキト〜　に言っています。真に受けないでください。:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

海外のAlchemistたちは、どうも「フェニックス」とは言っていないような気がします。

どう発音するのか調べてみました。

<font color="purple">$\huge{フィニック(ス)}$</font>
と私には聞こえています。
最後のスは言っているか言っていないかくらいの小ささです。


# 発音記号

`fíːniks`


:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

あ、ごめん。
私コレ出されてもよくわかりません :sweat_smile: 

 
# 実際に聞いてみよう

YouTubeから、[Phoenix](https://www.phoenixframework.org/)と言っているできるだけピンポイントの瞬間をご紹介します。

## [Chris McCord](https://twitter.com/chris_mccord)さん

[Phoenix](https://www.phoenixframework.org/)の作者です。

https://www.youtube.com/watch?v=MZvmYaFkNJI&t=4s

## [José Valim](https://twitter.com/josevalim)さん

[Elixir](https://elixir-lang.org/)の作者です。

https://www.youtube.com/watch?v=bk3icU8iIto&t=14s


みなさんには、どう聞こえましたか？

# ジョン万次郎方式

https://englishbootcamp.jp/?p=16241

そういうものがあるんです。
幕末に活躍された方です。

> 万次郎達は足摺岬の南東15キロメートルほどの沖合で操業中、突然の強風に船ごと吹き流され、航行不能となって遭難してしまう。5日半（資料によっては10日間）を漂流した後、伊豆諸島にある無人島の一つである鳥島に漂着し、この島でわずかな溜水と海藻や海鳥を口にしながら143日間を生き延びた。同年5月9日（1841年6月27日）、万次郎達は、船長ウィリアム・ホイットフィールド率いるアメリカ合衆国の捕鯨船ジョン・ハウランド号が食料として海亀を確保しようと島に立ち寄った際、乗組員によって発見され、救助された。
しかし、その頃の日本は鎖国していたため、この時点で故郷へ生還する術はなく、帰国の途に就いた捕鯨船に同乗したままアメリカへ向かわざるを得なかった。

(https://ja.wikipedia.org/wiki/%E3%82%B8%E3%83%A7%E3%83%B3%E4%B8%87%E6%AC%A1%E9%83%8E)

すさまじい人生です。
食いしん坊の私なら3日と持たないでしょう。

そんなすんごい万次郎さんが、たとえば`water`を「ワラ」と書き残すわけです。
生きるか死ぬかの死線をくぐり抜けた万次郎さんが編み出した英語学習法です。
これを使わない手はありません。

早速使ってみます。

じゃん！
<font color="purple">$\huge{フィニック(ス)}$</font>
と私には聞こえています。
最後のスは言っているか言っていないかくらいの小ささです。

「(ス)」についてアメリカ在住の @mnishiguchi さんから教えてもらいました。

:::note
ネイティブの発音を聞いてみると舌と前歯の隙間から漏れる空気の音です。
日本語で「うーすっ」みたいに軽い挨拶のときの「ス」が近いと思います。
:::

さらにはこの空気の音をまず覚えておいて、`TH`と比べてみるとまた面白いそうです!!!


---
ここで突然、[Phoenix](https://www.phoenixframework.org/)のHello, world的なことをおっぱじめます。
[Elixir](https://elixir-lang.org/)をインストールしておいてください。
ここでは、データベースに[PostgreSQL](https://www.postgresql.org/)を使います。

## 参考: Dockerで[PostgreSQL](https://www.postgresql.org/)を起動する

```
$ docker run -d --rm -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgres:13
```

`POSTGRES_USER`と　`POSTGRES_PASSWORD`の値を変更したら、あとで作る`config/dev.exs`や`config/test.exs`の値を変更してください。


## プロジェクトのセットアップ

```
$ mix local.hex
$ mix archive.install hex phx_new
$ mix phx.new basic
$ cd basic
$ mix setup
```

## ブログ機能

ブログ機能を作ります。

```
$ mix phx.gen.live Blogs Blog blogs title:string body:text
```

指示にしたがって、`lib/basic_web/router.ex`を変更

```elixir:lib/basic_web/router.ex
  scope "/", BasicWeb do
    pipe_through :browser

    get "/", PageController, :index

    live "/blogs", BlogLive.Index, :index
    live "/blogs/new", BlogLive.Index, :new
    live "/blogs/:id/edit", BlogLive.Index, :edit

    live "/blogs/:id", BlogLive.Show, :show
    live "/blogs/:id/show/edit", BlogLive.Show, :edit
  end
```


```
$ mix ecto.create
$ mix ecto.migrate
$ mix phx.server
```

※ 前の手順で、この記事の通り`mix setup`をした場合はこのときにデータベースが作られるので、`mix ecto.create`はしなくてもよいです。

はい、できあがり:rocket:

Visit: http://localhost:4000/blogs

![スクリーンショット 2022-01-25 19.44.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/13d65f41-5200-52ef-8caf-b72a772b15ef.png)





# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

[Phoenix](https://www.phoenixframework.org/)は、
<font color="purple">$\huge{フィニック(ス)}$</font>
と私には聞こえています。
最後のスは言っているか言っていないかくらいの小ささです。



2022年に流行る技術予想 ーー それは、[Elixir](https://elixir-lang.org/)、[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)、[Livebook](https://github.com/livebook-dev/livebook)、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)です:rocket::rocket::rocket:

[Elixir](https://elixir-lang.org/)の誕生日は、2012年5月24日です。
そのため、今年の2022年5月24日は10周年を迎えます。

```elixir
iex> Date.diff(~D[2022-05-24], ~D[2022-01-27])
117
```


そうそう！
2月24日発売予定の[WEB+DB PRESS](https://gihyo.jp/magazine/wdpress)で、[Elixir](https://elixir-lang.org/)と[Phoenix](https://www.phoenixframework.org/)の特集がでますよ〜

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">次号のWEB+DB PRESSでElixirとPhoenix特集が出ます！お楽しみに！！1 <a href="https://t.co/d4hIfhIfZ1">pic.twitter.com/d4hIfhIfZ1</a></p>&mdash; 栗林健太郎 (@kentaro) <a href="https://twitter.com/kentaro/status/1483308857019760640?ref_src=twsrc%5Etfw">January 18, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


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
([piyopiyo.ex](https://piyopiyoex.connpass.com/) ＆ [エリジョ](https://elijo.connpass.com/) の nakoさん(@nako_sleep_9h) 作、素敵な資料:clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:)



---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





