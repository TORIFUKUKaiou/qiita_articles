---
title: Elixirで超簡単にWebアプリケーションを作る
tags:
  - Elixir
  - fukuoka.ex
private: false
updated_at: '2020-05-22T07:01:46+09:00'
id: ec4d0ae18c7072309c5c
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- @lambda_funtaro さんの[Haskellで超簡単にWebアプリケーションを作る(モナドも出てこないよ)](https://qiita.com/lambda_funtaro/items/589c2a93749927c33c96)を拝見しまして、ぜひ[Elixir](https://elixir-lang.org/)でやってみたいとおもってやってみました

## この記事でのハイライトコード !!!

```elixir:lib/example/router.ex
defmodule Example.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "hello Cowboy")
  end

  get "/foo" do
    send_resp(conn, 200, "bar buz")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
```


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

# 1. mix new (プロジェクトを作りましょう!)

```
$ elixir -v
Erlang/OTP 22 [erts-10.7.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Elixir 1.10.3 (compiled with Erlang/OTP 22)
$ mix new example --sup
```

- `--sup` オプションを指定して、supervision treeを含むOTPアプリケーションのスケルトンを生成しています


# 2. mix deps.get (依存関係を解決しましょう)

```elixir:lib/mix.exs
  defp deps do
    [
      {:plug_cowboy, "~> 2.0"}
    ]
  end
```
- 上記のように書き換えます
- [PlugCowboy](https://github.com/elixir-plug/plug_cowboy)を使います
    - A Plug Adapter for the [Erlang](https://www.erlang.org/) [Cowboy](https://github.com/ninenines/cowboy) web server.
    - だそうです

```
$ cd example
$ mix deps.get
```

# 3. router.exを書く

```elixir:lib/example/router.ex
defmodule Example.Router do
  use Plug.Router

  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "hello Cowboy")
  end

  get "/foo" do
    send_resp(conn, 200, "bar buz")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
```

# 4. アプリが起動したらCowboyウェブサーバーを起動してsuperviseするように伝えます

```elixir:lib/example/applicatio
  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Example.Router, options: [port: 8000]}
    ]
```

# 5. 起動 🚀🚀🚀

```
$ mix run --no-halt
```

または

```
$ iex -S mix
```

Visit !!!

| | Response | Status Code    |
|:---|:---|:---:|
| http://localhost:8000/ | hello Cowboy | 200 |
| http://localhost:8000/foo | bar buz | 200 |
| http://localhost:8000/other | not found | 404 |


# 参考
- [Elixir School](https://elixirschool.com/en/)の[Plug](https://elixirschool.com/en/lessons/specifics/plug/) 記事をとても参考にしました


**Enjoy!!!**
