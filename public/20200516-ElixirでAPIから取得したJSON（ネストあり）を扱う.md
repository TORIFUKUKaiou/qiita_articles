---
title: ElixirでAPIから取得したJSON（ネストあり）を扱う
tags:
  - Elixir
  - fukuoka.ex
private: false
updated_at: '2020-05-16T13:24:21+09:00'
id: 378f5b69a8a90e8afb26
organization_url_name: fukuokaex
slide: true
ignorePublish: false
---
# はじめに
- @chokunari さんの[Node.jsでAPIから取得したJSON（ネストあり）を扱う](https://qiita.com/chokunari/items/cfabfa1039911f8f5f75)を拝見しまして、ぜひ[Elixir](https://elixir-lang.org/)で書いてみようとおもいました
- [参考にさせていただいた記事](https://qiita.com/chokunari/items/cfabfa1039911f8f5f75)と同じように、`https://mediaarts-db.bunka.go.jp/api/search?aipId=C15461`にアクセスして得られた[JSON](https://www.json.org/json-en.html)から`record` -> `metadata` -> `schema:name` とたどって値を取り出してみます
- [Elixir](https://elixir-lang.org/)は、1.10.3-otp-22 を使っています
- これまで[Elixir](https://elixir-lang.org/)を全く触ったことがない方向けに書いています
- 私自身が[Elixir](https://elixir-lang.org/)初級者ですが、初級者であるからこそまだ忘れていない[Elixir](https://elixir-lang.org/)言語を使う際に味わえる感動を記録しておきたいとおもっています

----
# 最終成果

```elixir
HTTPoison.get!("https://mediaarts-db.bunka.go.jp/api/search?aipId=C15461")
|> Map.get(:body)
|> Jason.decode!()
|> Map.get("record")
|> Enum.map(&(Map.get(&1, "metadata")))
|> Enum.map(&(Map.get(&1, "schema:name")))
|> Enum.at(0)
```

- たったのこれだけです
- これだけですみます

----

# メディア芸術データベース(ベータ版)
- [メディア芸術データベース(ベータ版) 　WebAPI仕様](https://mediaarts-db.bunka.go.jp/resources/pdf/mediaartsdb_webapi_documents.pdf)

----

# 0. 準備
- まずは[Elixir](https://elixir-lang.org/)をインストールしましょう
- Windowsの方は
    - [公式](https://elixir-lang.org/install.html#windows) のインストーラーがあります
- macOSの方は
    - a. [asdf-vm](https://asdf-vm.com/#/)を使ってインストールする(オススメ)
        - (参考) [macOS Catalina(10.15.1)にasdfでElixirをインストールする](https://qiita.com/torifukukaiou/items/75fa25c55ce2f0b92496)
        - [Erlang](https://www.erlang.org/)のインストールにけっこう時間がかかります
    - b. [Homebrew](https://brew.sh/index_ja)を使ってインストールする
        - `$ brew install elixir`
        - まず手軽に試してみる感じならこちらのほうが詰まるところは少ないとおもいます
- Linuxの方は、[asdf-vm](https://asdf-vm.com/#/)がよいとおもいます(ふだんあまり使っていないのでよくわかっていません)


----

# 1. プロジェクト作成
```
$ mix new mediaarts_db
$ cd mediaarts_db
```
----

# 2. `mix.exs`の`deps`を書き換え

```elixir:mix.exs
  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.2"}
    ]
  end
```

- [HTTPoison](https://github.com/edgurgel/httpoison)と[Jason](https://github.com/michalmuskala/jason)を利用します
- [HTTPoison](https://github.com/edgurgel/httpoison)はHTTPクライアントです
- [Jason](https://github.com/michalmuskala/jason)は[JSON](https://www.json.org/json-en.html)のデコード、エンコードを高速に行ってくれます
- [HTTPoison](https://github.com/edgurgel/httpoison)や[Jason](https://github.com/michalmuskala/jason)は[Hex](https://hex.pm/)と呼ばれます
- `1.6`や`1.2`はバージョンです
- お試しされるときに、それぞれの[Hex](https://hex.pm/)に書いてある最新の記載内容に従えばよいです

----

# 3. mix deps.get

```
$ mix deps.get
```

- このコマンドで、依存する[Hex](https://hex.pm/)をダウンロードします
- 実行は `mediaarts_db` ディレクトリの中で行ってください

----

# 4. iex -S mix

```elixir
$ iex -S mix
コンパイルがはじまります
...
iex> HTTPoison.get!("https://mediaarts-db.bunka.go.jp/api/search?aipId=C15461") |> Map.get(:body) |> Jason.decode!() |> Map.get("record") |> Enum.map(&(Map.get(&1, "metadata"))) |> Enum.map(&(Map.get(&1, "schema:name"))) |> Enum.at(0)
["冴えない彼女*の 育てかた[ヒロイン]"]
```
----

もう少し見やすくしてみます。

```elixir
iex> (
...> HTTPoison.get!("https://mediaarts-db.bunka.go.jp/api/search?aipId=C15461")
...> |> Map.get(:body)
...> |> Jason.decode!()
...> |> Map.get("record")
...> |> Enum.map(&(Map.get(&1, "metadata")))
...> |> Enum.map(&(Map.get(&1, "schema:name")))
...> |> Enum.at(0)
...> )
["冴えない彼女*の 育てかた[ヒロイン]"]
```

[元記事](https://qiita.com/chokunari/items/cfabfa1039911f8f5f75)と比べてエラー処理を端折っていますが、だいたいの骨格はたったこれだけです。

----

- 私はこれを一気呵成に全部書いているわけではありません
- うまく文字で説明する自信はないのですが、以下書いてみます
- 一行ずつ書いて結果をみながら次の行を書いている感じです
- まずHTTP Getが必要だよなー　どうやるんだろう？ iexに`HTTP`くらい押してタブを押す、そうすると`HTTPoison`と補完してくれます
    - 本当にはじめてやる人がどうやって[HTTPoison](https://github.com/edgurgel/httpoison)を探しあてるのか？　はもう忘れてしまいましたがまあそこはこの記事を読んでいらっしゃる方ならうまく見つけられることでしょう
- さらにtabをおすと`HTTPoison.`と補完されてさらに、タブをおすと関数の一覧が表示されます
- そこでもう一度やりたかったことをおもいだすとHTTP Getなので、いくつか`get`ではじまるものがみつかりますのでそれをつかうのだろうとあたりをつけてヘルプをみてみます
- `iex> h HTTPoison.get`
- ↑ iex上で、`h`を使うとヘルプがみれます
- ヘルプの内容だけではつかめない場合は**公式のドキュメント**と向き合います
    - わかりやすい英語で書かれていますので、**公式のドキュメント**をあたるのがオススメです
- たとえば、[Usage](https://hexdocs.pm/httpoison/readme.html#usage) 等をみるとイメージがつきます
- あとは`body`を取り出して、[JSON](https://www.json.org/json-en.html)を扱いやすくして、`record` -> `metadata` -> `schema:name` とたどって値を取り出します
- お気づきだとおもいますが、やりたいことの順番とソースコードの順番がぴったり一致します
- [`|>`](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)は`Pipe operator`と呼ばれるものです
- 直前の関数の実行結果が、次の関数の第一引数に入って次の関数が実行されます
- [`|>`](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)でつなげています
- [Enum](https://hexdocs.pm/elixir/Kernel.html)と[Map](https://hexdocs.pm/elixir/Map.html#content)は[Elixir](https://elixir-lang.org/)でもっともよくつかうモジュールとおもっています
- [プログラミングElixir](https://www.amazon.co.jp/dp/4274219151/)という本がとても詳しいです
- こちらの本や[Elixir School](https://elixirschool.com/)を参考にしてください

----

# Wrapping Up
- お好みの言語で[JSON](https://www.json.org/json-en.html)のパースをお楽しみください!!!
- [`|>`](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2) `Pipe operator`最高! ([Elixir](https://elixir-lang.org/))
- `iex`で実行結果をみながら少しずつ組み立てていけるのが気持ちいい ([Elixir](https://elixir-lang.org/))
- Enjoy!!!


