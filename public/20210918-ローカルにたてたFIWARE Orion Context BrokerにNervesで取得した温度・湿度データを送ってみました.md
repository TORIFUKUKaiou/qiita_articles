---
title: ローカルにたてたFIWARE Orion Context BrokerにNervesで取得した温度・湿度データを送ってみました
tags:
  - Elixir
  - Nerves
  - FIWARE
  - Qiita10th_未来
private: false
updated_at: '2021-09-20T01:01:57+09:00'
id: fad466eee261b619c781
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/official-events/12fc7bacec894d33a981

# はじめに
- [Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
- [Open Source Conference 2021 Online/Hiroshima](https://event.ospn.jp/osc2021-online-hiroshima/)が2021年9月18日(土)に開催されました
- 私は参加していない :sweat_smile: のですが、[NervesJP](https://nerves-jp.connpass.com/)の[Slack](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA)にて[FIWARE](https://www.fiware.org/)が盛り上がっていたので試してみました
- @kikuzo さんの「[誰でもできるスマートシティ向けOSS : FIWAREのはじめかた](https://speakerdeck.com/kikuzo/shui-demodekirusumatositeixiang-keoss-fiwarefalsehazimekata)」をとても参考にしました
    - <font color="purple">$\huge{ありがとうございます！}$</font>

## [FIWARE](https://www.fiware.org/)
- [FIWARE](https://www.fiware.org/) technology enables Smart Cities worldwide
- なんだかすごそうです！

## [Nerves](https://www.nerves-project.org/)
- [Elixir](https://elixir-lang.org/)というプログラミング言語で楽しめる、[ナウでヤングでcoolなすごいIoTフレームワーク](https://www.slideshare.net/takasehideki/elixirnervescool-249038510)です。

# とりあえずローカルでFIWARE Orion Context Brokerをイゴかしてみます[^1]
- https://fiware-orion.readthedocs.io/en/master/admin/install/index.html
- https://hub.docker.com/r/fiware/orion/
- [Docker](https://www.docker.com/)を使えるようにしておきます
- macOSを使いました

```yaml:docker-compose.yml
mongo:
  image: mongo:4.4
  command: --nojournal
orion:
  image: fiware/orion
  links:
    - mongo
  ports:
    - "1026:1026"
  command: -dbhost mongo
```

```
$ docker-compose up
```

```
$ curl localhost:1026/version
{
"orion" : {
  "version" : "3.1.0-next",
  "uptime" : "0 d, 0 h, 0 m, 13 s",
  "git_hash" : "7bd1e43514539bd65caeb30d4e3319202e0f115b",
  "compile_time" : "Mon Jul 26 08:19:44 UTC 2021",
  "compiled_by" : "root",
  "compiled_in" : "dae1c5e3a7d9",
  "release_date" : "Mon Jul 26 08:19:44 UTC 2021",
  "machine" : "x86_64",
  "doc" : "https://fiware-orion.rtfd.io/",
  "libversions": {
     "boost": "1_66",
     "libcurl": "libcurl/7.61.1 OpenSSL/1.1.1g zlib/1.2.11 nghttp2/1.33.0",
     "libmicrohttpd": "0.9.70",
     "openssl": "1.1",
     "rapidjson": "1.1.0",
     "mongoc": "1.17.4",
     "bson": "1.17.4"
  }
}
}
```


[^1]: イゴかす = 動かす。西日本のほうの方言(たぶん)。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。


# [Nerves](https://www.nerves-project.org/)から温度・湿度データを送ってみます
## 準備
- https://github.com/telefonicaid/fiware-orion
- をみるとcurlのコマンド例が書いてあるので、[Nerves](https://www.nerves-project.org/)を持ち出すまでもないのですが、私はとにかく[Elixir](https://elixir-lang.org/)を楽しみたいとおもっています
- 開発環境の構築方法は、@takasehideki先生の「[ElixirでIoT#4.1：Nerves開発環境の準備（2020年11月版）](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)」か公式の「[Installation](https://hexdocs.pm/nerves/installation.html)」が詳しいです

```
$ mix nerves.new hello_fiware
```

```diff:mix.exs
       {:nerves_system_rpi4, "~> 1.13", runtime: false, targets: :rpi4},
       {:nerves_system_bbb, "~> 2.8", runtime: false, targets: :bbb},
       {:nerves_system_osd32mp1, "~> 0.4", runtime: false, targets: :osd32mp1},
-      {:nerves_system_x86_64, "~> 1.13", runtime: false, targets: :x86_64}
+      {:nerves_system_x86_64, "~> 1.13", runtime: false, targets: :x86_64},
+      {:httpoison, "~> 1.8"},
+      {:jason, "~> 1.2"},
+      {:aht20, "~> 0.4.0"}
     ]
   end
```

- [aht20](https://github.com/elixir-sensors/aht20)は、@mnishiguchi さん作
    - <font color="purple">$\huge{ありがとうございます！}$</font>
- 話は前後しますが、手先が[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40s)な私でもはめ込み式なので、IoTを手軽に楽しめるSeeedさんの製品を使って、温度・湿度を測定します
    - [Grove AHT20 I2C温度および湿度センサー 工業用グレード](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)
    - [Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)

```
$ export MIX_TARGET=rpi4
$ mix deps.get
$ mix firmware
```

- microSDカードをmacOSに挿して、以下のコマンドで焼き込みます

```
$ mix burn
```

- LANケーブルでRaspberry Pi([Nerves](https://www.nerves-project.org/))をmacOSと同じネットワークに接続して電源ON:fire:

## Run
- :coffee: でも飲みながら15秒から30秒程度待ちましたら、sshでつないでIExで楽しみます

```
$ ssh nerves.local
Interactive Elixir (1.12.1) - press Ctrl+C to exit (type h() ENTER for help)
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
```


### 書き込み
- https://github.com/elixir-sensors/aht20#usage
- と
- https://github.com/telefonicaid/fiware-orion#usage
- を参考に[Elixir](https://elixir-lang.org/)でHTTP POSTしてみました

```elixir
iex> {:ok, pid} = AHT20.start_link(bus_name: "i2c-1", bus_address: 0x38)

iex> {:ok, %AHT20.Measurement{humidity_rh: humidity, temperature_c: temperature}} = AHT20.measure(pid)

iex> json = %{id: "Room", type: "Room", temperature: %{value: temperature, type: "Number"}, humidity: %{value: humidity, type: "Number"}} |> Jason.encode!

iex> HTTPoison.post "http://192.168.1.8:1026/v2/entities", json, [{"Content-Type", "application/json"}]                                                   
{:ok,
 %HTTPoison.Response{
 ...
```

- :tada::tada::tada: 
- 成功しているようです
- `192.168.1.8`は、`docker-compose up`してFIWARE Orion Context Brokerをイゴかしている私の家にあるmacOSのIPアドレスです

### 読み込み

```elixir
iex> HTTPoison.get!("http://192.168.1.8:1026/v2/entities") |> Map.get(:body) |> Jason.decode!
[
  %{
    "humidity" => %{
      "metadata" => %{},
      "type" => "Number",
      "value" => 66.05091095
    },
    "id" => "Room",
    "temperature" => %{
      "metadata" => %{},
      "type" => "Number",
      "value" => 27.030181885
    },
    "type" => "Room"
  }
]
```

- :tada::tada::tada: 

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- 今日は「[誰でもできるスマートシティ向けOSS : FIWAREのはじめかた](https://speakerdeck.com/kikuzo/shui-demodekirusumatositeixiang-keoss-fiwarefalsehazimekata)」を参考にさらーっとなぞってみました
- これからももっともっと触っていこうとおもっています[^2]
    - FIWAREは2017年ころのスタート、その源流に相当するとおもわれる"Next Generation Service Interfaces" (NGSI)は2012年ころからあったという意味では、10年前の自分に教えてあげたいです
    - まあ私は昨日はじめて知ったということで、「次の10年の技術トレンド予想」の方がしっくりきますので**[Qiita10th_未来](https://qiita.com/tags/qiita10th_%e6%9c%aa%e6%9d%a5)**タグをつけました
- Enjoy [Elixir](https://elixir-lang.org/):rocket::rocket::rocket:

[^2]: おもっています。あくまでもおもっています。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">無事終わりました。動画も公開されるそうなので、ご興味のある方そちらなども。(1.5倍速とかで再生できるしね。)<br><br>発表資料こちら。<a href="https://t.co/C39ZD1uARt">https://t.co/C39ZD1uARt</a> <a href="https://t.co/4EXgnZh7HJ">https://t.co/4EXgnZh7HJ</a></p>&mdash; kikuzokikuzo (@kikuzokikuzo) <a href="https://twitter.com/kikuzokikuzo/status/1439064911280148481?ref_src=twsrc%5Etfw">September 18, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">今日はElixir/Nerves界隈が、<a href="https://twitter.com/hashtag/FIWARE?src=hash&amp;ref_src=twsrc%5Etfw">#FIWARE</a> 完全に理解する日になったみたい。</p>&mdash; myasu🍊 (@etcinitd) <a href="https://twitter.com/etcinitd/status/1439085012943446016?ref_src=twsrc%5Etfw">September 18, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
