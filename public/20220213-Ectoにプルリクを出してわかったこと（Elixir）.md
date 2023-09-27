---
title: Ectoにプルリクを出してわかったこと（Elixir）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-02-16T19:38:50+09:00'
id: bfbe459979172ecab7d9
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
**新しい技術は、必ず次の技術によって置き換わる宿命を持っている。それをまた自分の手でやってこそ技術屋冥利に尽きる。自分がやらなければ他社がやるだけのこと。商品のコストもまったく同じ**

Advent Calendar 2022 45日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[Ecto](https://github.com/elixir-ecto/ecto)に出した[プルリク](https://github.com/elixir-ecto/ecto/pull/3826)を[José Valim](https://twitter.com/josevalim)さんにマージしてもらえました :tada::tada::tada:

# What is [Ecto](https://github.com/elixir-ecto/ecto) ?

> the database wrapper and query generator for Elixir

https://hexdocs.pm/ecto/getting-started.html

# [プルリク](https://github.com/elixir-ecto/ecto/pull/3826)の内容

[プルリク](https://github.com/elixir-ecto/ecto/pull/3826)の内容は、`mix ecto.gen.repo`タスクを実行したときのメッセージを改善しました。



## [プルリク](https://github.com/elixir-ecto/ecto/pull/3826)にて、[José Valim](https://twitter.com/josevalim)さんとやりとりをしているときにわかったこと

[プルリク](https://github.com/elixir-ecto/ecto/pull/3826)にて、[José Valim](https://twitter.com/josevalim)さんとやりとりをしているときにわかったことがあります。
以下、プロジェクト名の`friends`は[EctoのGetting Started](https://hexdocs.pm/ecto/getting-started.html#content)の例に由来しています。

`Friends.Application.start/2`の`children`に`Friends.Repo`を追加する方法は2つあります。

### タプルで書く例

```elixir:lib/friends/application.ex
      def start(_type, _args) do
        children = [
          {Friends.Repo, []}
        ]
```

### モジュール名だけで書く例★[José Valim](https://twitter.com/josevalim)さん推奨★

```elixir:lib/friends/application.ex
      def start(_type, _args) do
        children = [
          Friends.Repo
        ]
```

引数を必要としない場合の書き方は、後者のほうを[José Valim](https://twitter.com/josevalim)さんは好まれているようです。
プルリクでのやりとりにて、後者にするようにコメントをいただきました。
この視点は、 @mnishiguchi さんにコメントをいただいて気づきました。
ありがとうございます！:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:


## What is `mix ecto.gen.repo`タスク ?

`mix ecto.gen.repo`タスクは、`config`と`Repo`モジュールを生成してくれます。
以下、例です。

```bash
$ mix ecto.gen.repo -r Friends.Repo
```

と、[ガイド](https://hexdocs.pm/ecto/getting-started.html#adding-ecto-to-an-application)と同じように実行すると、以下の2つのファイルが生成されます。

```elixir:config/config.exs
config :friends, Friends.Repo,
  database: "friends",
  username: "user",
  password: "pass",
  hostname: "localhost"
```

```elixir:lib/friends/repo.ex
defmodule Friends.Repo do
  use Ecto.Repo,
    otp_app: :friends,
    adapter: Ecto.Adapters.Postgres
end
```

## ちょっと待って、`mix ecto.gen.repo`タスクなんて知らないよ!?

[Phoenix](https://www.phoenixframework.org/)では、`mix phx.new`タスクで自動的に`config`や`Repo`モジュールが作られます。
`mix new friends --sup`てな具合に、素の[Elixir](https://elixir-lang.org/)プロジェクトからはじめて、[Ecto](https://github.com/elixir-ecto/ecto)を追加したときに必要です。


## なんで、素の[Elixir](https://elixir-lang.org/)プロジェクトからはじめたの!?

気まぐれです。
「[スッキリわかるSQL入門 第2版 ドリル222問付き！](https://book.impress.co.jp/books/1118101071):book:」という本でSQLを基礎から学び直そうと取り組みはじめて、どうせなら[Elixir](https://elixir-lang.org/)を楽しみたいということではじめました。

`mix ecto.gen.repo`タスクを実行時のメッセージがわかりにくいとおもったから、ダメ元で[プルリク](https://github.com/elixir-ecto/ecto/pull/3826)をだしたら、[José Valim](https://twitter.com/josevalim)さんにマージしてもらえました :tada::tada::tada:

![スクリーンショット 2022-02-13 22.11.54.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/fb1f6ecb-459e-7958-7c4c-d808efcadc96.png)





# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

今回は、以下を書きました。

- [Ecto](https://github.com/elixir-ecto/ecto)に出した[プルリク](https://github.com/elixir-ecto/ecto/pull/3826)を[José Valim](https://twitter.com/josevalim)さんにマージしてもらえました :tada::tada::tada:
- `application.ex`の`children`にモジュールを追加する際には、引数を必要としない場合にはモジュール名のみを書くことが推奨されているようです

<font color="purple">$\huge{ありがとうございます！}$</font>


以上です。


---

# 付録

以下、付録です。





[Elixir](https://elixir-lang.org/)の誕生日は、2012年5月24日です。
そのため、今年の2022年5月24日は10周年を迎えます。

```elixir
iex> Date.diff(~D[2022-05-24], ~D[2022-02-14])
99
```


そうそう！
2月24日発売予定の[WEB+DB PRESS](https://gihyo.jp/magazine/wdpress)で、[Elixir](https://elixir-lang.org/)と[Phoenix](https://www.phoenixframework.org/)の特集がでますよ〜

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





