---
title: ErlangのhttpcモジュールでHTTP通信する(Elixir)
tags:
  - Elixir
private: false
updated_at: '2021-09-04T09:14:00+09:00'
id: b474b1045303f66282d2
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- Erlangの[httpc](https://erlang.org/doc/man/httpc.html)モジュールでHTTP通信を楽しんでみたいとおもいます
- この記事は2021/09/04(土) 00:00〜2021/09/06(月) 23:59開催の純粋なもくもく会「[autoracex #44](https://autoracex.connpass.com/event/224102/)」の成果物です

## 背景
- ふつうは[HTTPoison](https://github.com/edgurgel/httpoison)等の[Elixir](https://elixir-lang.org/)製の[Hex](https://hex.pm/)を使ったほうが書きやすいとおもいますし、使えばよいとおもいます
- ただし[HTTPoison](https://github.com/edgurgel/httpoison)等の[Hex](https://hex.pm/)をどうしても追加できない(できないというよりもしたくない)条件下においては必要となるテクニックだとおもいます
    - たとえば[Nerves Livebook](https://github.com/fhunleth/nerves_livebook)
    - 自分でファームウェアをビルドすればよいのですが、友達にファームウェアを焼き込むツール[fwup](https://github.com/fwup-home/fwup#installing)だけインストールすればいいよと教えた手前、[Nerves](https://www.nerves-project.org/)開発に必要な[あれこれ](https://hexdocs.pm/nerves/installation.html#content)をインストールしてもらうのには忍びないとか
    - 2021/09/04時点の最新版[v0.2.17](https://github.com/fhunleth/nerves_livebook/releases/tag/v0.2.17)では、[Elixir](https://elixir-lang.org/)は`1.12.2-otp-24`なのですが、[Nerves Livebook](https://github.com/fhunleth/nerves_livebook)では[Mix.install/2](https://hexdocs.pm/mix/1.12/Mix.html#install/2)を使って新たに[Hex](https://hex.pm/)を追加することはできないことになっています[^1]

[^1]: そのうち[Nerves Livebook](https://github.com/fhunleth/nerves_livebook)においても、[Mix.install/2](https://hexdocs.pm/mix/1.12/Mix.html#install/2)は対応されるような気もします

![スクリーンショット 2021-09-04 8.18.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6bac07e5-281a-06b3-f0b9-c98af2a37d6a.png)



# HTTP Get
- [httpc](https://erlang.org/doc/man/httpc.html)ここをよく読みましょう
- 以下、サンプルです

## HTTP Get 例①

```elixir
:inets.start
:ssl.start

{:ok, {status, headers, body}} = :httpc.request("https://www.nerves-project.org/")

body |> List.to_string() |> IO.puts()
```

![スクリーンショット 2021-09-04 8.26.36.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/52ed5341-c130-fc0a-6716-56f6506a271d.png)



## HTTP Get 例②

```elixir
:inets.start
:ssl.start

{:ok, {_status, _headers, body}} = :httpc.request("https://qiita.com/api/v2/items?query=elixir")

body
|> List.to_string()
|> Jason.decode!()
|> Enum.map(& Map.take(&1, ["title", "url"]))
```

- [Jason](https://github.com/michalmuskala/jason)は、素の[Nerves Livebook](https://github.com/fhunleth/nerves_livebook)のファームウェアに入っているのでありがたく使っています

![スクリーンショット 2021-09-04 8.23.44.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9d9692ef-0599-4c2a-d627-d0b6b4a1640c.png)


# HTTP Post

- 今度も[httpc](https://erlang.org/doc/man/httpc.html)をよく読みましょう
- 以下、サンプルです

```elixir
:inets.start
:ssl.start

hum = 79.4
temp = 27.3
{:ok, datetime} = DateTime.now("Etc/UTC")
time = datetime |> DateTime.to_unix()

json = Jason.encode!(%{value: %{temperature: temp, humidity: hum, time: time}}) |> String.to_charlist()
request = {'https://<your host>/api/values', [], 'application/json', json}

:httpc.request(:post, request, [], [])
```

![スクリーンショット 2021-09-04 8.31.37.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9141b34a-c9ec-a5b6-08e9-30b5fc041a40.png)

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- [HTTPoison](https://github.com/edgurgel/httpoison)等の[Hex](https://hex.pm/)をどうしても追加できない(できないというよりもしたくない)条件ということに出くわすことがほとんどないような気がしますが、未来の自分へ向けて調べたことを記事にしておきます
    - 記事を書くにあたり、Erlangのプログラム例を参考にしました[^2]
- Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
- [autoracex #44](https://autoracex.connpass.com/event/224102/)開催中 :rocket::rocket::rocket:

[^2]: [Elixir](https://elixir-lang.org/)をやっているとなんとなくErlangが読めるようになるという話を聞いたことがあるのですが、確かになんとな〜くですが読めるようになりつつあることを少し感じました
