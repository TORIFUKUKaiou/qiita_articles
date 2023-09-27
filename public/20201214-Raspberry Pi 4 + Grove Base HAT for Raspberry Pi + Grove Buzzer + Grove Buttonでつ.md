---
title: >-
  Raspberry Pi 4 + Grove Base HAT for Raspberry Pi  + Grove Buzzer + Grove
  ButtonでつくるNervesアラーム
tags:
  - RaspberryPi
  - Elixir
  - Nerves
  - Seeed
private: false
updated_at: '2020-12-20T19:40:51+09:00'
id: d24749203b1586b5685a
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
この記事は[Raspberry Pi Advent Calendar 2020](https://qiita.com/advent-calendar/2020/raspberry-pi) 10日目です。
前日は、@s51517765さんの[エアコンをSlackでスマートリモコン化の効果を温湿度センサで測定する【2020年版】](https://s51517765.hatenadiary.jp/entry/2020/05/25/073000)でした。
10日目はまだ投稿されていなかったので投稿してみました :calendar: 
はじめまして！　よろしくお願いします！ :rocket::rocket::rocket:

---

# はじめに
- 目覚ましアラームをつくります
    - 7:00になったら[Grove - Buzzer](https://www.seeedstudio.com/Grove-Buzzer.html)が鳴る
    - [Grove Button(P)](https://wiki.seeedstudio.com/Grove-Button/)を押したら音が止まる

# What is [Nerves](https://www.nerves-project.org/) ?
- [NervesはElixirのIoTでナウでヤングなcoolなすごいヤツです:rocket:](https://twitter.com/torifukukaiou/status/1201266889990623233)
    - [Nerves](https://www.nerves-project.org/)を作っている[Justin Schneckさん](https://twitter.com/mobileoverlord)が、:thumbsup: しているので間違いないです
- [Elixir](https://elixir-lang.org/)というプログラミング言語がありまして、それを使ってRaspberry Piで動くアプリケーションを作っていくことができます。

# 外観
![IMG_20201214_215925.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/decc299d-a6e7-1e9d-2d0e-6bb58c57b476.jpeg)

- Raspberry Pi 4(4GB)
- [Grove Base HAT for Raspberry Pi](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)
- [Grove Button(P)](https://wiki.seeedstudio.com/Grove-Button/)
    - `D5`
- [Grove - Buzzer](https://www.seeedstudio.com/Grove-Buzzer.html)
    - `D16`
- [ヒートシンク](https://www.switch-science.com/catalog/5986/)
    - 写真ではみえませんが、@myasu さんに教えてもらって貼っています
    - だって、Raspberry Pi 4がものすごく熱くなるのですもの
- [Seeed株式会社](https://www.seeed.co.jp/)様のモノを使うことで、工作が簡単にできます！
 - なにせ自分は、**[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40)**

# 準備
- 公式の[Getting Started](https://hexdocs.pm/nerves/getting-started.html#content)
- @takasehideki先生の[ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
- @takasehideki先生の[ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9)
- @kentaroさんの[ウェブチカでElixir/Nervesに入門する](https://qiita.com/kentaro/items/e8df79aa93b9fe9a567e)

# mix nerves.new alarm

- このコマンドでばーっと、プロジェクトの雛形が作られます

```
$ mix nerves.new alarm
$ cd alarm
$ export MIX_TARGET=rpi4
```

- 今回はRaspberry Pi 4を使っているので`rpi4`です
- その他のものを使う場合は、[Targets](https://hexdocs.pm/nerves/targets.html#content)をご参照ください

# 依存ライブラリの導入

```diff:mix.exs
@@ -49,7 +49,11 @@ defmodule Alarm.MixProject do
       {:nerves_system_rpi4, "~> 1.13", runtime: false, targets: :rpi4},
       {:nerves_system_bbb, "~> 2.8", runtime: false, targets: :bbb},
       {:nerves_system_osd32mp1, "~> 0.4", runtime: false, targets: :osd32mp1},
-      {:nerves_system_x86_64, "~> 1.13", runtime: false, targets: :x86_64}
+      {:nerves_system_x86_64, "~> 1.13", runtime: false, targets: :x86_64},
+
+      # add
+      {:circuits_gpio, "~> 0.4"},
+      {:quantum, "~> 3.0"}
     ]
   end
```

- `Alarm.MixProject.deps/0`に追加します
- [circuits_gpio](https://github.com/elixir-circuits/circuits_gpio)は、GPIOを扱えるライブラリです
- [quantum](https://github.com/quantum-elixir/quantum-core)は、cronライクなジョブスケジューラです

# lib/alarm/buzzer.ex
- ブザーを鳴らしたり、止めたりします
- `D16`に[Grove - Buzzer](https://www.seeedstudio.com/Grove-Buzzer.html)を挿したので`16`をopenしています

```elixir:lib/alarm/buzzer.ex
defmodule Alarm.Buzzer do
  @pin 16

  def start do
    Circuits.GPIO.write(gpio(), 1)
  end

  def stop do
    Circuits.GPIO.write(gpio(), 0)
  end

  def pin, do: @pin

  defp gpio do
    {:ok, gpio} = Circuits.GPIO.open(@pin, :output)
    gpio
  end
end
```

# lib/alarm/button.ex
- `D5`に[Grove Button(P)](https://wiki.seeedstudio.com/Grove-Button/)を挿したので`5`をopenしています

```elixir:lib/alarm/button.ex
defmodule Alarm.Button do
  @pin 5

  def pin, do: @pin

  def gpio do
    {:ok, gpio} = Circuits.GPIO.open(@pin, :input)
    gpio
  end
end
```

# lib/alarm/set_interrupter.ex

```elixir:lib/alarm/set_interrupter.ex
defmodule Alarm.SetInterrupter do
  use GenServer

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    Circuits.GPIO.set_interrupts(Alarm.Button.gpio(), :both, receiver: Alarm.Observer)

    {:ok, state}
  end
end
```

- [Grove Button(P)](https://wiki.seeedstudio.com/Grove-Button/)が押されたり、離されたりすると、`Alarm.Observer`モジュールで処理をします

# lib/alarm/observer.ex

```elixir:lib/alarm/observer.ex
defmodule Alarm.Observer do
  use GenServer

  require Logger

  @button_pin Alarm.Button.pin()

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_info({:circuits_gpio, @button_pin, _timestamp, 1}, state) do
    Logger.debug("Received rising event on pin #{@button_pin}")
    Alarm.Buzzer.State.toggle()
    {:noreply, state}
  end

  def handle_info({:circuits_gpio, @button_pin, _timestamp, 0}, state) do
    Logger.debug("Received falling event on pin #{@button_pin}")
    {:noreply, state}
  end
end
```

- ボタンが押されたときに、`Alarm.Buzzer.State.toggle/0`を呼び出しています(後述)
- ボタンが離されたときは特に処理はしていません

# lib/alarm/buzzer/state.ex

```elixir:lib/alarm/buzzer/state.ex
defmodule Alarm.Buzzer.State do
  use GenServer

  def start_link(_state) do
    GenServer.start_link(__MODULE__, false, name: __MODULE__)
  end

  def init(state) do
    {:ok, state}
  end

  def toggle do
    GenServer.cast(__MODULE__, :toggle)
  end

  # 鳴らしていないときはこちらが実行される
  def handle_cast(:toggle, false) do
    Alarm.Buzzer.start()

    {:noreply, true}
  end

  # 鳴らしているときはこちらが実行される
  def handle_cast(:toggle, true) do
    Alarm.Buzzer.stop()

    {:noreply, false}
  end
end
```

- 初期状態を`false`にしておいて、[Grove - Buzzer](https://www.seeedstudio.com/Grove-Buzzer.html)を鳴らしているときには、状態をtrueにしています

# 日本時間07:00に鳴動するようにする

```elixir:lib/alarm/scheduler.ex
defmodule Alarm.Scheduler do
  use Quantum, otp_app: :alarm
end
```

```elixir:config/config.exs
config :alarm, Alarm.Scheduler,
  jobs: [
    {"0 22 * * *", {Alarm.Buzzer.State, :toggle, []}}
  ]
```
- UTC時刻で指定しています

# Wi-Fiで接続する(オプション)
- LANケーブルでネットワーク接続する場合には必要ありません
    - 今回のアプリケーションではネットワークにつながなくてもよいのですが、ネットワークにつながっていると、`ssh`で接続できてさらに後述する良いことがあるので、ネットワークにつなげておくことはオススメです
- [VintageNet Cookbook — WiFi](https://hexdocs.pm/vintage_net/cookbook.html#wifi)
- 環境変数`NERVES_NETWORK_SSID`、`NERVES_NETWORK_PSK`を開発マシンにセットしておいてください

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
             ssid: System.get_env("NERVES_NETWORK_SSID"),
             psk: System.get_env("NERVES_NETWORK_PSK")
           }
         ]
       },
       ipv4: %{method: :dhcp}
     }}
  ]
```

# Alarm.Application
- `mix nerves.new alarm`したときにほとんどできあがっています
- やることは、今回`use GenServer`しているモジュールを追加するのみです
    - 「#add」をつけた4行のみです

```elixir:lib/alarm/application.ex
defmodule Alarm.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Alarm.Supervisor]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: Alarm.Worker.start_link(arg)
        # {Alarm.Worker, arg},
        Alarm.Scheduler #add
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: Alarm.Worker.start_link(arg)
      # {Alarm.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: Alarm.Worker.start_link(arg)
      # {Alarm.Worker, arg},
      Alarm.Observer, #add
      Alarm.SetInterrupter, #add
      Alarm.Buzzer.State #add
    ]
  end

  def target() do
    Application.get_env(:alarm, :target)
  end
end
```

# ファームウェアビルド

```
$ mix firmware
```

# microSDカードに焼く
- microSDカードを開発マシンに挿して焼き込みます

```
$ mix burn
```

- こんがり焼けたらRaspberry Pi 4に挿して電源ON!!!
- 朝7時に「**<font color="purple">フ、ピェ〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜〜</font>**」ってけっこう大きい音が鳴り続けますので、ボタンを押して止めてください！

# おまけ

## ssh 接続

```
$ ssh nerves.local

iex>
```

- `IEx`(Elixir's interactive shell)が立ち上がります

## ファームウェアアップデート
- ソースコードを修正する

```
$ mix firmware
$ mix upload
```

- microSDカードを抜かずにネットワーク経由でファームウェアのアップデートができます！
- これは便利ですよ〜〜
    - 開発マシンとRaspberry Pi 4は同じネットワークに接続しておいてください
- さらにさらに @kentaro さんの[kentaro/mix_tasks_upload_hotswap](https://github.com/kentaro/mix_tasks_upload_hotswap)を使うともっとはやく反映することができます
    - 解説記事: [`mix upload.hotswap` (kentaro/mix_tasks_upload_hotswap)の裏側](https://qiita.com/kentaro/items/3fbf6a0e603adf64b235)

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- [Nerves](https://www.nerves-project.org/)を使うと、[Elixir](https://elixir-lang.org/)だけで、Raspberry Piで動くアプリケーションを作ることができます
    - ([circuits_gpio](https://github.com/elixir-circuits/circuits_gpio)はよ〜く探検していくと、C言語のコードが入っています)
- ソースコード全体は[TORIFUKUKaiou/alarm](https://github.com/TORIFUKUKaiou/alarm)です
- [Seeed株式会社](https://www.seeed.co.jp/)様のモノを利用することで、**[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40)**な自分でも、簡単に工作できます！
- 最後に紹介したネットワーク越しにファームウェアをアップデートできるのはとても便利です
    - いちいちmicroSDカードを抜き差ししなくて済むのはvery very :+1::+1::+1:です
- この記事で少しでも[Nerves](https://www.nerves-project.org/)に興味を持っていただけましたら、ぜひ[NervesJP](https://nerves-jp.connpass.com/)にご参加ください
    - [NervesJP Slack](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)
    - 愉快なfolksたちが歓迎してくれます
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket: 

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a4ae3fe2-982d-d26b-3df1-7db9f357c399.png)
