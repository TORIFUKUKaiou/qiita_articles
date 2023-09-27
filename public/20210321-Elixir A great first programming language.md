---
title: 'Elixir: A great first programming language'
tags:
  - Azure
  - Elixir
  - QiitaAzure
private: false
updated_at: '2021-03-21T11:28:06+09:00'
id: aecb1297672163f7d5f4
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか:bangbang:
- [Microsoft Ignite](https://myignite.microsoft.com/home)の下記のセッションをみました
    - [Python: A great first programming language](https://myignite.microsoft.com/sessions/a67ab101-b082-43de-800c-14f427c766ff?source=sessions)
    - [Hello, World! in 3 languages: beginning coding with C#, Python and Javascript](https://myignite.microsoft.com/sessions/cbbf30c2-c02e-4259-8ea3-e458e789801a?source=sessions)
    - [How to become a software developer](https://myignite.microsoft.com/sessions/31b5fab4-686a-49e3-917e-5cbd8ba0e210?source=sessions)
- これらからインスパイアされて、[Elixir](https://elixir-lang.org/)を紹介したいとおもったわけです
    - だって、 https://myignite.microsoft.com/sessions で、 [Elixir](https://elixir-lang.org/)って検索しても何もでてこないのですもの
    - じゃあ、自分で書くしかないとおもいました
- この記事のタイトルは、「[Python: A great first programming language](https://myignite.microsoft.com/sessions/a67ab101-b082-43de-800c-14f427c766ff?source=sessions)」の[Python](https://www.python.org/)を[Elixir](https://elixir-lang.org/)に置き換えてみました
    - <font color="purple">$\huge{I　use　Elixir.}$</font>
    - <font color="purple">$\huge{I　like　it!!!}$</font>
- 私は[Elixir](https://elixir-lang.org/)が好きです
- こんなタイトルをつけておきながら最初に学ぶとよい言語なのかどうかは私にはわかりません
- 「[How to become a software developer](https://myignite.microsoft.com/sessions/31b5fab4-686a-49e3-917e-5cbd8ba0e210?source=sessions)」の中で言われていたのだとおもうのですが、あなたの心の赴くままに最初のプログラミング言語を選べばいいとおもいます
  - (`I am not good at English...` なので、聞き間違えしているかも :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)
  - 以下、私の意見もまぜて書いています
        - あなたがなにをやりたいのかで最適な言語は決まってきます
            - [Python](https://www.python.org/)かもしれませんし、この記事で紹介する[Elixir](https://elixir-lang.org/)かもしれません
        - ある意味ではあなたはすでに答えをもっているともいえます
            - あなたが本当にやりたいことをもう一度自分自身に聞いてみましょう
            - 自分の声を聞きましょう
        - まわりに聞ける人がいるのかどうかーーこれは大きいとおもいます
        - [Elixir](https://elixir-lang.org/)をはじめるにあたって、前提知識としてあれが必要、これが必要とはいいません
        - 本当に必要とするものであればあとから必ず身についてきます
        - あえていえば、**ヤル気**だけは必要だとおもいます
        - <font color="purple">$\huge{楽しむ気持ち}$</font>
        - と言ったほうがいいのかもしれませんという気持ちです
        - Happy coding!!!


https://qiita.com/official-events/a50e99d62dc62d68a9c9

- この記事はこちら:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:のイベントに参加しています
- また2021/3/21(月)開催予定のとにかく純粋な純度100％のもくもく会[autoracex #18](https://autoracex.connpass.com/event/207969/)の成果であり〼
    - そしてこの記事は[autoracex](https://autoracex.connpass.com/)というグループの初心者向けコンテンツとします

# 自己紹介
- 名乗るほどのものではございません

## 私がどのくらい[Elixir](https://elixir-lang.org/)をわかっているのか
- Interface 2021年1月号 -- [IoT向きモダン言語Elixirの研究 第7回　IoTシステム開発にトライ!](https://interface.cqpub.co.jp/wp-content/uploads/if2101_152.pdf)
    - @takasehideki 先生のおかげで雑誌に記事を載せていただきました
- [Qiitaアドベントカレンダー2020 日本マイクロソフト賞 ④ 受賞](https://qiita.com/chomado/items/7d1f757f18c5b442fadd?utm_campaign=email&utm_content=link&utm_medium=email&utm_source=public_mention#%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%BD%E3%83%95%E3%83%88%E8%B3%9E-%E3%82%AF%E3%83%A9%E3%82%A6%E3%83%89%E3%83%8D%E3%82%A4%E3%83%86%E3%82%A3%E3%83%96%E3%81%AE-aspnet-core-%E3%83%9E%E3%82%A4%E3%82%AF%E3%83%AD%E3%82%B5%E3%83%BC%E3%83%93%E3%82%B9%E3%82%92%E4%BD%9C%E6%88%90%E3%81%97%E3%81%A6%E3%83%87%E3%83%97%E3%83%AD%E3%82%A4%E3%81%99%E3%82%8B-%E3%82%92%E3%82%84%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B-torifukukaiou-%E3%81%95%E3%82%93)
    - 受賞の原動力となったのは
        - <font color="purple">$\huge{I　use　Elixir.}$</font>
        - <font color="purple">$\huge{I　like　it!!!}$</font>
    - です

# Agenda
- What is [Elixir](https://elixir-lang.org/)?
- How to install [Elixir](https://elixir-lang.org/)
- [Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/) [Elixir](https://elixir-lang.org/) extension
- [IEx](https://hexdocs.pm/iex/IEx.html) (Elixir's interactive shell) & mix new
- Resources

# What is [Elixir](https://elixir-lang.org/)?
> **Elixir is a dynamic, functional language for building scalable and maintainable applications.**

- [Elixir](https://elixir-lang.org/) の公式ページの先頭に書いてあります
- ごめんなさい:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:、いきなりですが、[Elixir](https://elixir-lang.org/)とは? を私はちゃんと説明できません
- 第一、ここにでてきているキーワードはどれも舌をかんでしまいそうです
- ちゃんと説明できませんが、以下、私の感じ方です
    - **美しい**です
    - [Elixir](https://elixir-lang.org/)と出会ってからプログラミングってこんなに楽しかったっけ？　と改めて気づかせてくれました
    - [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2) パイプ演算子というものをよく使います
        - これを使うのが気持ちいい
        - 詳しくは、 @zacky1972 先生の「[大学でElixirを教えた話](https://qiita.com/zacky1972/items/0c2869f9f39f7bb917a5)」をご参照ください

## Big 2(, 3!?)
- Web applications 作りたいなら、[Phoenix](https://www.phoenixframework.org/)
- IoT やりたいなら、[Nerves](https://www.nerves-project.org/)
- (AIでいいのかな？　[Nx](https://github.com/elixir-nx/nx))
    - 最近でてきました
    - 私はよくわかっていません

# How to install [Elixir](https://elixir-lang.org/)

## Windows
- 公式の[インストール](https://elixir-lang.org/install.html)ページにあるインストーラーを利用してください

## macOS
- a. [asdf](https://asdf-vm.com/#/)
    - @nishiuchikazuma さんの「[Elixirのバージョン管理環境をasdfを使って作った](https://qiita.com/nishiuchikazuma/items/b9d319732ddb540fd990)」を参考にしてください
- b. [Homebrew](https://brew.sh/index_ja)
    - `brew install elixir`
    - [asdf](https://asdf-vm.com/#/)がオススメですが、ちょっと試すだけなら[Homebrew](https://brew.sh/index_ja)がトラブルなくインストールできるとおもいます

## Linux
- 本格派のみなさまに私から申し上げることはございません
- お任せします
- 私は、Ubuntu 18.04に公式の[インストール](https://elixir-lang.org/install.html)ページに書いてあるやり方でインストールしたことがあります

## [Docker](https://www.docker.com/) + [Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)
- [Developing inside a Container](https://code.visualstudio.com/docs/remote/containers)
- マシンに直接インストールするのは嫌だという方にオススメです
- @takasehideki先生の「[ALGYAN x Seeed x NervesJPハンズオン！に向けた開発環境の準備方法 → これからの開発環境についても追記](https://qiita.com/takasehideki/items/79d4ba3f95b1463105f8)」の記事が詳しいです
- こちらの記事を参考に以下のインストールをすすめてください
    - ① [Docker Desktopのインストール](https://qiita.com/takasehideki/items/79d4ba3f95b1463105f8#docker-desktop%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
    - ② [Visual Studio Code](https://qiita.com/takasehideki/items/79d4ba3f95b1463105f8#visual-studio-code)
    - ③ [拡張機能のインストール](https://qiita.com/takasehideki/items/79d4ba3f95b1463105f8#%E6%8B%A1%E5%BC%B5%E6%A9%9F%E8%83%BD%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)

### .devcontainer
- インストールが無事にすんだら適当なディレクトリ配下に以下のようなファイルを置いてください


```tree
projects
└── .devcontainer
    ├── Dockerfile
    └── devcontainer.json
```

```json:projects/.devcontainer/devcontainer.json
{
    "name": "Elixir v1.11.4",
    "dockerFile": "Dockerfile",
    "settings": {
      "terminal.integrated.shell.linux": "/bin/bash"
    },
    "extensions": [
      "elixir-lsp.elixir-ls",
    ]
}
```

```Docker:projects/.devcontainer/Dockerfile
FROM elixir:1.11.4
```

### 使い方
- [Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)の左下のほうの `><`感じのやつを押して、`Remote Containers: Open folder in Container...`
- ファイルダイアログがでてくるので、`.devcontainer`フォルダがあるところを選択する
    - 上記の例では`projects`フォルダを選択
    - 初回はイメージのダウンロードなどで時間がかかるので :coffee: でも飲みながら気長に待ちましょう
- 左下がこんな表示になっていれば完了!
    - [Elixir](https://elixir-lang.org/)を楽しめます :rocket::rocket::rocket:

![スクリーンショット 2021-03-21 0.10.17.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e7d3e666-603d-ae92-1481-cb51fea35fec.png)

- [Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)上で、[Terminal] -> [New Terminal]とやりまして

```
# elixir -v
Erlang/OTP 23 [erts-11.1.8] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Elixir 1.11.4 (compiled with Erlang/OTP 23)
```

- 以下、本記事では、[Docker](https://www.docker.com/) + [Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/) な環境で説明します

# [Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/) [Elixir](https://elixir-lang.org/) extension
- [ElixirLS](https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls)
- [Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)をお使いの方は、リンク先からインストールをすすめてください
    - ないならないでもかまいませんが、[Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)をお使いの場合はインストールしておくことをオススメします

# [IEx](https://hexdocs.pm/iex/IEx.html) (Elixir's interactive shell)

- まずは[IEx](https://hexdocs.pm/iex/IEx.html) (Elixir's interactive shell)で[Elixir](https://elixir-lang.org/)を楽しむことにします
- ターミナルにiexと打ち込んでください

```
# iex
Erlang/OTP 23 [erts-11.1.8] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Interactive Elixir (1.11.4) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> 
```

- 以下、`iex(1)` 等の`(1)`は省略します




```elixir
iex> "Hello World!"
"Hello World!"

iex> 1..10 |> Enum.map(fn i -> i * i end) |> Enum.sum()
385

iex> System.halt
```

- Great! :tada::tada::tada: 
- `System.halt`で[IEx](https://hexdocs.pm/iex/IEx.html)から抜けられます
    - 他には `Ctl + C` を2回押す

# mix new
- プロジェクトを作ってみましょう
- ファイルにプログラムを書きたい場合に必ずしもプロジェクトを作る必要はありませんが、今後本格的になにかをやりはじめたらきっとつくるはずのものですで、最初っからプロジェクトをつくること(mix new)をご紹介します
- いっぱいファイルがつくられたようにみえるかもしれませんが、慣れると景色です
    - いい眺めです
- まずはここで編集しているあたりのファイルを触るのだと覚えておけばよいでしょう

```
# mix new hello_ignite
```

```elixir:mix.exs
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:httpoison, "~> 1.8"}, # add
      {:jason, "~> 1.2"} # add
    ]
  end
```

```elixir:lib/hello_ignite.ex
defmodule HelloIgnite do
  @moduledoc """
  Documentation for `HelloIgnite`.
  """

  def run do
    greeting = "Learning Elixir is fun!"
    IO.puts(greeting)

    "https://qiita.com/api/v2/items?query=azure"
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Jason.decode!()
    |> Enum.map(& &1["title"])
    |> Enum.join("\n")
    |> IO.puts()
  end
end
```

- `greeting`を表示して、Qiitaの記事一覧を`azure`で検索して最新の20件のタイトルを表示しています
    - とりあえず今回は[Elixir](https://elixir-lang.org/)を使ってみましょう！　ということで１つの関数の中に全部おしこんで書いていることをご容赦ください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
    - あまりこういうことはオススメしません
- 元から書いてある`HelloIgnite.hello/0`関数はそのまま残しておいてもかまいません
    - `/`のうしろの数は関数の引数の数を表しています


```
# cd hello_ignite
# mix deps.get
# iex -S mix
```

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e19e9c24-ce6d-0e84-c1ed-c5c02f92c3ac.gif)

## mix format

```elixir
    def run do
greeting = "Learning Elixir is fun!"
      IO.puts(greeting)

  "https://qiita.com/api/v2/items?query=azure"
|> HTTPoison.get!()
    |> Map.get(:body)
    |> Jason.decode!()
    |> Enum.map(& &1["title"])
    |> Enum.join("\n")
    |> IO.puts()
  end
```

- へんてこりんなインデントになっていても`mix format`できれいに整形してくれます

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4f1e57bd-1e35-c5c8-60fb-64344795bcfd.gif)

## シングルクォーテーション`'`とダブルクォーテーション`"`の違い
- [Python: A great first programming language](https://myignite.microsoft.com/sessions/a67ab101-b082-43de-800c-14f427c766ff?source=sessions)のビデオ内で質問がでていた件です
- 同じく説明してみたいとおもいます
- ダブルクォーテーション`"`で囲まれたものは文字列です
- シングルクォーテーション`'`は[CharList](https://hexdocs.pm/elixir/List.html#module-charlists)です
- [Elixir](https://elixir-lang.org/)においてはもうまるで違います
    - まずは全然別物であるとご認識ください
        - [Ruby](https://www.ruby-lang.org/ja/)や[Python](https://www.python.org/)では文字列であることにはかわりはなくて、式展開できるかできないかといった違いがあるというものだとおもいます
    - [Elixir](https://elixir-lang.org/)ではそういう違いではなくて全然別のものなのです


### 例

```elixir
iex> ?a
97
iex> ?b
98
iex> ?c
99
iex> 'abc' === [97, 98, 99]
true
iex> 'abc' === "abc"
false
iex> "abc" === <<97, 98, 99>>
true
```

- 以下述べることは私の経験則であり、そんないい加減な理解の仕方はよくないとおもいますが、乱暴にいいますと、
    - ダブルクォーテーション`"`で囲まれたものは文字列は、[Elixir](https://elixir-lang.org/)でよく使います
        - たとえばさきほどでてきた[HTTPoison](https://github.com/edgurgel/httpoison)に指定する`url`はダブルクォーテーション`"`で囲まれたものは文字列でした
    - シングルクォーテーション`'`は[CharList](https://hexdocs.pm/elixir/List.html#module-charlists)はErlangのモジュールを使う際によく使います
        - 例 `:os.cmd('ls')`
- 上記以外の使い方もありますし、繰り返しますがこの理解は正確ではありません
- 乱暴だと自分でも自覚していますが、まずはざっくりこんなふうに私は最初に理解したというご紹介です
    - (いまはもう少し理解は進んでいるつもりですが、ここも舌をかみそうなのでこの記事ではこのくらいでやめておきます)

# Resources

## オンライン
- [Elixir](https://elixir-lang.org/) 公式ページ
    - [Getting Started](https://elixir-lang.org/getting-started/introduction.html)
    - [Elixir入門の連載を開始(Elixir入門もくじ)](https://dev.to/gumi/elixerelixir-10g2)
        - 日本語訳
- [Elixir School](https://elixirschool.com/en/)
    - 日本語訳: https://elixirschool.com/ja/
- [AHT20で温度湿度を取得して全世界に惜しげもなくあたい（値）を公開する(Elixir/Nerves/Phoenix)](https://qiita.com/torifukukaiou/items/5876bc4576e7b7991347)
    - 手前味噌ですが
    - [Phoenix](https://www.phoenixframework.org/)と
    - [Nerves](https://www.nerves-project.org/)
    - を同時に使った作例
    - [Phoenix](https://www.phoenixframework.org/)アプリは2021/03/21現在、Azure VMにデプロイしています
        - https://aht20.torifuku-kaiou.tokyo/aht20-dashboard

## :books: 本 :books:
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/)
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021)

## オススメの勉強法
- **私が2年前に戻れるなら**
- 上記のオンラインリソースや本で基礎を身に着けます
- 特に、[Enum](https://hexdocs.pm/elixir/Enum.html#content)とモジュール仲良くなっておくとよいです
    - [Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールは、[Elixir](https://elixir-lang.org/)でなにかを作ろうとすると必ずといっていいほど使う頻度がたかいモジュールです
    - ざざーっと`Examples`を中心に眺めておくとよいです
- [AtCoder](https://atcoder.jp/)のやさしめの問題(ABCコンテスト等)をやってみるのはよいとおもいます
    - 手前味噌ですが「[AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)」に入力の読み取り方などをまとめておりますのでご参照ください

## Communities   
- **マジやさしくって　いい人ばっかりだから** :thumbsup::thumbsup_tone1::thumbsup_tone2::thumbsup_tone3::thumbsup_tone4::thumbsup_tone5:  
- ウェルカムです
- [connpass](https://connpass.com/dashboard/)で探してみてください
- [勉強会が頻繁に行われています](https://twitter.com/piacere_ex/status/1364109880362115078)
    - 私がよく参加している勉強会です
    - [autoracex](https://autoracex.connpass.com/) 【毎週月曜】 主催
    - [Sapporo.beam](https://sapporo-beam.connpass.com)　　【毎週水曜】
    - [OkazaKirin.beam](https://okazakirin-beam.connpass.com)　【毎週木曜】
    - [fukuoka.ex／kokura.ex](https://fukuokaex.connpass.com)　【毎月2～3回】
    - [NervesJP](https://nerves-jp.connpass.com/) 　【毎月1回】

![EsvA7uQU0AEoTuX.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2ad87109-2684-1605-e1dc-457b835b8c15.jpeg)

(@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)



# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm: 
- Happy coding with [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket:
- We are the Alchemists, my friends![^1]
    - [Elixir](https://elixir-lang.org/): 不老不死の霊薬
    - [Elixir](https://elixir-lang.org/)の使い手のことをアルケミスト(錬金術師)と呼ばれます
    - あなたがアルケミストだとおもったその瞬間から、もうあなたはアルケミストなのです
 
[^1]: [Queen - We Are The Champions (Official Live Video)](https://www.youtube.com/watch?v=KXw8CRapg7k)
