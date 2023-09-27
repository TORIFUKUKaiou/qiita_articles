---
title: Nervesを使ってRaspberry pi2からTwitterの投稿を行う
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2020-12-02T14:32:10+09:00'
id: 6096c201fbb013e65baa
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
（この記事は、「[#NervesJP Advent Calendar 2019](https://qiita.com/advent-calendar/2019/nervesjp)」の2日目です）
昨日は[takasehideki](https://qiita.com/takasehideki)先生の「[ElixirでIoT#4.1：Nerves開発環境の準備（2019年12月版）](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)」です！こちらもぜひぜひ！


# What is [Nerves](https://nerves-project.org/) ?
- 神経
- [ElixirでIoT#2.1：Nervesって何者？ラズパイでLチカできんの！？](https://qiita.com/takasehideki/items/94820516ec95b85bae32)
    - こちらの[@TAKASEhideki](https://twitter.com/TAKASEhideki) 先生の記事がわかりやすいです
    - **IoTボード上で動作する最小構成のLinuxブートローダ＋Elixir実行環境＋各種デバドラのパッケージセット**
- とにかく、[Elixir](https://elixir-lang.org/)がRaspberry Pi2で動きます、**動かしてみましょう**
- 以下、[Getting Started](https://hexdocs.pm/nerves/getting-started.html)の内容を日本語で少しだけ詳しくかいているつもりです

# 使うもの
- MacBook Pro (13-inch, 2017, Two Thunderbolt 3 ports)
- Raspberry Pi2

![IMG_20191125_204302.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2b651c28-37c1-6de3-93dd-a5490bcceaf2.jpeg)


# つくったもの
- [hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)
- 記事執筆時点のリビジョン: [76443c5e4a16c35b0fbc88c2dd89b9fa424a4c61](https://github.com/TORIFUKUKaiou/hello_nerves/tree/76443c5e4a16c35b0fbc88c2dd89b9fa424a4c61)

# [Elixir](https://elixir-lang.org/)のインストール
- Host(今回の記事ではMacBook Pro)にインストールします
- [macOS Catalina(10.15.1)にasdfでElixirをインストールする](https://qiita.com/torifukukaiou/items/75fa25c55ce2f0b92496)
    - [こちら](https://qiita.com/torifukukaiou/items/75fa25c55ce2f0b92496)などを参考にしてください
    - [Elixir](https://elixir-lang.org/)をインストールするとき、`1.9.4-otp-22` みたいなotpつきのやつを指定するほうがいいとおもいます
    - 指定なしの場合は、のちの`mix firmware`かなにかでエラーがでた気がします(わすれました)
- [Elixir](https://elixir-lang.org/)をインストールできたら、[公式](https://hexdocs.pm/nerves/installation.html#content)に従って以下を行います

```
$ mix local.hex
$ mix local.rebar
$ mix archive.install hex nerves_bootstrap
```

# まずは [nerves_examples](https://github.com/nerves-project/nerves_examples) で練習

## 1. microSDカードにfirmware.burnするまで
- Raspberry Pi2で[Nerves](https://nerves-project.org/)を動かしてネットワークに接続してみます
- 以下、Host(今回の記事ではMacBook Pro)での作業です
- `MIX_TARGET`は[Targets](https://hexdocs.pm/nerves/targets.html)でお持ちのガジェットを指定してください
    - 私はRaspberry Pi2しかもっていないのでこれでしか試せていません
- `NERVES_NETWORK_SSID`と`NERVES_NETWORK_PSK`の値は適切な値をセットしてください
- これを読んでいるような人はたいていもっているとおもうのですが、`~/.ssh`に秘密鍵と公開鍵のペアがおいてある必要があります
    - デフォルトは以下の３種類のうちいずれかを期待しているようです
        - `id_rsa` / `id_rsa.pub`
        - `id_ecdsa` / `id_ecdsa.pub`
        - `id_ed25519` / `id_ed25519.pub`
    - ソースコードは[ここ](https://github.com/nerves-project/nerves_examples/blob/e6791ae5db6dfbf9bf2f9f5f82b0bc0ae4baf272/hello_network/config/config.exs#L64-L78)なので、ファイル名が違うとかあればここを書き換えればうまくいくとおもいます
        - 私は、`~/.ssh/id_rsa` と `~/.ssh/id_rsa.pub` がありましたので特に変更はしていないです

```
$ git clone https://github.com/nerves-project/nerves_examples.git
$ cd nerves_examples/hello_network/
$ export MIX_TARGET=rpi2
$ export NERVES_NETWORK_SSID=ssid
$ export NERVES_NETWORK_PSK=secret
$ mix deps.get
$ mix firmware
```

- microSDカードをHost(今回の記事ではMacBook Pro)に挿入!

```
$ mix firmware.burn
```

- microSDカードを自動検出してくれるのですが、「本当にburnしていいの?」って、ここはじめてだと緊張します
- 慣れると`Y`をすぐおします
- Macのパスワード聞かれるので、本当に大丈夫なことを確認して、burnしてください
    - microSDカードのデータ容量くらいで、エイッとやっています
    - 正しい確認方法ありましたら、コメントください:bow:

## 2. できあがったmicroSDカードをRaspberry Pi2に差し込んで電源ON
- ディスプレイとキーボードを接続しておくといいかもしれません
- iexが起動しています
- 適当にエンターでもおして
- `HelloNetwork.test_dns`を実行してみてください
- `:ok` が返ってくれば、Nerves on Raspberry Pi2はインターネットにつながっています
- 私は特に失敗などありませんでした
- もしうまくつながらない場合は、[RPi3B/B+ wired and wireless Ethernet connections](https://hexdocs.pm/nerves/getting-started.html#rpi3b-b-wired-and-wireless-ethernet-connections) あたりが解決のヒントになるのではないかとおもいます(カンです)
- Nerves on Raspberry Pi2のIPアドレスをどうにかして調べてください
    - 私は192.168.1.1にアクセスして、ルーターの管理画面みたいなやつにいって、「DHCPv4サーバ払い出し状況」みたいなやつから特定しました
      - [@TAKASEhideki](https://twitter.com/TAKASEhideki) 先生から、Raspberry Pi2とTV(ディスプレイ)、キーボードをつないでおいて、iexに `ifconfig`コマンドを打ち込む方法を教えてもらいました
- Host(今回の記事ではMacBook Pro)からNerves on Raspberry Pi2にssh接続しましょう!
    - 例: `ssh 192.168.1.10`
- ここまで順調にいきましたら、続いて自分のプロダクトを作ってみましょう

### おまけ
- どうでもよい話ですが、Host(今回の記事ではMacBook Pro)からNerves on Raspberry Pi2にssh接続ができることを[Nerves](https://nerves-project.org/)を始めた当初は知りませんでした
- TVとRaspberry Pi2をつないで、日本語配列のキーボードで記号をうつときに、パズルのようにしてキーを探していました:sweat_smile:
- [Nerves](https://nerves-project.org/)をはじめた当初はこんな感じで、[@zacky1972
](https://twitter.com/zacky1972)先生の[cpu_info](https://github.com/zeam-vm/cpu_info)のデバッグに参加していました
![IMG_20191106_212136.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b009092f-8c4a-c5af-5be4-f6f12cefd59f.jpeg)
- 文字起こしとかしてました:sweat:
- 解決したときは[こちら](https://github.com/zeam-vm/cpu_info/issues/1#issuecomment-551346163)に名前を載せてもらいました！
    - `hd`とかそれまで私は知らなかった関数の存在を知ることができてよかったです
    - いい思い出です




# アプリの作成

## 1. ひながたの作成
```
$ mix nerves.new hello_nerves
```

- https://github.com/TORIFUKUKaiou/hello_nerves/commit/667ca77389011759e0fe81eccb687d68cd4db26b

## 2. WiFi接続

```Elixir:config/target.exs
config :nerves_network,
  regulatory_domain: "JP"

key_mgmt = System.get_env("NERVES_NETWORK_KEY_MGMT") || "WPA-PSK"

config :nerves_network, :default,
  wlan0: [
    networks: [
      [
        ssid: System.get_env("NERVES_NETWORK_SSID"),
        psk: System.get_env("NERVES_NETWORK_PSK"),
        key_mgmt: String.to_atom(key_mgmt)
      ]
    ]
  ]
```
- https://github.com/TORIFUKUKaiou/hello_nerves/commit/10a9d08e9edbe12a94ab67183c94d05a083911dc
- 上記を書き足したあと、とりあえずWiFi接続できるかどうか試してみましょう

```
$ export MIX_TARGET=rpi2
$ export NERVES_NETWORK_SSID=ssid
$ export NERVES_NETWORK_PSK=secret
$ mix deps.get
$ mix firmware
$ mix firmware.burn
```

- 練習のところでやったように、Host(今回の記事ではMacBook Pro)からNerves on Raspberry Pi2にssh接続できることを確かめましょう



## 3. 天気予報取得、Twitter投稿のためのソースコード変更
- Livedoor Weather Web Serviceは、[■サービス終了のお知らせ](https://help.livedoor.com/weather/index.html)となっております。
  - いままでありがとうございました
- 2020/12/2現在、天気予報の取得はは下記をご参考にしてください。
    - [天気予報を定期的にTwitterにつぶやく(Elixir)](https://qiita.com/torifukukaiou/items/9135aa5528726abefcad)
- 天気予報は[お天気Webサービス](http://weather.livedoor.com/weather_hacks/webservice)を使わせていただいて、HTTP Get |> parse をします
- 取得した結果をTwitterに投稿(HTTP POST)します
- 普通の[Elixir](https://elixir-lang.org/)プログラムを作る感覚でつくれば良いです
- 変更箇所は、[こちら](https://github.com/TORIFUKUKaiou/hello_nerves/commit/02628abcc13d53fa6615abb4add04d8942c6d2be)をご参照ください
- 以下はうまく書けたとおもうところを抜粋しています

```Elixir:lib/weather/forecast.ex
defmodule Weather.Forecast do
  def run do
    city = cities() |> Enum.random()

    description =
      "http://weather.livedoor.com/forecast/webservice/json/v1?city=#{city}"
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Poison.decode!()
      |> Map.get("description")
      |> Map.get("text")
      |> String.split()
      |> Enum.reduce_while("", fn s, acc ->
        if String.length(acc <> "#{s}\n") < 140 - String.length(i_use_nerves()),
          do: {:cont, acc <> "#{s}\n"},
          else: {:halt, acc}
      end)

    if String.length(description) == 0, do: exit("oh no")

    description |> Kernel.<>(i_use_nerves())
  end

  defp i_use_nerves do
    if Application.get_env(:hello_nerves, :target) != :host do
      "I use Nerves. I like it!"
    else
      ""
    end
  end
```
- その後、なんどかリファクタをして現在の姿は[こちら](https://github.com/TORIFUKUKaiou/hello_nerves/blob/1cb077e26c223bb0c54f0fff03ab3d64242b535f/lib/weather/forecast.ex) です
- 大筋はかわっていません

## 4. イメージの作成、microSDカードへの書き込み

- Twitterの認証情報の取得方法はわすれました:sunglasses:
- いつ取得したのかすら忘れましたがもっていたものを使いました

```
$ export MIX_TARGET=rpi2
$ export NERVES_NETWORK_SSID=ssid
$ export NERVES_NETWORK_PSK=secret
$ export TWITTER_CONSUMER_KEY=xxx
$ export TWITTER_CONSUMER_SECRET=yyy
$ export TWITTER_ACCESS_TOKEN=zzz
$ export TWITTER_ACCESS_TOKEN_SECRET=aaa
$ mix deps.get
$ mix firmware
$ mix firmware.burn
```

## 5. Nerves on Raspberry Pi2の起動
- こんがりやきあがったmicroSDカードをRaspberry Pi2に挿し込んで電源を投入しましょう
- Host(今回の記事ではMacBook Pro)からNerves on Raspberry Pi2にssh接続して、`HelloNerves.update`を実行してみましょう

```Elixir
Interactive Elixir (1.9.4) - press Ctrl+C to exit (type h() ENTER for help)
Toolshed imported. Run h(Toolshed) for more info
RingLogger is collecting log messages from Elixir and Linux. To see the
messages, either attach the current IEx session to the logger:

  RingLogger.attach

or print the next messages in the log:

  RingLogger.next

iex(1)> HelloNerves.update
%ExTwitter.Model.Tweet{
  in_reply_to_user_id: nil,
  truncated: false,
  withheld_in_countries: nil,
  quoted_status_id_str: nil,
  favorite_count: 0,
  scopes: nil,
  lang: "ja",
  favorited: false,
  geo: nil,
```

[<img width="611" alt="スクリーンショット 2019-11-15 2.54.07.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9a1e5331-98ce-f710-ff8b-6ca9aa969867.png">](https://twitter.com/torifukukaiou/status/1195036637341683712)

- うまく投稿できましたでしょうか！
- [ラズパイ4でも動くそうです！](https://twitter.com/TAKASEhideki/status/1200618820701847553?s=19)

# まとめ
- [Nerves](https://nerves-project.org/)だからと身構える必要はなく、ふつうの[Elixir](https://elixir-lang.org/)プログラムを書けばうごきます
    - 私の郷里の言葉では、「いごきます」
- [Getting Started](https://hexdocs.pm/nerves/getting-started.html)は英語が不得手な私でも読みやすいです
- cron的なこと:robot:ができていないので、手動でiexから実行しています
    - 課題といえば課題ですが
    - 朝、早起きする意味でこのままでもいいかも:relaxed:

# 最後に
- [IoTつくるよ！2 2019/11/30(土)](https://www.tsukuruyo.net/)の[NervesJP](https://nerves-jp.connpass.com/)のブースにて、[TAKASEhideki](https://twitter.com/TAKASEhideki)先生に使っていただきました！
- ありがとうございます！
  - https://twitter.com/TAKASEhideki/status/1200660354306437120
  - https://twitter.com/TAKASEhideki/status/1200647229872041986

# 次回
次回も引き続き私が担当しまして、「[Nervesでcron的なことをする](https://qiita.com/torifukukaiou/items/19a6aef76e28f9a1f319)」です！こちらも是非どうぞ～
