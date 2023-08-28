---
title: mix_install_examplesからex_doc.exsの紹介です（Elixir）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-03-12T23:29:14+09:00'
id: aa05896f009588175c04
organization_url_name: fukuokaex
slide: false
---
**あまの原ふりさけ見ればかすがなるみ笠の山にいでし月かも**

Advent Calendar 2022 56日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2)のサンプル集である[mix_install_examples](https://github.com/wojtekmach/mix_install_examples/)から[ex_doc](https://github.com/wojtekmach/mix_install_examples/blob/main/ex_doc.exs)を紹介します。



# What's [Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2) ?

[Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2)は、[Elixir](https://elixir-lang.org/) 1.12から追加されました。
[Elixir](https://elixir-lang.org/)でライブラリ(Hex)を追加するのは、1.11までは`mix new`でプロジェクトを作らないといけないなど、ひと手間必要でした。
[Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2)を使うことで、ちょっとした1ファイルで収まるようなスクリプトを書く際に`.exs`のみで完遂できるようになりました。

## 具体例

具体例です。
私がよく使ういつものサンプルです。

[Qiita API](https://qiita.com/api/v2/docs)を使わせていただいて、`Elixir`タグがついた最新の記事を20件取得しています

```elixir
Mix.install [{:req, "~> 0.2.1"}]

"https://qiita.com/api/v2/items?query=tag:Elixir"
|> URI.encode()
|> Req.get!(finch_options: [pool_timeout: 50000, receive_timeout: 50000])
|> Map.get(:body)
|> Enum.map(& Map.take(&1, ["title", "url"]))

```

Qiitaさん、いつもありがとうございます!!!


## [ex_doc.exs](https://github.com/wojtekmach/mix_install_examples/blob/main/ex_doc.exs)

おもしろそうなサンプルってことで、今日は[ExDoc](https://github.com/elixir-lang/ex_doc)を楽しんでみます。
朗報です。



### What's [ExDoc](https://github.com/elixir-lang/ex_doc) ?

> ExDoc is a tool to generate documentation for your Elixir projects. To see an example, you can access Elixir's official docs.

要はドキュメントをいい感じに作ってくれます。

[Elixir](https://elixir-lang.org/)は、プログラミング言語としてはヤングで後発の部類に入ります。
2022/05/24でようやく10年です。
後発の強みというものもありまして、[Elixir](https://elixir-lang.org/)のドキュメントは、本体から各種ライブラリまで、すべて[ExDoc](https://github.com/elixir-lang/ex_doc)で書かれています。
どのドキュメントも見方が同じなので、調べ物がしやすいです。
ドキュメント中で、`g`キーを押すと他のライブラリのドキュメントに飛べたりします。

ためしにやってみましょう。
まず

https://hexdocs.pm/elixir/Kernel.html

にアクセスしてみてください。
そうして、つぎに`g`キーをおしてください。
そうするとポップアップがでます。
今回は、`ex_doc`とでも打ち込んでみてください。
一文字ずつ、「e」「x」「_」と打ち込んでみてください。
次の「d」「o」くらいでそろそろ`ex_doc`で候補がでてくるとおもいます。
一文字ずつ打ち込むことで候補が絞り込まれていく様子をみるとことができるとおもいます。

![スクリーンショット 2022-02-25 8.23.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e5836945-c0c5-f93c-2515-02801917cfe2.png)



ただし、少し古い形式で書かれていると、`g`によるジャンプができない場合があります。


### Run

それでは、[ex_doc.exs](https://github.com/wojtekmach/mix_install_examples/blob/main/ex_doc.exs)を動かしてみます。

https://github.com/wojtekmach/mix_install_examples/blob/main/ex_doc.exs

以下、そのまま掲載します。

```elixir:ex_doc.exs
Mix.install(
  [
    {:ex_doc, "~> 0.28.0"}
  ],
  elixir: "~> 1.13"
)

{:module, module, beam, _} =
  defmodule Foo do
    @moduledoc """
    A module.
    """

    @doc """
    A function.
    """
    def foo do
    end
  end

tmp_dir = Path.join(System.tmp_dir!(), "mix_install_ex_doc")
beam_path = "#{tmp_dir}/_build/dev/lib/example/ebin/#{module}.beam"
File.mkdir_p!(Path.dirname(beam_path))
File.write!(beam_path, beam)

Hex.start()

defmodule Example.MixProject do
  use Mix.Project

  def project do
    [
      app: :example,
      version: "1.0.0",
      build_path: "#{unquote(tmp_dir)}/_build",
      lockfile: "#{unquote(tmp_dir)}/mix.lock",
      deps_path: "#{unquote(tmp_dir)}/deps"
    ]
  end
end

Mix.Task.run("docs", ~w(--formatter html --main Foo --output #{tmp_dir}/doc --open))
```


今回のプログラムは少し複雑に見えるかもしれません。

[Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2)でやってみよう! シリーズの一種のお遊びだとおもいます。
安心してください。
実際にあなたのプロジェクトに[ExDoc](https://github.com/elixir-lang/ex_doc)を導入するのはもっと簡単です。

簡単だと言っている導入方法については、誌面の都合でこの記事では説明をしません。
別の記事で書きます。(書いたことあるかも？、ないかも？）

#### 実行

```shell
git clone https://github.com/wojtekmach/mix_install_examples.git
cd mix_install_examples
elixir ex_doc.exs
```

#### 結果

ドキュメントが出来上がって、な〜んとブラウザでドキュメンを開いてくれました。
私はmacOS Catalinaを使っています。

![スクリーンショット 2022-02-25 8.34.09.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1f180ac8-8361-fd6f-7d16-894917ed7354.png)



---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

今回は、[mix_install_examples](https://github.com/wojtekmach/mix_install_examples/)の中から、[ex_doc.exs](https://github.com/wojtekmach/mix_install_examples/blob/main/ex_doc.exs)をご紹介をしました。

あなたがみている[Elixir](https://elixir-lang.org/)のドキュメント、それ、[ExDoc](https://github.com/elixir-lang/ex_doc)形式で書かれています！

今後も他のサンプルをご紹介していきます。
また、シンプルでいい例をおもいついたら、プルリクを送ってみるのはいいかもしれません。
私は、おもいついた場合には、プルリクを送ってみる気でいます :rocket::rocket::rocket: 


以上です。


---

# 付録

以下、付録です。





[Elixir](https://elixir-lang.org/)の誕生日は、2012年5月24日です。
そのため、今年の2022年5月24日は10周年を迎えます。

```elixir
iex> Date.diff(~D[2022-05-24], ~D[2022-02-25])
88
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





