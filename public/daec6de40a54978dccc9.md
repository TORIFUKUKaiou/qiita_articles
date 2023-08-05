---
title: Elixirで湯婆婆を実装してみる
tags:
  - Elixir
  - ネタ
  - 湯婆婆
private: false
updated_at: '2020-11-16T21:31:40+09:00'
id: daec6de40a54978dccc9
organization_url_name: fukuokaex
slide: false
---
# はじめに
- @Nemesis さんの[Javaで湯婆婆を実装してみる](https://qiita.com/Nemesis/items/c7192a7c510788d2cba2)を拝見しまして、私は[Elixir](https://elixir-lang.org/)でやってみようとおもいました
- [Elixir](https://elixir-lang.org/) はじめてな方に向けて書いています
    - といいつつ、私自身は多少、毛が生えてきた程度の素人でございます
    - [Elixir](https://elixir-lang.org/)の意味は、**不老不死の霊薬**です
    - a magic liquid that is believed to cure illnesses or to make people live forever

# 0. 準備
- まずは[Elixir](https://elixir-lang.org/)をインストールしましょう
- 手前味噌な記事ですが[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)などをご参照ください

# 1. プロジェクト作成

```
$ mix new yubaba
$ cd yubaba
```

- プロジェクトの雛形がつくられます
- いっぱいファイルができます
- [Elixir](https://elixir-lang.org/)がはじめての方はそんなものだと流してください
- 慣れるといつもの景色にみえてきます


# 2. プログラムを書く

```elixir:lib/yubaba.ex
defmodule Yubaba do
  def main do
    name = IO.gets("契約書だよ。そこに名前を書きな。\n") |> String.trim()

    IO.puts("フン。#{name}というのかい。贅沢な名だねぇ。")
    new_name = String.codepoints(name) |> Enum.random()

    IO.puts("今からお前の名前は#{new_name}だ。いいかい、#{new_name}だよ。分かったら返事をするんだ、#{new_name}!!")
  end
end
```

- `|>` は[Pipe operator](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)と呼ばれるものでして、前の計算結果を次の関数の第一引数に入れて計算をしてくれます
- 入力文字列から一文字を選ぶ([名前を奪う](https://qiita.com/Nemesis/items/c7192a7c510788d2cba2#%E5%90%8D%E5%89%8D%E3%82%92%E5%A5%AA%E3%81%86))ところは、[String.codepoints/1](https://hexdocs.pm/elixir/String.html#codepoints/1)関数で要素が1文字ずつのリストにして、そのリストの中から1要素を適当に選んでくれる[Enum.random/1](https://hexdocs.pm/elixir/Enum.html#random/1)関数を使うことで`new_name`を求めています
    - `String.codepoints(name) |> Enum.random()`
- `Module.function/1`なんていきなりさらっと書いていますが、`/`のうしろは引数の数です
    - [Elixir](https://elixir-lang.org/)界でよくみる表記方法です

# 3. 実行

```elixir
$ iex -S mix

iex> Yubaba.main
契約書だよ。そこに名前を書きな。
山田太郎
フン。山田太郎というのかい。贅沢な名だねぇ。
今からお前の名前は太だ。いいかい、太だよ。分かったら返事をするんだ、太!!
:ok

iex> Yubaba.main
契約書だよ。そこに名前を書きな。

フン。というのかい。贅沢な名だねぇ。
** (Enum.EmptyError) empty error
    (elixir 1.10.4) lib/enum.ex:1999: Enum.random/1
    (yubaba 0.1.0) lib/yubaba.ex:24: Yubaba.main/0

iex> 
```

- 何も入力しない場合にエラーになってしまう件は[本家](https://qiita.com/Nemesis/items/c7192a7c510788d2cba2)と同じくです

# 4. 改善(する必要はないのかもしれませんが)案

- いろいろと方法はあるとおもいます
- ここでは`Yubaba.new_name/1`関数を用意して入力値によって処理を変えてみることにします
- `Yubaba.new_name/1`関数を2つ作っています
    - [パターンマッチ](https://elixir-lang.org/getting-started/pattern-matching.html)と呼ばれる仕掛けで最初にマッチしたほうの関数が実行されます
    - 空文字列`""`とそれ以外でわけてみました
- `defp`の`p`は`private`のピ〜です(そもそも`def`を説明していませんが)
    - `Yubaba`モジュール内だけで使える関数です

```elixir:lib/yubaba.ex
defmodule Yubaba do
  def main do
    name = IO.gets("契約書だよ。そこに名前を書きな。\n") |> String.trim()

    IO.puts("フン。#{name}というのかい。贅沢な名だねぇ。")
    new_name = new_name(name)

    IO.puts("今からお前の名前は#{new_name}だ。いいかい、#{new_name}だよ。分かったら返事をするんだ、#{new_name}!!")
  end

  defp new_name(""), do: ""

  defp new_name(name), do: String.codepoints(name) |> Enum.random()
end
```

- `IEx`を起動したままの場合は`recompile`して再度実行してみてください

# 5. IExの終了

```
iex> System.halt
```

- 参考
    - [ElixirのIExをコマンド入力で停止する](https://qiita.com/im_miolab/items/22d725a77ba3ea3a3513)

# Wrapping Up :lgtm: :qiita-fabicon: :lgtm:
- とにかく[Elixir](https://elixir-lang.org/)で書いてみようと始めてみましたところ、実は奥深い題材だったようで[Elixir](https://elixir-lang.org/)のけっこういろいろなことを紹介できた気がします
- [Elixir](https://elixir-lang.org/)は、[Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールと仲良くなれるとよいです
- 何だってそうだとおもいますが、[Elixir](https://elixir-lang.org/)は特に、公式ドキュメントを読むのが一番よいです
    - 英語で書かれていますがたいてい実行例が書いてありますし、公式ドキュメントも各種ライブラリも同じ形式で書かれているので慣れるととても読みやすいです
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket: 
