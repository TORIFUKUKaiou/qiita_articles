---
title: Nerves + L-02C(データ通信端末)でデータ通信にトライ(モデムモードにはなりました) (Elixir)
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2021-05-16T17:51:01+09:00'
id: 218622e08992a226b540
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- [Elixir](https://elixir-lang.org/)でIoTができる[**ナウでヤングでcoolな**](https://www.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)[Nerves](https://www.nerves-project.org/)にデータ通信端末をさしこんでanywhereで通信を楽しみたいとおもっています

# 前回
- 「[Customizing Your Own Nerves System の前半をまずやってみる (Elixir)](https://qiita.com/torifukukaiou/items/71c3aaaee999ac1b7617)」の続きからやってみます
- 前回の記事のファームウェアでは、ほとんど素の状態と変わらないので`usb_modeswitch`は使えません

```elixir
iex> System.find_executable("usb_modeswitch")
nil
```

## プロジェクト構造

```
project
├── custom_rpi2
└── your_project
```

# [nerves-networking/vintage_net_mobile](https://github.com/nerves-networking/vintage_net_mobile)
- [nerves-networking/vintage_net_mobile](https://github.com/nerves-networking/vintage_net_mobile)を使うと[Nerves](https://www.nerves-project.org/)でデータ通信できそうです
- READMEにかいてある「These requirements are believed to be the minimum needed to be added to the official Nerves systems.」をやってみます

![スクリーンショット 2021-05-15 21.45.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0861906c-ac79-4d75-1921-0f4830b06811.png)

## custom_rpi2
- READMEに書いてある通り、書き加えてみます

```diff:linux-5.4.defconfig
 CONFIG_CMA_SIZE_MBYTES=5
 CONFIG_PRINTK_TIME=y
 CONFIG_PANIC_TIMEOUT=10
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
 BR2_NERVES_ADDITIONAL_IMAGE_FILES="${NERVES_DEFCONFIG_DIR}/fwup.conf ${NERVES_DEFCONFIG_DIR}/cmdline.txt ${NERVES_DEFCONFIG_DIR}/config.txt"
 BR2_PACKAGE_NBTTY=y
 BR2_PACKAGE_NERVES_CONFIG=y
+BR2_PACKAGE_USB_MODESWITCH=y
+BR2_PACKAGE_PPPD=y
+BR2_PACKAGE_PPPD_FILTER=y
+BR2_PACKAGE_BUSYBOX_CONFIG_FRAGMENT_FILES="${NERVES_DEFCONFIG_DIR}/busybox.fragment"
```

```busybox.fragment
CONFIG_MKNOD=y
CONFIG_WC=y
```

## your_project
- https://github.com/nerves-networking/vintage_net_mobile#serial-at-command-debugging
- に従って、[Elixircom](https://github.com/mattludwigs/elixircom)を追加しておきます

```elixir:mix.exs
  defp deps do
    ...
    {:custom_rpi2, path: "../custom_rpi2", runtime: false, targets: :custom_rpi2, nerves: [compile: true]},
    {:elixircom, "~> 0.2.0"}
  end
```

## ビルド
```
$ cd your_project
$ export MIX_TARGET=custom_rpi2
$ mix deps.get
$ mix firmware
```

## microSDカードにやく
```
$ mix burn
```

# Run
- [Nerves](https://www.nerves-project.org/)にsshではいります

```elixir
$ ssh nerves.local

iex> System.find_executable("usb_modeswitch")
"/usr/sbin/usb_modeswitch" 
```

- :tada::tada::tada: 
- `usb_modeswitch`が使えるようになったようです！

## いろいろやってみる
- ここからはいろいろ試行錯誤の過程を書いています
- **結論** モバイル通信はまだできていません(ATコマンドを打ち込める状態にすることはできるようになりました)
- わかってきたこともあるのでのちほどまとめるとして、しばらくお付き合いください

### ATコマンドを打ち込んでみる

```elixir
iex> Elixircom.run("/dev/ttyUSB2")
Unable to find specified port.

Please make sure your device is plugged in and ready to
be connected to.

{:error, :enoent}
```

- うまくいっていません...

### Circuits.UART.enumerate()

```elixir
iex> Circuits.UART.enumerate()
%{"ttyAMA0" => %{}}
```

- `/dev/ttyUSB2`というのがなさそう

### lsusbしてみる

![スクリーンショット 2021-05-16 15.27.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/421f2bb0-73f9-6b5e-fb32-ab0b9a9fe77a.png)


```elixir
iex> System.find_executable("lsusb")
nil
```

- がーん、ない
    - Linuxのカスタマイズどうやってやればいいんだろう...
- わらにもすがるおもいで`nerves lsusb`でぐぐる
- お、しかも日本語で記事がみつかる
    - [作って学ぶNerves、BBBでCO2計測](https://qiita.com/pojiro/items/ffc8f01fed5b02e3b17c)
    - `h Toolshed`するとあった！
    - @pojiroさん、ありがとうございます！

```elixir
iex> lsusb
...
Bus 001 Device 004: ID 1004:61dd NTT DOCOMO, INC. docomo L02C
...
```

- `1004`がLGで、`61dd`がモード
- `61dd`モードがストレージモードだからいかんっぽい
- これを`618f`のモデムモードにしないといけない
    - このへんの話は、`L-02C Linux`とかで検索して先人の方の記事から得た情報です
- `usb_modeswitch`は使えるから簡単にいくだろうとおもいましたが、なかなかうまくいきませんでした
- いろいろ試したり、調べたりするなかで以下の記事の通りにやるとモードが切り替わりました！
    - [Debian GNU/kFreeBSDでL-02Cを使ってpppする](http://www.pcdennokan.wjg.jp/site/article/5/)
    - ありがとうございます！

```:your_project/rootfs_overlay/etc/usb_modeswitch.d/L02C.conf
DefaultVendor= 0x1004
DefaultProduct=0x61dd

TargetVendor= 0x1004
TargetProduct=0x618f

MessageContent=5553424312345678000000000000061b000000020000000000000000000000
NeedResponse=1
CheckSuccess=20
```

- 記事の通り`L02C.conf`を用意します
- [Nerves](https://www.nerves-project.org/)プロジェクトの下の`rootfs_overlay`配下におくといい感じにLinuxのファイルとしておいてくれます
- 上の例ではLinuxの中では`/etc/usb_modeswitch.d/L02C.conf`として配置されます
- 気を取り直してビルド、そしてまた焼く

```
$ mix firmware
$ mix upload nerves.local
```

- やけたら`ssh nerves.local`して試してみます

```elixir
iex> lsusb  
Bus 001 Device 004: ID 1004:61dd NTT DOCOMO, INC. docomo L02C

iex> File.read("/etc/usb_modeswitch.d/L02C.conf") |> elem(1) |> IO.puts
DefaultVendor= 0x1004
DefaultProduct=0x61dd

TargetVendor= 0x1004
TargetProduct=0x618f

MessageContent=5553424312345678000000000000061b000000020000000000000000000000
NeedResponse=1
CheckSuccess=20
```

- うん、ちゃんと`/etc/usb_modeswitch.d/L02C.conf`は配置されています

```elixir
iex> :os.cmd('usb_modeswitch -c /etc/usb_modeswitch.d/L02C.conf') |> List.to_string |> IO.puts
Look for target devices ...
 No devices in target mode or class found
Look for default devices ...
 Found devices in default mode (1)
Access device 004 on bus 001
Get the current device configuration ...
Current configuration number is 1
Use interface number 0
 with class 8
Use endpoints 0x01 (out) and 0x81 (in)
Looking for active drivers ...
 OK, driver detached
Set up interface 0
Use endpoint 0x01 for message sending ...
Trying to send message 1 to endpoint 0x01 ...
 OK, message successfully sent
Read the response to message 1 (CSW) ...
 Response successfully read (13 bytes), status 0
Reset response endpoint 0x81
Reset message endpoint 0x01

Check for mode switch (max. 20 times, once per second) ...

iex> lsusb
...
Bus 001 Device 005: ID 1004:618f NTT DOCOMO, INC. docomo L02C
...
```

- やったー
- モデムモードになっちょります :tada: 


```elixir
iex> Circuits.UART.enumerate()
%{
  "ttyAMA0" => %{},
  "ttyUSB0" => %{
    description: "docomo L02C",
    manufacturer: "NTT DOCOMO, INC.",
    product_id: 24975,
    vendor_id: 4100
  },
  "ttyUSB1" => %{
    description: "docomo L02C",
    manufacturer: "NTT DOCOMO, INC.",
    product_id: 24975,
    vendor_id: 4100
  },
  "ttyUSB2" => %{
    description: "docomo L02C",
    manufacturer: "NTT DOCOMO, INC.",
    product_id: 24975,
    vendor_id: 4100
  },
  "ttyUSB3" => %{
    description: "docomo L02C",
    manufacturer: "NTT DOCOMO, INC.",
    product_id: 24975,
    vendor_id: 4100
  }
}
```

- 結果がかわりました
- 続いてATコマンドを打ち込んでみます

```elixir
iex> Elixircom.run("/dev/ttyUSB2")
AT
OK
ATH
OK
ATZ
OK
ATQ0 V1 E1 S0=0 &C1 &D2
OK
AT+COPS=1,2,"44010"
OK
AT+CGDCONT=1,"IP","soracom.io"
OK
AT$QCPDPP=1,1,"sora","sora"
OK
ATD*99***1#
CONNECT
```

- `AT`で始まるものは自分で打ち込んだものです
- `OK`は応答です
- `CONNECT`とはでていますが、モバイル通信はできていません
- 別のターミナルで`ssh nerves.local`して`ifconfig`してみますが`ppp0`はありません
- そういえば、「[団長！　いつでもどこでも温度・湿度が測れるのであります！ (Elixir, SORACOM Air for セルラー)](https://qiita.com/torifukukaiou/items/ed0d80c2af8699875f54)」でやっていたときには、`wvdial`というコマンドをつかいました
    - きっと`wvdial`がよろしくやってくれたのだろうとおもいます

# Wrapping up :lgtm::lgtm::lgtm::lgtm:

<font color="purple">$\huge{Enjoy　Elixir!!!}$</font>

## できたこと、わかったこと
- L-02CをNerves上でモデムモードにすることはできました
- Nervesをカスタマイズすることはサンプルがないとなにもできませんが、Linuxにコマンドを追加する方法を雰囲気だけなんとなく理解しました
- [System.find_executable/1](https://hexdocs.pm/elixir/System.html#find_executable/1) で、このコマンドあるんだっけなあを調べられます
- `:os.cmd('cmd args') |> List.to_string |> IO.puts`と実行すると、シェルで実行した雰囲気の結果が得られます

```elixir
iex> :os.cmd('ls -la /etc') |> List.to_string |> IO.puts
drwxr-xr-x    2 root     root            32 May  8 18:30 usb_modeswitch.d
-rw-r--r--    1 root     root          1523 Apr  7 10:06 usb_modeswitch.conf
drwxr-xr-x    3 root     root            30 May  8 18:30 udev
drwxr-xr-x    3 root     root           121 Apr  7 10:06 ssl
-rw-r--r--    1 root     root             9 Apr  7 10:06 shells
-rw-------    1 root     root           243 Apr  7 10:06 shadow
lrwxrwxrwx    1 root     root            18 Apr  7 10:06 resolv.conf -> ../tmp/resolv.conf
-rw-r--r--    1 root     root          2744 Apr  7 10:06 protocols
drwxr-xr-x    3 root     root            79 May  8 18:30 ppp
-rw-r--r--    1 root     root           340 Apr  7 10:06 passwd
lrwxrwxrwx    1 root     root            21 Apr  7 10:06 os-release -> ../usr/lib/os-release
-rw-r--r--    1 root     root             0 Apr  7 10:06 odbcinst.ini
-rw-r--r--    1 root     root             0 Apr  7 10:06 odbc.ini
-rw-r--r--    1 root     root           230 Apr  7 10:06 nsswitch.conf
-rw-r--r--    1 root     root           937 Apr  7 10:06 mke2fs.conf
drwxr-xr-x    2 root     root            44 Apr  7 10:06 libnl
-rw-r--r--    1 root     root           669 May  8 18:30 iex.exs
-rw-r--r--    1 root     root            20 Apr  7 10:06 hosts
-rw-r--r--    1 root     root           307 Apr  7 10:06 group
-rw-r--r--    1 root     root           349 Apr  7 10:06 fw_env.config
-rw-r--r--    1 root     root           752 May  8 18:30 erlinit.config
-rw-r--r--    1 root     root          1596 Apr  7 10:06 erl_inetrc
-rw-r--r--    1 root     root           685 Apr  7 10:06 e2scrub.conf
drwxr-xr-x    2 root     root            34 Apr  7 10:06 cron.d
drwxr-xr-x    2 root     root            27 May  8 18:30 chatscripts
-rw-r--r--    1 root     root           610 Apr  7 10:06 boardid.config
drwxr-xr-x   19 502      20             257 May  8 18:30 ..
drwxr-xr-x    9 root     root           486 May  8 18:30 .
```

## できていないこと
- Nerves with L-02Cでデータ通信はできていません

## 今後について
- おそらく、https://github.com/nerves-networking/vintage_net_mobile#custom-modems にそって、L-02用のモデムがつくれたらいい感じにデータ通信してくれる気がしていますので引き続きやってみます
    - ななめ読み程度ですが、`ppp`という文字面だけはみえましたのでいい感じにやってくれそうです
    - 少しやってみましたがうんともすんとも言わない感じなので、もう少し成果がでたら記事にします
    - この記事では、モデムモードに切り替えることしかできていませんが、だいぶ疲れました...
- データ通信端末を変えてみたらどうなるのかは気になっています
    - とくに`usb_modeswitch`が不要な端末で試してみたいとおもっています
    - [SORACOM IOT ストア](https://soracom.jp/store/)で買い求めてみようかと検討中です(検討中です)
- 外に持ち出したいという用途なら、Nervesのカスタマイズをがんばらなくても素の状態でデータ通信できる、[HUAWEI Mobile WiFi E5785](https://consumer.huawei.com/jp/routers/e5785/)のようなモバイルWiFi機器を持ち運べばいい気がしてきました...
    - お家のWiFiにつなぐのと同じ要領で[Nerves](https://www.nerves-project.org/)をつないでデータ通信できました
    - [IIJmio](https://www.iijmio.jp/)さんのSIMをつかいました
    - 持っているSIMのサイズがあわず、[SORACOM](https://soracom.jp/)さんのSIMではまだ試せていません
    - もうこれでいいかなあという気が若干しています...
        - それを言うと元も子もないといいますか...
        - けれどいろいろ試行錯誤した経験はきっとどこかで役立つだろうとおもっています
        - Nervesにデータ通信端末さしこんでデータ通信できました！　と言ってみたい気もしています

## Raspberry Pi 2(Nerves) + [HUAWEI Mobile WiFi E5785](https://consumer.huawei.com/jp/routers/e5785/)
![IMG_20210516_174625.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/78a39456-d508-6933-2069-d905fa7d6172.jpeg)

- Raspberry Pi 2(Nerves) + [HUAWEI Mobile WiFi E5785](https://consumer.huawei.com/jp/routers/e5785/)の図
- ブレッドボードは不器用につなげたもので本記事とはほとんど関係ありません


<font color="purple">$\huge{Enjoy　Elixir!!!}$</font>







