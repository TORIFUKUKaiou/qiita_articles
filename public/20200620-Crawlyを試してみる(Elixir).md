---
title: Crawlyを試してみる(Elixir)
tags:
  - Elixir
private: false
updated_at: '2020-06-20T14:13:43+09:00'
id: e9ee35caf4c5f11e541d
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [ElixirConf EU Virtual](https://virtual.elixirconf.eu/)で[セッション](https://virtual.elixirconf.eu/talks/web-scraping-in-elixir-with-crawly/)をきいた[Crawly](https://github.com/oltarasenko/crawly)を試してみます

```
elixir         1.10.3-otp-23
erlang         23.0.1
```

# What is [Crawly](https://github.com/oltarasenko/crawly) ?
> Crawly, a high-level web crawling & scraping framework for Elixir.

クローラーに必要なこと全部入りライブラリというところでしょうか。

セッションの中では以下の内容を熱っぽく語られていました。
- 他言語製のなにかにインスパイアを受けて[Elixir](https://elixir-lang.org/)でつくっちゃおう
- ドキュメントを充実させる
- 電池入ではめ込んですぐにでも使えるもの
- Robots.txtに従ったり、JavaScriptのコンテンツをいい感じ(!?)にしたり
- アクセスの都度User-Agentを変えたりする
- を作りました！

# 0. 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
- 手前味噌ですが[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)などを参考にしてください 

# 1. プロジェクトをつくってREADME等に書いてあることをそのまま写します

- まずプロジェクトをつくります
 
```console
$ mix new crawly_example --sup
$ cd crawly_example
```

- 次に依存関係を解決します

```elixir:mix.exs
  defp deps do
    [
      {:crawly, "~> 0.10.0"},
      {:floki, "~> 0.26.0"}
    ]
  end
```

```console
$ mix deps.get
```

- サンプルモジュールを写します
- [作者](https://github.com/oltarasenko) さんが[Erlang Solutions](https://www.erlang-solutions.com)の中の人のようで、スクレイピングするサイトはサンプルをそのまま使わせてもらいます

```elixir:lib/crawly_example/esl_spider.ex
defmodule EslSpider do
  use Crawly.Spider

  alias Crawly.Utils

  @impl Crawly.Spider
  def base_url(), do: "https://www.erlang-solutions.com"

  @impl Crawly.Spider
  def init(), do: [start_urls: ["https://www.erlang-solutions.com/blog.html"]]

  @impl Crawly.Spider
  def parse_item(response) do
    {:ok, document} = Floki.parse_document(response.body)
    hrefs = document |> Floki.find("a.more") |> Floki.attribute("href")

    requests =
      Utils.build_absolute_urls(hrefs, base_url())
      |> Utils.requests_from_urls()

    title = document |> Floki.find("article.blog_post h1") |> Floki.text()

    %{
      :requests => requests,
      :items => [%{title: title, url: response.request_url}]
    }
  end
end
```

```elixir:config/config.exs
use Mix.Config

config :crawly,
  middlewares: [
    {Crawly.Middlewares.UserAgent,
     user_agents: ["Crawly Bot", "Crawly Bot 1.0", "Crawly Bot 2.0", "Awesome Bot"]}
  ],
  pipelines: [
    Crawly.Pipelines.JSONEncoder,
    {Crawly.Pipelines.WriteToFile, folder: "/tmp", extension: "jl"}
  ]
```

# 2. 実行
- 動かしてみましょう

```
$ iex -S mix
iex> Crawly.Engine.start_spider(EslSpider)
```

# 3. 結果確認

```console
$ cat /tmp/EslSpider_2020_06_20_00_42_16_073891.jl
{"url":"https://www.erlang-solutions.com/blog.html","title":""}
{"url":"https://www.erlang-solutions.com/blog/welcome-to-our-new-blog.html","title":"Welcome to our new blog!!"}
{"url":"https://www.erlang-solutions.com/blog/mongooseim-1-6-1-is-released.html","title":"MongooseIM 1.6.1 is releasedMongooseIM 1.6.1 is released"}
{"url":"https://www.erlang-solutions.com/blog/secure-shell-for-your-erlang-node.html","title":"Secure Shell for Your Erlang NodeSecure Shell for Your Erlang NodeStarting upWrapping in an application"}
{"url":"https://www.erlang-solutions.com/blog/mongooseim-1-6-riak-devops-love-and-so-much-more.html","title":"MongooseIM 1.6: Riak, DevOps love, and so much more!"}
{"url":"https://www.erlang-solutions.com/blog.html","title":""}
{"url":"https://www.erlang-solutions.com/blog/welcome-to-our-new-blog.html","title":"Welcome to our new blog!!"}
```

- `EslSpider.parse_item`の結果の`items`に指定した形のものがファイルに書き出されるようです

- ファイル名の日時のところは適宜読み替えてください

# その他
- Use-Agentをランダムに切り替える処理は、たぶん[ココ](https://github.com/oltarasenko/crawly/blob/0.10.0/lib/crawly/middlewares/user_agent.ex#L29)

# Wrapping Up
- **Enjoy!!!**

```elixir
iex> [87, 101, 32, 97, 114, 101, 32, 116, 104, 101, 32, 65, 108, 99, 104, 101, 109, 105, 115, 116, 115, 44, 32, 109, 121, 32, 102, 114, 105, 101, 110, 100, 115, 33]
```




