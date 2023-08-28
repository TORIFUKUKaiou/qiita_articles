---
title: Customizing Your Own Nerves System の前半をまずやってみる (Elixir)
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2021-05-09T11:24:30+09:00'
id: 71c3aaaee999ac1b7617
organization_url_name: fukuokaex
slide: false
---
https://autoracex.connpass.com/event/212778/

# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか :bangbang::bangbang::bangbang:
- [**ナウでヤングでcoolな**](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)IOTフレームワーク[Nerves](https://www.nerves-project.org/)で、[SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のSIMを挿した[L-02C](https://www.nttdocomo.co.jp/support/product/l02c/index.html)等でデータ通信をしてみたいのです
- [nerves-networking/vintage_net_mobile](https://github.com/nerves-networking/vintage_net_mobile)を使えばなんとかなるのだろうとおもっています
- [System requirements](https://github.com/nerves-networking/vintage_net_mobile#system-requirements)を読むと`These requirements are believed to be the minimum needed to be added to the official Nerves systems.`と書いてあるので、なにかを追加してあげる必要がありそうです
- そこで[Customizing Your Own Nerves System](https://hexdocs.pm/nerves/customizing-systems.html#content)を試してみようとおもったわけです
- まずは自分でほんの少しだけでも、カスタマイズした[Nerves](https://www.nerves-project.org/)をイゴかすことに挑戦してみたいとおもいます
- この記事は2021/05/08(土)00:00 〜 2021/05/10(月) 23:59開催の[autoracex #27](https://autoracex.connpass.com/event/212778/)という純粋なもくもく会での成果です

# 準備
- 事前準備は@takasehideki 先生の[ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)が詳しいです
- Dockerが必要です
    - Dockerを動かしていないと、`mix firmware`の手順のときに
    - `** (Mix) Nerves Docker build_runner is unable to connect to docker daemon`と怒られます




# なにをもってゴールとするか:interrobang:
- [Nerves.Runtime.KV.get_all_active/0](https://hexdocs.pm/nerves_runtime/Nerves.Runtime.KV.html#get_all_active/0)というメソッドがあります
- オフィシャルの[Nerves](https://www.nerves-project.org/)で実行してみるとこんな結果です

```elixir
iex> Nerves.Runtime.KV.get_all_active
%{
  "nerves_fw_application_part0_devpath" => "/dev/mmcblk0p3",
  "nerves_fw_application_part0_fstype" => "ext4",
  "nerves_fw_application_part0_target" => "/root",
  "nerves_fw_architecture" => "arm",
  "nerves_fw_author" => "The Nerves Team",
  "nerves_fw_description" => "",
  "nerves_fw_misc" => "",
  "nerves_fw_platform" => "rpi2",
  "nerves_fw_product" => "hello_nerves",
  "nerves_fw_uuid" => "ceb360bb-d767-5571-0014-d7e88f077f9a",
  "nerves_fw_vcs_identifier" => "",
  "nerves_fw_version" => "0.1.0"
}
```
- いろいろありますけど、`"The Nerves Team"`を書き換えてみたいとおもいます
- `"The Nerves Team"`を`"Awesome YAMAUCHI"`に変えてみたいとおもいます

# [Customizing Your Own Nerves System](https://hexdocs.pm/nerves/customizing-systems.html#content)
- ここに書いてある手順に従って進めます
- targetは令和3年なのにいまだにRaspberry Pi 2です


```
$ mkdir projects
$ cd projects
$ git clone https://github.com/nerves-project/nerves_system_rpi2.git custom_rpi2 -b v1.15.1
$ cd custom_rpi2
```
- [nerves_system_rpi2のリポジトリ](https://github.com/nerves-project/nerves_system_rpi2)を見に行って、最新のタグを指定しておくと吉です

![スクリーンショット 2021-05-09 4.20.47.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6b2d7ecc-152f-9b7e-42dd-b080168302e6.png)



- 少し書きかえておきます

```diff:fwup.conf
-define(NERVES_FW_AUTHOR, "The Nerves Team")
+define(NERVES_FW_AUTHOR, "Awesome YAMAUCHI")
```

```diff:mix.exs
-defmodule NervesSystemRpi2.MixProject do
+defmodule CustomRpi2.MixProject do
   use Mix.Project
 
-  @github_organization "nerves-project"
-  @app :nerves_system_rpi2
+  @github_organization "TORIFUKUKaiou"
+  @app :custom_rpi2
   @source_url "https://github.com/#{@github_organization}/#{@app}"
   @version Path.join(__DIR__, "VERSION")
            |> File.read!()
```

- 続いて自分自身のプロジェクトをつくります



```
$ cd ..
$ mix nerves.new your_project --target rpi2
```

- 途中で`mix deps.get`するか? と尋ねられますが`Y`を押さないほうが無難です
    - 以下、愚痴のようなものです
    - 最初にcloneした`nerves_system_rpi2`のバージョンより新しいバージョンがcloneした直後に即座にリリースされた場合(※)に、`your_project`のほうの`mix.lock`により新しいバージョンが記録されます
      - (※) めったにないとおもいます。むしろ遭遇したほうが奇跡に近い。
    - その状態で`mix deps.get`をすると`custom_rpi2/mix.exs`と`your_project/mix.lock`でバージョンの食い違いがおこり自動では解決してくれません
    - なんでこんな問題なのかどうなのかわからないことを書いているのかというと、どこで勘違いしてしまったのかわからなくなりましたが、`nerves_system_rpi2`を`v1.13.3`という古いものを最新だと思いこんでチェックアウトしていました(2021/05/09時点は最新が`v1.15.1`)
        - 少し前に述べためったにありえないであろう状態を自分の手でつくりあげてしまっていました
    - このバージョン違いの現象で散々悩みました
    - 悩んだ過程はダラダラ書いても仕方ないので省きますが、この記事の文字数ほどスマートに進まなかったということを残しておきます
- ディレクトリ構成はこんな感じになっています

```
projects
├── custom_rpi2
└── your_project
```

- `your_project/mix.exs`を変更しておきます

```Elixir:your_project/mix.exs
  #=vvv= Update your_project/mix.exs to accept your new :custom_rpi2 target

  # ...
  @all_targets [:rpi3, :custom_rpi2]
  #                    =^^^^^^^^^^=

  defp deps do
    [
      # Dependencies for all targets
      # ...

      # Dependencies for specific targets
      {:nerves_system_rpi2, "~> 1.13", runtime: false, targets: :rpi},
      {:custom_rp2, path: "../custom_rpi2", runtime: false, targets: :custom_rpi2, nerves: [compile: true]}, # <===
    ]
  end
```

- Wi-Fi接続設定(Option)
    - https://hexdocs.pm/vintage_net/cookbook.html#wifi

```elixir:config/target.exs
        type: VintageNetEthernet,
        ipv4: %{method: :dhcp}
      }},
-    {"wlan0", %{type: VintageNetWiFi}}
+    {"wlan0",
+     %{
+       type: VintageNetWiFi,
+       vintage_net_wifi: %{
+         networks: [
+           %{
+             key_mgmt: :wpa_psk,
+             ssid: System.get_env("NERVES_NETWORK_SSID"),
+             psk: System.get_env("NERVES_NETWORK_PSK")
+           }
+         ]
+       },
+       ipv4: %{method: :dhcp}
+     }}
   ]
```

- your_project直下で以下を行います

```
$ cd your_project
$ export MIX_TARGET=custom_rpi2
$ mix deps.get
$ mix firmware
```

- 長い...
- めちゃくちゃ長い
- 休日で家のインターネットの回線速度が遅いことも原因
- 待つしかありません
- 終わったら、microSDカードに焼きます

![bbq_couple.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c3e6912a-a4b1-c8dc-9d08-29a26dcb9a9d.png)
- https://www.irasutoya.com/2014/07/blog-post_996.html


```
$ mix burn
```

- microSDカードをRaspberry Pi 2にさしこんで電源ON
- `ping nerves.local`で応答があることを確認(15〜30秒くらい待てばOK)してからssh


```elixir
$ ssh nerves.local
Interactive Elixir (1.11.4) - press Ctrl+C to exit (type h() ENTER for help)
████▄▖    ▐███
█▌  ▀▜█▙▄▖  ▐█
█▌ ▐█▄▖▝▀█▌ ▐█   N  E  R  V  E  S
█▌   ▝▀█▙▄▖ ▐█
███▌    ▀▜████

Toolshed imported. Run h(Toolshed) for more info.
RingLogger is collecting log messages from Elixir and Linux. To see the
messages, either attach the current IEx session to the logger:

  RingLogger.attach

or print the next messages in the log:

  RingLogger.next

iex(1)> 
```

![スクリーンショット 2021-05-09 4.35.25.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/39341a6d-0d1a-09de-14be-c9abedb33c11.png)


```elixir
iex(1)> Nerves.Runtime.KV.get_all_active
%{
  "nerves_fw_application_part0_devpath" => "/dev/mmcblk0p3",
  "nerves_fw_application_part0_fstype" => "ext4",
  "nerves_fw_application_part0_target" => "/root",
  "nerves_fw_architecture" => "arm",
  "nerves_fw_author" => "Awesome YAMAUCHI",
  "nerves_fw_description" => "",
  "nerves_fw_misc" => "",
  "nerves_fw_platform" => "rpi2",
  "nerves_fw_product" => "your_project",
  "nerves_fw_uuid" => "5131eb6a-29d7-5543-27ef-e5072499f085",
  "nerves_fw_vcs_identifier" => "",
  "nerves_fw_version" => "0.1.0"
}
```

- :tada::tada::tada:
- [Customizing Your Own Nerves System](https://hexdocs.pm/nerves/customizing-systems.html#content)の一歩目は踏み出せたとおもいます

## Elixir: 1.11.4-otp-23, Erlang: 23.0.1 をつかっています
- 2021/05/09現在同じことを試すなら、ErlangはOTP 23系を使っておいたほうがいいです
- OTP 22系を使うと失敗しました :crying_cat_face: 
- こんなエラーが`mix firmware`で結構時間がたったあとに言われます
- 普段はOTP 23系をglobal設定している[^1]のですがいろいろ試行錯誤しているうちに、どこかでなにを血迷ってしまったのか、OTP 22系を久しぶりにわざわざセットして使ってしまっていました……
- 赤い字でなんか言われます……
- ごめんよ

[^1]: [asdf](https://asdf-vm.com/#/)をつかって[Elixir](https://elixir-lang.org/)のバージョン切り替えを行っています

```
** (Mix) Major version mismatch between host and target Erlang/OTP versions
  Host version: 22
  Target version: 23

This will likely cause Erlang code compiled for the target to fail in
unexpected ways.

The easiest way to resolve this issue is to install the same version of
Erlang/OTP on your host. See the Nerves installation guide for doing this
using the `asdf` version manager.

The Nerves System (nerves_system_*) dependency determines the OTP version
running on the target. It is possible that a recent update to the Nerves
System pulled in a new version of Erlang/OTP. If you are using an official
Nerves System, you can verify this by reviewing the CHANGELOG.md file that
comes with the release. Run 'mix deps' to see the Nerves System version and
go to that system's repository on https://github.com/nerves-project.

If you need to run a particular version of Erlang/OTP on your target, you can
either lock the nerves_system_* dependency in your mix.exs to an older
version. Note that this route prevents you from receiving security updates
from the official systems. The other option is to build a custom Nerves
system. See the Nerves documentation for building a custom system and then
run 'make menuconfig' and look for the Erlang options.
```

![スクリーンショット 2021-05-09 4.08.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1cebc52d-2d31-2a58-f926-4cfc229290d6.png)
 
# Wrapping up :lgtm::lgtm::lgtm::lgtm:
- 記事の文字数自体は少ないですが、ハマったり、ダウンロードが遅くてすごく時間がかかったりして、とにかく大変でした
    - `mix firmware`の最後の最後で赤文字でなんか言われることの絶望感たるや、筆舌に尽くしがたいです
- 成功へ一直線の道筋を書いておきました 
- Enjoy [Elixir](https://elixir-lang.org/) !!!
