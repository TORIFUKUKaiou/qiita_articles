---
title: 環境変数を変更したときに変更後の値がElixirのアプリケーションに反映されない!? （mix clean するといいかもね、だよね）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-02-09T04:18:55+09:00'
id: bc21aad5b44fb3b95156
organization_url_name: fukuokaex
slide: false
---
**企画の知恵に勝るコストダウンはない。**

Advent Calendar 2022 38日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

:::note warn
この記事は冒頭に出したNervesアプリの例と後半のElixirアプリの例では事情が異なるので、中途半端な内容になってしまっています。
後日、内容を見直して更新します🙏🙏🙏🙏🙏
:::


# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

WiFiルータを買い替えました。
Nervesに設定したSSIDとパスフレーズが書き換わらなくてアタフタしたので書きとめておきます。

# NervesでWiFiを使うには

https://hexdocs.pm/vintage_net/cookbook.html#wifi

[ここ](https://hexdocs.pm/vintage_net/cookbook.html#wifi)に設定例が書いてあります。

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
             ssid: System.get_env("NERVES_WIFI_SSID"),
             psk: System.get_env("NERVES_WIFI_PASSPHRASE")
           }
         ]
       },
       ipv4: %{method: :dhcp}
     }}
  ]
```

こんな感じで設定をしています。
`mix firmware`で以前ビルドしたことのある[Nerves](https://www.nerves-project.org/)プロジェクトです。

# 新しいWiFiルータの値に書き換えよう:rocket::rocket::rocket:

`.zshenv`に環境変数`NERVES_WIFI_SSID`と`NERVES_WIFI_PASSPHRASE`を設定しています。
新しく買ったWiFiルータの値に設定しなおして、ターミナルを再起動して、`source ~/.zshenv`とやって、`echo $NERVES_WIFI_SSID`で、「うん、正しいね」と確認して、念には念をで`echo $NERVES_WIFI_PASSPHRASE`で正しいことも確認してあと

```
$ mix firmware
$ mix burn
```

と、バーンでmicroSDカードに焼きましたよ。
これで一丁上がり!!!
<font color="purple">$\huge{とはなりません。}$</font>
:sob::sob::sob::sob::sob::sob::sob:

結論から言うと、前回`mix firmware`したときに参照した古いWiFiルータの値がそのまま使われます。
これ、私は以前からよくありがちで、そのたびにいつも悩んでいました。
忘れるのは記事にしないから記憶に定着しないのです。

# 解決策? 回避策?

すごくダサいやり方です。
`config/target.exs`をコンパイルエラーを起こすようにします。
具体的には、環境変数を参照している箇所の2箇所の閉じカッコを消すことをしました。
そしてコンパイルエラーをわざと起こして、ご丁寧に一個づつ修正をしました。

果たして
<font color="purple">$\huge{新しいWiFiルータにつながるようになりました。}$</font>
:tada::tada::tada:

一応、これで解決しました。

# `mix clean && mix compile`でどうでしょう 

上記で**めでたしめでたし**でもいいのですが、
<font color="purple">$\huge{ダサいので}$</font>
どげんかしたいとおもいます。

ここからはふつうの[Elixir](https://elixir-lang.org/)でやってみます。

```
$ mix new hoge
```

```elixir:lib/hoge.ex
defmodule Hoge do
  @value System.get_env("AWESOME_VALUE")
  
  def value, do: @value
end
```

というソースコードを用意しておいて、おもむろに

```
$ export AWESOME_VALUE="awesome"
$ iex -S mix
```

```elixir
iex> Hoge.value
"awesome"
```

です。
Ctl+Cを2回でもおして一度止めて、今度は値を`hiroshi`に変えてやってみます。

```
$ export AWESOME_VALUE="hiroshi"
$ iex -S mix
```

果たして、

```elixir
iex> Hoge.value
"awesome"
```

です。
`hiroshi`に変わっていません。

そこで

```
$ mix clean
$ mix compile
$ iex -S mix
```

とやりますと、

```elixir
iex> Hoge.value
```
<font color="purple">$\huge{"hiroshi"}$</font>
です。

めだたく、`hiroshi`に変わりました。
:tada::tada::tada:



---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

今回は、環境変数の値を変えたつもりだけど[Elixir](https://elixir-lang.org/)のアプリケーションには反映されないなあ〜　ということを私はやりがちでして、その都度、アレレ？　となっていますので記事に残しておくことにしました。
該当箇所でコンパイルエラーを起こすか、`mix clean && mix compile`すればよいでしょう。


以上です。


---

# 付録

以下、付録です。





[Elixir](https://elixir-lang.org/)の誕生日は、2012年5月24日です。
そのため、今年の2022年5月24日は10周年を迎えます。

```elixir
iex> Date.diff(~D[2022-05-24], ~D[2022-02-07])
106
```


そうそう！
2月24日発売予定の[WEB+DB PRESS](https://gihyo.jp/magazine/wdpress)で、[Elixir](https://elixir-lang.org/)と[Phoenix](https://www.phoenixframework.org/)の特集がでますよ〜

[Elixir](https://elixir-lang.org/)、[Phoenix](https://www.phoenixframework.org/)をはじめられたばかりの方も、腕におぼえがある方も、どんなものなのかなあと様子見をきめこんでいる方も、
つまりは
<font color="purple">$\huge{全人類のみなみなさま！！！}$</font>
**お手にとって、お楽しみください!!!**

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">We, <a href="https://twitter.com/tamanugi?ref_src=twsrc%5Etfw">@tamanugi</a> <a href="https://twitter.com/torifukukaiou?ref_src=twsrc%5Etfw">@torifukukaiou</a> <a href="https://twitter.com/the_haigo?ref_src=twsrc%5Etfw">@the_haigo</a> <a href="https://twitter.com/mokichi_s12m?ref_src=twsrc%5Etfw">@mokichi_s12m</a> including me, wrote featured articles for WEB+DB PRESS Vol.127 about Elixir and Phoenix! It&#39;s being published on 24, Feb.<a href="https://t.co/UPNiVU1zG9">https://t.co/UPNiVU1zG9</a></p>&mdash; 栗林健太郎 (@kentaro) <a href="https://twitter.com/kentaro/status/1489441847130746880?ref_src=twsrc%5Etfw">February 4, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


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

## コミュニティ
- [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slack workspaceに参加してみてください
    - マヂ、やさしい人ばっかりのコミュニティ
    - あなたの**困った**をきっと解決してくれるでしょう
- [NervesJP Slack](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA) workspaceでは、NervesやIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
- たくさんのコミュニティがあります
![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)
([EDI／fukuoka.ex／kokura.ex](https://fukuokaex.connpass.com/) ＆ [LiveView JP](https://liveviewjp.connpass.com/) の @piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)



# <u><b>Elixirコミュニティに初めて接する方は下記がオススメです</b></u>

**Elixirコミュニティ の歩き方 －国内オンライン編－**<br>
https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian
[![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/155423/f891b7ad-d2c4-3303-915b-f831069e28a4.png)](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian)
([piyopiyo.ex](https://piyopiyoex.connpass.com/) ＆ [エリジョ](https://elijo.connpass.com/) の nakoさん(@kn339264) 作、素敵な資料:clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:)

# [Elixir](https://elixir-lang.org/)のイベント情報

@koga1020 さんが作成されたイベントカレンダーがあります。
[https://elixir-jp-calendar.fly.dev/](https://elixir-jp-calendar.fly.dev/)

https://elixir-jp-calendar.fly.dev/

気になるイベントにはぜひ参加してみましょう!!!

上記サイトの解説記事は[こちら](https://zenn.dev/koga1020/articles/6e67765cc53539)です。

https://zenn.dev/koga1020/articles/6e67765cc53539


---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





