---
title: 'Nerves meets SORACOM Harvest '
tags:
  - Elixir
  - SORACOM
  - Nerves
  - SoracomHarvest
  - autoracex
private: false
updated_at: '2021-12-15T14:53:18+09:00'
id: 29f3ebd974edcde8abf3
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/advent-calendar/2021/nervesjp

2021/12/14(水)の回です。

:::note
2022/1/7(金) 19:30 NervesJP #22 新年LT回 開催🎍🎍🎍
:::

https://nerves-jp.connpass.com/event/234191/

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Nerves](https://www.nerves-project.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

2021/12/14(水)に、「[SORACOM UG x NervesJP #1 ~Hello, world!~](https://soracomug-tokyo.connpass.com/event/231532/)」が開催されました。
ありがとうございました。
レポートは前日の13日に書きました。
どのくらいあっているかな？

**よげんの書**

https://qiita.com/torifukukaiou/items/bfb827fd97c70e89c427

# What's [Nerves](https://www.nerves-project.org/)?

https://speakerdeck.com/takasehideki/nerveshanaudeyangunacoolnasugoiyatu-for-soracom-ug

**ナウでヤングでcoolなすごいやつ**
です。

# [Nerves](https://www.nerves-project.org/)で[SORACOM](https://soracom.jp/)さんのサービスを楽しむ方法

かんたんな順に並べます。

1. 「[インターネット経由でSORACOM Harvestにデータが入れられるようになりました。](https://blog.soracom.com/ja-jp/2018/07/04/inventory-update/)」に従ってHTTPSでデータを投げ込む
1. モバイルWiFiルータに[SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)のSIMを差し込んで、[Nerves](https://www.nerves-project.org/)アプリからはふつうのWiFi接続と同じ要領でつなぐ
1. [SORACOM Air for セルラー](https://soracom.jp/services/air/cellular/)を差し込んだドングルをつかう(Buildrootの知識と覚悟が必要)
1. [SORACOM Arc](https://soracom.jp/services/arc/)を利用する(Buildrootの知識と覚悟が必要。私にはできていません:sob:)

# 「[インターネット経由でSORACOM Harvestにデータが入れられるようになりました。](https://blog.soracom.com/ja-jp/2018/07/04/inventory-update/)」に従ってHTTPSでデータを投げ込む

をやってみます。
これは全然知りませんでした。
「[SORACOM UG x NervesJP #1 ~Hello, world!~](https://soracomug-tokyo.connpass.com/event/231532/)」にてお聞きして初めて知りました。
さっそくやってみたらあっけなくできてしまいました:rocket::rocket::rocket:
公式ドキュメントがすばらしいです！！！

https://dev.soracom.io/jp/start/inventory_harvest_with_keys/

このドキュメントの通りにやればできます。

あとは、[Nerves](https://www.nerves-project.org/)というよりは、[Elixir](https://elixir-lang.org/)ではどう書くの？　という話になります。
以下、一例をお示ししておきます。

[Elixir](https://elixir-lang.org/)は1.12 or laterを使っている前提です。

```
curl -X POST --header "x-device-secret: <シークレットキー>" -d "{\"temp\":20}" https://api.soracom.io/v1/devices/<デバイスID>/publish
```

以下、上記のコマンドを[Elixir](https://elixir-lang.org/)でどう書くかを書いております。


## 開発マシン上にてイゴかす[^1]

[^1]: 「動かす」の意。おそらく西日本の方言、たぶん。NervesJPではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^2]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg=

[^2]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。 

`iex`というコマンドでREPLが使えます。

```
$ iex
```

`IEx`が起動しますので以下のプログラムをペタっと貼り付けて実行してみてください。


```elixir
Mix.install([{:httpoison, "~> 1.8"}, {:jason, "~> 1.2"}])

device_id = "your deviceId"
url = "https://api.soracom.io/v1/devices/#{device_id}/publish"
json = %{temp: 21} |> Jason.encode!()
secret_key = "your secretKey"
headers = ["Content-Type": "application/json", "x-device-secret": secret_key]

HTTPoison.post!(url, json, headers)
```

## 素の[Nerves Livebook Firmware](https://github.com/livebook-dev/nerves_livebook)にてイゴかす[^1]

https://qiita.com/torifukukaiou/items/117cc23963b55ae3fc5d#nerves-livebook

を参考にしてセットアップしてください。
動画もあります〜

<iframe width="922" height="519" src="https://www.youtube.com/embed/-c4VJpRaIl4" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

素の[Nerves Livebook Firmware](https://github.com/livebook-dev/nerves_livebook) 公式イメージには、[Elixir](https://elixir-lang.org/)界で[Hex](https://hex.pm/)と呼ばれるライブラリをあとからインストールすることはできません。(もちろんファームウェアを自分でビルドすれば予め追加することができます)
さきほどパソコン版の例で利用した、使いやすいHTTPクライアントライブラリである[HTTPoison](https://github.com/edgurgel/httpoison)が使えません。
そこでErlangのモジュールを利用します。



```elixir
defmodule MyHttpClient do
  @device_id "your deviceId"
  @secret_key 'your secretKey'

  def post(temperature) do
    :inets.start
    :ssl.start

    url = "https://api.soracom.io/v1/devices/#{@device_id}/publish" |> String.to_charlist()
    json = Jason.encode!(%{temp: temperature}) |> String.to_charlist()
    request = {url, [{'x-device-secret', @secret_key}], 'application/json', json}

   :httpc.request(:post, request, [], [])
  end
end
```

`MyHttpClient`を定義しておき、以下のように呼び出すわけです。

```elixir
MyHttpClient.post(20)
```

一点注意点です。
`"`でくくると文字列、`'`でくくると[Charlists](https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html#charlists)となり、その意味するところが[Elixir](https://elixir-lang.org/)では全く異なります。
他の言語では`"`は式展開できて、`'`では式展開できないという違いがあるのみで、文字列であるということには変わりがないというものが多い気がします。
[Elixir](https://elixir-lang.org/)では全く異なります。
どう違うのかこの記事では説明いたしますまい。

https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html#bitstrings

どうしても気になる方は上記をご確認ください。


## 結果 :tada::tada::tada::tada::tada: 

![スクリーンショット 2021-12-15 6.14.49.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d8cb9dc2-00c4-d32a-3633-0eae78a3e2f2.png)

:tada::tada::tada::tada::tada:

てきと〜　にデータを送ってみました :rocket::rocket::rocket: 

# そもそも[Nerves](https://www.nerves-project.org/)をネットワークにつなぐのどうしたらいいのさ〜？


## 有線

1. LANケーブルで接続する


## Wi-Fi

1. [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)の場合は、https://github.com/livebook-dev/nerves_livebook#fwup を参考に`fwup`コマンドでmicroSDカードに焼く
1. 自作の[Nerves](https://www.nerves-project.org/)アプリをつくる場合[^3]は、https://github.com/nerves-networking/vintage_net/blob/main/docs/cookbook.md#wifi を参考に接続情報をあらかじめ設定しておいてファームウェアをビルドして、microSDカードに焼く

[^3]: [Nerves これだけおぼえておけばいいっす。これだけです。本当にこれだけです。これだけ覚えればいいんです。](https://twitter.com/torifukukaiou/status/1470720811325878274)

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Nerves](https://www.nerves-project.org/) meets [SORACOM Harvest](https://soracom.jp/services/harvest/)
できちゃいました:hugging::hugging::hugging:


来年のことを言うと鬼に笑われてしまいますが、2022/1/7(金) 19:30より「[NervesJP #22 新年LT回](https://nerves-jp.connpass.com/event/234191/)」会を開催します :tada::tada::tada: 


:::note
2022/1/7(金) 19:30 NervesJP #22 新年LT回 開催🎍🎍🎍
:::

https://nerves-jp.connpass.com/event/234191/
