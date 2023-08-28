---
title: >-
  【Elixir】B - FizzBuzz Sum問題をEnum.map/2 |> Enum.filter/2 |> Enum.sum/1,
  Enum.reduce/3 を使って解く (2021/12/02)
tags:
  - Elixir
  - fukuoka.ex
  - autoracex
private: false
updated_at: '2022-01-08T13:28:48+09:00'
id: b82dac53c79b4ee16b98
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/advent-calendar/2021/elixir

2021/12/02の回です。
前日は、[Nerves](https://www.nerves-project.org/)界で大活躍の@mnishiguchiさんによる「[ElixirでEnumを使わずEnumする](https://qiita.com/mnishiguchi/items/28a3ade4b7b37f262bcb)」でした。
本日、私も[Enum](https://hexdocs.pm/elixir/Enum.html#content)の話をします。

# はじめに
- [Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
- この記事は、**[AtCoder](https://atcoder.jp/home)**の[B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)問題を題材に、[Elixir](https://elixir-lang.org/)でどのように解くのかを説明します
    - **[AtCoder](https://atcoder.jp/home)**は、オンラインで参加できるプログラミングコンテスト(競技プログラミング)のサイトです。リアルタイムのコンテストで競い合ったり、約3000問のコンテストの過去問にいつでも挑戦することが出来ます。

## 対象
- これから[Elixir](https://elixir-lang.org/)をはじめてみよう:rocket::rocket::rocket:という方に向けて書いています
- すでに、ぼくは／私は／俺は／アタイは**Alchemist**だよ、という方には簡単すぎる内容ですし、説明がくどいところが多々あります
- そういう方は、初心のころを思い出していただいて、「初心者へ向けて書くのなら、○○の説明を追加したらいいとおもうよ」という編集リクエストにてご批正を賜われば幸甚です


## [Elixir](https://elixir-lang.org/)
- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)でスイスイ、プログラミングしていくことができる素敵なプログラミング言語です
- さっそくプログラムの例を示します
- [Qiita API](https://qiita.com/api/v2/docs)を使わせていただいて、`Elixir`タグがついた最新の記事を20件取得しています
- ここでは雰囲気をつかんでいただければ大丈夫です
- どうでしょうか:interrobang:

```elixir
Mix.install([{:jason, "~> 1.2"}, {:httpoison, "~> 1.8"}])

"https://qiita.com/api/v2/items?query=tag:Elixir"
|> URI.encode()
|> HTTPoison.get!()
|> Map.get(:body)
|> Jason.decode!()
|> Enum.map(& Map.take(&1, ["title", "url"]))

```

### インストール
- ワクワクしてきたあなたはきっとよき<font color="purple">$\huge{Alchemist}$</font>になれるでしょう
    - [Elixir](https://elixir-lang.org/)は日本語に訳すと、**不老不死の霊薬**です
    - [Elixir](https://elixir-lang.org/)の使い手は**Alchemist**と尊称されます
    - Alchemistとは錬金術師のことです
- 早速、イゴかしてみましょう[^1]
- まずは[Elixir](https://elixir-lang.org/)のインストールが必要です
    - Windows
        - https://github.com/elixir-lang/elixir-windows-setup/releases/download/v2.1/elixir-websetup.exe
        - インストーラからインストールしてください
    - macOS
        - [Homebrew](https://brew.sh/index_ja)を使ったインストールがお手軽です
            - `brew install elixir`
        - 高みを目指していくにはバージョン切り替えができると便利でして、[asdf](https://asdf-vm.com/)をオススメします
- お節介がすぎるかもしれませんが、エディタは[Visual Studio Code](https://code.visualstudio.com/download)がオススメです
    - オススメのプラグインは[ElixirLS: Elixir support and debugger](https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls)です



### Run :rocket::rocket::rocket:
- `iex`コマンドが使えるようになっています
    - Elixir's interactive shell.
- [Elixir](https://elixir-lang.org/)は1.12以上を使ってください

```
$ iex
Erlang/OTP 24 [erts-12.1.4] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [jit]

Interactive Elixir (1.12.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)>
```

- さきほどのプログラム例をコピペしてみてください
- きっと素敵な記事たちと出会えることでしょう :clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:


[^1]: 「早速動かしてみましょう」の意。おそらく、西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^2]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg= 

[^2]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。

# [B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)問題
- さていよいよ本題です
- **[AtCoder](https://atcoder.jp/home)**の[B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)問題を解いてみます
- 問題文はリンク先をご参照ください
    - 例: 入力が15の場合、FizzBuzzの列は、`1,2,Fizz,4,Buzz,Fizz,7,8,Fizz,Buzz,11,Fizz,13,14,FizzBuzz`となり、数字だけを足し算して、60が答え


## プロジェクトをつくる

```
$ mix new fizz_buzz_sum
```

- どぅわーっとファイルがたくさんできます
- 最初は面食らうかもしれませんが、そのうち景色にみえてきます
- そういうものだとおもってください
- さっそくテストをしてみましょう :tada::tada::tada:

```
$ cd fizz_buzz_sum
$ mix test

Compiling 1 file (.ex)
Generated fizz_buzz_sum app
..

Finished in 0.06 seconds (0.00s async, 0.06s sync)
1 doctest, 1 test, 0 failures
```

```elixir:lib/fizz_buzz_sum.ex
  @doc """
  Hello world.

  ## Examples

      iex> FizzBuzzSum.hello()
      :world

  """
  def hello do
    :world
  end
```

このコメントに見えるところが実は、[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれるもので、テストになっています。これを使ってプログラムを書いていきます。

## fizz_buzz/1関数
- まずは`fizz_buzz/1`関数を作ります
- `/1`は引数が1個の意味です

```elixir:lib/fizz_buzz_sum.ex
  @doc """
  fizz_buzz

  ## Examples

      iex> FizzBuzzSum.fizz_buzz(1)
      1
      iex> FizzBuzzSum.fizz_buzz(2)
      2
      iex> FizzBuzzSum.fizz_buzz(3)
      "Fizz"
      iex> FizzBuzzSum.fizz_buzz(4)
      4
      iex> FizzBuzzSum.fizz_buzz(5)
      "Buzz"
      iex> FizzBuzzSum.fizz_buzz(15)
      "FizzBuzz"

  """
  def fizz_buzz(n) do
    if rem(n, 3) == 0 and rem(n, 5) == 0 do
      "FizzBuzz"
    else
      if rem(n, 3) == 0 do
        "Fizz"
      else
        if rem(n, 5) == 0 do
          "Buzz"
        else
          n
        end
      end
    end
  end
```

- [rem/2](https://hexdocs.pm/elixir/Kernel.html#rem/2)は、整数同士の割り算の余りを返してくれます
- `mix test`してみましょう
    - パスします :tada::tada::tada: 
- イゴいてはいますが、実は[Elixir](https://elixir-lang.org/)っぽくないです
- はじめての方にはなんのことだかわからないとおもいますので[Elixir](https://elixir-lang.org/)っぽい書き方とはどういうことなのかを実際に書き換えたものを示します
- ここからというかちょっと前からの説明はギアがチェンジしたというか、説明が大雑把になってきたというか、いろいろ説明を端折っています
- 「**細かいことはいいんです、四の五の言わずにまずはイゴかしてみましょう**」
- 感じてください
    - 君はコスモを感じたことがあるか:interrobang::interrobang::interrobang:

```elixir:lib/fizz_buzz_sum.ex
  def fizz_buzz(n) do
    do_fizz_buzz(n, rem(n, 3), rem(n, 5))
  end

  defp do_fizz_buzz(_n, 0, 0), do: "FizzBuzz"

  defp do_fizz_buzz(_n, 0, _), do: "Fizz"

  defp do_fizz_buzz(_n, _, 0), do: "Buzz"

  defp do_fizz_buzz(n, _, _), do: n
```

- テストがあることで安心して書き換えることができます
- [Pattern matching](https://elixir-lang.org/getting-started/pattern-matching.html)と呼ばれる書き方を使い、[if/2](https://hexdocs.pm/elixir/Kernel.html#if/2)を排除すると、グッと[Elixir](https://elixir-lang.org/)っぽい書き方になります

## fizz_buzz_sum/1関数 -- その1
- 続いて与えたれた**N**項目までに含まれる数の和を計算する`fizz_buzz_sum/1`関数を作ります
- [List](https://elixir-lang.org/getting-started/basic-types.html#linked-lists)やRangeなど[Enumerables](https://elixir-lang.org/getting-started/enumerables-and-streams.html#enumerables)を操作する関数が集まったモジュールを[Elixir](https://elixir-lang.org/)では、[Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールと言います
- [AtCoder](https://atcoder.jp/home)の問題は、この[Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールを使うか前日の@mnishiguchi さんの記事のように再帰を使うかすると解答を導けることが多いです
- この記事では、[Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールを使って解く方法を説明します


```elixir:lib/fizz_buzz_sum.ex
  @doc """
  fizz_buzz_sum

  ## Examples

      iex> FizzBuzzSum.fizz_buzz_sum(15)
      60
      iex> FizzBuzzSum.fizz_buzz_sum(1000000)
      266666333332

  """
  def fizz_buzz_sum(n) do
    1..n
    |> Enum.map(&fizz_buzz/1)
    |> Enum.filter(&is_integer/1)
    |> Enum.sum()
  end
```

- `1..n`は[Range](https://elixir-lang.org/getting-started/enumerables-and-streams.html#enumerables)です
    - `[1,2,3,...,n]`みたいな〜　ものだとおもってください
- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)
    - 前の計算結果を次の関数の第1引数に入れてくれます
- [Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2)
    - 与えたれたenumerable(リストやRangeやMap)の各要素に、第2引数で指定した関数を用いて演算を施して結果を返してくれます
    - 与えたれたenumerableの要素数と同じ要素数のenumerableが返ってきます
- [Enum.filter/2](https://hexdocs.pm/elixir/Enum.html#filter/2)
    - 与えたれたenumerable(リストやRangeやMap)の各要素に、第2引数で指定した関数を用いて、truthyな要素のみを残したenumerableを返します
    - truthyとは、`nil`と`false`以外です
    - 与えられたenumerableの要素数がNだとすると、結果は0個〜N個のenumerableになります
- [Enum.sum/1](https://hexdocs.pm/elixir/Enum.html#sum/1)
    - 与えられたenumerableの各要素を足し算した結果を返します


もし[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)が、[Elixir](https://elixir-lang.org/)になかったらこんな感じになります。

```elixir:lib/fizz_buzz_sum.ex
  def fizz_buzz_sum(n) do
    Enum.sum(Enum.filter(Enum.map(1..n, &fizz_buzz/1), &is_integer/1))
  end
```

どちらがお好みでしょうか。
人の好みはそれぞれですしあなたの好みまでかえる気はありませんが、[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)を使った書き方の方を美しいと感じる方は、きっとよき<font color="purple">$\huge{Alchemist}$</font>になれるでしょう


## fizz_buzz_sum/1関数 -- その2
- [B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)問題は、**その1**のプログラムでパスできます
- mapして、filterして、足し算してという3ステップを踏んでいることが気になる方がいらっしゃるでしょう
    - きっとよき<font color="purple">$\huge{Alchemist}$</font>になれるでしょう
- [Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)を使った書き方をご紹介しておきます
    - 専門家の間では**畳み込み**と呼ばれます
    - @kuroda@github さんの「[Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス:book:」に詳しく解説されています

```elixir:lib/fizz_buzz_sum.ex
  def fizz_buzz_sum(n) do
    1..n
    |> Enum.reduce(0, fn i, acc ->
      fizz_buzz(i)
      |> to_i()
      |> Kernel.+(acc)
    end)
  end

  defp to_i("Fizz"), do: 0

  defp to_i("Buzz"), do: 0

  defp to_i("FizzBuzz"), do: 0

  defp to_i(i), do: i
```

- [Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)を使ったほうがループの回数が減るので、[AtCoder](https://atcoder.jp/home)の提出環境においては、約100ms弱速くなります :race_car: :fire:

## main/0関数
- 入力を読み取って |> 計算して |> 出力する というのが競技プログラミングのスタイルです
- その方法については、「[AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)」 に詳しく書いています
- プログラム全体を示します

```elixir:lib/fizz_buzz_sum.ex
defmodule FizzBuzzSum do
  def main do
    IO.read(:line)
    |> String.trim()
    |> String.to_integer()
    |> fizz_buzz_sum()
    |> IO.puts()
  end

  @doc """
  fizz_buzz

  ## Examples

      iex> FizzBuzzSum.fizz_buzz(1)
      1
      iex> FizzBuzzSum.fizz_buzz(2)
      2
      iex> FizzBuzzSum.fizz_buzz(3)
      "Fizz"
      iex> FizzBuzzSum.fizz_buzz(4)
      4
      iex> FizzBuzzSum.fizz_buzz(5)
      "Buzz"
      iex> FizzBuzzSum.fizz_buzz(15)
      "FizzBuzz"

  """
  def fizz_buzz(n) do
    do_fizz_buzz(n, rem(n, 3), rem(n, 5))
  end

  defp do_fizz_buzz(_n, 0, 0), do: "FizzBuzz"

  defp do_fizz_buzz(_n, 0, _), do: "Fizz"

  defp do_fizz_buzz(_n, _, 0), do: "Buzz"

  defp do_fizz_buzz(n, _, _), do: n

  @doc """
  fizz_buzz_sum

  ## Examples

      iex> FizzBuzzSum.fizz_buzz_sum(15)
      60
      iex> FizzBuzzSum.fizz_buzz_sum(1000000)
      266666333332

  """
  def fizz_buzz_sum(n) do
    1..n
    |> Enum.reduce(0, fn i, acc ->
      fizz_buzz(i)
      |> to_i()
      |> Kernel.+(acc)
    end)
  end

  defp to_i("Fizz"), do: 0

  defp to_i("Buzz"), do: 0

  defp to_i("FizzBuzz"), do: 0

  defp to_i(i), do: i
end
```

- 提出の際には、モジュール名を`Main`として提出してください
- パスします :tada::tada::tada: 



## 整形
- ソースコードはキレイにしておきましょう
- 整形してくれます

```
$ mix format
```




# Wrapping up :qiitan::lgtm::xmas-tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::lgtm::xmas-tree::qiitan:
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang:
- [Elixir](https://elixir-lang.org/)のプログラムには、[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)がよくでてきます
- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)を使ってスイスイ、プログラミングしていくことができます
- [Elixir](https://elixir-lang.org/)をはじめたばかりの方は、[Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールを眺めておくとよいです
    - [Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールは[Elixir](https://elixir-lang.org/)のプログラムでよく使います
- この記事を読んでくださったあなたは、きっとよき<font color="purple">$\huge{Alchemist}$</font>になれるでしょう


## コミュニティ
- [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slack workspaceに参加してみてください
    - マヂ、やさしい人ばっかりのコミュニティ
    - あなたの**困った**をきっと解決してくれるでしょう
- [NervesJP Slack](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA) workspaceでは、NervesやIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
- たくさんのコミュニティがあります
    - @kn339264 さん作の素敵な資料をご紹介します
    - [Elixirコミュニティ の歩き方〜国内オンライン編〜](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian) :clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:

![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)

(@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)

## もっと[Elixir](https://elixir-lang.org/)のことを知りたい方へオススメの書籍 :books: 
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/) -- オーム社
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス
- [アルケミスト − 夢を旅した少年](https://www.kadokawa.co.jp/product/199999275001/) -- KADOKAWA

この記事を最後まで読んでくださったあなたは、きっとよき<font color="purple">$\huge{Alchemist}$</font>になれるでしょう

---

明日は、@iyanayatudazeさんによる「[iexで関数のドキュメントを調べる方法 他3本](https://zenn.dev/ito_shigeru/articles/dc238b216d73f2)」です。
お楽しみに〜〜〜:tada::tada::tada:
