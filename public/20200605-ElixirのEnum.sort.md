---
title: ElixirのEnum.sort
tags:
  - Elixir
private: false
updated_at: '2020-06-06T10:15:17+09:00'
id: 33c51de4a1abae2b683f
organization_url_name: fukuokaex
slide: false
---
# はじめに
- @natsukbd さんの[Goのsortパッケージ](https://qiita.com/natsukbd/items/356d9a2f52176925544f)を拝見しまして、私はぜひ[Elixir](https://elixir-lang.org/)でやってみようとおもいました
- [Elixir](https://elixir-lang.org/)は、`1.10.3`を使いました

```console
$ elixir -v
Erlang/OTP 23 [erts-11.0.2] [source] [64-bit] [smp:72:2] [ds:72:2:10] [async-threads:1] [hipe]

Elixir 1.10.3 (compiled with Erlang/OTP 23)
```

# ハイライト
- 公式ドキュメントがわかりやすいです
- [Enum.sort/1](https://hexdocs.pm/elixir/Enum.html#sort/1)
- [Enum.sort/2](https://hexdocs.pm/elixir/Enum.html#sort/2)
- [Enum.sort_by/3](https://hexdocs.pm/elixir/Enum.html#sort_by/3)

# 0. 準備
- まずは[Elixir](https://elixir-lang.org/)をインストールしましょう
- Windowsの方は
    - [公式](https://elixir-lang.org/install.html#windows) のインストーラーがあります
- macOSの方は
    - a. [asdf-vm](https://asdf-vm.com/#/)を使ってインストールする(オススメ)
        - (参考) [macOS Catalina(10.15.5)にasdfでElixirをインストールする](https://qiita.com/torifukukaiou/items/75fa25c55ce2f0b92496)
        - [Erlang](https://www.erlang.org/)のインストールにけっこう時間がかかります
    - b. [Homebrew](https://brew.sh/index_ja)を使ってインストールする
        - `$ brew install elixir`
        - まず手軽に試してみる感じならこちらのほうが詰まるところは少ないとおもいます
- Linuxの方は、[asdf-vm](https://asdf-vm.com/#/)がよいとおもいます
- エディタを[VSCode](https://code.visualstudio.com/)をお使いの場合は、[ElixirLS](https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls)というextensionがオススメです
- `iex`コマンドで結果を少しずつ試しながら実行できます
    - iexは`System.halt()`で終わらせることができます

```elixir
$ iex
iex> 1 + 1
2
iex> System.halt()
```

- プログラムをファイルに書きたい場合は、以下のようにしてプロジェクトを作ることをオススメします
    - `$ mix test`ですぐに実行できるテストの雛形が手に入る
    - `$ mix format`でフォーマットができる
    - そのうち本格的なプログラムを作る際には`mix new`するようになるので最初からそれに慣れておく

## mix new の例

```console
$ mix new sort
$ cd sort
$ mix test
```

- `sort`はお好きな名前にしてください

## 実行
- ソースコードを書いたら実行したいですよね
- あとで例を示します

```console
$ iex -S mix
```

# IntegerのListを昇順でソートする

- `iex`で実行します

```elixir
$ iex
iex> [7, 2, 3, 1, 4, 5, 6] |> Enum.sort()
[1, 2, 3, 4, 5, 6, 7]
```

# IntegerのListを降順でソートする

- `iex`で実行します

```elixir
$ iex
iex> [7, 2, 3, 1, 4, 5, 6] |> Enum.sort(:desc)
[7, 6, 5, 4, 3, 2, 1]
```
- `:desc`を指定して降順にするのは1.10からのサポートです
- 1.9までは関数を渡す必要がありました(1.10でも関数を渡してお好みの順序に並び替えることができます)

# 文字を昇順でソートする

- `iex`で実行します

```elixir
iex> "cabed" |> String.codepoints() |> Enum.sort()
["a", "b", "c", "d", "e"]
```

# 文字を降順でソートする

- `iex`で実行します

```elixir
iex> "cabed" |> String.codepoints() |> Enum.sort(:desc)
["e", "d", "c", "b", "a"]
```

# 構造体のソート

- ここからはプログラムをファイルに書いてみましょう

## scoreの昇順

```lib/player.ex
defmodule Player do
  defstruct player_id: 0, score: 0
end
```

```elixir:lib/sort.ex
defmodule Sort do
  def run do
    [{1, 50}, {2, 20}, {3, 100}]
    |> Enum.map(fn {player_id, score} ->
      %Player{player_id: player_id, score: score}
    end)
    |> Enum.sort_by(fn %{score: score} -> score end)
  end
end
```

### 実行

```elixir
$ iex -S mix
iex> Sort.run
[
  %Player{player_id: 2, score: 20},
  %Player{player_id: 1, score: 50},
  %Player{player_id: 3, score: 100}
]
```

## scoreの降順

- `iex`は立ち上げたまま`Sort.run/0`関数を変更してみましょう

```elixir:lib/sort.ex
defmodule Sort do
  def run do
    [{1, 50}, {2, 20}, {3, 100}]
    |> Enum.map(fn {player_id, score} ->
      %Player{player_id: player_id, score: score}
    end)
    |> Enum.sort_by(fn %{score: score} -> score end, :desc)
  end
end
```

```elixir
iex> recompile
Compiling 1 file (.ex)
:ok
iex> Sort.run 
[
  %Player{player_id: 3, score: 100},
  %Player{player_id: 1, score: 50},
  %Player{player_id: 2, score: 20}
]
```

- `recompile` で文字通り、コンパイルしなおしてくれます

## 補足
- [Elixir](https://elixir-lang.org/)は異なる型どうしでも大小比較ができます
- 型どうしの大小関係がきまっています

### [Term ordering](https://hexdocs.pm/elixir/operators.html#term-ordering)
```
number < atom < reference < function < port < pid < tuple < map < list < bitstring
```

### 具体例
```elixir
iex> "-1" > 100 
true
iex> "-1" > {50}
true
iex> {50} > 100
true
iex> ["-1", {50}, 100] |> Enum.sort()
[100, {50}, "-1"]
```

# Wrapping Up
- [Elixir](https://elixir-lang.org/)は公式ドキュメントがわかりやすいです
    - また、たいていのものは[ExDoc](https://github.com/elixir-lang/ex_doc)という同じ形式で書かれていて読みやすいです
    - 公式ドキュメントを読み漁るのが楽しいのです
    - [Writing Documentation](https://hexdocs.pm/elixir/writing-documentation.html)
- 途中何も説明していませんが、[Elixir](https://elixir-lang.org/)をはじめての方でもなんとなく読めるのではないかとおもいます
    - 特に[Ruby](https://www.ruby-lang.org/ja/)のご経験があると読みやすいのではないかとおもいます
- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2) は、Pipe operatorと呼ばれるものです
    - 前の関数の結果が、次の関数の第一引数に入っています
- お好きな言語でお好きな順にソートをしてみましょう
- **Enjoy!!!**
- **Have fun coding! (doesn’t matter which language/framework!)**
