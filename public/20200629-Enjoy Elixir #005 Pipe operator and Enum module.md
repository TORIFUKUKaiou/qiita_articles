---
title: 'Enjoy Elixir #005 Pipe operator and Enum module'
tags:
  - Elixir
private: false
updated_at: '2020-11-15T11:25:41+09:00'
id: 70a350cfc45d0eb58371
organization_url_name: fukuokaex
slide: true
---
# はじめに
- [KFIE](https://kfieyaruki.connpass.com/)という近畿大学産業理工学部の情報系コミュニティがあります
- 最近は、毎週火曜日にLT会をやっているそうです
- 私が学生だったのはもうずいぶん昔のことなのですが、参加させてもらっています
- 毎週、5分間時間をもらって、[Elixir](https://elixir-lang.org/)いいよ！　を伝えていきたいとおもいます
    - [2020/6/30(火)の回](https://kfieyaruki.connpass.com/event/177854/)
- 今日は以下を学びます
    - Pipe operator and Enum module
- A journey of a thousand miles begins with a single step.
- この記事は[Elixir](https://elixir-lang.org/)を触るのがはじめてという方に向けて書いています

----
# もくじ
[001 mix new, iex -S mix, mix format](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af)
|> [002 型](https://qiita.com/torifukukaiou/items/1f5789dbd05498be1132)
|> [003 Pattern matching](https://qiita.com/torifukukaiou/items/47b088f6c44ccf213226)
|> [004 Modules and functions](https://qiita.com/torifukukaiou/items/2b6f30db0a7d37c4f139)
|> [005 Pipe operator and Enum module](https://qiita.com/torifukukaiou/items/70a350cfc45d0eb58371)
|> [006 HTTP GET!](https://qiita.com/torifukukaiou/items/e4416cca916497ee76fb)
|> [007 Flow](https://qiita.com/torifukukaiou/items/eb1aa2c8842adfc40637)
|> [008 AtCoderを解いてみる](https://qiita.com/torifukukaiou/items/98f875ee4d0f4038b5a2)
|> [999 Where to go next](https://qiita.com/torifukukaiou/items/4fa0747546aafa3fe89a)

----
# 準備

```console
$ mix new hello
$ cd hello
```

----
# Pipe operator

- Pipe operatorは[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)のことです
- たとえば以下のリストの各要素に3を加えて、200未満の整数のみをリストに残すことを考えてみましょう

```elixir
[84, 197, 98, 197, 29, 197, 94, 197, 111, 197, 98, 197, 29, 197, 113, 197, 101,
 197, 98, 197, 29, 197, 62, 197, 105, 197, 96, 197, 101, 197, 98, 197, 106, 197,
 102, 197, 112, 197, 113, 197, 112, 197, 41, 197, 29, 197, 106, 197, 118, 197,
 29, 197, 99, 197, 111, 197, 102, 197, 98, 197, 107, 197, 97, 197, 112, 30]
```

----
- **各要素に3を加える**は[Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2)を使うとよいです
- たとえばこんな感じです

```elixir
iex> Enum.map([1, 2, 3], & &1 + 3)
[4, 5, 6]
```

----
- **200未満の整数のみをリストに残す**は[Enum.filter/2](https://hexdocs.pm/elixir/Enum.html#filter/2)を使うとよいでしょう
- たとえばこんな感じです

```elixir
iex> Enum.filter([10, 200, 199, 100, 300], & &1 < 200)
[10, 199, 100]
```

----
- それでは最初の問題を解いてみましょう

```elixir
iex> list = [84, 197, 98, 197, 29, 197, 94, 197, 111, 197, 98, 197, 29, 197, 113, 197, 101,
 197, 98, 197, 29, 197, 62, 197, 105, 197, 96, 197, 101, 197, 98, 197, 106, 197,
 102, 197, 112, 197, 113, 197, 112, 197, 41, 197, 29, 197, 106, 197, 118, 197,
 29, 197, 99, 197, 111, 197, 102, 197, 98, 197, 107, 197, 97, 197, 112, 30]

iex> Enum.filter(Enum.map(list, & &1 + 3), & &1 < 200)
'We are the Alchemists, my friends!'
```

- [Elixir](https://elixir-lang.org/)には[Charlists](https://hexdocs.pm/elixir/List.html#content)と呼ばれるものがありまして、[List.scii_printable?/2](https://hexdocs.pm/elixir/List.html#ascii_printable?/2)が`true`になるものはシングルクォーテーションで文字のリストが表示されます
- ちなみに[Elixir](https://elixir-lang.org/)の使い手のことをアルケミストと呼ばれます

----
- [Charlists](https://hexdocs.pm/elixir/List.html#content)のことは一旦おいておきまして、**各要素に3を加えて、200未満の整数のみをリストに残す** プログラムをみてみましょう
    - 気になる方は[Charlists](https://hexdocs.pm/elixir/List.html#content)や以下の記事をご確認ください
    - [Elixirで整数リストが「謎の文字」として返ってくる現象と、文字列・文字リストについて](https://qiita.com/im_miolab/items/2d41b10ff005b334295d)
- `Enum.filter(Enum.map(list, & &1 + 3), & &1 < 200)`は、たしかに動いてはいますがパッと見なにをしているのかわかりにくいですよね
- そんなときに使うのが[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)です

----
```elixir
iex> Enum.map(list, & &1 + 3) |> Enum.filter(& &1 < 200)
'We are the Alchemists, my friends!'

iex> list |> Enum.map(& &1 + 3) |> Enum.filter(& &1 < 200)
'We are the Alchemists, my friends!'
```
- いかがでしょうか、だいぶ読みやすくなりましたよね！
- リストがある |> 各要素に3を加える |> 200未満の整数のみをリストに残す
- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)を使うことで、やりたいこととソースコードの順序がぴったり一致します
    - 前の計算結果が次の関数の第一引数に入って関数が実行されます

----
- たとえば以下はJSONが返ってくるAPIをコールして、bodyを取り出して、JSONデコードして、"items_count"キーの値を取り出すプログラム例です
    - どうでしょうか！
    - 言葉での説明とプログラムの順序がぴったり一致します！
    - 美しい！（※)

```elixir
HTTPoison.get!("https://qiita.com/api/v2/users/torifukukaiou")
|> Map.get(:body)
|> Jason.decode!()
|> Map.get("items_count")
```
- （※)たいていのプログラミング言語は上から下に処理が流れると言われればその通りですし、これは[Elixir](https://elixir-lang.org/)の魅力に取り憑かれたものだけが感じる美意識のようなものなのかもしれません

----

- [Enum](https://hexdocs.pm/elixir/Enum.html#content)は[Elixir](https://elixir-lang.org/)を使う上でよく使うモジュールですので、一通りどんな関数があるのか眺めていただけるとよいとおもいます
- 時間のないあなたのために、独断と偏見で特によく使うとおもわれるものをピックアップしておきます
    - [Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2)
    - [Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)
    - [Enum.filter/2](https://hexdocs.pm/elixir/Enum.html#filter/2)
    - [Enum.sort/2](https://hexdocs.pm/elixir/Enum.html#sort/2)
    - [Enum.at/3](https://hexdocs.pm/elixir/Enum.html#at/3)

----
# Wrapping Up
- 今日のポイントは、[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)、[Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールです
- 次回は、ちらっと例をみせた[HTTP GET!](https://qiita.com/torifukukaiou/items/e4416cca916497ee76fb)を詳しくみていきたいとおもいます
    - 来週を待ちきれない方は、リソースやコミュニティの情報を [Where to go next](https://qiita.com/torifukukaiou/items/4fa0747546aafa3fe89a) にまとめていますのでダイブしてください！
- **Enjoy!!!**

