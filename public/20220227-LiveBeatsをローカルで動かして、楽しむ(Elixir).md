---
title: LiveBeatsをローカルで動かして、楽しむ(Elixir)
tags:
  - Elixir
  - Phoenix
  - LiveView
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-02-28T23:15:12+09:00'
id: bc4210986fc6d4880245
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
**わが庵は都のたつみしかぞ住む世を宇治山と人は言ふなり**

Advent Calendar 2022 57日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[LiveBeats](https://github.com/fly-apps/live_beats)をローカルで動かして、楽しんでみます。

![スクリーンショット 2022-02-27 22.15.20.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a2566abb-230f-c16d-bf7d-2b6d64748133.png)


# What's [LiveBeats](https://github.com/fly-apps/live_beats) ?

こういうものです。
まずは動画をご覧になってください。

<iframe width="976" height="549" src="https://www.youtube.com/embed/w3xq-t2hpHY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

## [LiveBeats: Building a Social Music App With Phoenix LiveView](https://fly.io/blog/livebeats/)抜粋

[Chris McCord](https://twitter.com/chris_mccord)さんの紹介記事
[LiveBeats: Building a Social Music App With Phoenix LiveView](https://fly.io/blog/livebeats/)からポイントを独断と偏見で抜粋します。

> We decided that 2022 was a good year to ship a full-stack Phoenix reference app.
> Meet LiveBeats, a social music application we wrote to show off the LiveView UX, while serving as a learning example and a test-bed for new LiveView features.

## 超意訳
2022年が[Phoenix](https://www.phoenixframework.org/)フルスタックなリファレンスアプリを紹介するの良い年であると、[Fly.io](https://fly.io/)は決断しました。
[LiveBeats](https://github.com/fly-apps/live_beats)を紹介しよう。
[LiveView](https://github.com/phoenixframework/phoenix_live_view)を学ぶのに最適な、ソーシャル音楽アプリです。

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I just released LiveBeats – open source social music app built on Phoenix LiveView. It&#39;s deployed around the world a 14 node cluster. PubSub and Presence Just Work™ <br><br>This is what the future of full stack development looks like 👇<a href="https://t.co/Oq28DRTfyV">https://t.co/Oq28DRTfyV</a></p>&mdash; Chris McCord (@chris_mccord) <a href="https://twitter.com/chris_mccord/status/1488886429140893704?ref_src=twsrc%5Etfw">February 2, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


## [Chris McCord](https://twitter.com/chris_mccord)さんご本人による解説記事

[Phoenix](https://www.phoenixframework.org/)の作者[Chris McCord](https://twitter.com/chris_mccord)さんご本人による解説記事はこちらです。

https://fly.io/blog/livebeats/

## ソースコード

ソースコードはここにあります。

https://github.com/fly-apps/live_beats

## 体験サイト

[Fly.io](https://fly.io/)さんがデプロイしていくれているモノを試すことができます。

[https://livebeats.fly.dev/signin](https://livebeats.fly.dev/signin)

---

# ローカルで動かす

ローカルで動かしてみます。

[README](https://github.com/fly-apps/live_beats/blob/master/README.md)に従うとよいです。
[README](https://github.com/fly-apps/live_beats/blob/master/README.md)に書いてあること以上のことは書けませんが、私はこうやって動かしたということを記録しておきます。

## GitHubアカウント

GitHubアカウントを用意しておいてください。
みなさん、お持ちですよね:interrobang:

## [Elixir](https://elixir-lang.org/)

[Elixir](https://elixir-lang.org/)は`1.13.1`を使っています。

```
elixir -v
```

上記を実行すると下記の結果が得られました。

```
Erlang/OTP 24 [erts-12.2] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [jit]

Elixir 1.13.1 (compiled with Erlang/OTP 24)
```

OSを記しておきます。
`macOS Monterey 12.2.1`

## PostgreSQL

PostgreSQLが必要です。
私は以下のようにしてDockerで動かしました。

```
docker run -d --rm -p 5432:5432 -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres postgres:13
```

## [Github OAuth app](https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app)の作成

[このページ](https://github.com/settings/applications/new)から、[Github OAuth app](https://docs.github.com/en/developers/apps/building-oauth-apps/creating-an-oauth-app)を作成します。

![スクリーンショット 2022-02-27 22.36.47.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0c4caff5-4aa3-be50-8e02-bd5775cd882f.png)

[README](https://github.com/fly-apps/live_beats/blob/master/README.md)に書いてある通りです。

- Application name: 任意
- Homepage URL: `http://localhost:4000`
- Authorization callback URL: `http://localhost:4000/oauth/callbacks/github`

![スクリーンショット 2022-02-27 22.51.57.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/5594658f-043f-5f17-572a-ba27ea409e2c.png)




さらに、2つの環境変数を設定します。

- `LIVE_BEATS_GITHUB_CLIENT_ID`
- `LIVE_BEATS_GITHUB_CLIENT_SECRET`

## いつもの操作、いつもの景色

[Phoenix](https://www.phoenixframework.org/)を楽しんだことのある方ならおなじみのいつもの操作、いつもの景色です。

```
mix deps.get
mix ecto.setup
mix phx.server
```

Visit: http://localhost:4000/

# (おまけ)アップロードする`.mp3`ファイルが欲しい〜っす

https://www.purple-planet.com/

[https://www.purple-planet.com/](https://www.purple-planet.com/)

[Chris McCord](https://twitter.com/chris_mccord)さんの[解説動画](https://www.youtube.com/watch?v=w3xq-t2hpHY)の中でちらっとでてくる[サイト](https://www.purple-planet.com/)に行くと無料で`.mp3`ファイルがダウンロードできます。
お手元に適当なものが無い方はこちらのサイトを使えばよいとおもいます。

[解説動画](https://www.youtube.com/watch?v=w3xq-t2hpHY)の中で使っている下記の楽曲が手に入ります。

- [Dreamcatcher](https://www.purple-planet.com/tracks/dreamcatcher)
- [Feelin Good](https://www.purple-planet.com/tracks/feelin-good)



<font color="purple">$\huge{でっかい夢をつかんで}$</font>
<font color="purple">$\huge{気分は上々!!!}$</font>






---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

今回は[LiveBeats](https://github.com/fly-apps/live_beats)をローカルで動かして、楽しんでみました。
動かしてみました〜　ってだけの記事です。

[LiveBeats](https://github.com/fly-apps/live_beats)の中身はいろいろみて研究していきたいです。
たとえば、GitHubと連携してメールアドレスやアイコンを取得したりしている以下

- [lib/live_beats/github.ex](https://github.com/fly-apps/live_beats/blob/master/lib/live_beats/github.ex)
- [lib/live_beats_web/controllers/oauth_callback_controller.ex](https://github.com/fly-apps/live_beats/blob/master/lib/live_beats_web/controllers/oauth_callback_controller.ex)

は特に興味津々です。


以上です。


---

# 付録

以下、付録です。





[Elixir](https://elixir-lang.org/)の誕生日は、2012年5月24日です。
そのため、今年の2022年5月24日は10周年を迎えます。

```elixir
iex> Date.diff(~D[2022-05-24], ~D[2022-02-26])
87
```


そうそう！
2月24日発売の[WEB+DB PRESS](https://gihyo.jp/magazine/wdpress)で、[Elixir](https://elixir-lang.org/)と[Phoenix](https://www.phoenixframework.org/)の特集がでていますよ〜

[Elixir](https://elixir-lang.org/)、[Phoenix](https://www.phoenixframework.org/)をはじめられたばかりの方も、腕におぼえがある方も、どんなものなのかなあと様子見をきめこんでいる方も、
つまりは
<font color="purple">$\huge{全人類のみなみなさま！！！}$</font>
**お手にとって、お楽しみください!!!**

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">We, <a href="https://twitter.com/tamanugi?ref_src=twsrc%5Etfw">@tamanugi</a> <a href="https://twitter.com/torifukukaiou?ref_src=twsrc%5Etfw">@torifukukaiou</a> <a href="https://twitter.com/the_haigo?ref_src=twsrc%5Etfw">@the_haigo</a> <a href="https://twitter.com/mokichi_s12m?ref_src=twsrc%5Etfw">@mokichi_s12m</a> including me, wrote featured articles for WEB+DB PRESS Vol.127 about Elixir and Phoenix! It&#39;s being published on 24, Feb.<a href="https://t.co/UPNiVU1zG9">https://t.co/UPNiVU1zG9</a></p>&mdash; 栗林健太郎 (@kentaro) <a href="https://twitter.com/kentaro/status/1489441847130746880?ref_src=twsrc%5Etfw">February 4, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


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





