---
title: NervesKeyなしでNervesHubからOTAでファームウェア更新をしてみる(Elixir)
tags:
  - Elixir
  - Nerves
  - NervesHub
private: false
updated_at: '2020-06-28T13:16:22+09:00'
id: 1e2018e949d4e8e0fe48
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [NervesHub](https://www.nerves-project.org/nerveshub) is an extensible web service that allows you to manage over-the-air (OTA) firmware updates of devices in the field. 
    - [NervesHub](https://www.nerves-project.org/nerveshub)とは、野に咲くデバイスをOTAでのファームウェア更新を可能にする優れものです
- 私は[NervesKey](https://docs.nerves-hub.org/nerves-key/getting-started)を持っていません:sweat:
- また私は、令和二年ですがいまだにRaspberry Pi 2で楽しんでいます
    - Raspberry Pi 2しかもっていません:mask::mask:
- 公式は[こちら](https://docs.nerves-hub.org/)なのですが、2020/6/28現在においては、以下のような状況とのことでドキュメントの順番が前後していたり、手順がわかりにくかったりしますが、ここでは私がうまく行った手順をまとめておきたいとおもいます
    - 一応OTAまで一通りできましたというくらいのふわっとした記事です
    - 間違いなどございましたら、修正取り込みをしますので、ご指摘いただけるとありがたいです！

> We're busy adding and updating the NervesHub documentation to make it easier to use NervesHub. In particular, the NervesHub web user interface is being reorganized so we're only lightly documenting it now. If something doesn't make sense, please let us know via a GitHub issue or by contacting us on the #nerves-hub channel on the Elixir lang Slack.

- この記事で使用したバージョンは以下の通りです

```
elixir            1.10.3-otp-23
erlang            23.0.1
nerves_bootstrap  1.8.1
nerves            1.6.3
```

## ハイライト

<img width="1063" alt="スクリーンショット 2020-06-28 10.37.44.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6b32a7af-b268-8dac-1993-30834c327e80.png">

- OTAでファームウェア更新が進行中です！


# 0. インストール
- @takasehideki 先生の[ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9) を参考に[Erlang](https://www.erlang.org/)、[Elixir](https://elixir-lang.org/)、[nerves_bootstrap](https://hexdocs.pm/nerves/installation.html#all-platforms)のインストールを進めてください
- いままさにこれから`$ mix nerves.new`するなら現時点では、[Erlang](https://www.erlang.org/)は`23`系を使ったほうが詰まるところが少ないような気がします

# 1. プロジェクト作成

- おなじみですね

```
$ mix nerves.new hello_nerves_hub
$ cd hello_nerves_hub
$ export MIX_TARGET=rpi2
$ export NERVES_NETWORK_SSID=ssid
$ export NERVES_NETWORK_PSK=psk
$ mix deps.get
```

- `MIX_TARGET`に指定できるターゲットは、[Targets](https://hexdocs.pm/nerves/targets.html#content)をご参照ください
- `NERVES_NETWORK_SSID`と`NERVES_NETWORK_PSK`は次のWi-Fiの設定で使います

# 2. Wi-Fiの設定

```config/target.exs
config :vintage_net,
  regulatory_domain: "JP",
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
             ssid: System.get_env("NERVES_NETWORK_SSID"),
             psk: System.get_env("NERVES_NETWORK_PSK")
           }
         ]
       },
       ipv4: %{method: :dhcp}
     }}
  ]
```

- `wlan0`の設定をいい感じに書き換えます
- 詳細は、[vintage_net](https://github.com/nerves-networking/vintage_net)を参照してください
    - ちなみに以前(2019/11くらい) `mix nerves.new`したプロジェクトには[vintage_net](https://github.com/nerves-networking/vintage_net)の設定はなかったので、どこかのバージョンから追加されたのだとおもいます
- 私はRaspberry Pi 2をWi-Fiでネットワークにつないでいますが、有線LAN等でもよいとおもいます

# 3. NervesHubの設定

```elixir:mix.exs
  defp deps do
    [
      ...
      {:nerves_hub_cli, "~> 0.10.0", runtime: false},
      {:nerves_hub_link, "~> 0.8.2", targets: @all_targets},
      {:nerves_hub_link_http, "~> 0.8.1", targets: @all_targets},
      {:nerves_time, "~> 0.4.1"}
    ]
  end
```

## 依存関係の解決
```console
$ mix deps.get
```

## ユーザー登録
```console
$ mix nerves_hub.user register
Email address: 
Username: 
NervesHub password: 
```

- ここで作ったユーザーで[https://www.nerves-hub.org/](https://www.nerves-hub.org/)にログインできます

## このあとの操作でNervesHubにデータを書き込んだりする際に使うローカルパスワードを設定します

```console
$ mix nerves_hub.user auth
Username or email address: 
NervesHub password:

Authenticating...
Success

NervesHub uses client-side SSL certificates to authenticate CLI requests.

The next step will create an SSL certificate and store it in your 
'~/.nerves-hub' directory. A password is required to protect it. This password
does not need to be your NervesHub password. It will never be sent to NervesHub
or any other computer. If you lose it, you will need to run
'mix nerves_hub.user auth' and create a new certificate.

Please enter a local password: 
Certificate created successfully.
```

## Firmware signing keys

```console
$ mix nerves_hub.key create devkey
```

## config/config.exsの書き換え

```config/config.exs
config :nerves, :firmware, provisioning: :nerves_hub_link_http

config :nerves_hub_link_http,
  socket: [
    json_library: Jason,
    heartbeat_interval: 45_000
  ],
  ssl: [
    cert: "some_cert_der",
    keyfile: "path/to/keyfile"
  ]

config :nerves_hub,
  fwup_public_keys: [:devkey]
```

- `cert`, `keyfile`はあとで書き換えます

## Products

```console
$ mix nerves_hub.product create
```

- 上記のコマンドで[https://www.nerves-hub.org/](https://www.nerves-hub.org/)にProductが追加されます

<img width="1063" alt="スクリーンショット 2020-06-28 8.04.37.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/dc325d59-c450-e05f-6808-8380e620b544.png">

- この記事の手順では`hello_nerves_hub`が登録されます

## Devices

```console
$ mix nerves_hub.device create
NervesHub server: api.nerves-hub.org:443
NervesHub organization: TORIFUKUKaiou
Identifier (e.g., serial number): 5678
Description: test-5678
One or more comma-separated tags: qa
Local NervesHub user password: 
Device 5678 created.

If your device has an ATECCx08A module or NervesKey that has been
provisioned by a CA/signer certificate known to NervesHub, it is
ready to go.

If not using a hardware module to protect the device's private
key, create and register a certificate and key pair manually by
running:

  mix nerves_hub.device cert create 5678
```

- `Identifier`と`Description`と`tags`の入力を求められます
- 何でもいいとおもうのですが[公式](https://docs.nerves-hub.org/nerves-hub/setup/devices)を参考に入力しています
- Deviceが登録されます
- もちろんまだ`offline`であります

<img width="1063" alt="スクリーンショット 2020-06-28 8.07.08.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f6d00362-aecd-b832-b5f4-43494cf2cb60.png">

- コマンド実行結果の最後に書いてある、NervesKeyを持っていない人の手順を実行します

```console
$ mix nerves_hub.device cert create 5678
```

- これを行うと`nerves-hub/5678-cert.pem`と`nerves-hub/5678-key.pem`ができています
- 続いてさきほどとりあえずそのままにしていた`some_cert_der`を作ります

```elixir
$ iex -S mix

iex> IEx.configure(inspect: [limit: :infinity])
:ok

iex> File.read!("nerves-hub/5678-cert.pem") |> X509.Certificate.from_pem!() |> X509.Certificate.to_der()
<<48, 130, ...>>
```

- 上記の結果をもとに`config/config.exs`を更新します

```elixir:config/config.exs
config :nerves_hub_link_http,
  socket: [
    json_library: Jason,
    heartbeat_interval: 45_000
  ],
  ssl: [
    cert:
      <<48, 130, ...>>,
    keyfile: "nerves-hub/5678-key.pem"
  ]
```

- `cert`のところには、IExの結果をそのまま書きます
    - 手順は、[Jon Carstens](https://twitter.com/JonCarstens) さんに教えてもらいました
    - ありがとうございます！
- インデントがおかしい場合は以下のコマンドでキレイに整形してくれます

```console
$ mix format
```

- ファームウェアをつくります

```console
$ mix deps.compile nerves_hub --force
$ mix firmware
```

- microSDカードに焼きます

```console
$ mix nerves_hub.device burn 5678
```

- microSDカードをRaspberry Pi 2に挿します
- 電源をオンします
- うまくいっていれば、[https://www.nerves-hub.org/](https://www.nerves-hub.org/)上のDeviceが`online`になっているはずです :tada::tada::tada:

# 4. OTA
- 少しプロジェクトに変更を加えておきましょう

```elixir:mix.exs
defmodule HelloNervesHub.MixProject do
  use Mix.Project

  @app :hello_nerves_hub
  @version "0.1.1" # 変更

...

  def application do
    [
      mod: {HelloNervesHub.Application, []},
      extra_applications: [:logger, :runtime_tools, :inets] # :inets 追加
    ]
  end
``` 

```elixir:mix.exs
  defp deps do
    [
      ...
      {:nerves_time, "~> 0.4.1"},
      {:lwwsx, "~> 0.1.2"} # 追加
    ]
  end
``` 

- [lwwsx](https://hex.pm/packages/lwwsx)というのは私が作ったHexで、[Livedoorさんのお天気Webサービス](http://weather.livedoor.com/weather_hacks/webservice)のAPIクライアントです

```
$ mix deps.get
$ mix firmware
$ mix nerves_hub.firmware publish --key devkey
```

- 上記が成功すると、[https://www.nerves-hub.org/](https://www.nerves-hub.org/)上のFirmwareが追加されます
- Web画面上でDeploymentsからDeploymentを作ります

<img width="1063" alt="スクリーンショット 2020-06-28 11.52.46.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/bd806a9d-cb67-c9c5-0b13-b7a7f0e83242.png">

- なんでもいいのだろうとはおもいますが[公式](https://docs.nerves-hub.org/nerves-hub/setup/deployments)を参考に下記のような値をいれてみました
    - Name: qa_deployment
    - Version Requirement: 未入力
    - Tag(s): qa
- 登録が終わったらDeploymentの詳細画面で"Make Active"ボタンを押します
- すると！
- ファームウエアアップデートがはじまっています！  

<img width="1063" alt="スクリーンショット 2020-06-28 10.37.29.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c4b89493-45d7-25e2-2048-dde9aaf59378.png">
- 52%!

<img width="1063" alt="スクリーンショット 2020-06-28 10.37.44.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6b32a7af-b268-8dac-1993-30834c327e80.png">
- 65%!!!
- 100%!!!
- 少しだけ待つとファームウェアのバージョンがアップしていることがわかります

<img width="1063" alt="スクリーンショット 2020-06-28 11.58.35.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/fcf99f73-2734-2e0c-8c46-a4cd85e2f88e.png">

- 本当に更新した内容が含まれているのか確かめてみましょう
- Nervesアプリにsshでログインします
    - `192.168.1.10`のところはご利用のネットワーク環境にあわせて読み替えてください

```elixir
$ ssh 192.168.1.10

iex> use Toolshed
Toolshed imported. Run h(Toolshed) for more info.
:ok 

iex> weather
Weather report: Tsushima, Japan

    \  /       Partly cloudy
  _ /"".-.     27..28 °C      
    \_(   ).   ↗ 5 km/h       
    /(___(__)  10 km          
               0.0 mm 

iex> Lwwsx.current 400030
{:ok,
 %{
   "copyright" => %{
     "image" => %{
       "height" => 26,
       "link" => "http://weather.livedoor.com/",
       "title" => "livedoor 天気情報",
       "url" => "http://weather.livedoor.com/img/cmn/livedoor.gif",
       "width" => 118
     },

```
- 確かにアップデートされています！ :rocket::rocket::rocket:

# Wrapping Up
- NervesKeyなしでNervesHubからOTAでファームウェア更新ができました :boy:
- **Enjoy!**




