---
title: AHT20で温度湿度を取得して全世界に惜しげもなくあたい（値）を公開する(Elixir/Nerves/Phoenix)
tags:
  - Elixir
  - Phoenix
  - Nerves
  - 大晦日ハッカソン
private: false
updated_at: '2021-03-07T09:51:05+09:00'
id: 5876bc4576e7b7991347
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang:
- 2020/12/31 大晦日です
- `#大晦日ハッカソン`なるものに参加しています
    - 初参加です
    - @myasu さんに教えてもらいました
    - [大晦日ハッカソン2020](https://omisoka-hackathon.connpass.com/event/199478/)
    - `#大晦日ハッカソン`と[ツイート](https://twitter.com/hashtag/%E5%A4%A7%E6%99%A6%E6%97%A5%E3%83%8F%E3%83%83%E3%82%AB%E3%82%BD%E3%83%B3?src=hashtag_click)すればよいようです
- 2020/12/27(日)に行われた「[オンライン】豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/)」で準備のお手伝い、講師(歌唱:interrobang:)をしたのですが、[Phoenix](https://www.phoenixframework.org/)でのグラフうねうねのみを担当し、温湿度センサー[Grove - AHT20](https://wiki.seeedstudio.com/Grove-AHT20-I2C-Industrial-Grade-Temperature&Humidity-Sensor/)の取り扱いはコードをななめ読みしかできていません
    - [グラフうねうね (動かし方 編) (Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/3926fe3740e229594c8f)
    - [グラフうねうね (作り方 編) (Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/e3056efc3d2c62600fa2)
- はたして[データシート](https://files.seeedstudio.com/wiki/Grove-AHT20_I2C_Industrial_Grade_Temperature_and_Humidity_Sensor/AHT20-datasheet-2020-4-16.pdf)片手に、自力でコーディングできるのだろうか？　という疑問がわいてきました
- そこで、[大晦日ハッカソン2020](https://omisoka-hackathon.connpass.com/event/199478/)を利用して、「[オンライン】豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/)」の復習をしつつ、
    - 自分で書いてみる 
    - |> **せっかくつくったのだから我が家の温湿度情報を世界へ発信してみる**
- をやってみたいとおもいます
- 「[オンライン】豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/)」でははじめから[Nerves](https://www.nerves-project.org/)のファームウェアが焼き込まれたmicroSDカードからスタートしましたが、最初に焼き込むファームウェアの作り方から解説いたします

# 完成品
- https://aht20.torifuku-kaiou.tokyo/aht20-dashboard
- 自宅の温度・湿度を全世界に発信し続けています

![IMG_20210102_173324.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/96e4da17-99e2-8732-1048-cc21f04ee61a.jpeg)



- **[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40)な私でも、はめ込み式で簡単に工作を楽しめます 🚀🚀🚀**
- [Seeed株式会社](https://www.seeed.co.jp/)様ありがとうございます:bangbang::bangbang::bangbang:


# What is [Elixir](https://elixir-lang.org/)?
> Elixir is a dynamic, functional language designed for building scalable and maintainable applications.

> Elixir leverages the Erlang VM, known for running low-latency, distributed and fault-tolerant systems, while also being successfully used in web development, embedded software, data ingestion, and multimedia processing domains across a wide range of industries.

- 不老不死の霊薬っちいうことですね

# What is [Nerves](https://www.nerves-project.org/)?
- @takasehideki 先生の「[ElixirでIoT！？ナウでヤングでcoolなNervesフレームワーク](https://www2.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)」をご参照ください
- [Elixir](https://elixir-lang.org/)というプログラミング言語でIoTできちゃうんです

# What is [Phoenix](https://www.phoenixframework.org/)?
> Build rich, interactive web applications quickly, with less code and fewer moving parts. Join our growing community of developers using Phoenix to craft APIs, HTML5 apps and more, for fun or at scale.

- [Elixir](https://elixir-lang.org/)というプログラミング言語でのWebアプリケーションフレームワークです

# 準備

## 使用するハードウェア
- [Raspberry Pi 4GBモデル](https://www.seeedstudio.com/Raspberry-Pi-4-Computer-Model-B-4GB-p-4077.html)
- [Grove Base HAT for Raspberry Pi](https://wiki.seeedstudio.com/jp/Grove_Base_Hat_for_Raspberry_Pi/)
- [Grove AHT20 I2C (温湿度センサ)](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)
- AC-DCアダプタ（Type-C, 5V3A）
- microSDカード（16 GB Class10)
- **[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40)な私でも、はめ込み式で簡単に工作を楽しめます 🚀🚀🚀**

### 組み立て方
- [ALGYAN x Seeed x NervesJPハンズオン基本編](https://docs.google.com/presentation/d/1u7V6aR0wrWs23oGmNq6Scl6M_WRpa0eyB4lSqyOsbRM/edit#slide=id.p)
    - 7ページまでご参照ください
    - Grove Button(P)とGrove LEDはこの記事では使いません
- [ALGYAN x Seeed x NervesJPハンズオン応用編](https://docs.google.com/presentation/d/1ybBMKVnYnImRv1V_vozVXTOt-DwfpUiAwqhrNSubt3k/edit)
    - 7ページをご参照ください

## 開発マシン

- [Nerves](https://www.nerves-project.org/)開発環境の[Installation](https://hexdocs.pm/nerves/installation.html#content)
    - @takasehideki 先生の[ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)が詳しいです
- [Phoenix](https://www.phoenixframework.org/)開発環境の[Installation](https://hexdocs.pm/phoenix/installation.html#content)
- ここが一番たいへんで、謎につまったりしますがここを乗り越えるとあとは楽しみだけですのでがんばりましょう🚀🚀🚀
- 私はmacOSを使っています
- Windows 10でも大丈夫です

## 開発外観

![Nerves.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2e3a8caa-a1f1-b5b5-f514-d186b24c62a2.png)

- 開発マシンで[Nerves](https://www.nerves-project.org/)アプリを作成・ビルドしてファームウェアをつくります
- 開発マシンからmicroSDカードにファームウェアを焼き込みます(初回のみ)
- ハードウェアにmicroSDカードを挿入して電源ON!!!
    - 開発マシン(Host)とハードウェア(Target)が同じネットワークにいるようにします
- 2回目以降のビルドしたファームウェアは、ネットワーク経由でアップロードすることができます
    - microSDカードを抜き差しする必要はないのです!
- [Nerves](https://www.nerves-project.org/)アプリは別途用意するWebアプリケーションへ向けて取得したデータを打ち上げ(HTTP POST)して、データを表示します


# [Nerves](https://www.nerves-project.org/)アプリの作成

## mix nerves.new
```
$ export MIX_TARGET=rpi4
$ mix nerves.new temperature_and_humidity_nerves
$ cd temperature_and_humidity_nerves
```

- `rpi4`のところはお手持ちのハードウェアにあわせてください
    - [Targets](https://hexdocs.pm/nerves/targets.html#content)
    - [Seeed株式会社](https://www.seeed.co.jp/)様ありがとうございます:bangbang::bangbang::bangbang:

## mix deps.get

```elixir:mix.exs
  defp deps do
    [
      ...
      {:nerves_system_x86_64, "~> 1.13", runtime: false, targets: :x86_64},

      # add
      {:circuits_i2c, "~> 0.1"},
      {:httpoison, "~> 1.7"},
      {:jason, "~> 1.2"},
      {:timex, "~> 3.6"}
    ]
  end
```

- 上の変更を行ったあとに

```
$ mix deps.get
```

- 必要なライブラリをインストールしています

## `config :tzdata, :data_dir, "/data/tzdata"`

```elixir:config/target.exs
config :tzdata, :data_dir, "/data/tzdata"
```

- @nishiuchikazumaさんの「[Nervesで出続けるtzdataのエラーを止めた](https://qiita.com/nishiuchikazuma/items/3a7dd012193f59423831)」をご参照ください

## WiFi設定(オプション)
- 有線LANケーブルでネットワークに接続する場合は不要です
- 手前味噌の「[NervesをWiFiを使って固定IPでネットワークに追加します(Elixir)](https://qiita.com/torifukukaiou/items/45cfc7bdf73f3f232299)」をご参照ください

## mix firmware && mix burn
- ここまでやったら一度、ファームウェアを作ってmicroSDカードに焼き込んでおきましょう :fire:

```
$ mix firmware
```
- ファームウェアがビルドされます
- microSDカードを開発マシンに差し込んで以下のコマンドで焼き込みます:fire:

```
$ mix burn
```

- こんがり焼き上がったら、ハードウェア(この記事の場合はRaspberry Pi 4)に差し込んで電源ON!!!
- 30秒ほど瞑想して`ping nerves.local`が通ることを確認したら

```
$ ssh nerves.local

iex>
``` 

- [Nerves](https://www.nerves-project.org/)の中に入れて、`IEx`(Elixir's Interactive Shell)が立ち上がっています
- ここまで確認できたらとりあえず`exit`で抜けておきましょう
- もしsshできない場合は、[VintageNet Cookbook](https://hexdocs.pm/vintage_net/cookbook.html)に従って、固定IP(例 `192.168.1.200`)を設定するなどして、`ssh 192.168.1.200`とかするとつながりやすいです

## AHT20から温度湿度を取得するソースコードを書く
- https://github.com/NervesJP/nervesjp_basis/blob/f92aa586acbda53d87846f3cd0909380296a4ff1/lib/sensor/aht20.ex
- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:に答えがあるので、[データシート](https://files.seeedstudio.com/wiki/Grove-AHT20_I2C_Industrial_Grade_Temperature_and_Humidity_Sensor/AHT20-datasheet-2020-4-16.pdf)を片手に書いていきます

```elixir:lib/temperature_and_humidity_nerves/aht20.ex
defmodule TemperatureAndHumidityNerves.Aht20 do
  use Bitwise
  alias Circuits.I2C

  @i2c_bus "i2c-1"
  @i2c_addr 0x38
  @initialization_command <<0xBE, 0x08, 0x00>>
  @trigger_measurement_command <<0xAC, 0x33, 0x00>>
  @two_pow_20 :math.pow(2, 20)

  def read do
    {:ok, ref} = I2C.open(@i2c_bus)

    I2C.write(ref, @i2c_addr, @initialization_command)
    Process.sleep(10)

    I2C.write(ref, @i2c_addr, @trigger_measurement_command)
    Process.sleep(80)

    ret =
      case I2C.read(ref, @i2c_addr, 7) do
        {:ok, val} -> {:ok, val |> convert()}
        {:error, :i2c_nak} -> {:error, "Sensor is not connected"}
        _ -> {:error, "An error occurred"}
      end

    I2C.close(ref)

    ret
  end

  defp convert(<<_, raw_humi::20, raw_temp::20, _>>) do
    humi = Float.round(raw_humi / @two_pow_20 * 100.0, 1)
    temp = Float.round(raw_temp / @two_pow_20 * 200.0 - 50.0, 1)

    {temp, humi}
  end
end
```

- 少し変えた部分はありますがほんのわずかでして、
- <font color="purple">$\huge{お手本をみながら一文字一文字彫るように写しました}$</font>
- `convert/1`関数は、@mnishiguchi さんのコメントのおかげで複雑なビット演算が不要になりました！
    - https://qiita.com/torifukukaiou/items/5876bc4576e7b7991347#comment-6bfe2b7c37542cf15e83

```
$ mix firmware
$ mix upload
```

- microSDカードを抜かずにネットワーク越しにファームウェアの書き換えが可能です!
- やってみればわかりますがものすごく便利です!
- `mix upload`がうまくいかない場合にはたとえば`mix upload 192.168.1.200`等、ハードウェア(今回の場合はRaspberry Pi 4)に割り当たっているIPアドレスを指定してください
- また30秒ほど瞑想をして

```elixir
$ ssh nerves.local

iex> TemperatureAndHumidityNerves.Aht20.read
{:ok, {16.4, 32.0}}
```

- :tada::tada::tada:
- 温度湿度が取得できたことを確認したら`exit`で抜けておきましょう

## 1秒に一回、温度湿度を取得するようにする

```elixir:lib/temperature_and_humidity_nerves/ticker.ex
defmodule TemperatureAndHumidityNerves.Ticker do
  use GenServer
  require Logger

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    :timer.send_interval(1000, self(), :tick)
    {:ok, state}
  end

  def handle_info(:tick, state) do
    Logger.debug("tick")
    spawn(TemperatureAndHumidityNerves.Worker, :run, [])

    {:noreply, state}
  end
end
```

```elixir:lib/temperature_and_humidity_nerves/worker.ex
defmodule TemperatureAndHumidityNerves.Worker do
  require Logger

  @name "awesome"
  @headers [{"Content-Type", "application/json"}]

  def run do
    {:ok, {temperature, humidity}} = TemperatureAndHumidityNerves.Aht20.read()

    inspect({temperature, humidity}) |> Logger.debug()

    post_temperature(temperature)
    post_humidity(humidity)
  end

  defp post_temperature(value) do
    post(value, "https://phx.japaneast.cloudapp.azure.com/temperatures")
  end

  defp post_humidity(value) do
    post(value, "https://phx.japaneast.cloudapp.azure.com/humidities")
  end

  defp post(value, url) do
    time = Timex.now() |> Timex.to_unix()
    json = Jason.encode!(%{value: %{name: @name, value: value, time: time}})
    HTTPoison.post(url, json, @headers)
  end
end
```

```elixir:lib/temperature_and_humidity_nerves/application.ex
defmodule TemperatureAndHumidityNerves.Application do
  ...

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: TemperatureAndHumidityNerves.Worker.start_link(arg)
      # {TemperatureAndHumidityNerves.Worker, arg},
      TemperatureAndHumidityNerves.Ticker # add
    ]
  end
```

- `@name` はお好きなお名前に変更してください
- 「[オンライン】豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/)」で用意したデータ打ち上げ先にHTTP POSTしています
- <font color="purple">$\huge{Don't　think,　feeeeeeeeeeeeel !!!}$</font>
- Visit: https://phx.japaneast.cloudapp.azure.com/chart-temperature
- Visit: https://phx.japaneast.cloudapp.azure.com/chart-humidity

![スクリーンショット 2020-12-31 14.15.14.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ea1199a2-ad12-e904-489d-cffe4f977eb6.png)

- :sweat_smile::sweat_smile::sweat_smile::sweat_smile::sweat_smile::sweat_smile: 
- 温度湿度ってそんなコロコロかわるものじゃないでしょうから、まっつぐなんですよねー
- ということで後半は打ち上げ先のWebアプリケーションも作ってしまいましょう:rocket::rocket::rocket:

# [Phoenix](https://www.phoenixframework.org/)アプリの作成

```
$ mix phx.new aht20 --live
$ cd aht20
$ mix setup
```

## APIを作ります

### mix phx.gen.json 
```
$ mix phx.gen.json Measurements Value values temperature:float humidity:float time:integer
```

- このコマンドで下記のファイルができます
- このコマンドでだいたいできあがっています

```
lib/aht20/measurements.ex
lib/aht20/measurements/value.ex
lib/aht20_web/controllers/fallback_controller.ex
lib/aht20_web/controllers/value_controller.ex
lib/aht20_web/views/changeset_view.ex
lib/aht20_web/views/value_view.ex
priv/repo/migrations/20201231063807_create_values.exs
test/aht20/
test/aht20_web/controllers/
```

- このうち`lib/aht20/measurements.ex`と`priv/repo/migrations/20201231063807_create_values.exs`(コマンド実行時のタイムスタンプでファイル名はかわります)を少し変更します

```elixir:lib/aht20/measurements.ex
  def last do
    Value |> last() |> Repo.one()
  end
```

```elixir:priv/repo/migrations/20201231063807_create_values.exs
defmodule Aht20.Repo.Migrations.CreateValues do
  use Ecto.Migration

  def change do
    create table(:values) do
      add :temperature, :float, null: false
      add :humidity, :float, null: false
      add :time, :integer, null: false

      timestamps()
    end
  end
end
```

- `null: false`を追加しています

### パスの追加

```elixir:lib/aht20_web/router.ex
  scope "/api", Aht20Web do
    pipe_through :api

    resources "/values", ValueController, only: [:create, :show]
  end
```

### マイグレーション

```
$ mix ecto.migrate
```

- ここまでやって、下記のコマンドでWebアプリケーションを開始します

```
$ mix phx.server
```

- たとえばcurlで以下のようにするとデータが保存されます

```
$ curl -X POST -H "Content-Type: application/json" -d '{"value": {"temperature": "23.5", "humidity": 40.123, "time": 1605097502}}' http://localhost:4000/values
```

## 画面

```elixir:lib/aht20_web/live/dashboard_live.ex
defmodule Aht20Web.DashboardLive do
  use Aht20Web, :live_view

  alias Aht20.Values

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :tick)
    end

    socket = assign_stats(socket)

    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <h1>Dashboard</h1>
    <div id="dashboard">
      <div class="stats">
        <div class="stat">
          <span class="value">
            <%= @temperature %>度
          </span>
          <span class="name">
            温度
          </span>
        </div>
        <div class="stat">
          <span class="value">
            <%= @humidity %>%
          </span>
          <span class="name">
            湿度
          </span>
        </div>
      </div>
    </div>
    """
  end

  def handle_info(:tick, socket) do
    socket = assign_stats(socket)
    {:noreply, socket}
  end

  defp assign_stats(socket) do
    {temperature, humidity} = Values.get()

    assign(socket,
      temperature: temperature,
      humidity: humidity
    )
  end
end
```

```elixir:lib/aht20/values.ex
defmodule Aht20.Values do
  def get do
    Aht20.Measurements.last()
    |> handle_get()
  end

  defp handle_get(nil), do: {0, 0}

  defp handle_get(%Aht20.Measurements.Value{temperature: temperature, humidity: humidity}) do
    {temperature, humidity}
  end
end
```

```elixir:lib/aht20_web/router.ex
   scope "/", Aht20Web do
     pipe_through :browser
 
     live "/", PageLive, :index
     live "/aht20-dashboard", DashboardLive
   end
```

- Visit: http://localhost:4000/aht20-dashboard

![スクリーンショット 2020-12-31 16.24.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1cdb2fbb-a85b-d3ed-33d1-4ded71ddbcdd.png)

- 素っ気ない画面がでるとおもいます :rocket::rocket::rocket: 

## makeup

- **この節はオプションです**
- **私自身はフロントエンドまわりに疎いし弱いしあんまりちゃんとわかっていません**
- **以下は私がこんなふうにやったら格好良くなりました(私にはこれが精一杯で、それなりに格好良くみえた)よという記録です**
- **さらによくないことに、私は以下の部分は雰囲気で書いてしまっているので間違っているところもあるとおもいます**
    - **何かお気づきの方はご指摘ください** :bow::bow_tone1::bow_tone2::bow_tone3::bow_tone4::bow_tone5: 

<font color="purple">$\huge{スタイリングはあなたのお好みで}$</font>
<font color="purple">$\huge{もっと格好良くしてください}$</font>
:tada::tada::tada: 

<!-- 
本記事を心から楽しんだ上での感想です。
ここの部分はいっそのこと「スタイリングはお好みで」というスタンスにすると、スッキリするかもしれません。ここにはあるCSSの大部分が実際には使用されていないので初心者が混乱するかもです。個人的にここでTailwindの登場はオーバーキルの気もしますので、これがないだけでとっつきやすくなるかもしれません。
西口
-->

![スクリーンショット 2020-12-31 17.37.57.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a61f7068-e9e8-58fb-a062-9421414ca146.png)

```
$ cd assets
$ npm install @tailwindcss/ui@0.5.0 tailwindcss@1.7.3 postcss-import@12.0.1 postcss-loader@3.0.0 postcss-nested@4.2.1 autoprefixer@9.8.6 --save-dev
```


```js:assets/webpack.config.js
    module: {
      rules: [
        {
          test: /\.js$/,
          exclude: /node_modules/,
          use: {
            loader: "babel-loader",
          },
        },
        {
          test: /\.[s]?css$/,
          use: [
            MiniCssExtractPlugin.loader,
            "css-loader",
            "sass-loader",
            "postcss-loader",
          ],
        },
      ],
    },
```

```scss:assets/css/app.scss
/* This file is for your main application css. */

@import "../node_modules/nprogress/nprogress.css";

@import "tailwindcss/base";

@import "tailwindcss/components";

@import "./custom.css";

@import "./phoenix.css";

@import "./live_view.css";

@import "tailwindcss/utilities";

```

- 以下追加

```css:assets/css/custom.css
body {
  @apply antialiased relative bg-cool-gray-200 font-sans;
}

header {
  @apply mb-8;
}

.container {
  @apply max-w-6xl mx-auto px-6;
}

h1 {
  @apply text-center text-cool-gray-900 font-extrabold text-4xl mb-8;
}

ul.examples {
  @apply mt-8 text-2xl mx-auto max-w-xs list-disc;

  li {
    @apply mt-3;

    a {
      @apply underline;
    }
  }
}

.icon {
  fill: currentColor;
}

/* Light */

#light {
  @apply max-w-xl mx-auto text-center;

  button {
    @apply bg-transparent mx-1 py-2 px-4 border border-cool-gray-400 border-2 rounded-lg shadow-sm transition ease-in-out duration-150 outline-none;
  }

  button:hover {
    @apply bg-cool-gray-300;
  }

  img {
    @apply w-10;
  }

  .meter {
    @apply flex h-12 overflow-hidden text-base bg-cool-gray-300 rounded-lg mb-8;
  }

  .meter > span {
    @apply flex flex-col justify-center text-cool-gray-900 text-center whitespace-no-wrap bg-yellow-300 font-bold;
    transition: width 2s ease;
  }
}

/* License */

#license {
  @apply max-w-lg mx-auto text-center;

  .card {
    @apply bg-white shadow rounded-lg shadow-lg;

    .content {
      @apply p-6;
    }
  }

  .seats {
    @apply inline-flex items-center mb-8;

    img {
      @apply w-10 pr-2;
    }

    span {
      @apply text-xl font-semibold text-cool-gray-700;
    }
  }

  .amount {
    @apply text-4xl leading-none font-extrabold text-cool-gray-900 mt-4;
  }
}

/* Dashboard */

#dashboard {

  @apply max-w-2xl mx-auto;

  .stats {
    @apply mb-8 rounded-lg bg-white shadow-lg grid grid-cols-3;

    .stat {
      @apply p-6 text-center;

      .name {
        @apply block mt-2 text-lg leading-6 font-medium text-cool-gray-500;
      }

      .value {
        @apply block text-5xl leading-none font-extrabold text-indigo-600;
      }
    }
  }

  button {
    @apply inline-flex items-center px-4 py-2 border border-indigo-300 text-sm shadow-sm leading-6 font-medium rounded-md text-indigo-700 bg-indigo-100 transition ease-in-out duration-150 outline-none;

    img {
      @apply mr-2 h-4 w-4;
    }
  }

  button:active {
    @apply bg-indigo-200;
  }

  button:hover {
    @apply bg-white;
  }

  .controls {
    @apply flex items-center justify-end;

    form {
      .group {
        @apply flex items-baseline;
      }

      label {
        @apply uppercase tracking-wide text-indigo-800 text-xs font-semibold mr-2;
      }

      select {
        @apply appearance-none bg-cool-gray-200 border-indigo-300 border text-indigo-700 py-2 px-4 rounded-lg leading-tight font-semibold cursor-pointer mr-2 h-10;
      }

      select:focus {
        @apply outline-none bg-white border-indigo-500;
      }
    }
  }
}

/* Search */

#search {
  @apply max-w-3xl mx-auto text-center;

  form {
    @apply inline-flex items-center;

    input[type="text"] {
      @apply h-10 border border-cool-gray-400 rounded-l-md bg-white px-5 text-base;
    }

    input[type="text"]:focus {
      @apply outline-none;
    }

    input[name*='city'] {
      @apply ml-4;
    }
  }

  button {
    @apply h-10 px-4 py-2 bg-transparent border border-cool-gray-400 border-l-0 rounded-r-md transition ease-in-out duration-150 outline-none;

    img {
      @apply h-4 w-4;
    }
  }

  button:hover {
    @apply bg-cool-gray-300;
  }

  .open {
    @apply inline-flex items-center px-3 py-1 rounded-md text-xs font-medium leading-5 bg-green-200 text-green-800 rounded-full;
  }

  .closed {
    @apply inline-flex items-center px-3 py-1 rounded-md text-xs font-medium leading-5 bg-red-200 text-red-800 rounded-full;
  }

  .stores {
    @apply mt-8 bg-white shadow overflow-hidden rounded-md;

    li {
      @apply border-t border-cool-gray-300 px-6 py-4;

      .first-line {
        @apply flex items-center justify-between;

        .name {
          @apply text-lg leading-5 font-medium text-indigo-600 truncate;
        }

        .status {
          @apply ml-2 flex-shrink-0 flex;
        }
      }

      .second-line {
        @apply mt-2 flex justify-between;

        .street {
          @apply mt-0 flex items-center text-base leading-5 text-cool-gray-400;

          img {
            @apply flex-shrink-0 mr-1 h-5 w-5;
          }
        }

        .phone_number {
          @apply mt-0 flex items-center text-sm leading-5 text-cool-gray-400;

          img {
            @apply flex-shrink-0 mr-2 h-5 w-5;
          }
        }
      }
    }
  }

  .flights {
    @apply mt-8 bg-white shadow overflow-hidden rounded-md;

    li {
      @apply border-t border-cool-gray-300 px-6 py-4;

      .first-line {
        @apply flex items-center justify-between;

        .number {
          @apply text-lg leading-5 font-semibold text-indigo-600 truncate;
        }

        .origin-destination {
          @apply mt-0 flex items-center text-base leading-5 text-indigo-600;

          img {
            @apply flex-shrink-0 mr-1 h-5 w-5;
          }
        }
      }

      .second-line {
        @apply mt-2 flex justify-between;

        .departs {
          @apply text-cool-gray-500;
        }

        .arrives {
          @apply text-cool-gray-500;
        }
      }
    }
  }

  li:hover {
    @apply bg-indigo-100;
  }
}

/* Filter */

#filter {

  .boats {
    @apply flex flex-wrap;
  }

  .card {
    @apply m-6 max-w-sm rounded bg-white overflow-hidden shadow-lg;

    img {
      @apply w-full;
    }

    .content {
      @apply px-6 py-4;
    }

    .model {
      @apply pb-3 text-center text-cool-gray-900 font-bold text-xl;
    }

    .details {
      @apply px-6 mt-2 flex justify-between;
    }

    .price {
      @apply text-cool-gray-700 font-semibold text-xl;
    }

    .type {
      @apply inline-block bg-cool-gray-300 rounded-full px-3 py-1 text-sm font-semibold text-cool-gray-700;
    }
  }

  form {
    @apply max-w-xl mx-auto mb-4;

    .filters {
      @apply flex items-baseline justify-around;

      select {
        @apply appearance-none w-1/3 bg-cool-gray-200 border border-cool-gray-400 text-cool-gray-700 py-3 px-4 rounded-lg leading-tight font-semibold cursor-pointer;
      }

      select:focus {
        @apply outline-none bg-cool-gray-200 border-cool-gray-500;
      }

      .prices {
        @apply flex;

        input[type="checkbox"] {
          @apply opacity-0 fixed w-0;
        }

        input[type="checkbox"]:checked + label {
          @apply bg-indigo-300 border-indigo-500;
        }

        label {
          @apply inline-block border-t border-b border-cool-gray-400 bg-cool-gray-300 py-3 px-4 text-lg font-semibold leading-5;
        }

        label:hover {
          @apply bg-cool-gray-400 cursor-pointer;
        }

        label:first-of-type {
          @apply border-l border-r rounded-l-lg ;
        }

        label:last-of-type {
          @apply border-l border-r rounded-r-lg ;
        }
      }

      a {
        @apply inline underline text-lg;
      }
    }
  }
}

/* Donations */

#donations {
  @apply max-w-4xl mx-auto;

  .wrapper {
    @apply mb-4 align-middle inline-block min-w-full shadow overflow-hidden rounded-lg border-b border-cool-gray-300;
  }

  a {
    @apply underline text-indigo-500 font-semibold;
  }

  .fresh {
    @apply px-4 py-2 rounded-md text-lg font-medium leading-5 bg-green-200 text-green-800 rounded-full;
  }

  .stale {
    @apply px-4 py-2 rounded-md text-lg font-medium leading-5 bg-red-200 text-red-800 rounded-full;
  }

  table {
    @apply min-w-full;

    th {
      @apply bg-transparent px-6 py-4 border-b border-cool-gray-300 bg-indigo-700 text-base leading-4 font-medium uppercase tracking-wider text-center text-white;

      a {
        @apply no-underline text-white;
      }

      a:hover {
        @apply underline;
      }
    }

    td {
      @apply px-6 py-4 whitespace-no-wrap border-b border-cool-gray-300 text-lg leading-5 font-medium text-cool-gray-900 text-center;
    }

    tbody {
      @apply bg-white;
    }

    th.item {
      @apply pl-12 text-left;
    }

    td.item {
      @apply pl-12 font-semibold text-left;
    }
  }

  .footer {
    @apply text-center bg-white max-w-4xl mx-auto text-lg py-8;

    .pagination {
      @apply inline-flex shadow-sm;
    }

    a {
      @apply -ml-px inline-flex items-center px-3 py-2 border border-cool-gray-300 bg-white text-base leading-5 font-medium text-cool-gray-600 no-underline;
    }

    a:hover {
      @apply bg-cool-gray-300;
    }

    a.active {
      @apply bg-indigo-700 text-white;
    }

    a.previous {
      @apply rounded-l-md;
    }

    a.next {
      @apply rounded-r-md;
    }
  }
}

/* Incidents */

#incidents {
  @apply max-w-3xl mx-auto;

  .incident {
    @apply flex items-center justify-between mt-2 border-r border-b border-l border-cool-gray-300 border-l-0 border-t bg-white rounded-b rounded-b-none rounded p-4 leading-normal w-full;
  }

  .priority {
    @apply px-4;
  }

  .description {
    @apply flex-1 px-4 text-cool-gray-800 font-bold text-lg;
  }

  .location {
    @apply flex-1 px-4 font-semibold text-lg text-cool-gray-600 text-base;
  }

  .status {
    @apply px-4;
  }

  button {
    @apply bg-indigo-500 text-white font-semibold py-2 px-4 rounded outline-none;
  }

  button:hover {
    @apply bg-indigo-700;
  }

  .resolved {
    @apply text-lg font-bold leading-5 text-indigo-600 bg-transparent text-indigo-600 px-2;
  }

  .priority-1 {
    @apply px-4 py-2 rounded-md text-lg font-bold leading-5 bg-red-500 text-white;
  }

  .priority-2 {
    @apply px-4 py-2 rounded-md text-lg font-bold leading-5 bg-orange-500 text-white;
  }

  .priority-3 {
    @apply px-4 py-2 rounded-md text-lg font-bold leading-5 bg-yellow-500 text-white;
  }
}

/* New Incident */

#new-incident {
  @apply mx-auto w-full max-w-md;

  .wrapper {
    @apply bg-white py-6 shadow rounded-lg px-10;
  }

  form {
    input[type="text"],
    textarea {
      @apply appearance-none block w-full px-3 py-2 border border-cool-gray-400 rounded-md transition duration-150 ease-in-out text-base leading-5;
    }

    input[type="text"]:focus,
    textarea:focus {
      @apply outline-none border-indigo-300 shadow-outline-indigo;
    }

    .group:not(:first-of-type) {
      @apply mt-6;
    }

    label {
      @apply block text-sm font-bold leading-5 text-cool-gray-700 mb-1;
    }

    button {
      @apply mt-6 w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600  transition duration-150 ease-in-out outline-none;
    }

    button:hover {
      @apply bg-indigo-500
    }

    button:focus {
      @apply outline-none border-indigo-700 shadow-outline-indigo
    }

    .help-block {
      @apply text-orange-600 mt-4;
    }
  }
}

/*
 * Range Input
 *
 * Generated by:
 * http://danielstern.ca/range.css
 *
 */

input[type=range] {
  -webkit-appearance: none;
  width: 100%;
  margin: 13.8px 0;
}
input[type=range]:focus {
  outline: none;
}
input[type=range]::-webkit-slider-runnable-track {
  width: 100%;
  height: 8.4px;
  cursor: pointer;
  box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
  background: #7f9cf5;
  border-radius: 0px;
  border: 0px solid #7f9cf5;
}
input[type=range]::-webkit-slider-thumb {
  box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
  border: 1px solid #4c51bf;
  height: 36px;
  width: 17px;
  border-radius: 35px;
  background: #4c51bf;
  cursor: pointer;
  -webkit-appearance: none;
  margin-top: -13.8px;
}
input[type=range]:focus::-webkit-slider-runnable-track {
  background: #97aef7;
}
input[type=range]::-moz-range-track {
  width: 100%;
  height: 8.4px;
  cursor: pointer;
  box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
  background: #7f9cf5;
  border-radius: 0px;
  border: 0px solid #7f9cf5;
}
input[type=range]::-moz-range-thumb {
  box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
  border: 1px solid #4c51bf;
  height: 36px;
  width: 17px;
  border-radius: 35px;
  background: #4c51bf;
  cursor: pointer;
}
input[type=range]::-ms-track {
  width: 100%;
  height: 8.4px;
  cursor: pointer;
  background: transparent;
  border-color: transparent;
  color: transparent;
}
input[type=range]::-ms-fill-lower {
  background: #678af3;
  border: 0px solid #7f9cf5;
  border-radius: 0px;
  box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
}
input[type=range]::-ms-fill-upper {
  background: #7f9cf5;
  border: 0px solid #7f9cf5;
  border-radius: 0px;
  box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
}
input[type=range]::-ms-thumb {
  box-shadow: 0px 0px 0px #000000, 0px 0px 0px #0d0d0d;
  border: 1px solid #4c51bf;
  height: 36px;
  width: 17px;
  border-radius: 35px;
  background: #4c51bf;
  cursor: pointer;
  height: 8.4px;
}
input[type=range]:focus::-ms-fill-lower {
  background: #7f9cf5;
}
input[type=range]:focus::-ms-fill-upper {
  background: #97aef7;
}

/*
 * Loading Spinner
 *
 * Copied from:
 * https://projects.lukehaas.me/css-loaders/
 */

.loader,
.loader:before,
.loader:after {
  border-radius: 50%;
  width: 2.5em;
  height: 2.5em;
  -webkit-animation-fill-mode: both;
  animation-fill-mode: both;
  -webkit-animation: load7 1.8s infinite ease-in-out;
  animation: load7 1.8s infinite ease-in-out;
}
.loader {
  color: #5a67d8;
  font-size: 10px;
  margin: 20px auto;
  position: relative;
  text-indent: -9999em;
  -webkit-transform: translateZ(0);
  -ms-transform: translateZ(0);
  transform: translateZ(0);
  -webkit-animation-delay: -0.16s;
  animation-delay: -0.16s;
}
.loader:before,
.loader:after {
  content: '';
  position: absolute;
  top: 0;
}
.loader:before {
  left: -3.5em;
  -webkit-animation-delay: -0.32s;
  animation-delay: -0.32s;
}
.loader:after {
  left: 3.5em;
}
@-webkit-keyframes load7 {
  0%,
  80%,
  100% {
    box-shadow: 0 2.5em 0 -1.3em;
  }
  40% {
    box-shadow: 0 2.5em 0 0;
  }
}
@keyframes load7 {
  0%,
  80%,
  100% {
    box-shadow: 0 2.5em 0 -1.3em;
  }
  40% {
    box-shadow: 0 2.5em 0 0;
  }
}

#repos {
  @apply max-w-3xl mx-auto text-center;

  form {
    @apply inline-flex items-center px-2;

    .filters {
      @apply flex items-baseline;

      select {
        @apply appearance-none bg-cool-gray-200 border border-cool-gray-400 text-cool-gray-700 py-3 px-4 mr-4 rounded-lg leading-tight font-semibold cursor-pointer;
      }

      select:focus {
        @apply outline-none bg-cool-gray-200 border-cool-gray-500;
      }

      a {
        @apply inline underline text-lg;
      }
    }
  }

  .repos {
    @apply mt-8 bg-white shadow overflow-hidden rounded-md;

    li {
      @apply px-6 py-4 border-t border-cool-gray-300;

      .first-line {
        @apply flex items-center justify-between;

        .group {
          @apply font-medium text-lg text-gray-800;

          img {
            @apply mr-1 h-6 w-6 inline;
          }
        }

        button {
          @apply flex items-center py-1 px-3 ml-2 text-base bg-transparent border border-cool-gray-300 font-medium rounded outline-none shadow-sm;

          img {
            @apply mr-1 h-4 w-4 inline;
          }
        }

        button:hover {
          @apply bg-cool-gray-300 border border-cool-gray-400;
        }
      }

      .second-line {
        @apply flex items-center justify-between mt-3;

        .group {
          @apply mt-0 flex items-center;

          img {
            @apply h-4 w-4 inline;
          }
        }

        .language {
          @apply px-3 py-1 rounded-full font-medium text-sm text-gray-600;
        }
        .language.elixir {
          @apply bg-purple-300;
        }
        .language.ruby {
          @apply bg-red-300;
        }

        .license {
          @apply ml-4 mr-4 text-sm font-medium text-gray-600;
        }

        .stars {
          @apply mr-1;
        }
      }
    }
  }
}
```

```css:assets/css/live_view.css
/* LiveView specific classes for your customizations */

.invalid-feedback {
  color: #a94442;
  display: block;
  margin: -1rem 0 2rem;
}

.phx-no-feedback.invalid-feedback, .phx-no-feedback .invalid-feedback {
  display: none;
}

.phx-click-loading {
  opacity: 0.5;
  transition: opacity 1s ease-out;
}

.phx-disconnected{
  cursor: wait;
}
.phx-disconnected *{
  pointer-events: none;
}

.phx-modal {
  opacity: 1!important;
  position: fixed;
  z-index: 1;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: auto;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0,0.4);
}

.phx-modal-content {
  background-color: #fefefe;
  margin: 15% auto;
  padding: 20px;
  border: 1px solid #888;
  width: 80%;
}

.phx-modal-close {
  color: #aaa;
  float: right;
  font-size: 28px;
  font-weight: bold;
}

.phx-modal-close:hover,
.phx-modal-close:focus {
  color: black;
  text-decoration: none;
  cursor: pointer;
}


/* Alerts and form errors */
.alert {
  padding: 15px;
  margin-bottom: 20px;
  border: 1px solid transparent;
  border-radius: 4px;
}
.alert-info {
  color: #31708f;
  background-color: #d9edf7;
  border-color: #bce8f1;
}
.alert-warning {
  color: #8a6d3b;
  background-color: #fcf8e3;
  border-color: #faebcc;
}
.alert-danger {
  color: #a94442;
  background-color: #f2dede;
  border-color: #ebccd1;
}
.alert p {
  margin-bottom: 0;
}
.alert:empty {
  display: none;
}
```

```js:assets/postcss.config.js
module.exports = {
  plugins: [
    require("postcss-import"),
    require("tailwindcss"),
    require("autoprefixer"),
    require('postcss-nested')
  ]
};
```

```js:assets/tailwind.config.js
module.exports = {
  theme: {
    fontFamily: {
      sans: [
        // "system-ui",
        "-apple-system",
        // "BlinkMacSystemFont",
        "Segoe UI",
        "Roboto",
        "Helvetica Neue",
        "Arial",
        "Noto Sans",
        "sans-serif",
        "Apple Color Emoji",
        "Segoe UI Emoji",
        "Segoe UI Symbol",
        "Noto Color Emoji",
      ],
    },
  },
  variants: {
    //backgroundColor: ["responsive", "hover", "focus", "active"]
  },
  plugins: [require("@tailwindcss/ui")],
  future: {
    removeDeprecatedGapUtilities: true,
  },
};

```


### 参考
- https://github.com/pragmaticstudio/live_view_studio
- [Adding Tailwind CSS to Phoenix 1.4 and 1.5](https://pragmaticstudio.com/tutorials/adding-tailwind-css-to-phoenix)
- ごめん、私は全く解説できないです :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:  

## Nervesアプリがデータを打ち上げる先が変わったので変更してファームウェアをアップデート

```elixir:lib/temperature_and_humidity_nerves/worker.ex
defmodule TemperatureAndHumidityNerves.Worker do
  require Logger

  @url "https://aht20.torifuku-kaiou.tokyo/api/values"
  @headers [{"Content-Type", "application/json"}]

  def run do
    {:ok, {temperature, humidity}} = TemperatureAndHumidityNerves.Aht20.read()

    inspect({temperature, humidity}) |> Logger.debug()

    post(temperature, humidity)
  end

  defp post(temperature, humidity) do
    time = Timex.now() |> Timex.to_unix()
    json = Jason.encode!(%{value: %{temperature: temperature, humidity: humidity, time: time}})
    HTTPoison.post(@url, json, @headers)
  end
end
```

```
$ mix firmware
$ mix upload
```


# ソースコード
- [TORIFUKUKaiou/temperature_and_humidity_nerves](https://github.com/TORIFUKUKaiou/temperature_and_humidity_nerves)
- [TORIFUKUKaiou/aht20_phoenix](https://github.com/TORIFUKUKaiou/aht20_phoenix)

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- ([Nerves](https://www.nerves-project.org/)と[Phoenix](https://www.phoenixframework.org/)をいっぺんに書くと長くなるなあ〜)
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:
- ありがとう! [大晦日ハッカソン2020](https://omisoka-hackathon.connpass.com/event/199478/)








