---
title: Nerves Livebook Firmwareを使って温度・湿度のグラフをかいてみる
tags:
  - Elixir
  - SORACOM
  - Nerves
  - Qiitaエンジニアフェスタ_SORACOM
private: false
updated_at: '2021-09-04T11:34:18+09:00'
id: dfe1577004f36b8b77d7
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/official-events/846e19ec9af76ca9c940

# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- この記事は、「[SORACOMを使ったIoTにチャレンジしよう！](https://qiita.com/official-events/846e19ec9af76ca9c940)」という[Qiitaエンジニアフェスタ2021](https://qiita.com/official-campaigns/engineer-festa/2021)の中の1つのテーマに応募した記事です
- [Elixir](https://elixir-lang.org/)という素敵なプログラミング言語がありまして、その[Elixir](https://elixir-lang.org/)で楽しめる、[ナウでヤングでcoolな](https://www.slideshare.net/takasehideki/elixirnervescool-249038510)IoTフレームワーク[Nerves](https://www.nerves-project.org/)というものがあります
- [Nerves](https://www.nerves-project.org/)に[Livebook](https://github.com/livebook-dev/livebook)という、これまたプログラム言語[Elixir](https://elixir-lang.org/)謹製のノートブックを組み合わせたものが[Nerves Livebook Firmware](https://github.com/fhunleth/nerves_livebook)です
- めちゃくちゃ簡単に[Nerves](https://www.nerves-project.org/)をはじめられます！
- どんなことができるの？　というのが気になるとおもいます
- こんなことができますですよ

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/77dcc2a3-05ef-4c22-02ee-a62e233ff612.gif)

# 必要なもの
![スクリーンショット 2021-08-07 12.13.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/459d60f3-6313-47bb-33ad-3dd5c9704996.png)

- 私はRaspberry Pi 4を使いました
- `Prerequisites`に書いてあるターゲットをお持ちの方はぜひお試しください！
- 温度・湿度の測定には手先が[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40s)な私でもIoTを楽しめるSeeedさんの製品を使いました
    - [Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)
    - [Grove AHT20 I2C温度および湿度センサー 工業用グレード](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)
        - この記事では、私が持っているセンサーを使います
        - そのほかのセンサーでもこの記事を参考に楽しめるとおもいます
            - センサーから値を読み込む[Elixir](https://elixir-lang.org/)のプログラムを作っていただく必要はあります
        - そんなの無いよう〜　という方のために、この記事でつかった`Raspberry Pi 4`さえあれば楽しめる手順は後ほど書いておきます
- 私の開発マシンはmacOS Catalina 10.15.7です
- Windowsでも大丈夫なはずです (すみません。試してはいません)

# 準備
- https://github.com/fhunleth/nerves_livebook にすべて書いてあります


## ①ファームウェアを焼き込むツールをインストールします
- 私は`fwup`を使いました
- https://github.com/fwup-home/fwup#installing

## ②ファームウェアをダウンロードします
- https://github.com/fhunleth/nerves_livebook/releases
- お持ちのターゲットと合致するものをダウンロードします
- 私は`nerves_livebook_rpi4.fw`をダウンロードしました

## ③ファームウェアをmicroSDカードに焼き込みます
- 開発マシンにmicroSDカードをさして以下のコマンドを実行します

### LANケーブルでネットワークに接続する場合
```
$ fwup nerves_livebook_rpi4.fw
Use 15.84 GB memory card found at /dev/rdisk2? [y/N] y
```

### Wi-Fiでネットワークに接続する場合

```
$ sudo NERVES_WIFI_SSID='access_point' NERVES_WIFI_PASSPHRASE='passphrase' fwup nerves_livebook_rpi4.fw
```

## ④こんがり焼き上がったmicroSDカードをターゲットに差し込んで電源ON
- 10秒から30秒程度、:coffee: でも飲んでお待ちください
- `ping nerves.local`で反応があることを確かめたら、ブラウザで`http://nerves.local`にアクセスしてみてください
- こんな画面がでてきましたら、`Password`には迷わず`nerves`と叩き込んでください！

![スクリーンショット 2021-08-07 12.34.25.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/eb4ab8ef-8fbf-4b75-16fd-5120cdcd1a76.png)

# 温度・湿度のグラフを書いてみる
<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Livebook v0.2 is out! I have recorded a video with our latest features: <a href="https://t.co/jvbL5lNrjX">https://t.co/jvbL5lNrjX</a><br><br>After the initial announcement, we have added user profiles, notebook importing, inputs, charts, and interactive widgets with Kino!<br><br>Thread 👇 with a TL;DW [1/6] <a href="https://twitter.com/hashtag/MyElixirStatus?src=hash&amp;ref_src=twsrc%5Etfw">#MyElixirStatus</a></p>&mdash; José Valim (@josevalim) <a href="https://twitter.com/josevalim/status/1405586165315604486?ref_src=twsrc%5Etfw">June 17, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

- ↑[Elixir](https://elixir-lang.org/)の作者である[José Valim](https://twitter.com/josevalim)さんの解説動画をとても参考にしています
- `nerves`でAuthenticateすると以下のような画面に遷移します

![スクリーンショット 2021-08-07 12.37.18.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7f332d40-8c22-541f-3f5a-69e2acc7be4e.png)

- 右上の`New notebook`でノートブックをつくります
- あとはポチポチやっていく感じです
- タイトルのデフォルト値は`Untitled notebook`です
    - そのままでもよいです
    - 名前は大事なので、`temperature-humidity`とでもつけておきましょう

![スクリーンショット 2021-08-07 12.46.30.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/34a998b9-d076-ba43-fe1f-ad97f68874e7.png)

## グラフをかく
- タイトルの下のほうの`+ Section`を押します
    - `Graph`とでも名前をつけておきます
![スクリーンショット 2021-08-07 12.52.56.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2c56b5c5-a244-046a-2936-fa9d392f4b62.png)

- そうすると`Elixir`というボタンがみえるのでそれを押します

```elixir
defmodule Aht20.Reader do
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

    ret = I2C.read(ref, @i2c_addr, 7)

    I2C.close(ref)

    value(ret)
  end

  defp value({:ok, val}), do: {:ok, convert(val)}

  defp value(_), do: :error

  defp convert(<<_, raw_humi::20, raw_temp::20, _>>) do
    humi = Float.round(raw_humi * 100 / @two_pow_20, 1)
    temp = Float.round(raw_temp * 200 / @two_pow_20 - 50.0, 1)

    {temp, humi}
  end
end
```

- いきなり長いですね
- センサーごとにデータシートを読み解きながら、値を読み取るプログラムをつくる必要があります
- もしかしたらライブラリとして公開されているものがあるかもしれません
- [Elixir](https://elixir-lang.org/)がはじめての方にはもしかしたら見慣れないものが多いかもしれませんが、なんとなく感じてください
- 以下のコミュニティがきっと優しくSlackで相談にのってくれるでしょう！
    - [NervesJP](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)
    - [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w)

![スクリーンショット 2021-08-07 15.53.41.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/287c3ca6-d737-305b-47f5-a66f8b27d753.png)

- 続いて`+ Elixir`を押して

```elixir
Aht20.Reader.read()
```

- と入力します
- すぐ上に`> Evaluate`というボタンがありますので迷わずおしてみます

![スクリーンショット 2021-08-07 15.56.56.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c5afc4b5-04b2-ebe4-ca5d-9d39e3399953.png)

- 温度・湿度が読み取れました
    - この例では気温 28.2℃、湿度 46.4%です
- あとは定期的に値を取得してグラフ表示してみます
- `+ Elixir`を押して以下のプログラムを入力してください
- https://www.youtube.com/watch?v=MOTEgF-wIEI にて、[José Valim](https://twitter.com/josevalim)さんが説明されているプログラムを参考にしています

```elixir
alias VegaLite, as: Vl

layers = 
  for {layer, color} <- [temp: :red, humi: :blue] do
    Vl.new()
    |> Vl.mark(:line)
    |> Vl.encode_field(:x, "iteration", type: :quantitative)
    |> Vl.encode_field(:y, Atom.to_string(layer), type: :quantitative, title: "℃, %")
    |> Vl.encode(:color, value: color, datum: Atom.to_string(layer))
  end

widget = Vl.new(width: 500, height: 200)
  |> Vl.layers(layers)
  |> Kino.VegaLite.new()
```

- 一度、`+ Elixir`を押してプログラムを分けてください

```elixir
Kino.VegaLite.periodically(widget, 200, 0, fn i ->
  {:ok, {temp, humi}} = Aht20.Reader.read()
  point = %{temp: temp, humi: humi, iteration: i}
    
  Kino.VegaLite.push(widget, point, window: 1000)
  {:cont, i + 1}
end)
```

- `evaluate`を迷わず押すと、こんなグラフが表示されるとおもいます
- センサーを水に近づけることで湿度があがっています
    - なにもしないとまっすぐにしかならないので演出です

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/77dcc2a3-05ef-4c22-02ee-a62e233ff612.gif)

:tada::tada::tada::tada:

## おまけ メモリ使用量でグラフをかく
- センサーをお持ちではない方でもお手軽に試せる方法を書いておきます

```elixir
Mix.install([
  {:vega_lite, "~> 0.1.0"},
  {:kino, "~> 0.2.0"}
])

alias VegaLite, as: Vl

memory = [
  total: :red,
  processes: :yellow,
  atom: :green,
  binary: :pink,
  code: :orange,
  ets: :blue
]

layers = 
  for {layer, color} <- memory do
    Vl.new()
    |> Vl.mark(:line)
    |> Vl.encode_field(:x, "iteration", type: :quantitative)
    |> Vl.encode_field(:y, Atom.to_string(layer), type: :quantitative, title: "Memory usage (MB)")
    |> Vl.encode(:color, value: color, datum: Atom.to_string(layer))
  end

widget = Vl.new(width: 500, height: 200)
  |> Vl.layers(layers)
  |> Kino.VegaLite.new()
```


```elixir
Kino.VegaLite.periodically(widget, 200, 0, fn i ->
  point =
    :erlang.memory()
    |> Enum.map(fn {type, bytes} -> {type, bytes / 1_000_000} end)
    |> Map.new()
    |> Map.put(:iteration, i)
  
  Kino.VegaLite.push(widget, point, window: 1000)
  {:cont, i + 1}
end)

for i <- 1..1_000_000 do
  :"atom#{i}"
end
```

## おまけ Lチカ
- 手前味噌の記事を参考にしてください
- [Livebook Lチカをイゴかす (Elixir)](https://qiita.com/torifukukaiou/items/2f7c9f460fde510356e8)

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7e3143f4-e959-7914-850a-bdb4758051e3.gif)

# しまった:bangbang::bangbang::bangbang:
- ここまでRaspberry Pi 4と温度・湿度センサーを使っているので、IoTに関することを書いたことにさせてください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
- しかしながら[SORACOM](https://soracom.jp/)さんの要素がちっともありません
- ここからは、[Nerves Livebook Firmware](https://github.com/fhunleth/nerves_livebook) + [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のSIMを使ったデータ通信をやってみます
- データ通信端末には[L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)を使います
- 選出基準の「日常生活や、業務の課題解決を実現」とはほど遠いですが、**私の知的好奇心は満たしています**ので、**私の日常生活を豊か**にしてくれました

# [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のSIMを使ったデータ通信
- ここからは[Nerves](https://www.nerves-project.org/)を使った開発経験がある方へ向けて要点だけ書いていきます
- まずは、https://hexdocs.pm/nerves/installation.html#content 等を参考に環境整備が必要です
- それが整ったら
- https://hexdocs.pm/nerves/customizing-systems.html#content
- を参考にcustom_rpi4をつくって、カスタマイズしたNerves System上でイゴくようにします
    - 素のNerves Systemでは、[L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)等でのデータ通信はできません

```
$ mkdir livebook_project
$ cd livebook_project
$ git clone https://github.com/fhunleth/nerves_livebook.git
$ git clone https://github.com/nerves-project/nerves_system_rpi4.git custom_rpi4 -b v1.16.1
```

- Nerves Systemのバージョンは、`nerves_livebook/mix.lock`に記録されているバージョンにあわせておくのが吉です

## custom_rpi4

```diff:livebook_project/custom_rpi4/mix.exs
-defmodule NervesSystemRpi4.MixProject do
+defmodule CustomRpi4.MixProject do
   use Mix.Project
 
-  @github_organization "nerves-project"
-  @app :nerves_system_rpi4
+  @github_organization "TORIFUKUKaiou"
+  @app :custom_rpi4
```

- https://github.com/nerves-networking/vintage_net_mobile#system-requirements を参考に`ppp`等が使えるようにします

```:livebook_project/custom_rpi4/linux-5.4.defconfig
CONFIG_PPP=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_USB_NET_CDC_NCM=m
CONFIG_USB_NET_HUAWEI_CDC_NCM=m
CONFIG_USB_NET_QMI_WWAN=m
CONFIG_USB_SERIAL_OPTION=m

```

```:livebook_project/custom_rpi4/nerves_defconfig
BR2_PACKAGE_USB_MODESWITCH=y
BR2_PACKAGE_PPPD=y
BR2_PACKAGE_PPPD_FILTER=y
BR2_PACKAGE_BUSYBOX_CONFIG_FRAGMENT_FILES="${NERVES_DEFCONFIG_DIR}/busybox.fragment"
```

```:livebook_project/custom_rpi4/busybox.fragment
CONFIG_MKNOD=y
CONFIG_WC=y

```

## nerves_livebook
- 続いてnerves_livebookのほうをカスタマイズします

```diff:livebook_project/nerves_livebook/mix.exs
diff --git a/mix.exs b/mix.exs
index 0ca7bbb..558b54d 100644
--- a/mix.exs
+++ b/mix.exs
@@ -13,7 +13,8 @@ defmodule NervesLivebook.MixProject do
     :bbb,
     :osd32mp1,
     :x86_64,
-    :npi_imx6ull
+    :npi_imx6ull,
+    :custom_rpi4
   ]
 
   def project do
@@ -76,7 +77,8 @@ defmodule NervesLivebook.MixProject do
       {:nerves_system_bbb, "~> 2.10", runtime: false, targets: :bbb},
       {:nerves_system_osd32mp1, "~> 0.6", runtime: false, targets: :osd32mp1},
       {:nerves_system_x86_64, "~> 1.15", runtime: false, targets: :x86_64},
-      {:nerves_system_npi_imx6ull, "~> 0.2", runtime: false, targets: :npi_imx6ull}
+      {:nerves_system_npi_imx6ull, "~> 0.2", runtime: false, targets: :npi_imx6ull},
+      {:custom_rpi4, path: "../custom_rpi4", runtime: false, targets: :custom_rpi4, nerves: [compile: true]},
+      {:elixircom, "~> 0.2.0", targets: @all_targets}
     ]
   end
```

```:livebook_project/nerves_livebook/rootfs_overlay/etc/chatscripts/soracom
# This chatfile was generated by pppconfig 2.3.18.
# Please do not delete any of the comments.  Pppconfig needs them.
# 
# ispauth CHAP
# abortstring
ABORT BUSY ABORT 'NO CARRIER' ABORT VOICE ABORT 'NO DIALTONE' ABORT 'NO DIAL TONE' ABORT 'NO ANSWER' ABORT DELAYED
# modeminit
'' ATZ
'' ATH
# ispnumber
OK-AT-OK "ATDT*99***1#"
# ispconnect
CONNECT \d\c
# prelogin

# ispname
# isppassword
# postlogin

# end of pppconfig stuff
```

```:livebook_project/nerves_livebook/rootfs_overlay/etc/ppp/chap-secrets
# Secrets for authentication using CHAP
# client    server  secret          IP addresses


sora    *   sora
"sora@soracom.io" * "sora"
"sora@soracom.io" * "sora"
```

```:livebook_project/nerves_livebook/rootfs_overlay/etc/ppp/peers/soracom
# This optionfile was generated by pppconfig 2.3.18. 
# 
#
hide-password 
noauth
connect "/usr/sbin/chat -v -f /etc/chatscripts/soracom"
debug
/dev/ttyUSB2
115200
defaultroute
noipdefault 
user "sora@soracom.io"

ipparam soracom
```

```elixir:livebook_project/nerves_livebook/config/custom_rpi4.exs
import Config

# Configure the network using vintage_net
# See https://github.com/nerves-networking/vintage_net for more information
config :vintage_net,
  regulatory_domain: "US",
  config: [
    {"usb0", %{type: VintageNetDirect}},
    {"eth0", %{type: VintageNetEthernet, ipv4: %{method: :dhcp}}},
    {"wlan0", %{type: VintageNetWiFi}}
  ]
```

## ビルド
- Nerves SystemのビルドでDockerを使いますので、Dockerを起動しておきます
    - `mix firmware`の中で自動的にいい感じにやってくれるので起動さえしておけばよいです

```
$ cd livebook_project/nerves_livebook
$ export MIX_TARGET=custom_rpi4
$ mix deps.get
$ mix firmware
```

- `mix firmware`はマシンスペックやネットワーク環境などに依存するとおもいますが、けっこう時間がかかります
- :coffee:でも飲んで待ちましょう
- ちなみに私の場合は、1時間弱かかりました

### 焼く
```
$ cd _build/custom_rpi4_dev/nerves/images/
$ sudo NERVES_WIFI_SSID='access_point' NERVES_WIFI_PASSPHRASE='passphrase' fwup nerves_livebook.fw
```

## 実行
- microSDカードをRaspberry Pi 4にさして電源ON
- `ping nerves.local`で応答があるまで:coffee:でも飲みながらまって
- それからおちついて[L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)をさします
    - 私の[L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)は必ずモデムモードとなるように設定しています
    - 参考: [L-02Cがデフォルトでモデムモードになっているようにする](https://qiita.com/torifukukaiou/items/efe528f8dbd1012ba37e#l-02c%E3%81%8C%E3%83%87%E3%83%95%E3%82%A9%E3%83%AB%E3%83%88%E3%81%A7%E3%83%A2%E3%83%87%E3%83%A0%E3%83%A2%E3%83%BC%E3%83%89%E3%81%AB%E3%81%AA%E3%81%A3%E3%81%A6%E3%81%84%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B)

```elixir
$ ssh livebook@nerves.local

iex>  lsusb()
Bus 001 Device 004: ID 1004:618f NTT DOCOMO, INC. docomo L02C
...

iex> Elixircom.run("/dev/ttyUSB2")
```

## 入力するATコマンド
```
AT+COPS=1,2,"44010"
OK # 端末から返される
~.
```

## New Notebook で[Elixir](https://elixir-lang.org/)のプログラムを書く

```elixir
defmodule CellularSample do
  use Toolshed

  def connect do
    cmd("mknod /dev/ppp c 108 0")
    cmd("pon soracom")
  end

  def update_route do
    cmd("ip rou delete default")
    cmd("ip rou add default via #{ip_address()} dev ppp0")
  end

  # ifconfigしてIP Addressを取得している感じです
  defp ip_address do
    {:ok, list} = :inet.getifaddrs()

    Enum.filter(list, fn {type, _} -> type == 'ppp0' end)
    |> Enum.at(0)
    |> elem(1)
    |> Enum.at(1)
    |> elem(1)
    |> Tuple.to_list()
    |> Enum.join(".")
  end
end

CellularSample.connect()
CellularSample.update_route()
```

- [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)が青く光っていればセルラー通信できています
- 本当にセルラー通信しているかはNervesの中に入ってピンポンできることを確かめるのが確実です
    - [デバイスからのPING要求にECHO REPLYを返すエンドポイントを用意しました。](https://blog.soracom.com/ja-jp/2020/02/27/pong-soracom-io/)

```elixir
iex> ping "pong.soracom.io"   
Press enter to stop
Response from pong.soracom.io (100.127.100.127): time=69.427ms
Response from pong.soracom.io (100.127.100.127): time=66.683ms
Response from pong.soracom.io (100.127.100.127): time=77.495ms
```

- 一応できてはいますが、本当は[Custom modems](https://github.com/nerves-networking/vintage_net_mobile#custom-modems)にあるようにモデムモジュールを作るのが推奨されています

# Wrapping Up :lgtm::lgtm::lgtm::lgtm:
- 前半は、[Nerves Livebook Firmware](https://github.com/fhunleth/nerves_livebook)を丁寧に説明しました
    - 丁寧に説明したつもりです
    - もしタンスの肥やしになってしまっているラズベリーパイなどがありましたら、ひっぱりだしてきてぜひイゴかしてみてください
    - わかりにくい箇所などありましたら補足等いたしますので、お気軽にご質問ください
- 後半は、以前自分で書いた[【続】SORACOM x Nerves できたとはいえるとぼくおもいます](https://qiita.com/torifukukaiou/items/efe528f8dbd1012ba37e)を参考にしながら、[Nerves Livebook Firmware](https://github.com/fhunleth/nerves_livebook)においてもカスタムNerves Systemを組み込めることを示しました
    - [Nerves Livebook Firmware](https://github.com/fhunleth/nerves_livebook) x おもしろカスタムNerves Systemでもっとおもしろいことができるかもしれません
- この記事自体では、どなかの困りごとであるサムシングを解決できているわけではないことは認めます
    - サムシングを解決するのは自分でありたいとおもいますし、はたまたどなたかのインプットとなりえたら幸いです
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket:  
- [SORACOM](https://soracom.jp/) x [Nerves](https://www.nerves-project.org/) の化学反応にておもしろいことがきっとはじまることを祈念して筆をおきます
    - [俺、ディ、Discovery 2021が終わったら Nervesに取り組むんだ！](https://twitter.com/ma2shita/status/1401101218152280064)
    - :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">俺、ディ、Discovery 2021が終わったら Nervesに取り組むんだ！</p>&mdash; 松下享平(Max)@ソラコム/IoTのエバンジェリスト (@ma2shita) <a href="https://twitter.com/ma2shita/status/1401101218152280064?ref_src=twsrc%5Etfw">June 5, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>



