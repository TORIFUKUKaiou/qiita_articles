---
title: 驚くべきことですが、リレーショナルデータベースなしにEctoの一部の機能を使うことができます (Elixir)
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-02-06T09:50:03+09:00'
id: aea6409e695f9a29d1b0
organization_url_name: fukuokaex
slide: false
---
**よいものを安く、より新しいものを早く。**

Advent Calendar 2022 35日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:


まさしく文字通り**待ち望んで**いた、
<font color="purple">$\huge{待望}$</font>
の[Elixir](https://elixir-lang.org/)[関連イベントの開催日を確認できるサイト](https://elixir-jp-calendar.fly.dev/)がリリースされました :tada::tada::tada:

この記事では、私なりの視点で解説をいたします。

# [Elixir](https://elixir-lang.org/)[関連イベントの開催日を確認できるサイト](https://elixir-jp-calendar.fly.dev/)

https://elixir-jp-calendar.fly.dev/

作者の@koga1020 さんによる[解説記事](https://zenn.dev/koga1020/articles/6e67765cc53539)と[ソースコード](https://github.com/koga1020/elixir_jp_calendar)が公開されています :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 

https://zenn.dev/koga1020/articles/6e67765cc53539

https://github.com/koga1020/elixir_jp_calendar

# 個人的に興味をそそられた事項

私が興味をそそられた事項は次の3点です。

1. データベースは使用しないのに、[Ecto](https://hexdocs.pm/ecto/Ecto.html)を使用:interrobang:
1. [fly.io](https://fly.io/)へのデプロイ
1. [Quinn](https://hexdocs.pm/quinn/Quinn.html) Hexの使用

他にも興味は尽きないのですが、「データベースは使用しないのに、[Ecto](https://hexdocs.pm/ecto/Ecto.html)を使用:interrobang:」を深掘りしたいとおもいます。

@koga1020 さんの記事中、以下の記載がありますし、[リポジトリ](https://github.com/koga1020/elixir_jp_calendar/tree/main/lib/elixir_jp_calendar_web)をみてもマイグレーションファイルはありません。

> DBなしのシンプルな作りです。最近好きなやり方です。

---
> mix phx.new elixir_jp_calendar --no-ecto でゼロからスタート

---

# リレーショナルデータベースなしに[Ecto](https://hexdocs.pm/ecto/Ecto.html)の一部の機能を使うことができます

[Programming Ecto](https://pragprog.com/titles/wmecto/programming-ecto/)という本:book:で聞いたことがあります。

> And, perhaps most surprising, you can use parts of Ecto without a relational database.

順番が前後しますが、[Ecto](https://hexdocs.pm/ecto/Ecto.html)を知らない方のために説明をすると、[Ecto](https://hexdocs.pm/ecto/Ecto.html)は[Elixir](https://elixir-lang.org/)製のデータベースライブラリです。

[Ecto](https://hexdocs.pm/ecto/Ecto.html)は[Elixir](https://elixir-lang.org/)は、[Phoenix](https://www.phoenixframework.org/)のデフォルトデータベースライブラリとして採用されています。
[Ecto](https://hexdocs.pm/ecto/Ecto.html)は2013年に開発がスタートしています。
[Elixir](https://elixir-lang.org/)の誕生は2012年ですので、[Elixir](https://elixir-lang.org/)界では重鎮ライブラリです。
[Elixir](https://elixir-lang.org/)作者のJosé Valimさんが積極的に開発にコミットし続けている点も見逃せません。

話を戻します。
「**おそらくもっとも驚くべきことは、リレーショナルデータベースなしに[Ecto](https://hexdocs.pm/ecto/Ecto.html)の一部の機能を使うことができます**」
この具体例を探訪してみたいとおもいます。

# ElixirJpCalendarWeb.Event.IndexParams

ここが該当します。

https://github.com/koga1020/elixir_jp_calendar/blob/24c647262c7e29ee604eb4eb839f6831d305c57c/lib/elixir_jp_calendar_web/params/event/index_params.ex

```elixir:lib/elixir_jp_calendar_web/params/event/index_params.ex
defmodule ElixirJpCalendarWeb.Event.IndexParams do
  @default_source "community"
  use Params.Schema, %{
    source: [field: :string, default: @default_source]
  }

  import Ecto.Changeset

  def changeset(ch, params) do
    ch
    |> cast(params, [:source])
    |> ignore_invalid_source()
  end

  def ignore_invalid_source(%Ecto.Changeset{changes: %{source: source}} = ch) do
    case source in ~w(#{@default_source} keyword) do
      true ->
        ch

      false ->
        change(ch, source: @default_source)
    end
  end

  def ignore_invalid_source(ch), do: ch
end
```

呼び出しているのは[ここ](https://github.com/koga1020/elixir_jp_calendar/blob/24c647262c7e29ee604eb4eb839f6831d305c57c/lib/elixir_jp_calendar_web/controllers/event_controller.ex#L7-L11)です。

```elixir:lib/elixir_jp_calendar_web/controllers/event_controller.ex
  def index(conn, params) do
    index_params =
      params
      |> IndexParams.from(with: &IndexParams.changeset/2)
      |> Params.to_map()
```

外部から与えられるデータソースから`Ecto.Changeset`を使って、必要な要素のみを取り出す実例です。
[Programming Ecto](https://pragprog.com/titles/wmecto/programming-ecto/):book:の中では、CHAPTER4の「Creating Changesets Using External Data」で解説されているものと同じ内容です:rocket:

`/events?awesome=1&source=keyword`
などにアクセスをして、周辺のコードに[IO.inspect/2](https://hexdocs.pm/elixir/1.13/IO.html#inspect/2)を入れて値をみるといろいろと楽しめます!!!


# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

**驚くべきことですが、リレーショナルデータベースなしに[Ecto](https://hexdocs.pm/ecto/Ecto.html)の一部の機能を使うことができます。**
本記事ではその実例をご紹介しました。


以上です。




---

# 付録

以下、付録です。





[Elixir](https://elixir-lang.org/)の誕生日は、2012年5月24日です。
そのため、今年の2022年5月24日は10周年を迎えます。

```elixir
iex> Date.diff(~D[2022-05-24], ~D[2022-02-04])
109
```


そうそう！
2月24日発売予定の[WEB+DB PRESS](https://gihyo.jp/magazine/wdpress)で、[Elixir](https://elixir-lang.org/)と[Phoenix](https://www.phoenixframework.org/)の特集がでますよ〜

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



---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





