---
title: "SORACOM Harvest x Req(Elixirのチョ〜新星 HTTP Client\U0001F680)"
tags:
  - Elixir
  - SORACOM
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-08-17T20:25:52+09:00'
id: ae64a1d9cb0a9a727821
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**心しらぬ 人は何とも 言はばいへ 身をも惜まじ 名をも惜まじ**

Advent Calendar 2022 26日目[^1]の記事です。
I'm ready for 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I can't wait for 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

2022/01/26(水)は

https://soracomug-tokyo.connpass.com/event/237086/

に参加しました。

SORACOM Harvest x [Req](https://github.com/wojtekmach/req)
をやってみます。

https://users.soracom.io/ja-jp/docs/inventory/harvest/

こちらの公式ページをよくみて、curlで行っていることを[Req](https://github.com/wojtekmach/req)で置き換えてやってみます。

# 以前HTTPoisonで試してみたことはあります

https://qiita.com/torifukukaiou/items/29f3ebd974edcde8abf3


# SORACOM Harvest x [Req](https://github.com/wojtekmach/req)


<font color="purple">$\huge{できました}$</font>:tada::tada::tada:


```elixir
Mix.install([{:req, "~> 0.2.1"}])

device_id = "your deviceId"
secret_key = "your secretKey"

Req.post!(
  "https://api.soracom.io/v1/devices/#{device_id}/publish",
  {:json, %{temp: 20}},
  headers: ["x-device-secret": secret_key]
)
```

同じコードは、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)でも動きます:rocket::rocket::rocket:

## [Harvest データの確認](https://users.soracom.io/ja-jp/docs/inventory/harvest/#harvest-%e3%83%87%e3%83%bc%e3%82%bf%e3%81%ae%e7%a2%ba%e8%aa%8d)

[Elixir](https://elixir-lang.org/)はあんまり関係ありませんが、データを送ればあとは、SORACOMさんのおかげで、[Harvest データの確認](https://users.soracom.io/ja-jp/docs/inventory/harvest/#harvest-%e3%83%87%e3%83%bc%e3%82%bf%e3%81%ae%e7%a2%ba%e8%aa%8d)ができました :tada::tada::tada:

![スクリーンショット 2022-01-26 21.49.37.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/5f6733dc-7b24-77b6-d317-b87053c1dcb1.png)



# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

SORACOM Harvest x [Req](https://github.com/wojtekmach/req)できました。

2022年に流行る技術予想 ーー それは、[Elixir](https://elixir-lang.org/)、[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)、[Livebook](https://github.com/livebook-dev/livebook)、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)です:rocket::rocket::rocket:

[Elixir](https://elixir-lang.org/)の誕生日は、2012年5月24日です。
そのため、今年の2022年5月24日は10周年を迎えます。

```elixir
iex> Date.diff(~D[2022-05-24], ~D[2022-01-26])
118
```


そうそう！
2月24日発売予定の[WEB+DB PRESS](https://gihyo.jp/magazine/wdpress)で、[Elixir](https://elixir-lang.org/)と[Phoenix](https://www.phoenixframework.org/)の特集がでますよ〜

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">次号のWEB+DB PRESSでElixirとPhoenix特集が出ます！お楽しみに！！1 <a href="https://t.co/d4hIfhIfZ1">pic.twitter.com/d4hIfhIfZ1</a></p>&mdash; 栗林健太郎 (@kentaro) <a href="https://twitter.com/kentaro/status/1483308857019760640?ref_src=twsrc%5Etfw">January 18, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>


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
([piyopiyo.ex](https://piyopiyoex.connpass.com/) ＆ [エリジョ](https://elijo.connpass.com/) の nakoさん(@nako_sleep_9h) 作、素敵な資料:clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:)



---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





