---
title: '[Elixir] JSON レスポンスから CSV を作成する'
tags:
  - Elixir
private: false
updated_at: '2020-06-07T23:40:00+09:00'
id: c0c4af21d0dc25ad3855
organization_url_name: fukuokaex
slide: false
---
# はじめに
- @tsuBee5 さんの[[Go] JSON レスポンスから CSV を作成する](https://qiita.com/tsuBee5/items/9b8da61e851a1e62f309)を拝見しまして、私はぜひ[Elixir](https://elixir-lang.org/)でやってみようとおもいました
- [Elixir](https://elixir-lang.org/)を使うのははじめてという方向けの記事です

## [JSONPlaceholder](https://jsonplaceholder.typicode.com/)
- FakeのJSONを返してくれるサイトがあります(拝見した[記事](https://qiita.com/tsuBee5/items/9b8da61e851a1e62f309)ではじめて知りました！)
- ここから`/posts`のデータを取得して、CSVを作成してみます
- [スポンサー募集](https://github.com/sponsors/typicode)中とのことです

## [Elixir](https://elixir-lang.org/)は、`1.10.3`を使いました

```console
$ elixir -v
Erlang/OTP 23 [erts-11.0.2] [source] [64-bit] [smp:72:2] [ds:72:2:10] [async-threads:1] [hipe]

Elixir 1.10.3 (compiled with Erlang/OTP 23)
```

# ハイライト
- 以下の[Hex](https://hex.pm/)を利用します
    - [HTTPoison](https://hex.pm/packages/httpoison)
    - [Jason](https://hex.pm/packages/jason)
    - [NimbleCSV](https://hex.pm/packages/nimble_csv)

```elixir
$ iex
iex> NimbleCSV.define(MyParser, separator: ",", escape: "\"")
iex> (
...> HTTPoison.get!("https://jsonplaceholder.typicode.com/posts")
...> |> Map.get(:body)
...> |> Jason.decode!()
...> |> Enum.map(fn %{"id" => id, "title" => title, "body" => body} -> [id, title, body] end)
...> |> MyParser.dump_to_iodata()
...> |> IO.iodata_to_binary()
...> |> (fn content -> File.write!("test.csv", content) end).()
...> )
```

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
- エディタに[VSCode](https://code.visualstudio.com/)をお使いの場合は、[ElixirLS](https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls)というextensionがオススメです

## iex
- `iex`コマンドで結果を少しずつ試しながら実行できます
    - iexは`System.halt()`で終わらせることができます

```elixir
$ iex
iex> 1 + 1
2
iex> System.halt()
```

## mix new
- プログラムをファイルに書きたい場合は、以下のようにしてプロジェクトを作ることをオススメします
    - `$ mix test`ですぐに実行できるテストの雛形が手に入る
    - `$ mix format`でフォーマットができる
    - そのうち本格的なプログラムを作る際には`mix new`するようになるので最初からそれに慣れておく

### mix new の例

```console
$ mix new json_csv
$ cd json_csv
$ mix test
```

- `json_csv`はお好きな名前にしてください

### 実行
- ソースコードを書いたら実行したいですよね
- あとで例を示します

```console
$ iex -S mix
```

# まずは`iex`だけで作る
- `iex`を起動して一歩ずつ作ってみましょう
- やることは以下の通りです

```
HTTP Getする # HTTPoisonをつかう
|> レスポンスからbodyを取り出す 
|> bodyのJSONをElixirで扱いやすいMapの形式にする # Jasonをつかう
|> CSVに保存したい値だけ取り出す 
|> CSVの形式にあうように整形する(改行があるときに" "で囲むとか) # NimbleCSV
|> ファイルに保存する
```

## 依存関係の解決
```console
$ mix new json_csv
$ cd json_csv
```

```elixir:mix.exs
  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.2"},
      {:nimble_csv, "~> 0.7.0"}
    ]
  end
```
- Versionは、2020/6/7時点のものです
- お試しされる際には以下をご確認のうえ、最新のバージョンをお使いください
    - [HTTPoison](https://hex.pm/packages/httpoison)
    - [Jason](https://hex.pm/packages/jason)
    - [NimbleCSV](https://hex.pm/packages/nimble_csv)

```
$ mix deps.get
```


## 0. CSV Dumperの初期化
```elixir
$ iex -S mix
iex> NimbleCSV.define(MyParser, separator: ",", escape: "\"")
```
- [NimbleCSV.define/2](https://hexdocs.pm/nimble_csv/NimbleCSV.html#define/2)

## 1. HTTP Getする # HTTPoisonをつかう
```elixir
iex> HTTPoison.get!("https://jsonplaceholder.typicode.com/posts")
```
- [HTTPoison.get!/3](https://hexdocs.pm/httpoison/HTTPoison.html#get!/3)
- 値が得られたら次に進みましょう

## 2. レスポンスからbodyを取り出す 
```elixir

iex> (
...> HTTPoison.get!("https://jsonplaceholder.typicode.com/posts")
...> |> Map.get(:body)
...> )
```
- [Map.get/3](https://hexdocs.pm/elixir/Map.html#get/3)

## 3. bodyのJSONをElixirで扱いやすいMapの形式にする # Jasonをつかう

```elixir

iex> (
...> HTTPoison.get!("https://jsonplaceholder.typicode.com/posts")
...> |> Map.get(:body)
...> |> Jason.decode!()
...> )
```
- [Jason.decode!/2](https://hexdocs.pm/jason/Jason.html#decode!/2)
- だいぶ結果がみやすくなっているとおもいます
- 残りは省略しますが、最終的には以下のようになります

```elixir
iex> (
...> HTTPoison.get!("https://jsonplaceholder.typicode.com/posts")
...> |> Map.get(:body)
...> |> Jason.decode!()
...> |> Enum.map(fn %{"id" => id, "title" => title, "body" => body} -> [id, title, body] end)
...> |> MyParser.dump_to_iodata()
...> |> IO.iodata_to_binary()
...> |> (fn content -> File.write!("test.csv", content) end).()
...> )
```

- [Enum.map/2](https://hexdocs.pm/elixir/Enum.html#map/2)
- [dump_to_iodata/1](https://hexdocs.pm/nimble_csv/NimbleCSV.html#c:dump_to_iodata/1)
- [IO.iodata_to_binary/1](https://hexdocs.pm/elixir/IO.html#iodata_to_binary/1)
- [File.write!/3](https://hexdocs.pm/elixir/File.html#write!/3)

# プログラムをファイルに書く
- `iex`でおおまかな流れはつかめました
- HTTP Getに失敗した場合はプログラムを終了することにします
- HTTP Getに成功したらJSONの中身は正しいものとしています

```elixir:lib/json_csv/jsonplaceholder.ex
defmodule JsonCsv.Jsonplaceholder do
  @parsers %{"posts" => JsonCsv.Jsonplaceholder.Parser.Post}

  def fetch(path \\ "posts") do
    HTTPoison.get("https://jsonplaceholder.typicode.com/#{path}")
    |> handle_response(path)
  end

  def handle_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}, path) do
    {:ok, Jason.decode!(body) |> Enum.map(&@parsers[path].parse(&1))}
  end

  def handle_response({_, resp}, _path) do
    {:error, resp}
  end
end
```

```elixir:lib/json_csv/jsonplaceholder/parser.ex
defmodule JsonCsv.Jsonplaceholder.Parser do
  @callback parse(arg :: map) :: struct
end
```

```elixir:lib/json_csv/jsonplaceholder/parser/post.ex
defmodule JsonCsv.Jsonplaceholder.Parser.Post do
  @behaviour JsonCsv.Jsonplaceholder.Parser
  defstruct [:user_id, :id, :title, :body]

  @impl true
  def parse(%{"userId" => user_id, "id" => id, "title" => title, "body" => body}) do
    %__MODULE__{user_id: user_id, id: id, title: title, body: body}
  end
end
```

```elixir:lib/json_csv.ex
NimbleCSV.define(MyParser, separator: ",", escape: "\"")

defmodule JsonCsv do
  def run(path \\ "posts") do
    JsonCsv.Jsonplaceholder.fetch(path)
    |> decode_response()
    |> Enum.map(&filter/1)
    |> MyParser.dump_to_iodata()
    |> IO.iodata_to_binary()
    |> (fn content -> File.write!("test.csv", content) end).()
  end

  defp decode_response({:ok, response}) do
    response
  end

  defp decode_response({_, response}) do
    IO.inspect(response)
    System.halt(2)
  end

  defp filter(%{id: id, title: title, body: body}), do: [id, title, body]
end
```

## 実行

```console
$ iex -S mix
iex> JsonCsv.run()
```

または

```console
$ mix run -e 'JsonCsv.run()'
```


- `test.csv`が生成されていることでしょう



# Wrapping Up
- まず`iex`で少しずつ結果を確認しながら大雑把に作ってみて、それから(途中だいぶ説明を端折っているとおもいますが)ソースコードを書く流れを示してみました
- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2) は、Pipe operatorと呼ばれるものです
    - これを使うことで、やりたいこととソースコードの順番をぴったり一致させることができます
- お好きな言語でJSONを取得してCSVを作成してみましょう
- **Enjoy!!!** :rocket::rocket::rocket:
- **Have fun coding! (doesn’t matter which language/framework!)**
