---
title: 【続】SORACOM x Nerves できたとはいえるとぼくおもいます
tags:
  - Azure
  - Elixir
  - SORACOM
  - Nerves
private: false
updated_at: '2021-07-10T21:38:06+09:00'
id: efe528f8dbd1012ba37e
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか:bangbang::bangbang::bangbang:
- 先日、「[SORACOM x Nerves できたとはいえるとぼくおもいます](https://qiita.com/torifukukaiou/items/a7694edb3cc86af062f0)」を書きました
- こちらは、本当にやりたいことはできませんでした〜　という内容でした
- その後、進展がありましたので改めて書いておきます
    - 本当にやりたかったことにだいぶ近づきました
- この記事は、2021/06/12(土) 00:00 〜 2021/06/14(月) 23:59開催の[autoracex #32](https://autoracex.connpass.com/event/215754/)という[Elixir](https://elixir-lang.org/)のもくもく会での成果です

# この記事で書いていること
- [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のSIMをセットした[L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)を[Nerves](https://www.nerves-project.org/)がイゴいているRaspberry Pi 4に挿してセルラー通信を楽しみます
    - [nerves-project/nerves_system_rpi4](https://github.com/nerves-project/nerves_system_rpi4)をカスタマイズします
- 本当に、[SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)でセルラー通信していることを確かめるために、[SORACOM Beam](https://soracom.jp/services/beam/)を使います
- `pon`コマンドや`ip route ...`コマンドなどを使って多少強引ではありますがセルラー通信ができるようになりました
- たったの4ステップです!!!
    - [① 準備](https://qiita.com/torifukukaiou/items/efe528f8dbd1012ba37e#-%E6%BA%96%E5%82%99)
    - [② SIMの購入・データ通信端末の購入](https://qiita.com/torifukukaiou/items/efe528f8dbd1012ba37e#-sim%E3%81%AE%E8%B3%BC%E5%85%A5%E3%83%87%E3%83%BC%E3%82%BF%E9%80%9A%E4%BF%A1%E7%AB%AF%E6%9C%AB%E3%81%AE%E8%B3%BC%E5%85%A5)
    - [③ Customizing Your Own Nerves System](https://qiita.com/torifukukaiou/items/efe528f8dbd1012ba37e#-customizing-your-own-nerves-system)
    - [④ Run](https://qiita.com/torifukukaiou/items/efe528f8dbd1012ba37e#-run)

![E0Y2GqDVgAInS0U.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1f767f15-62e0-987f-6c10-87388c4d1667.jpeg)



## [SORACOM Beam](https://soracom.jp/services/beam/)とは
- https://soracom.jp/services/beam/ の説明、図を拝借させていただきました
- _SORACOM Beam（以下、Beam）は、IoT デバイスにかかる暗号化等の高負荷処理や接続先の設定を、クラウドにオフロードできるサービスです。Beam を利用することによって、クラウドを介していつでも、どこからでも、簡単に IoT デバイスを管理することができます。大量のデバイスを直接設定する必要はありません。_

![fig_beam_01.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/fce0b4cd-ed87-cd98-fe6d-1dacd3dd655f.png)

- _お客さまのサーバー_は私の場合、[Azure 仮想マシン](https://azure.microsoft.com/ja-jp/services/virtual-machines/)上に[Phoenix](https://www.phoenixframework.org/)を使って自作したWebアプリケーションをイゴかします
    - [Phoenix](https://www.phoenixframework.org/)アプリの作成は、手前味噌の https://qiita.com/torifukukaiou/items/5876bc4576e7b7991347#phoenix%E3%82%A2%E3%83%97%E3%83%AA%E3%81%AE%E4%BD%9C%E6%88%90 をご参照ください
- 設定はこんな感じです
    - 転送先が、_お客さまのサーバー_ です
    - 公式ドキュメント → https://users.soracom.io/ja-jp/docs/beam/

![スクリーンショット 2021-06-13 18.16.56.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b1f46d2e-5483-5226-38c6-b3c87eacd32c.png)

![スクリーンショット 2021-05-08 17.35.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/79fa947c-66e3-e9ad-8c80-201b4ee74851.png)


# ① 準備
- この記事では割愛します :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
- いくつかリンクを示しておきます

## 公式
- https://hexdocs.pm/nerves/getting-started.html

## 環境構築
- [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
- [ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9)

## Nervesアプリの開発の流れがよくわかる記事
- [ウェブチカでElixir/Nervesに入門する](https://qiita.com/kentaro/items/e8df79aa93b9fe9a567e)

## WiFi設定
- https://hexdocs.pm/vintage_net/cookbook.html#wifi

# ② SIMの購入・データ通信端末の購入
- [SORACOM Air for セルラーの利用方法（個人・法人）](https://soracom.jp/start/) を参考にSIMを購入します
- 私は、`plan-D`を選びました
- [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)に合うサイズは、標準[^1]です
    - [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)はなぜ買ったのかは忘れてしまいましたが発売当初に購入した記憶だけはあります
    - SORACOM IoTストアで購入できるデータ通信端末でもよいとおもいます
        - https://soracom.jp/store/5273/
        - https://soracom.jp/store/5274/
        - ただし、私は試しているわけではないので[Nerves](https://www.nerves-project.org/)と組み合わせて使えるかどうかは保証できないです
        - がんばればいけるとおもいます!

## [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)がデフォルトでモデムモードになっているようにする
- 素の[Raspberry Pi OS](https://www.raspberrypi.org/software/)では自動的にモデムモードとして認識されますが、[Nerves](https://www.nerves-project.org/)の場合はCDROMとして認識されてしまいます
    - 以前は素の[Raspberry Pi OS](https://www.raspberrypi.org/software/)でもデフォルトはCDROMとして認識していたようです
    - もし[Raspberry Pi OS](https://www.raspberrypi.org/software/)のアップデート等でこのへんの動きが変わってしまった場合は、`eject`、`usb_modeswitch`、`lsusb`あたりでググると答えにたどりつけるとおもいます
- そこであらかじめ、素の[Raspberry Pi OS](https://www.raspberrypi.org/software/)でモデムモードとして認識されるように設定しておきました


```
$ cu -l /dev/ttyUSB2

ATZ

AT%USBMODEM=0

~.
```
- (たしかこんな感じだったはずです)


[^1]: SIMの場合は小は大を兼ねます。ただしSIMアダプターでサイズをあわせるのはススメられてはいません。https://soracom.zendesk.com/hc/ja/articles/223454148-SIM-%E3%81%AE%E3%82%B5%E3%82%A4%E3%82%BA%E5%A4%89%E6%9B%B4-%E5%86%8D%E7%99%BA%E8%A1%8C%E3%81%AF%E3%81%A7%E3%81%8D%E3%81%BE%E3%81%99%E3%81%8B-


# ③ [Customizing Your Own Nerves System](https://hexdocs.pm/nerves/customizing-systems.html#content)
- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: を参考にカスタマイズしていきます


## 環境
- 私が使用した環境です
- macOS Catalina 10.15.7
- Elixir: 1.11.4-otp-23
- Erlang: 23.0.1
- Docker version 20.10.6, build 370c289
    - Dockerをイゴかしておく必要があります
    - のちほど行う`mix firmware`のときにNerves Systemのビルドで使われます
    - イゴかしておけば勝手に使われる感じです

## フォルダ構成

```
soracom
├── custom_rpi4
└── cellular_sample
```

## custom_rpi4

```
$ git clone https://github.com/nerves-project/nerves_system_rpi4.git custom_rpi4 -b v1.15.1
```

### カスタマイズ
- https://hexdocs.pm/nerves/customizing-systems.html#getting-setup-to-build-a-system

```diff:mix.exs
-defmodule NervesSystemRpi4.MixProject do
+defmodule CustomRpi4.MixProject do
   use Mix.Project
 
-  @github_organization "nerves-project"
-  @app :nerves_system_rpi4
+  @github_organization "TORIFUKUKaiou"
+  @app :custom_rpi4
   @source_url "https://github.com/#{@github_organization}/#{@app}"
   @version Path.join(__DIR__, "VERSION")
            |> File.read!()
```

- 以下は、https://github.com/nerves-networking/vintage_net_mobile#system-requirements を参考にカスタマイズします
    - `ppp`等が使えるようになります

```diff:linux-5.4.defconfig
+CONFIG_PPP=m
+CONFIG_PPP_BSDCOMP=m
+CONFIG_PPP_DEFLATE=m
+CONFIG_PPP_FILTER=y
+CONFIG_PPP_MPPE=m
+CONFIG_PPP_MULTILINK=y
+CONFIG_PPP_ASYNC=m
+CONFIG_PPP_SYNC_TTY=m
+CONFIG_USB_NET_CDC_NCM=m
+CONFIG_USB_NET_HUAWEI_CDC_NCM=m
+CONFIG_USB_NET_QMI_WWAN=m
+CONFIG_USB_SERIAL_OPTION=m
```

```diff:nerves_defconfig
+BR2_PACKAGE_USB_MODESWITCH=y
+BR2_PACKAGE_PPPD=y
+BR2_PACKAGE_PPPD_FILTER=y
+BR2_PACKAGE_BUSYBOX_CONFIG_FRAGMENT_FILES="${NERVES_DEFCONFIG_DIR}/busybox.fragment"
```

```:busybox.fragment
CONFIG_MKNOD=y
CONFIG_WC=y
```

## cellular_sample
- [Nerves](https://www.nerves-project.org/)アプリです

```
$ mix nerves.new cellular_sample --target rpi4
```

## ファイルの変更

```diff:mix.exs
defmodule CellularSample.MixProject do
 
   @app :cellular_sample
   @version "0.1.0"
-  @all_targets [:rpi4]
+  @all_targets [:rpi4, :custom_rpi4]
 
   def project do
     [
@@ -41,7 +41,13 @@ defmodule CellularSample.MixProject do
       {:nerves_pack, "~> 0.4.0", targets: @all_targets},
 
       # Dependencies for specific targets
-      {:nerves_system_rpi4, "~> 1.13", runtime: false, targets: :rpi4}
+      {:nerves_system_rpi4, "~> 1.13", runtime: false, targets: :rpi4},
+      {:custom_rpi4, path: "../custom_rpi4", runtime: false, targets: :custom_rpi4, nerves: [compile: true]},
+      {:elixircom, "~> 0.2.0"},
+      {:circuits_i2c, "~> 0.3.8"},
+      {:httpoison, "~> 1.8"},
+      {:jason, "~> 1.2"},
+      {:timex, "~> 3.7"}
     ]
   end
```

### セルラー通信のための設定ファイル
- 素の[Raspberry Pi OS](https://www.raspberrypi.org/software/)で動作するファイルをこさえるとよいです
- ググったり、`pppconfig`でひな形つくって、ググって変更したり地道にがんばる必要があります
    - 各行の意味はそれほど理解しているわけではありません :sweat_smile: 
- [L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)に関しては多くの先人の方々の記録があり、たいへん参考にさせてもらいました
- ありがとうございます！
- データ通信端末ごとに多少異なる部分があるとおもいます

```:rootfs_overlay/etc/chatscripts/soracom
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

```:rootfs_overlay/etc/ppp/chap-secrets
# Secrets for authentication using CHAP
# client	server	secret			IP addresses


sora	*	sora
"sora@soracom.io" * "sora"
"sora@soracom.io" * "sora"
```

```:rootfs_overlay/etc/ppp/peers/soracom
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

### セルラー通信

```elixir:lib/cellular_sample.ex
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

```

### [Grove AHT20 I2C温度および湿度センサー 工業用グレード](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)で取得した値を、[SORACOM Beam](https://soracom.jp/services/beam/)を経由して自分のサーバーに送り込む

- ここは通信するプログラムならなにでもいいです
    - `ping 'soracom.jp'`でもいいとおもいます
- [SORACOM Beam](https://soracom.jp/services/beam/)と組み合わせたくて、過去にやったことある方法をつかいました
    - 本題とはだいぶずれます
    - [団長！　いつでもどこでも温度・湿度が測れるのであります！ (Elixir, SORACOM Air for セルラー)](https://qiita.com/torifukukaiou/items/ed0d80c2af8699875f54)を参考にしてください

```elixir:lib/cellular_sample/aht20.ex
defmodule CellularSample.Aht20 do
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

```elixir:lib/cellular_sample/worker.ex
defmodule CellularSample.Worker do
  require Logger

  @url "http://beam.soracom.io:8888/"
  @headers [{"Content-Type", "application/json"}]

  def run do
    {:ok, {temperature, humidity}} = CellularSample.Aht20.read()

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

### WiFi(オプション)
- sshで[Nerves](https://www.nerves-project.org/)の中に入って操作します
- LANケーブルで接続する場合は不要です
- https://hexdocs.pm/vintage_net/cookbook.html#wifi


## ビルド

```
$ cd soracom/cellular_sample
$ export MIX_TARGET=custom_rpi4
$ mix deps.get
$ mix firmware
```
- `mix firmware`はNerves Systemのビルドも行われるのでかなり時間がかかります
- :coffee: でも飲んで気長に待ちましょう
    - マシンスペックやネットワーク環境によるとおもいますが、私は4時間くらいかかりました
        - 時間がかかっていたのはダウンロードのところだとおもいます
        - 夜は家のインターネットがおそいのです……
- ビルドが終わったらmicroSDカードをPCに差し込んで`mix burn`です


# ④ Run
- `ssh nerves.local`等で[Nerves](https://www.nerves-project.org/)にログインします

```elixir
iex> lsusb
Bus 001 Device 003: ID 1004:618f NTT DOCOMO, INC. docomo L02C
...
```
- `618f`がモデムモードです
- `618f`になっていない場合には、[ココ](https://qiita.com/torifukukaiou/items/efe528f8dbd1012ba37e#l-02c%E3%81%8C%E3%83%87%E3%83%95%E3%82%A9%E3%83%AB%E3%83%88%E3%81%A7%E3%83%A2%E3%83%87%E3%83%A0%E3%83%A2%E3%83%BC%E3%83%89%E3%81%AB%E3%81%AA%E3%81%A3%E3%81%A6%E3%81%84%E3%82%8B%E3%82%88%E3%81%86%E3%81%AB%E3%81%99%E3%82%8B)を参照してください

```elixir
iex> Elixircom.run("/dev/ttyUSB2")
AT+COPS=1,2,"44010"
```
- このATコマンドはおまじないです
    - `44010`はドコモを表しています
    - 私の家の周辺ではこれを行っておくことでIPアドレスが割り当てられることが多くなったようにおもいます
- Ctl + Bで抜けます

```elixir
iex> CellularSample.connect
# cmd("mknod /dev/ppp c 108 0")
# cmd("pon soracom")
# の実行と同じです

iex> CellularSample.update_route
# ifconfigでppp0のIPアドレスを確認して
# cmd("ip rou delete default")
# cmd("ip rou add default via #{ip_address} dev ppp0")
# の実行と同じです

iex> CellularSample.Worker.run
# AHT20から温度・湿度を取得して、SORACOM Beamを経由して自分自身のサーバーにデータが送られます
```

![スクリーンショット 2021-05-08 17.35.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/79fa947c-66e3-e9ad-8c80-201b4ee74851.png)

- こんな感じのセルラー通信が実現しました！
    - ただし、[L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)には無通信監視タイマーというものが満了すると通信状態が途切れてしまいます(青表示から白表示)
    - 正確な時間はわかっていないのですが60秒くらいでしょうか
    - [団長！　いつでもどこでも温度・湿度が測れるのであります！ (Elixir, SORACOM Air for セルラー)](https://qiita.com/torifukukaiou/items/ed0d80c2af8699875f54)でやったときは、たしか10秒に1回くらいデータを送っていたのでこういうものがあることに気づかなかったのだとおもいます
    - また24時間以上経つと不通になってしまうことがあるそうです(そんな記事を読みました)
- というような制限みたいなものはありますが、そのへんはさまざまなデータ端末で今後試してみたいとおもいます

# 進展したきっかけ
- 行き詰まりを感じて、その思いを吐露([SORACOM x Nerves できたとはいえるとぼくおもいます](https://qiita.com/torifukukaiou/items/a7694edb3cc86af062f0))したあと寝ました
- 翌朝ダメもとで、`RingLogger.attach`でログ出してみました
- そうすると、`:os.cmd('pon soracom')`実行時に設定ファイルがみつからないというエラーログがでていまして、配置場所を間違えていたことにようやく気づきました

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- 開発をするときにはログを出しておくの大事
    - 寝るのも大事
- [Elixir](https://elixir-lang.org/)でIoTを楽しむ場合は、[Nerves](https://www.nerves-project.org/)です
- [Elixir](https://elixir-lang.org/)でWebアプリケーションを楽しむ場合は、[Phoenix](https://www.phoenixframework.org/)です
- つぎはmodemつくって対応したいとおもいます
    - https://github.com/nerves-networking/vintage_net_mobile#custom-modems

## ソースコード
- https://github.com/TORIFUKUKaiou/custom_rpi4
- https://github.com/TORIFUKUKaiou/cellular_sample


# NervesJP
- ここで[NervesJP](https://nerves-jp.connpass.com/)の紹介です
    - 月1回程度、ワイワイガヤガヤ オンラインで集まっています
    - 次回は、2021/6/23(水) 19:30〜 [NervesJP #18 テストどうやってやっていく回](https://nerves-jp.connpass.com/event/215428/) です
- 愉快なfolksたちがあなたの参加を待っています
- れっつじょいな〜す
- https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk
- ぜひぜひSlackにご参加ください :rocket::rocket::rocket::rocket::rocket:



![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/efe3084e-4891-9aa2-0ee3-e053c990ba4c.png)  
