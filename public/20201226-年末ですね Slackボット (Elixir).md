---
title: 年末ですね Slackボット (Elixir)
tags:
  - Elixir
  - Slack
private: false
updated_at: '2020-12-27T09:05:04+09:00'
id: 8402074a7e23d86c997c
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- [Qiita Advent Calendar 2021](https://qiita.com/advent-calendar/2021)へ向けて記事をどんどん書いていきましょう！
    - [Qiita Advent Calendar 2021](https://qiita.com/advent-calendar/2021)では、**Elixir その3**くらいまでは余裕で埋めてしまいましょう:bangbang:
    - [Qiita Advent Calendar 2020](https://qiita.com/advent-calendar/2020)の私てきまとめはこちら
        - :point_down::point_down_tone1::point_down_tone2::point_down_tone3::point_down_tone4::point_down_tone5:
        - **[Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:](https://qiita.com/torifukukaiou/items/e3056efc3d2c62600fa2#wrapping-up-christmas_treesantasanta_tone1santa_tone2santa_tone3santa_tone4santa_tone5christmas_tree)**
        - :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:
- 2020/12/26(土)に行われた[kokura.ex#16：Elixir忘年会&もくもく会～入門もあるよ（9:30~）](https://fukuokaex.connpass.com/event/198374/)の成果です
    - @im_miolab さん、ありがとうございます！
    - @im_miolab さんが、人間ボットで「年末ですね」と定期的につぶやくと宣言されたので、そこから着想を得て、バタバタとボットをつくりました

## [Qiita Advent Calendar 2020](https://qiita.com/advent-calendar/2020)
![スクリーンショット 2020-12-26 21.51.44.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/5d3056f4-27b7-3c1b-1a6e-cb5d882e7537.png)

:tada::tada::tada:

- 2020/12/26(土) 21:52現在
- [プログラミング言語](https://qiita.com/advent-calendar/2020/ranking/feedbacks/categories/programming_languages)カテゴリーでトップ10以内にダブルランクインです :rocket::rocket::rocket:
    - [Elixir Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir) 第2位
    - [Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2) 第9位
    - 29 :meat_on_bone:  GET :bangbang::bangbang::bangbang:

# インストール
- [Elixir](https://elixir-lang.org/)をインストールしましょう :rocket::rocket::rocket:
- 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)などをご参照ください 
- 何事にも準備が肝心です
- ここが一番つまらないし、謎にハマってしまうことが多いのですが、がんばってください！
- うまくいかなかったら、**思い切って僕の胸に飛び込んで来てほしい** (by 長嶋茂雄 読売ジャイアンツ終身名誉監督)
    - [elixirjp.slack.com slack workspace](https://elixirjp.slack.com/join/shared_invite/enQtODE0NjM3NTIyNTMzLTU5NmViZDE4N2Q3MGUyMmI5YTdlNmQ2ZDI4ZDgxZGZiYTVlYmJjOTMzYzk2NGUyMjBhMTBiNDdjYTg3ZjhmYWI)か[NervesJP workspace](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)に入ってきていただいて、`@torifukukaiou`へご質問ください
    - たとえ私が答えられなくても、マジみんな親切で優しい人が多いので、きっと解決できるでしょう:bangbang:

# プロジェクト作成

```
$ mix new nenmatsu_bot --sup
$ cd nenmatsu_bot
```

```elixir:mix.exs
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:httpoison, "~> 1.7"},
      {:jason, "~> 1.2"}
    ]
  end
```

- HTTPクライアント[HTTPoison](https://github.com/edgurgel/httpoison)とすんげー速い:rocket:JSONパーサー&ジェネレーター[Jason](https://github.com/michalmuskala/jason)をプロジェクトで使えるようにします

```
$ mix deps.get
```

# ソースコードを書く

```elixir:lib/nenmatsu_bot/slack.ex
defmodule NenmatsuBot.Slack do
  @url "https://hooks.slack.com/services/secret..."

  def post(text, username, icon_url, channel_name) do
    body =
      %{
        text: text,
        username: username,
        icon_url: icon_url,
        link_names: 1,
        channel: channel_name
      }
      |> Jason.encode!()

    headers = [{"Content-type", "application/json"}]
    HTTPoison.post!(@url, body, headers)
  end
end
```

```elixir:lib/nenmatsu_bot/worker.ex
defmodule NenmatsuBot.Worker do
  use GenServer

  @one_minute 60 * 1000
  @thirteen_minutes @one_minute * 13
  @famous_folks %{
    "徳川家康" =>
      "https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Tokugawa_Ieyasu2.JPG/270px-Tokugawa_Ieyasu2.JPG",
    "有名人①" =>
      "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Bill_Gates_June_2015.jpg/220px-Bill_Gates_June_2015.jpg",
    "有名人②" =>
      "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Elon_Musk_2015.jpg/220px-Elon_Musk_2015.jpg",
    "有名人③" =>
      "https://assets.media-platform.com/bi/dist/images/2019/06/07/jeff-bezos-shares-his-best-advice-for-anyone-starting-a-business.jpg"
  }

  def start_link(state \\ %{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    Process.send_after(__MODULE__, :tick, @one_minute)
    {:ok, state}
  end

  def handle_info(:tick, state) do
    Process.send_after(__MODULE__, :tick, @thirteen_minutes)

    {username, icon_url} = Enum.random(@famous_folks)
    NenmatsuBot.Slack.post("年末ですね", username, icon_url, "kokura-ex")

    {:noreply, state}
  end
end
```

- `kokura-ex`のところは投稿したいチャネル名に変更してください

```elixir:lib/nenmatsu_bot/application.ex
defmodule NenmatsuBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: NenmatsuBot.Worker.start_link(arg)
      # {NenmatsuBot.Worker, arg}
      NenmatsuBot.Worker # add
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NenmatsuBot.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
```

- ソースコードは説明しませんが、なんとなくやっていることは伝わるのではないでしょうか
    - <font color="purple">$\huge{Don't　think,　feeeeeeeel}$</font>
- SlackのIncoming Web hook APIを使っています

![スクリーンショット 2020-12-26 22.04.13.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a04f5ed7-4d4a-5528-2f04-9e271f5a5263.png)

- **その他管理項目** > **アプリを管理する**
- 次の画面で **Incoming Web hook**で検索

![スクリーンショット 2020-12-26 22.05.55.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b4b4d305-2846-5719-fd70-0d424e6c3729.png)

- あとは案内の通りに進めて、**Webhook URL**を`@url`にセットします

# Run

```
$ iex -S mix
```

- このまま放っておくと、
- 13分に一回 `kokura-ex` チャネルに「年末ですね」を投稿します
- [Enum.random/1](https://hexdocs.pm/elixir/Enum.html#random/1)関数でランダムに有名人を選んでいます

![スクリーンショット 2020-12-26 22.20.06.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7e133fd6-8cbe-fea8-b514-a65fea47cff2.png)



# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- [Qiita Advent Calendar 2021](https://qiita.com/advent-calendar/2021) 早くはじまらないかなあー
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket: 
