---
title: 'Enjoy Elixir #001 -- mix new, iex -S mix, mix format'
tags:
  - Elixir
private: false
updated_at: '2020-11-15T11:24:41+09:00'
id: d04d0273749c41eb50af
organization_url_name: fukuokaex
slide: true
ignorePublish: false
---
# はじめに
- [KFIE](https://kfieyaruki.connpass.com/)という近畿大学産業理工学部の情報系コミュニティがあります
- 最近は、毎週火曜日にLT会をやっているそうです
- 私が学生だったのはもうずいぶん昔のことなのですが、参加させてもらっています
- 毎週、5分間時間をもらって、[Elixir](https://elixir-lang.org/)いいよ！　を伝えていきたいとおもいます
    - [2020/6/2(火)の回](https://kfieyaruki.connpass.com/event/177278/)
- 今日は以下を学びます
    - iex
    - mix new
    - mix test
    - mix format
    - iex -S mix
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

# 0. インストール
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
- エディタは[VSCode](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)がオススメです
    - extensionは[ElixirLS: Elixir support and debugger](https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls)がよいでしょう
- 私は普段よくmacOSを使っておりまして、macOSでしか動作確認しておりません
- Windows, Linuxについては事情を把握できていない場合がありますのであしからずご了承ください

----

# 1. iex

```elixir
$ iex
Erlang/OTP 23 [erts-11.0.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Interactive Elixir (1.10.3) - press Ctrl+C to exit (type h() ENTER for help)
iex(1)> 40 + 2
42
iex(2)> "hello" <> " world"
"hello world"
iex(3)> h System.halt
...
```

- Windowsの場合は、`iex.bat` です
- `iex`コマンドで少しずつ実行しては結果を試しながら実行できます
- `h`で関数のドキュメントを参照できます
- 全部打ち込まなくてもタブで補完してくれます
- 終了するときは、`System.halt` で終わらせましょう

----

# 2. プロジェクトの作成(`mix new`)

```
$ mix new hello
```

- `mix new`で以下のプロジェクト構造が作られます 

```
hello
├── README.md
├── lib
│   └── hello.ex
├── mix.exs
└── test
    ├── hello_test.exs
    └── test_helper.exs
```

- プログラムをファイルに書きたい場合は、プロジェクトを作ることをオススメします
    - `$ mix test`ですぐに実行できるテストの雛形が手に入る
    - `$ mix format`でフォーマットができる
    - そのうち本格的なプログラムを作る際には`mix new`するようになるので最初からそれに慣れておく

----
## テストの実行

- テストの雛形が含まれています
- テストを実行してみましょう

```
$ cd hello
$ mix test
```

----
## 自動的に作られた.exをよくみてみる

- `mix new`で以下のコードが自動的につくられています
- `Hello.hello/0`が定義されています
    - /の後ろの数字の意味は引数の個数です
    - この場合は引数なし(0個)

```elixir:lib/hello.ex
defmodule Hello do
  @moduledoc """
  Documentation for `Hello`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Hello.hello()
      :world

  """
  def hello do
    :world
  end
end
```

- `## Examples`のところは、[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれる部分です
- 結果の`:world`をたとえば`:hello`に書き換えて `$ mix test`を実行するとテストが失敗します
- [ExDoc](https://github.com/elixir-lang/ex_doc/)というツールでドキュメントを生成することができます
    - 生成されるドキュメントの例はたとえば、[Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2) です
        - [Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2)はこれから接する機会が多い関数の一つです
    - [Elixir](https://elixir-lang.org/)のドキュメントはライブラリもたいていこの形式で書かれていて統一されているのがいいです
    - コメントで書いたところがテストされているので、ドキュメントのコード例が正確です！
    - 自分のプロジェクトのドキュメントを生成する方法はまたいつか別の機会に説明をします

----
## 実行

```elixir
$ iex -S mix

iex> Hello.hello
:world
```

----
## コードフォーマット

- `mix new`で作ったプロジェクト配下では、下記のコマンドでソースコードのフォーマットを行ってくれます

```
$ mix format
```

----
## 探検

- `mix`コマンドのtask一覧は下記で確認できます

```
$ mix help
mix                   # Runs the default task (current: "mix run")
...
mix new               # Creates a new Elixir project
...
iex -S mix            # Starts IEx and runs the default task
```

- さらにtaskの詳細を知りたい場合には以下のようにします(以下newの例)

```
$ mix help new
```

----
# 3. Wrapping Up
- `iex`, `mix new`, `mix test`, `iex -S mix`, `mix format`を学びました
- 次回は**[型](https://qiita.com/torifukukaiou/items/1f5789dbd05498be1132)**について説明しようとおもいます
- We are the Alchemists, my friends!
    - [Elixir](https://elixir-lang.org/)の使い手のことは、Alchemistと呼ばれます
    - [アルケミスト 夢を旅した少年](https://www.amazon.co.jp/dp/404275001X)
- **Enjoy!!!**

----

# 参考
- [Introduction](https://elixir-lang.org/getting-started/introduction.html)
- [Introduction to Mix](https://elixir-lang.org/getting-started/mix-otp/introduction-to-mix.html)
