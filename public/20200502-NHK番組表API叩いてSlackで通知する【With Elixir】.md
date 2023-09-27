---
title: 'NHK番組表API叩いてSlackで通知する[With Elixir]'
tags:
  - Elixir
  - Slack
private: false
updated_at: '2020-05-02T15:49:06+09:00'
id: 56373e0bab428ae51a83
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- @k_shibusawa さんの[NHK番組表API叩いてSlackで通知する](https://qiita.com/k_shibusawa/items/4e1cdb015f1271f9b404)を拝見しておりまして、ぜひ[Elixir](https://elixir-lang.org/)でやってみようとおもいました

# 作品
- https://github.com/TORIFUKUKaiou/nhk_api_demo

# 0. 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - macOSやLinuxの方は、[asdf-vm](https://asdf-vm.com/#/)がおすすめだとよく聞く気がするのですが他の方法でもよいとおもいます
        - たとえばmacOSをお使いで、[Homebrew](https://brew.sh/index_ja)をお使いの場合は、`$ brew install elixir` が公式でも紹介されている方法です
- とにかく、[Installing Elixir](https://elixir-lang.org/install.html) をご覧いただくとよいです

# 1. まずなにはともあれ、[NHK番組表API](http://api-portal.nhk.or.jp/ja)にユーザー登録をします
- ユーザー登録をしたらその次に、登録済アプリ(http://api-portal.nhk.or.jp/ja/user/xxxx/apps) というところにアプリを登録すると、めでたくAPIキーをもらえます

# 2. [Elixir](https://elixir-lang.org/)のプログラムをつくる

## 2-1. mix new でプロジェクトの雛形をつくる
```
$ mkdir nhk
$ cd nhk
$ asdf local elixir 1.10.3-otp-22
$ mix new . --sup
```

## 2-2. 依存[Hex](https://hex.pm/)を追加しよう

```elixir:mix.exs
  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.2"},
      {:quantum, "~> 3.0-rc"},
      {:timex, "~> 3.5"},
      {:flow, "~> 1.0"}
    ]
  end
```
### [HTTPoison](https://github.com/edgurgel/httpoison)
- HTTP client for Elixir

### [Jason](https://github.com/michalmuskala/jason)
- A blazing fast JSON parser and generator in pure Elixir.
- 速いよ

### [Quantum](https://github.com/quantum-elixir/quantum-core)
- Cron-like job scheduler for Elixir.
- 定期実行を堅牢なOTPを利用して動かしてみましょう

### [Timex](https://github.com/bitwalker/timex)
- Timex is a rich, comprehensive Date/Time library for Elixir projects, with full timezone support via the :tzdata package. 

### [Flow](https://github.com/dashbitco/flow)
- Flow allows developers to express computations on collections, similar to the Enum and Stream modules, although computations will be executed in parallel using multiple GenStages.
- まずは[Enum](https://hexdocs.pm/elixir/Enum.html#content)で書いて、とにかく[Flow](https://github.com/dashbitco/flow)と書き直してみましょう
- とにかく書き直すと速くなります

`mix.exs`を変更したら、以下のコマンドで依存[Hex](https://hex.pm/)を取得します。

```
$ mix deps.get
```

だいたい準備は整ったので、あとは楽しい楽しい[Elixir](https://elixir-lang.org/)のコードを書いていきましょう:rocket: 楽しみましょう！

```elixir:config/config.exs
use Mix.Config

config :nhk,
  nhk_api_key: System.get_env("NHK_API_KEY"),
  area: System.get_env("NHK_AREA"),
  acts: System.get_env("NHK_ACTS"),
  titles: System.get_env("NHK_TITLES"),
  slack_incoming_webbook_url: System.get_env("NHK_SLACK_INCOMING_WEBHOOK_URL"),
  slack_channel: System.get_env("NHK_SLACK_CHANNEL")
```

環境変数には以下のような値を書いておきます。

```
export NHK_API_KEY="secret"
export NHK_AREA=401
export NHK_ACTS="加藤一二三,美輪明宏,美空ひばり,春風亭一朝,ベニシア・スタンリー・スミス"
export NHK_TITLES="昆虫すごいぜ,LIFE,麒麟がくる,将棋"
export NHK_SLACK_INCOMING_WEBHOOK_URL="https://hooks.slack.com/services/Txxxxxx/BLLLLL/secret"
export NHK_SLACK_CHANNEL="#nhk"
```

## NHK番組表APIを呼び出すモジュール

HTTP Getして
|> bodyを取り出して
|> JSONデコードして
|> JSONをたぐって、"list"の値を取り出して
|> JSONをたぐって、service(`"g1"`や`"e1"`等)の値を取り出しています

```elixir:nhk/api.ex
defmodule Nhk.Api do
  @apikey Application.get_env(:nhk, :nhk_api_key)

  def get(area, service, date) do
    case HTTPoison.get(url(area, service, date)) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> Map.get("list")
        |> Map.get(service)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts(404)
        []

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
        []
    end
  end

  defp url(area, service, date) do
    "https://api.nhk.or.jp/v2/pg/list/#{area}/#{service}/#{date}.json?key=#{@apikey}"
  end
end
```

## Nhkモジュール

今日を含んで7日後までの日付とサービスIDを組み合わせて
|> エリアと日付、サービスIDを指定してNHK番組表APIを[Elixir](https://elixir-lang.org/)らしくconcurrency(※)に呼び出して結果を平らにして
|> 好きな演者が出演している or 好きな番組のレコードだけを残して
|> {テキスト整形結果, start_time}のタプルをつくって
|> 日時順にソートして
|> テキスト整形結果だけでmapして
|> それぞれを改行 x 2でくっつけてひとつのテキストにして
|> Slackに投函します

(※)[Flow](https://github.com/dashbitco/flow) にお任せしています(私は説明ができるほど理解はしていません)。まず[Enum](https://hexdocs.pm/elixir/Enum.html)を使って逐次処理での実装を終えてから[Flow](https://github.com/dashbitco/flow)を導入しました。とにかくここはconcurrencyでいけるよなー　というところを乱暴にいいます(そうとしか理解できていないので・・・)が、[Enum](https://hexdocs.pm/elixir/Enum.html) => [Flow](https://github.com/dashbitco/flow)って書けばよいのです。

```elixir:lib/nhk.ex
defmodule Nhk do
  @area Application.get_env(:nhk, :area)
  @acts Application.get_env(:nhk, :acts)
  @titles Application.get_env(:nhk, :titles)
  @slack_incoming_webbook_url Application.get_env(:nhk, :slack_incoming_webbook_url)
  @slack_channel Application.get_env(:nhk, :slack_channel)

  def run do
    first = Timex.now("Asia/Tokyo") |> Timex.to_date()
    last = first |> Timex.shift(days: 7) |> Timex.to_date()
    dates = Date.range(first, last) |> Enum.map(&Date.to_string/1)

    for service <- services(), date <- dates do
      {service, date}
    end
    |> Flow.from_enumerable() # 逐次処理にしてみたいときは消す or #でコメントアウト
    |> Flow.partition() # 逐次処理にしてみたいときは消す or #でコメントアウト
    |> Flow.flat_map(fn {service, date} -> # 逐次処理にしてみたいときはEnum.flat_mapにする
      Nhk.Api.get(@area, service, date)
    end)
    |> Flow.filter(fn %{"act" => act, "title" => title} -> # 逐次処理にしてみたいときはEnum.filterにする
      favorite_act?(act) || favorite_title?(title)
    end)
    |> Flow.map(fn %{ # 逐次処理にしてみたいときはEnum.mapにする
                     "act" => act,
                     "service" => %{"name" => service_name},
                     "start_time" => start_time,
                     "title" => title
                   } ->
      {"#{start_time}(#{service_name})\n#{title}\n#{act} ", start_time}
    end)
    |> Enum.to_list() # 逐次処理にしてみたいときは消す or #でコメントアウト
    |> Enum.sort_by(fn {_, start_time} -> start_time end)
    |> Enum.map(fn {txt, _} -> txt end)
    |> Enum.join("\n\n")
    |> post()
  end

  defp services do
    ["g1", "e1", "e4", "s1", "s3", "r1", "r2", "r3"]
  end

  defp favorite_act?(act) do
    String.split(@acts, ",")
    |> Enum.any?(&String.contains?(act, &1))
  end

  defp favorite_title?(title) do
    String.split(@titles, ",")
    |> Enum.any?(&String.contains?(title, &1))
  end

  defp post("") do
    post("探してる番組・出演者はありませんでした。")
  end

  defp post(text) do
    body =
      %{
        text: text,
        username: "NHK番組取得お知らせ",
        icon_emoji: ":ghost:",
        link_names: 1,
        channel: @slack_channel
      }
      |> Jason.encode!()

    headers = [{"Content-type", "application/json"}]
    HTTPoison.post!(@slack_incoming_webbook_url, body, headers)
  end
end
```

- テキスト整形のところは、もとの記事と比べますと、やっつけ感は否めません(サボりました)

## 定期的に実行されるようにする

```elixir:lib/nhk/application.ex
defmodule Nhk.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      Nhk.Scheduler
    ]
```

```elixir:lib/nhk/scheduler.ex
defmodule Nhk.Scheduler do
  use Quantum, otp_app: :nhk
end
```

```elixir:config/config.ex
config :nhk, Nhk.Scheduler,
  jobs: [
    {"10 22 * * *", {Nhk, :run, []}}
  ]
```
- UTCで指定します
- 上記は日本時間で日本で7:10

さあ、実行してみましょう

```
$ iex -S mix

# 時間になるまで待つか、まあ、待てないですよね

iex> Nhk.run
```

時間がきたら・・・・・・

<img width="926" alt="スクリーンショット 2020-05-02 8.51.34.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7a7e4927-686e-7f42-cd99-4e410a7e3d14.png">

**Yay!**

- `Nhk.run`を実行すると、8サービス x 7日分 = 56回のAPI呼び出しを行います
- 利用回数制限は、300回/日 とのことですのでお気をつけください


# Wrapping Up
- [Enum](https://hexdocs.pm/elixir/Enum.html#content) -> [Flow](https://github.com/dashbitco/flow)って書くとやっぱり速くなる :rocket: 
- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2) を使うことでやりたいこととソースコードの順番が一致するのがステキ(そのまま説明になる):sunflower:
- [Elixir](https://elixir-lang.org/)は書いていて楽しい
    - 個人の感想です
    - みなさまもお好みの言語で楽しみましょう！


