---
title: Hex探訪 HTTPoison
tags:
  - Elixir
  - autoracex
private: false
updated_at: '2022-01-12T22:45:38+09:00'
id: 9650c148bfb83e18c689
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**ときは今 あめが下しる 五月かな**

Advent Calendar 2022 12日目[^1]の記事です。
I'm ready for 12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I'm looking forward to  12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

<font color="purple">$\huge{Enjoy\ Elixir🚀🚀🚀}$</font>

今回は、[HTTPoison](https://github.com/edgurgel/httpoison)を探訪してみたいとおもいます。


この記事は、2022/01/12(水) 開催の「[SORACOM UG 夜のもくもく会 #26](https://soracomug-tokyo.connpass.com/event/235597/)」の成果です。


## [Hex](https://hex.pm/)探訪とは?

[Hex](https://hex.pm/)を探訪するんです。

まずは[Hex](https://hex.pm/)を説明します。

「[Hex](https://hex.pm/)とは、[Elixir](https://elixir-lang.org/)のライブラリの総称です」とドヤ顔で書きました。
ちょっと待てよ、それって本当なのかなあと定義を読みに行きました。
間違いじゃないけど、[Elixir](https://elixir-lang.org/)に限定するのは違うようです。

> Hex is a package manager for the BEAM ecosystem, any language that compiles to run on the BEAM VM, such as Elixir and Erlang, can be used to build Hex packages.

https://hex.pm/about

記事を書くっていうのはこうやって自分の知識のあやふやなところと、否応無しに向き合わざるを得ないわけです。
捉え方は人それぞれだとおもいますが、私は自分の知識がアップデートされることに喜びを感じます:rocket:
そして書いたことは、一切合財忘れてしまうのです。
<font color="purple">$\huge{Qiitaは私の外部記憶装置です。}$</font>
ありがとうございます!!!

話を「探訪」に戻します。
どこかに知らないところを訪れて、美しい景色をみたり、美味しいものを食べたりして、魅了されたその土地をさらに深く探検する ーー そんなイメージでよく使う[Hex](https://hex.pm/)を奥深くまで味わってみたいとおもっています。
ですから、[Hex](https://hex.pm/)の使い方は説明しませんし、網羅的な内容とはなっておりません。

風の吹くまま気の向くまま、筆を進めてみます。
どこに終着するのかは自分自身でもわかりません。

この記事が直接的に誰かの役に立つとはおもっていません。
けれども視点なり、なにかsomethingを感じてもらえる人がいるとおもいます。
格好つけて言うと、この記事が**バタフライエフェクト[^2]**の起点となる可能性はゼロではないとおもっています。

[^2]: https://ja.wikipedia.org/wiki/%E3%83%90%E3%82%BF%E3%83%95%E3%83%A9%E3%82%A4%E5%8A%B9%E6%9E%9C

# [SORACOM](https://soracom.jp/)さんとこの記事はどう関係するの？

たとえば、[SORACOM Harvest](https://soracom.jp/services/harvest/)にHTTP POSTする際に[HTTPoison](https://github.com/edgurgel/httpoison)を使います。

以前、[SORACOM Harvest](https://soracom.jp/services/harvest/)にHTTP POSTする記事を書いたなあ〜　とおもって、探してみました。

https://qiita.com/torifukukaiou/items/29f3ebd974edcde8abf3

すばらしい！ あった:rocket: あった:rocket:
[HTTPoison.post/4](https://hexdocs.pm/httpoison/HTTPoison.html#post/4)を使って、[SORACOM Harvest](https://soracom.jp/services/harvest/)にデータ送信しているところだけここに転記しておきます。

```elixir
Mix.install([{:httpoison, "~> 1.8"}, {:jason, "~> 1.2"}])

device_id = "your deviceId"
url = "https://api.soracom.io/v1/devices/#{device_id}/publish"
json = %{temp: 21} |> Jason.encode!()
secret_key = "your secretKey"
headers = ["Content-Type": "application/json", "x-device-secret": secret_key]

HTTPoison.post(url, json, headers)
```

ちゃんといまでもイゴく[^3]ことを確認しました!!!

- elixir          1.13.1-otp-24 
- erlang          24.2

[^3]: 「動く」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^4]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg=

[^4]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。


# いよいよ探訪です!

今日は、[Erlang](https://www.erlang.org/)がでてきたら終わります。
だって、怖え〜んだもん。[Erlang](https://www.erlang.org/)は漢です。
ラオウですよ。ラオウ。

[HTTPoison.post/4](https://hexdocs.pm/httpoison/HTTPoison.html#post/4)関数の実装を[Erlang](https://www.erlang.org/)がでてくるまで読み解いていきます。

GitHubのリンクを貼っておきます。
上から順にポチポチ押してみてください。
私と同じ体験、探検ができます。

https://github.com/edgurgel/httpoison/blob/791f1666d982e82b643ce01a4ec6eff54d19ce1a/lib/httpoison.ex#L134-L156

https://github.com/edgurgel/httpoison/blob/791f1666d982e82b643ce01a4ec6eff54d19ce1a/lib/httpoison/base.ex#L513-L514

https://github.com/edgurgel/httpoison/blob/791f1666d982e82b643ce01a4ec6eff54d19ce1a/lib/httpoison/base.ex#L404-L412

https://github.com/edgurgel/httpoison/blob/791f1666d982e82b643ce01a4ec6eff54d19ce1a/lib/httpoison/base.ex#L331-L362

https://github.com/edgurgel/httpoison/blob/791f1666d982e82b643ce01a4ec6eff54d19ce1a/lib/httpoison/base.ex#L331-L362

https://github.com/edgurgel/httpoison/blob/791f1666d982e82b643ce01a4ec6eff54d19ce1a/lib/httpoison/base.ex#L896-L915

[hackney - HTTP client library in Erlang](https://github.com/benoitc/hackney)までたどり着きました!!!

へ〜、[HTTPoison](https://github.com/edgurgel/httpoison)って[hackney - HTTP client library in Erlang](https://github.com/benoitc/hackney)という[Erlang](https://www.erlang.org/)のライブラリをラップしていたものだったのね。

> HTTPoison uses hackney to execute HTTP requests instead of ibrowse. I like hackney 👍

ばっちり[READMEのTOP](https://github.com/edgurgel/httpoison)にすでに書いてあるね!!!

ポチポチ上のリンクを踏んでみてください。
[Elixir](https://elixir-lang.org/)の書き方の新たな知見を得られることもあるでしょう。

楽しんでください:rocket::rocket::rocket:



# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
Enjoy [Nerves](https://www.nerves-project.org/):bangbang::bangbang::bangbang:

<font color="purple">$\huge{I\ like\ HTTPoison\ 👍}$</font>
 


2022年に流行る技術予想 ーー それは、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)です:rocket::rocket::rocket:



---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)
