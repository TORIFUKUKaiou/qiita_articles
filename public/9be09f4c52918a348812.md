---
title: '[Elixir]Nervesのweatherでお近くの天気情報を得る'
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2020-08-09T00:08:18+09:00'
id: 9be09f4c52918a348812
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Nerves](https://www.nerves-project.org/)は[Elixir](https://elixir-lang.org/)のIoTで[ナウでヤングなcoolなすごいヤツです🚀](https://twitter.com/torifukukaiou/status/1201266889990623233):lgtm:
- `use Toolshed`すると使える`weather`のご紹介です:lgtm:
- この記事では[Nerves](https://www.nerves-project.org/)のバージョンは1.6.3です
- 以下の操作はPCで行います(私はmacOSを使っています)

# ハイライト

```elixir
iex> weather
Weather report: Xxxxx, Japan

   _`/"".-.     Patchy rain possible
    ,\_(   ).   22..25 °C      
     /(___(__)  → 3 km/h       
       ‘ ‘ ‘ ‘  9 km           
      ‘ ‘ ‘ ‘   2.0 mm   
```

- お近くの天気情報が得られることでしょう！ :lgtm::lgtm::lgtm: 


# 準備
- @takasehideki 先生の[ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9) が詳しいです:lgtm:
- 2020/8/8 現在、[Erlang](https://www.erlang.org/)は23をインストールしておくと詰まるところが少ないはずです

# 1. プロジェクトの作成(からのいつもの景色)

```
$ mix nerves.new hello_nerves
$ cd hello_nerves
$ export MIX_TARGET=rpi2
$ mix deps.get
```

- MIX_TARGETに指定できるものは[Supported Targets and Systems](https://hexdocs.pm/nerves/targets.html#supported-targets-and-systems)からお選びください
- 私は令和2年ですがいまだにRaspberry Pi 2を使っています

# 2. 少し書き換え

```elixir:mix.exs
  def application do
    [
      mod: {HelloNerves.Application, []},
      extra_applications: [:logger, :runtime_tools, :inets] # :inetsを追加
    ]
  end
```
- `:inets`の指定は指定をせずに実行しようとすると怒られて、そのとき追加するといいよというようなメッセージをみて気づいた次第です

## Wi-Fiを使う場合(オプション)
- 私はWi-Fiでネットワークに接続しているので設定を書き換えます
- `$ mix nerves.new hello_nerves`したときにこんなふうになっている箇所があるとおもいます

```elixir:config/target.exs
config :vintage_net,
  regulatory_domain: "US",
  config: [
    {"eth0", %{type: VintageNetEthernet, ipv4: %{method: :dhcp}}},
    {"wlan0", %{type: VintageNetWiFi}}
  ]
```

↓↓↓↓

```elixir:config/target.exs
config :vintage_net,
  regulatory_domain: "US",
  config: [
    {"usb0", %{type: VintageNetDirect}},
    {"eth0",
     %{
       type: VintageNetEthernet,
       ipv4: %{method: :dhcp}
     }},
    {"wlan0",
     %{
       type: VintageNetWiFi,
       vintage_net_wifi: %{
         networks: [
           %{
             key_mgmt: :wpa_psk,
             ssid: "your_ssid", # ※ここにSSIDを追記
             psk: "your_psk" # ※ここにパスフレーズを追記
           }
         ]
       },
       ipv4: %{method: :dhcp}
     }}
  ]
```
- こんなふうに書き換えます
- [VintageNet Cookbook](https://hexdocs.pm/vintage_net/cookbook.html#wifi)を参考にしました

# 3. ビルド〜microSDへの焼き込み

```
$ mix firmware
```

- 👆これで`Build a firmware bundle`が行われます
- 成功したら、microSDカードをPCに挿してmicroSDカードにfirmwareを焼き込みます :fire::fire::fire:

```
$ mix burn
``` 
- 👆これで`Write a firmware image to an SDCard`が行われます

# 4. 実行
- こんがり焼き上がったmicroSDカードをRaspberry Pi 2に挿して電源を投入します
- 少し待つと(10〜15秒くらい?)、`ping`が通るようになるとおもいます

```
$ ping nerves.local
```
- pingが通ったら`ssh`しましょう


```elixir
$ ssh nerves.local
Interactive Elixir (1.10.4) - press Ctrl+C to exit (type h() ENTER for help)
Toolshed imported. Run h(Toolshed) for more info.
RingLogger is collecting log messages from Elixir and Linux. To see the
messages, either attach the current IEx session to the logger:

  RingLogger.attach

or print the next messages in the log:

  RingLogger.next

iex(1)> 
```

- `IEx`が使えるようになっているので使っていきます

```elixir
iex> use Toolshed
Toolshed imported. Run h(Toolshed) for more info.
:ok

iex> weather
Weather report: Xxxxx, Japan

   _`/"".-.     Patchy rain possible
    ,\_(   ).   22..25 °C      
     /(___(__)  → 3 km/h       
       ‘ ‘ ‘ ‘  9 km           
      ‘ ‘ ‘ ‘   2.0 mm   
```

- お近くの天気情報が表示されることでしょう
- `Toolshed`には他にも使えるのものがあります
`h(Toolshed)`でご確認ください
- `weather`関数の実体は[ココ](https://github.com/fhunleth/toolshed/blob/094f439994400774e1c1b6c988a2db54c0606dfd/lib/toolshed/http.ex#L12-L19)です
    - `http://wttr.in/?An0`にHTTP Getしています
    - どういう仕組みなのかはわかっていませんがサーバー側で判定してお近くの天気情報を返してくれているようです

```elixir:lib/toolshed/http.ex
  @doc """
  Display the local weather

  See http://wttr.in/:help for more information.
  """
  @spec weather() :: :"do not show this result in output"
  def weather() do
    check_inets()

    {:ok, {_status, _headers, body}} = :httpc.request('http://wttr.in/?An0')

    body |> :binary.list_to_bin() |> IO.puts()
    IEx.dont_display_result()
  end
```

# Wrapping Up
- `extra_applications: [:logger, :runtime_tools, :inets]` と `:inets`を追加すると、`weather`でお近くの天気予報を取得することができます
- Enjoy [Elixir](https://elixir-lang.org/)! :lgtm::lgtm::lgtm::rocket::rocket::rocket:




