---
title: nerves-<4 digit serial#>.local (Elixir/Nerves)
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2021-01-29T08:21:08+09:00'
id: 8ddcdd58b515ee114dbc
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか　:bangbang::bangbang::bangbang:
- 2020/12/27(日)は、[【オンライン】豪華プレゼント付！Elixir/Nerves(ナーブス)体験ハンズオン！](https://algyan.connpass.com/event/197306/)が行われました
    - このイベントのお手伝いをしたため、私も[Seeed株式会社](https://www.seeed.co.jp/)様からRaspberry Pi 4を頂戴しました！
    - ありがとうございます！
- 令和2年なのにいまだに使っているRaspberry Pi 2と都合2台となりまして、そうなってくると、
- @nishiuchikazumaさんが投稿された「[`nerves.local` の名前を `orenonerves.local` にする](https://qiita.com/nishiuchikazuma/items/e1f9bb17794ce31efadf)」のようなことが必要になってくるわけです

# ところで

- `mix nerves.new`したときに、はじめからできている

```elixir:config/target.exs
config :mdns_lite,
  # The `host` key specifies what hostnames mdns_lite advertises.  `:hostname`
  # advertises the device's hostname.local. For the official Nerves systems, this
  # is "nerves-<4 digit serial#>.local".  mdns_lite also advertises
  # "nerves.local" for convenience. If more than one Nerves device is on the
  # network, delete "nerves" from the list.

  host: [:hostname, "nerves"],
  ttl: 120,
```

- って書いてあって、`nerves.local`はconvenienceであって、**nerves-<4 digit serial#>.local**なるものがあるとのこと！
- で、次の疑問は**<4 digit serial#>**って何ですか？　という疑問です

# 答え

- シリアル番号の下4桁です
- まず[Nerves](https://www.nerves-project.org/)で`IEx`を使えるようにします
    - a. ディスプレイとキーボードを接続する
    - b. `ssh nerves.local`する (1台目の電源ON時はこれでいける)

## [@mnishiguchi さんコメント](https://qiita.com/torifukukaiou/items/8ddcdd58b515ee114dbc#comment-df6637bb323c112ea3c5)
- [Nerves.Runtime.serial_number/0](https://hexdocs.pm/nerves_runtime/Nerves.Runtime.html#serial_number/0)
- スッキリ :bangbang::bangbang::bangbang:
- :rocket::rocket::rocket:

```elixir
iex> Nerves.Runtime.serial_number
c3ba

iex> (
File.read!("/proc/cpuinfo")
|> String.split("\n")
|> Enum.find(&String.starts_with? &1, "Serial")
|> String.slice(-4..-1)
)
c3ba
```

## @torifukukaiou オリジナル
- 私はもともとこういうコードを載せていましたところ、@mnishiguchiさんがもっと短くすむコードをコメントで教えてくださいました :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:  
- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:  

```elixir
iex> (
File.read!("/proc/cpuinfo")
|> String.split("\n")
|> Enum.map(&(String.split(&1, ":")))
|> Enum.reject(&(Enum.count(&1) == 1))
|> Enum.map(fn [k, v] -> {String.trim(k), v} end)
|> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
|> Keyword.get(:Serial)
|> String.slice(-4..-1)
)
cccc
```

- 上記では、`nerves-cccc.local`になります
- (この値って変わることはないのかなあ？）
- ~~(私の家のRaspberry Pi 2ではこの4桁でうまくいったけど本当にそれでいいのかなあ?)~~


# 参考
- @takasehideki 先生の[ElixirでIoT#4.3：Nervesアプリ開発時のよくあるトラブルをシューティング -- 原因と対処法](https://qiita.com/takasehideki/items/5c79f5531fa189be99f0#%E5%8E%9F%E5%9B%A0%E3%81%A8%E5%AF%BE%E5%87%A6%E6%B3%95-5)
    - **この4桁は，ボードのシリアル番号から付けられています**
    - ありがとうございます！
- [RASPBERRY PI のシリアルナンバー](https://raspberrypi.akaneiro.jp/archives/413)

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- シリアル番号の下4桁で合っていますですかね:interrobang:
    - ~~ちょっと自信がありませんが、自信のある方が正してくださるでしょう~~
    - <font color="purple">Yes! Yes! Yes!</font>
    - @takasehideki 先生から回答をコメントでいただきました!
    - ありがとうございます！
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:
- [Nerves](https://www.nerves-project.org/)に興味を持っていただけましたらぜひ、[Nerves JP Slack](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)へご参加ください
    - 愉快なfolksたちが大歓迎です :bangbang::bangbang::bangbang:

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1c6bf255-ffeb-243c-6b60-3d7c313d6aa0.png)

