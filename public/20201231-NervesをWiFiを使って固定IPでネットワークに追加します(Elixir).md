---
title: NervesをWiFiを使って固定IPでネットワークに追加します(Elixir)
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2021-06-12T17:23:08+09:00'
id: 45cfc7bdf73f3f232299
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- 公式の[VintageNet Cookbook](https://hexdocs.pm/vintage_net/cookbook.html)をよくみるとよいです
    - 「[俺だけ見てればいいんだよ！](http://www.aristrist.com/)」
- 細かいところはお好みで環境にあわせた設定をしてください
    - [Google Public DNS](https://developers.google.com/speed/public-dns)
- [nerves-<4 digit serial#>.local (Elixir/Nerves)](https://qiita.com/torifukukaiou/items/8ddcdd58b515ee114dbc)という記事を書いてみましたところ、固定IPの話がでてきて、WiFi + 固定IPのサンプルそのものズバリDon!は、[VintageNet Cookbook](https://hexdocs.pm/vintage_net/cookbook.html)には書いてなかったので記事として書いておきます
    - @nishiuchikazuma さん: [固定IPの世界もいいですよ〜](https://qiita.com/torifukukaiou/items/8ddcdd58b515ee114dbc#comment-8788120c077757f2d374)
    - [VintageNet Cookbook](https://hexdocs.pm/vintage_net/cookbook.html)をよくよんで組み合わせればできますけどね
    - ちょっとしたことでも記事にしていくスタイル

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
       ipv4: %{
         method: :static,
         address: "192.168.1.200",
         prefix_length: 24,
         gateway: "192.168.1.1",
         name_servers: ["8.8.8.8", "8.8.4.4"]
       }
     }}
  ]
```

- **(ノート) `192.168.1.200` は、あくまでも例です。ご自身のネットワーク設定やすでに割り当て済みのものとはかぶらないように設定してください。**
- **`prefix_length`、`gateway`、`name_servers`の値もあくまでも例です。**
    - @kikuyuta 先生、[コメント](https://qiita.com/torifukukaiou/items/45cfc7bdf73f3f232299#comment-3d8c986d05e07610795c)ありがとうございます :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5: 
    - @piacerex さん、[コメント](https://qiita.com/torifukukaiou/items/45cfc7bdf73f3f232299#comment-231fc52baf77c44cce01)ありがとうございます:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

## memo
- `mix upload`したときに**ヤバい、こわしたか:interrobang:**と焦ったことがあったので書いておきます
- もともとは`ipv4: %{method: :dhcp}`に設定したファームウェアで動かしていました
- そこに固定IP `address: "192.168.1.200"` の変更を加えて、`mix firmware && mix upload`しました

```
$ mix upload
...

fwup: Upgrading partition B
100% [====================================] 50.38 MB in / 57.66 MB outReceived disconnect from 192.168.1.12 port 22:11: Terminated (shutdown) by supervisor
Disconnected from 192.168.1.12 port 22
** (Mix) ssh failed with status 255
```

- `** (Mix) ssh failed with status 255`はIPが変わって、単にssh接続がきれただけでした

```elixir
$ ssh 192.168.1.200

iex> ping "nerves-project.org"
Press enter to stop
Response from nerves-project.org (185.199.108.153): time=58.574ms
Response from nerves-project.org (185.199.108.153): time=61.568ms
Response from nerves-project.org (185.199.108.153): time=56.253ms
Response from nerves-project.org (185.199.108.153): time=45.763ms
```

- sshできるし、ちゃんと外にもつながる :bangbang::bangbang::bangbang:

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- 公式ドキュメント最高!!!
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang: 
- [Nerves](https://www.nerves-project.org/)ってなによ:interrobang: って方は、 @takasehideki 先生の「[ElixirでIoT！？ナウでヤングでcoolなNervesフレームワーク](https://www2.slideshare.net/takasehideki/elixiriotcoolnerves-236780506)」をご覧ください
- [NervesJP](https://nerves-jp.connpass.com/)というコミュニティにて愉快なfolksたちがあなたの訪れを大歓迎です :bangbang::bangbang::bangbang: 
    - [NervesJP Slackの招待リンク](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/efe3084e-4891-9aa2-0ee3-e053c990ba4c.png)
