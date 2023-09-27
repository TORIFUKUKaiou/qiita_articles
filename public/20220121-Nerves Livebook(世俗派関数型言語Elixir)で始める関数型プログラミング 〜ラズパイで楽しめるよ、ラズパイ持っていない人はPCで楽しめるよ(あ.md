---
title: >-
  Nerves Livebook(世俗派関数型言語Elixir)で始める関数型プログラミング
  〜ラズパイで楽しめるよ、ラズパイ持っていない人はPCで楽しめるよ(あ、Nervesはとれますけどね)〜
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2022-08-17T20:23:29+09:00'
id: 6bcd5bbb80df9e594e9e
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**志士ハ溝壑ニ在ルヲ忘レズ、勇士ハソノ元ヲ喪フヲワスレズ**

Advent Calendar 2022 21日目[^1]の記事です。
I'm ready for 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I can't wait for 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

Hey!
名乗るほどのものではありません。

**elixir azure 愛**で検索🔍してください。

https://www.youtube.com/watch?v=R3o8vR1A9ao

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

この記事は、LT資料です。
本日2022-01-21(金)に開催される「[第二回関数型プログラミング（仮）の会](https://opt.connpass.com/event/233498/)」でLTをさせていただく予定です。

[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)で、関数型プログラミングをはじめてみましょう :rocket::rocket::rocket: という内容の記事です。


# What are these?

とりあえず、今日のところは、そこんところは、
**[Elixir](https://elixir-lang.org/)という世俗派関数型言語はIoTを楽しめて、はじめてやるなら[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)がオススメ**
とご理解くださいませ :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
ヨロシク

|  | 私の感じ方、ざっくりとした説明 |
|:-|:-|
| [Elixir](https://elixir-lang.org/)  | 世俗派関数型言語[^4]。なんとなく知らない間にゆるふわで「アタシ、関数型言語でプログラミングしちゃってました」 てな具合にプログラミングを楽しめます。 |
| [Phoenix](https://www.phoenixframework.org/)  | Webアプリケーションの開発を楽しめます  |
| [LiveView](https://github.com/phoenixframework/phoenix_live_view)  | 高性能なバックエンド開発もリッチなフロントエンド開発も[Elixir](https://elixir-lang.org/)一本で楽しめます！  |
| [Livebook](https://github.com/livebook-dev/livebook)  | [Jupyter](https://jupyter.org/)に相当するもの。[LiveView](https://github.com/phoenixframework/phoenix_live_view)を利用したアプリケーションの代表例ともいうべき金字塔。[LiveView](https://github.com/phoenixframework/phoenix_live_view)を利用したアプリケーションのお手本であり、最高峰。  |
|[Nerves](https://www.nerves-project.org/)| [Elixir](https://elixir-lang.org/)でIoTを楽しめるフレームワークです。[ナウでヤングでcoolなすごいやつ](https://www.slideshare.net/takasehideki/elixirnervescool-249038510)です。(誤解を恐れずにいえば)[Nerves](https://www.nerves-project.org/)は、[Elixir](https://elixir-lang.org/)専用OSです!!! sshで中に入ったら`iex>`~~しかできません~~だけができて**一生[Elixir](https://elixir-lang.org/)だけを楽しめます:rocket::rocket::rocket:**　|
|[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook) |[Livebook](https://github.com/livebook-dev/livebook)は、[Nerves](https://www.nerves-project.org/)の上でイゴきます[^2]|

[^4]: @kikuyuta 先生の「[世俗派関数型言語 Elixir を関数型言語風に使ってみたらやっぱり関数型言語みたいだった](https://qiita.com/kikuyuta/items/afa4c264720eb29d9760)」より。[Elixir](https://elixir-lang.org/)はコワくないですよ〜。

## [Nerves](https://www.nerves-project.org/)にsshした時の様子

![スクリーンショット 2022-01-21 8.37.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3b83d724-a5f5-3e13-7df6-85f1e75b2886.png)

sshで中に入ったら`iex>`~~しかできません~~で[Elixir](https://elixir-lang.org/)のプログラミングだけができて**一生[Elixir](https://elixir-lang.org/)だけを楽しめます:rocket::rocket::rocket:**


# 環境構築 ーー インストール〜使い方

環境構築と使い方を説明します。
簡単です。Very easyです。

## [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)

1. [ファームウェア](https://github.com/livebook-dev/nerves_livebook/releases)をダウンロード(.zipのほう)
1. [Raspberry Pi Imager](https://www.raspberrypi.com/software/)をインストール
1. microSDカードにファームウェアを焼き込む
1. microSDカードをRaspberry Piに挿し込んで、LANケーブルも接続して電源ON
1. Passwordは、`nerves`
1. あとは、New notebookでもユー押しちゃいないよ(楽しむだけです)

動画 :movie_camera: にしたためております。

https://www.youtube.com/watch?v=-c4VJpRaIl4

参考にしてください。

## Raspberry Piは持っていないよ〜

1. [Docker](https://www.docker.com/)をインストールしてください
2. https://github.com/livebook-dev/livebook の案内に従ってください

---

えっ！？、[Docker](https://www.docker.com/)をインストールしたくない？、イメージのpullが面倒くさい？
そんな奥様に、
<font color="purple">$\huge{朗報}$</font>です。
私が全世界に[公開しているもの](https://livebook.torifuku-kaiou.app/authenticate)があります。


https://livebook.autoracex.dev/

[https://livebook.autoracex.dev/](https://livebook.autoracex.dev/)

パスワードは`enjoyelixirwearethealchemists`です。
どうぞご自由にお使いください。

# デモ

ここからは[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)のデモをします。
以下のプログラムをコピペして実行します。
うまく**イゴきます**[^2]ように :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
今朝はイゴいていました。本当です!!!

![スクリーンショット 2022-01-21 9.40.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1eb59297-c84a-fff3-cbe2-37d9dd5aea89.png)



[^2]: 「動きます」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^3]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg=

[^3]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。

## Lチカ

IoTの**Hello, World**を楽しんでみます。

### ON

```elixir
{:ok, gpio} = Circuits.GPIO.open(18, :output)
Circuits.GPIO.write(gpio, 1)
```

### OFF

```elixir
{:ok, gpio} = Circuits.GPIO.open(18, :output)
Circuits.GPIO.write(gpio, 0)
```

## 温度湿度

温度湿度を測定してみます。

- [Grove AHT20 I2C温度および湿度センサー 工業用グレード - Grove AHT20 I2C Industrial Grade Temperature and Humidity Sensor](https://jp.seeedstudio.com/Grove-AHT20-I2C-Industrial-grade-temperature-and-humidity-sensor-p-4497.html)
- [Raspberry Pi用Grove Base Hat](https://jp.seeedstudio.com/Grove-Base-Hat-for-Raspberry-Pi.html)

![IMG_20220121_173759.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0f6cb79e-6863-9c54-0c31-a861ebf0e301.jpeg)

[Seeed](https://www.seeed.co.jp/)さんの製品を使いまして、手先が「[不器用ですから](https://www.youtube.com/watch?v=c4e7jGkbDDw&t=40s)」な私でもはめ込み式で電子工作を楽しめます。


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

  # ポイントはここです。温度・湿度の計算の元になる値はそれぞれ20bit取り出す必要があります
  # シフト演算なぞ必要ありません。必要なビット列をパターンマッチで取り出せます。
  defp convert(<<_state::8, raw_humi::20, raw_temp::20, _crc::8>>) do
    humi = Float.round(raw_humi * 100 / @two_pow_20, 1)
    temp = Float.round(raw_temp * 200 / @two_pow_20 - 50.0, 1)

    {temp, humi}
  end
end
```

```elixir
Aht20.Reader.read()
```


# パイプ演算子

上記は、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)とちょっとしたハードウェアが必要でした。
次はそういったものがなくても楽しめるプログラム例です。

```elixir
"https://qiita.com/api/v2/items?query=tag:Elixir"
|> URI.encode()
|> Req.get!(finch_options: [pool_timeout: 50000, receive_timeout: 50000])
|> Map.get(:body)
|> Enum.map(& Map.take(&1, ["title", "url"]))

```

- [Qiita API](https://qiita.com/api/v2/docs)を使わせていただいて、[Elixir](https://qiita.com/tags/elixir)タグがついた最新の記事を20件取得しています
- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)は**パイプ演算子**と呼ばれるものです
    - 前の計算結果を次の関数の第一引数にいれて計算をしてくれます

もし、[Elixir](https://elixir-lang.org/)にパイプ演算子がなく、途中で変数を使わずにワンライナー([来いよ…ライナー](https://mandarabatake.hatenablog.com/entry/2021/04/01/000000))的に書くと以下のようになります。

```elixir
Enum.map(
  Map.get(
    Req.get!(URI.encode("https://qiita.com/api/v2/items?query=tag:Elixir"), 
      finch_options: [pool_timeout: 50000, receive_timeout: 50000]),
    :body),
  & Map.take(&1, ["title", "url"])
)
```

どちらがお好みですか?




# ところでElixirってRubyっぽい？

Rubyに似ているとおもった方いらっしゃいませんか？
Yesです。
作者の[José Valim](https://twitter.com/josevalim)さんは、次のようにおっしゃっています。

> The main, the top three influences are Erlang, Ruby, and Clojure.

(https://cognitect.com/cognicast/120)


ちなみに、[José Valim](https://twitter.com/josevalim)さんはRailsのご経験がある方ならみなさんご存知の[Devise](https://github.com/heartcombo/devise)の最初のコミッターです。

https://github.com/heartcombo/devise/commit/673fda9725b3a0b5522afdbe4fc9c0608243723c




---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
[Elixir](https://elixir-lang.org/)の誕生日は、**2012年5月24日**です。
今年は2022年ですので、**10周年**を迎えます:tada::tada::tada:

```elixir
iex> Date.diff(~D[2022-05-24], ~D[2022-01-21])
123
```

**ひ・ふ・み**


<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

ご自宅にタンスの肥やしになっちゃったり、ホコリをかぶったままのラズベリーパイはございませんか？
Raspberry Pi OS(旧Raspbian)では物足りない方はいらっしゃいませんか？
[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)を焼き込んで、**エキサイティングな体験**をぜひお手におとりください!!!
**エキサイティングレジャー**(山陽オート)です!!!
Very easyにはじめられます。

[connpass](https://opt.connpass.com/event/233498/)にて求められていた「**特に開発現場での関数型プログラミング的なテクニックの話を中心に募集します**」について強引にまとめます。

- [Elixir](https://elixir-lang.org/)はパターンマッチが強力です
    - 特にIoTでよく使われるであろうビット列の取り出しをパターンマッチで行えるのは楽です
- [Elixir](https://elixir-lang.org/)をはじめてみようとおもった方に、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)をオススメします
    - ラズパイをお持ちでない方は、[Livebook](https://github.com/livebook-dev/livebook)でお楽しみください
- [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)は、本当のプログラミング初心者にもオススメできるとおもっています
    - 本当の初心者が詰まるポイントはたくさんあります
        - インストール
        - エディタのインストール・使い方
        - ターミナルの起動方法・使い方
    - [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)なら目移りもせず[Elixir](https://elixir-lang.org/)に没頭できます!

2022年に流行る技術予想 ーー それは、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)です:rocket::rocket::rocket:

---


# [Elixir](https://elixir-lang.org/)

最後の最後に、[Elixir](https://elixir-lang.org/)について紹介します。

- [|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)でスイスイ、プログラミングしていくことができる素敵なプログラミング言語です
- さっそくプログラムの例を示します
- [Qiita API](https://qiita.com/api/v2/docs)を使わせていただいて、`Elixir`タグがついた最新の記事を20件取得しています
- ここでは雰囲気をつかんでいただければ大丈夫です

```elixir
Mix.install [{:req, "~> 0.2.1"}]

"https://qiita.com/api/v2/items?query=tag:Elixir"
|> URI.encode()
|> Req.get!(finch_options: [pool_timeout: 50000, receive_timeout: 50000])
|> Map.get(:body)
|> Enum.map(& Map.take(&1, ["title", "url"]))

```

## Webアプリケーションを楽しむなら
- [Phoenix](https://www.phoenixframework.org/)

## IoTを楽しむなら
- [Nerves](https://www.nerves-project.org/)

## AIを楽しむなら
- [Nx](https://github.com/elixir-nx/nx) + [Livebook](https://github.com/livebook-dev/livebook)

## もっと[Elixir](https://elixir-lang.org/)のことを知りたい方へオススメの書籍 :books: 
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/) -- オーム社
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス
- [アルケミスト − 夢を旅した少年](https://www.kadokawa.co.jp/product/199999275001/) -- KADOKAWA

## ドキュメント

英語のドキュメントを読むのが**オススメ**です。
[Elixir](https://elixir-lang.org/)本体、周辺ライブラリすべて同じ形式で統一されています。
後発の強みだとおもいます。
実行例が豊富でほとんど英語は読まくても理解できます。

![スクリーンショット 2022-01-21 9.23.57.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/5dcdb24f-531f-0a01-9dd2-c38ba1659fb8.png)

[佐久間象山](https://ja.wikipedia.org/wiki/%E4%BD%90%E4%B9%85%E9%96%93%E8%B1%A1%E5%B1%B1)のつもりで読んでみましょう。
おのずとその意はわかるでしょう。


## コミュニティ
- [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slack workspaceに参加してみてください
    - マヂ、やさしい人ばっかりのコミュニティ
    - あなたの**困った**をきっと解決してくれるでしょう
- [NervesJP Slack](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA) workspaceでは、NervesやIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
- たくさんのコミュニティがあります
    - @nako_sleep_9h さん作の素敵な資料をご紹介します
    - [Elixirコミュニティ の歩き方〜国内オンライン編〜](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian) :clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:

![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)

(@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)





# <u><b>Elixirコミュニティに初めて接する方は下記がオススメです</b></u>

**Elixirコミュニティ の歩き方 －国内オンライン編－**<br>
https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian

[![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/155423/f891b7ad-d2c4-3303-915b-f831069e28a4.png)](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian)


# 直近開催予定のイベント

https://autoracex.connpass.com/event/237164/

https://fukuokaex.connpass.com/event/234883/

https://liveviewjp.connpass.com/event/234692/

https://beam-lang.connpass.com/event/237008/

https://piyopiyoex.connpass.com/event/235758/

https://fukuokaex.connpass.com/event/237074/

その他、まだ開催案内はありませんが予定されているとおもわれるイベントです。

- 2022/01/26 08:30〜 [kokura.ex ラジオ](https://fukuokaex.connpass.com/event/236657/)
- 2022/02/18 19:30〜 [NervesJP 2月吉日の回](https://nerves-jp.connpass.com/)

---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)

Elixir = 不老不死の霊薬
Alchemist = 錬金術師のこと。[Elixir](https://elixir-lang.org/)というプログラミング言語の使い手はAlchemistと尊称されます。

俺たち~~ひょうきん族~~**錬金族** !!!

<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

https://github.com/elixir-lang/elixir/pull/11039/commits/ac9947085115fd7a71a62783be2e358514ad536c

名乗るほどのものでもない名前を[Elixir](https://elixir-lang.org/)の歴史にその名を刻み込んだことがあります。
