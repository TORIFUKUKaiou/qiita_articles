---
title: Livebook Lチカをイゴかす (Elixir)
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2021-11-20T21:49:37+09:00'
id: 2f7c9f460fde510356e8
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- [fhunleth/nerves_livebook](https://github.com/fhunleth/nerves_livebook) を使って、Raspberry Pi 4でLチカをしてみます
    - [Nerves](https://www.nerves-project.org/) + [Livebook](https://github.com/elixir-nx/livebook)です
- 本記事は2021/07/10(土) 00:00〜 2021/07/12(月) 23:59開催の純粋なもくもく会での[autoracex #36](https://autoracex.connpass.com/event/218699/)成果です
- 2021/05/07(金)に開催された[Nerves JP #17 GWやってみた会](https://nerves-jp.connpass.com/event/212353/)で@takasehideki先生にデモをみせていただいたのが、私にとって[fhunleth/nerves_livebook](https://github.com/fhunleth/nerves_livebook)との最初の出逢いです
    - ありがとうございました〜
    - 出逢いからずいぶん時間が経ってようやくイゴかしてみました

# 必要なもの
- Raspberry Pi 4, microSD, 電源
- LANケーブル
- LED
- 抵抗
- ジャンパーワイヤー
- ブレッドボード

## ついでに温度・湿度を測定してみます
- [Grove AHT20 I2C温度および湿度センサー 工業用グレード - Grove AHT20 I2C Industrial Grade Temperature and Humidity Sensor](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)
- [Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)

# 準備
- ファームウェアを焼くツールをPCにインストールします
- [Burning the Firmware](https://github.com/fhunleth/nerves_livebook#burning-the-firmware) を参考に`fwup` or `etcher`をインストールします
- 私が使っているPCは、macOS 10.15.7を使っています
- [Homebrew](https://brew.sh/index_ja)で`fwup`をインストールしました

```
$ brew install fwup
```

# ファームウェアをダウンロードする
- https://github.com/fhunleth/nerves_livebook/releases
- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:からお手持ちのターゲットに合致する`.fw`をPCにダウンロードします
    - Raspberry Pi 4の場合は、`nerves_livebook_rpi4.fw`です

# ファームウェアを焼く
- PCにてダウンロードしたファームウェアをmicroSDに焼きます
- こんな感じです

```
$ fwup nerves_livebook_rpi4.fw
```

# 電源ON
- 下図のような感じでLEDを接続しておきます
    - 「[Raspberry Piで学ぶ電子工作　超小型コンピュータで電子回路を制御する](https://bluebacks.kodansha.co.jp/books/9784062578912/appendix/)」という:book:を参考にしました
- microSDカードをRaspberry Pi 4に差し込んで、LANケーブルを接続して、電源ON!!!
- 15秒ほど待ちましょう :coffee:
- `ping nerves.local`で応答があることを確かめておきましょう

![Sketch_ブレッドボード.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b3271529-9d89-e27c-6519-08240beec068.png)


# ssh接続(任意)
- Livebookを動かすには不要な手順です
- もしPCから[Nerves](https://www.nerves-project.org/)にsshで入りたい場合は以下のようにします

```
$ ssh livebook@nerves.local
```

or

```
$ ssh root@nerves.local
```

- パスワードは`nerves`です
- https://github.com/fhunleth/nerves_livebook/blob/v0.2.14/config/target.exs#L51

```elixir:github.com/fhunleth/nerves_livebook/blob/v0.2.14/config/target.exs
config :nerves_ssh,
  user_passwords: [{"livebook", "nerves"}, {"root", "nerves"}],
  daemon_option_overrides: [
    {:auth_method_kb_interactive_data,
     {'Nerves Livebook',
      'https://github.com/fhunleth/nerves_livebook\n\nssh livebook@nerves.local # Use password "nerves"\n',
      'Password: ', false}}
  ]
```

# Run
- visit: http://nerves.local/
    - パスワードは、`nerves`です

![スクリーンショット 2021-07-10 20.33.27.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/68473270-31c2-63e0-3348-e8a1e97b6190.png)

- 右上の[New notebook]という青のボタンを押します
- そうするとこんなページが表示されます

![スクリーンショット 2021-07-10 20.48.49.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7f2e3ac3-f464-7174-36b8-112b5ccd3de8.png)

- タイトルを`Awesome`とでもつけて
- `+ Section`を押下して、`Lチカ`とでも名前をつけておきましょう
- そうすると、`+ Elixir`というボタンが押せるので押しましょう
- そこにプログラムを書きます

```elixir:
defmodule Example do
  use GenServer

  def init(state) do
    {:ok, gpio} = Circuits.GPIO.open(25, :output)
    set_interval()
    {:ok, {gpio, state}}
  end

  defp set_interval() do
    Process.send_after(self(), :tick, 1000)
  end

  def handle_info(:tick, {gpio, state}) do
    Circuits.GPIO.write(gpio, state)
    set_interval()
    {:noreply, {gpio, flip(state)}}
  end

  defp flip(1), do: 0
  defp flip(0), do: 1
end

GenServer.start_link(Example, 0)
```

![スクリーンショット 2021-07-10 20.54.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/60953664-91bb-ced6-b36b-8c4a93bd0b1e.png)

- ソースコードのちょっと上くらいにマウスカーソルをあわせると`> Evaluate`というボタンがでてくるので、迷わずおしましょう
- 1秒間隔でチカチカ点滅します :tada::tada::tada:

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7e3143f4-e959-7914-850a-bdb4758051e3.gif)




# 温度・湿度を測る
- [Grove AHT20 I2C温度および湿度センサー 工業用グレード - Grove AHT20 I2C Industrial Grade Temperature and Humidity Sensor](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)と[Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)をRaspberry Pi 4に接続した状態で、Lチカのところでやったのと同じような手順で[Elixir](https://elixir-lang.org/)のプログラムを書きます
    - 参考: [Grove Base HAT for RasPiは真っ直ぐグイっとさす](https://qiita.com/torifukukaiou/items/81f2a75bee0f919224ad#%E3%81%AF%E3%81%98%E3%82%81%E3%81%AB)

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

Aht20.Reader.read()
```
 
![スクリーンショット 2021-07-10 20.58.51.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6120fe00-1663-d818-2178-e9aeb027e1fe.png)

- 温度・湿度を測ることができています:rocket::rocket::rocket:

# Wrapping up :lgtm::lgtm::lgtm::lgtm:
- Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
- Lチカやってみました
- ところでLチカのLって、[Livebook](https://github.com/elixir-nx/livebook)のこと:interrobang::sweat_smile:

# 追伸
- そういえば、[Elixir Digitalization Implementors#6：LiveView夏祭り 2021/07/14（水） 19:30〜](https://fukuokaex.connpass.com/event/218299/)で`about Livebook`と題したLTの予定です

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Livebook v0.2 is out! I have recorded a video with our latest features: <a href="https://t.co/jvbL5lNrjX">https://t.co/jvbL5lNrjX</a><br><br>After the initial announcement, we have added user profiles, notebook importing, inputs, charts, and interactive widgets with Kino!<br><br>Thread 👇 with a TL;DW [1/6] <a href="https://twitter.com/hashtag/MyElixirStatus?src=hash&amp;ref_src=twsrc%5Etfw">#MyElixirStatus</a></p>&mdash; José Valim (@josevalim) <a href="https://twitter.com/josevalim/status/1405586165315604486?ref_src=twsrc%5Etfw">June 17, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

- 私がやっていることって、ただ[Livebook](https://github.com/elixir-nx/livebook)を素のまま用意したサーバーでイゴかしているだけで、実はちっとも詳しいわけではないのですが、LT申し込んじゃったので[José Valim](https://twitter.com/josevalim)さんのツイートの内容を理解して、派手めなところのデモを中心に発表してみようとおもっています
    - 私が全世界に向けて公開している[Livebook](https://github.com/elixir-nx/livebook)
        - https://livebook.torifuku-kaiou.tokyo/
        - パスワード: `enjoyelixirwearethealchemists `
- 時間があれば[fhunleth/nerves_livebook](https://github.com/fhunleth/nerves_livebook)のことも話そうとおもっています

# NervesJP
- ここで[NervesJP](https://nerves-jp.connpass.com/)の紹介です
    - 月1回程度、ワイワイガヤガヤ オンラインで集まっています
- 愉快なfolksたちがあなたの参加を待っています
- れっつじょいな〜す
- https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk
- ぜひぜひSlackにご参加ください :rocket::rocket::rocket::rocket::rocket:



![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/efe3084e-4891-9aa2-0ee3-e053c990ba4c.png)  
