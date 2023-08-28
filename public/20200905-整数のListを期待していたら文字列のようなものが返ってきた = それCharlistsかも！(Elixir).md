---
title: 整数のListを期待していたら文字列のようなものが返ってきた => それCharlistsかも！(Elixir)
tags:
  - Elixir
private: false
updated_at: '2020-09-05T19:24:24+09:00'
id: d9431806d0009be3faea
organization_url_name: fukuokaex
slide: false
---
# はじめに
- 2020/09/02に行われた[fukuoka.ex#41：Elixirお茶会](https://fukuokaex.connpass.com/event/186882/)にてこんな質問がありました

> Player |> Repo.all |> Enum.map(& &1.number)
> みたいなコードの結果が'\t\b'になりました。これは何でしょうか?

# 答えは[Charlists](https://hexdocs.pm/elixir/List.html#module-charlists)でしょう

```elixir
iex> [9, 8]
'\t\b'
```

- [Elixir](https://elixir-lang.org/)はListの要素がすべて整数で、それぞれの整数がアスキー文字として印字可能なものであれば、シングルクォーテーション(`'`)でくくられたアスキー文字の列で表示することになっています
- いやいやそんなのやめてくれ、整数のリストで表示したいよという場合にはIExの設定を変えてあげるとよいです
- 整数のリストで結果を確認したいときはIExの設定を変えてあげましょう
    - `~/.iex.exs`に設定を予め書いておくこともできます

```elixir
iex> IEx.configure(inspect: [charlists: :as_lists])
:ok

iex> [9, 8]
[9, 8]
```

- `h IEx.configure`と`h Inspect.Opts`でヘルプを表示すると設定の仕方が書いてあります

# 本当にそうなの?
- 簡単な[Phoenix](https://www.phoenixframework.org/)プロジェクトを作って試してみます
- 準備はこのあたりをご参照ください
    - [インストール](https://fukuoka-ex.github.io/phoenix-guide-ja/guides/1.4/introduction/installation.html)
    - [Installation](https://hexdocs.pm/phoenix/installation.html#content)


```
$ mix phx.new hello --live
$ cd hello 
$ mix ecto.create
$ mix phx.gen.live Baseball Player players name:string number:integer
```

- `router.ex`の変更は、今回の例では必ずしも必要な手順ではありません

```elixir:lib/hello_web/router.ex
  scope "/", HelloWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/players", PlayerLive.Index, :index # add
    live "/players/new", PlayerLive.Index, :new # add
    live "/players/:id/edit", PlayerLive.Index, :edit # add

    live "/players/:id", PlayerLive.Show, :show # add
    live "/players/:id/show/edit", PlayerLive.Show, :edit # add
  end
```

```elixir:priv/repo/seeds.exs
Hello.Repo.insert!(%Hello.Baseball.Player{name: "テッド・ウィリアムズ", number: 9})
Hello.Repo.insert!(%Hello.Baseball.Player{name: "原辰徳", number: 8})
```

```
$ mix ecto.migrate
$ mix run priv/repo/seeds.exs
$ iex -S mix
```

```elixir
iex> alias Hello.Repo
Hello.Repo

iex> alias Hello.Baseball.Player
Hello.Baseball.Player

iex> Player |> Repo.all |> Enum.map(& &1.number)
[debug] QUERY OK source="players" db=8.4ms decode=1.6ms queue=0.8ms idle=1527.6ms
SELECT p0."id", p0."name", p0."number", p0."inserted_at", p0."updated_at" FROM "players" AS p0 []
'\t\b'
```
- うん、やっぱりそうだね :lgtm: 

```elixir
iex> IEx.configure(inspect: [charlists: :as_lists])
:ok

iex> Player |> Repo.all |> Enum.map(& &1.number)   
[debug] QUERY OK source="players" db=2.6ms idle=1775.7ms
SELECT p0."id", p0."name", p0."number", p0."inserted_at", p0."updated_at" FROM "players" AS p0 []
[9, 8]
```

# Wrapping Up :lgtm: 
- 整数のListを期待していたら文字列のようなものが返ってきた => それは[Charlists](https://hexdocs.pm/elixir/List.html#module-charlists)かもしれません(きっとそうでしょう)
- Enjoy [Elixir](https://elixir-lang.org/)! :rocket: 
- Enjoy [Phoenix](https://www.phoenixframework.org/)! :rocket:

