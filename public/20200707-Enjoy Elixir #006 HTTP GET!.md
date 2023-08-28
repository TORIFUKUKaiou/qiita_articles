---
title: 'Enjoy Elixir #006 HTTP GET!'
tags:
  - Elixir
private: false
updated_at: '2020-11-15T11:25:56+09:00'
id: e4416cca916497ee76fb
organization_url_name: fukuokaex
slide: true
---
# はじめに
- [KFIE](https://kfieyaruki.connpass.com/)という近畿大学産業理工学部の情報系コミュニティがあります
- 最近は、毎週火曜日にLT会をやっているそうです
- 私が学生だったのはもうずいぶん昔のことなのですが、参加させてもらっています
- 毎週、5分間時間をもらって、[Elixir](https://elixir-lang.org/)いいよ！　を伝えていきたいとおもいます
    - [2020/7/7(火)の回](https://kfieyaruki.connpass.com/event/182014/)
- 今日は以下を学びます
    - HTTP GET!
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
$ mix new hello_http
$ cd hello_http
```

----
# 依存関係の解消

- [hex](https://hex.pm/)でパッケージをさがします
- 今回は以下を使います
    - [httpoison](https://hex.pm/packages/httpoison)
        - Yet Another HTTP client for Elixir powered by hackney
    - [jason](https://hex.pm/packages/jason)
        - A blazing fast JSON parser and generator in pure Elixir.
- 上記のページの右のほうに書いてある記述を参考に`deps`を書き換えます

<img width="1026" alt="スクリーンショット 2020-07-07 17.11.42.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a477fc13-9050-eb4d-c704-8d4b2950764d.png">


```elixir:mix.exs
  defp deps do
    [
      {:httpoison, "~> 1.7"},
      {:jason, "~> 1.2"}
    ]
  end
```

```
$ mix deps.get
```

----
# HTTP GET!
- ここでは[Qiita](https://qiita.com/)の[API](https://qiita.com/api/v2/docs)を利用してみましょう
- 記事では結果だけ書いていますが、発表のときには`iex`で少しずつ結果を確かめながら作っていくさまをお見せできたらとおもっています

```elixir:lib/hello_http.ex
defmodule HelloHttp do
  @query URI.encode_query(%{"query" => "tag:Elixir"})

  def run do
    "https://qiita.com/api/v2/items?#{@query}"
    |> HTTPoison.get()
    |> handle_response()
    |> Jason.decode!()
  end

  defp handle_response({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body
  end

  defp handle_response(_) do
    raise "error"
  end
end
```

- `@query`は[Module attributes](https://elixir-lang.org/getting-started/module-attributes.html)と呼ばれるものです
- 「多くのElixirプログラマは、JavaやRubyでは定数を使うようなところで使っている」そうです
    - [プログラミングElixir](https://www.amazon.co.jp/dp/4274219151) より

## 実行
```
$ iex -S mix

iex> HelloHttp.run
```

----
# GETはわかったけどその後、それをどうしたらいいの?
- たとえばこういうものが作れます
    - 取得したものを整形して[Qiita](https://qiita.com/)に記事を自動投稿
        - HTTP POSTは、[httpoison](https://hex.pm/packages/httpoison)でできます
    - ついでにTwitterにも投稿
        - [extwitter](https://hex.pm/packages/extwitter)を利用
    - 定期実行は[quantum](https://hex.pm/packages/quantum)を利用
- [【毎日自動更新】QiitaのElixir LGTMランキング！](https://qiita.com/torifukukaiou/items/1edb3e961acf002478fd)
    - [参考ソースコード(プルリク)](https://github.com/TORIFUKUKaiou/hello_nerves/pull/34)

----
# Wrapping Up
- 今日のポイントは、[hex](https://hex.pm/)の探し方と、`mix deps.get`です
- サンプルコードの`tag`にお好みの言語を設定してHTTP GETをお楽しみください
- 次回は、[Flow](https://qiita.com/torifukukaiou/items/eb1aa2c8842adfc40637)
    - 来週を待ちきれない方は、リソースやコミュニティの情報を [Where to go next](https://qiita.com/torifukukaiou/items/4fa0747546aafa3fe89a) にまとめていますのでダイブしてください！
- **Enjoy!!!**
