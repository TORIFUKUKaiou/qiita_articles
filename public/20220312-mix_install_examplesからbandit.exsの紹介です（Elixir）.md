---
title: mix_install_examplesからbandit.exsの紹介です（Elixir）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-04-10T19:54:12+09:00'
id: 415afd564ae02b50260c
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**吹くからに秋の草木のしをるればむべ山風を嵐と言ふらむ**

Advent Calendar 2022 71日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2)のサンプル集である[mix_install_examples](https://github.com/wojtekmach/mix_install_examples/)から[bandit](https://github.com/mtrudel/bandit)を紹介します。



# What's [Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2) ?

[Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2)は、[Elixir](https://elixir-lang.org/) 1.12から追加されました。
[Elixir](https://elixir-lang.org/)でライブラリ(Hex)を追加するのは、1.11までは`mix new`でプロジェクトを作らないといけないなど、ひと手間必要でした。
[Mix.install/2](https://hexdocs.pm/mix/1.13/Mix.html#install/2)を使うことで、ちょっとした1ファイルで収まるようなスクリプトを書く際に`.exs`のみで完結できるようになりました。

## 具体例

具体例です。
私がよく使ういつものサンプルです。

[Qiita API](https://qiita.com/api/v2/docs)を使わせていただいて、`Elixir`タグがついた最新の記事を20件取得しています

```elixir
Mix.install [{:req, "~> 0.2.1"}]

"https://qiita.com/api/v2/items?query=tag:Elixir"
|> URI.encode()
|> Req.get!(finch_options: [pool_timeout: 50000, receive_timeout: 50000])
|> Map.get(:body)
|> Enum.map(& Map.take(&1, ["title", "url"]))

```

Qiitaさん、いつもありがとうございます!!!

---

# [bandit.exs](https://github.com/wojtekmach/mix_install_examples/blob/main/bandit.exs)

おもしろそうなサンプルってことで、今日は[bandit](https://github.com/mtrudel/bandit)を楽しんでみます。



## What's [bandit](https://github.com/mtrudel/bandit) ?

> Bandit is an HTTP server for Plug apps.

作者によるElixirConfの発表ビデオが公開されています。

<iframe width="988" height="556" src="https://www.youtube.com/embed/ZLjWyanLHuk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


## Run

それでは、[bandit.exs](https://github.com/wojtekmach/mix_install_examples/blob/main/bandit.exs)を動かしてみます。

https://github.com/wojtekmach/mix_install_examples/blob/main/bandit.exs

以下、そのまま掲載します。

```elixir:bandit.exs
Mix.install([
  {:bandit, ">= 0.0.0"}
])

defmodule Router do
  use Plug.Router
  plug(Plug.Logger)
  plug(:match)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello, World!")
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end

bandit = {Bandit, plug: Router, scheme: :http, port: 4000}
require Logger
Logger.info("starting #{inspect(bandit)}")
{:ok, _} = Supervisor.start_link([bandit], strategy: :one_for_one)

# unless running from IEx, sleep idenfinitely so we can serve requests
unless IEx.started?() do
  Process.sleep(:infinity)
end
```


## 実行

```shell
git clone https://github.com/wojtekmach/mix_install_examples.git
cd mix_install_examples
elixir bandit.exs
```

## 結果

ブラウザで、 http://127.0.0.1:4000/ にアクセスしてみてください。
`Hello, World!`と表示されます。

![スクリーンショット 2022-03-12 23.40.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7098aea5-a7a5-9988-7a86-0a7f3c61fb2a.png)



ブラウザで、 http://127.0.0.1:4000/bad にアクセスしてみてください。
`not found`と表示されます。
レスポンスは、404を返しています。

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

今回は、[mix_install_examples](https://github.com/wojtekmach/mix_install_examples/)の中から、[bandit.exs](https://github.com/wojtekmach/mix_install_examples/blob/main/bandit.exs)をご紹介をしました。
[bandit](https://github.com/mtrudel/bandit)を利用するとLINEアプリやSlackアプリを簡単に作れます。

https://qiita.com/torifukukaiou/items/05255dc857ddd5a695ee

開発を楽しめます。



今後も他のサンプルをご紹介していきます。
また、シンプルでいい例をおもいついたら、プルリクを送ってみるのはいいかもしれません。
私は、おもいついた場合には、プルリクを送ってみる気でいます :rocket::rocket::rocket: 


以上です。





---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





