---
title: A3RTさんのTalk APIをElixirで使ってみます
tags:
  - Elixir
private: false
updated_at: '2021-12-24T07:01:43+09:00'
id: 6e9a02e7a20d3d43b4a2
organization_url_name: null
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/advent-calendar/2021/nagatutu

2021/12/24(金)の回です。

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[A3RT（アート）](https://a3rt.recruit.co.jp/about/)さんの[Talk API](https://a3rt.recruit.co.jp/product/talkAPI/)の[Elixir](https://elixir-lang.org/)でのサンプル実装を書きます。

# What is [Talk API](https://a3rt.recruit.co.jp/product/talkAPI/) ?

> Talk APIはChatbotを作成するためのAPIです。 Recurrent Neural Network(LSTM)を用いた入力文からの応答文生成による日常会話応答機能を提供します。 Talk APIを活用したChatbotによって様々なアプリケーション上でユーザとの対話を自動化し、 どのようなタイミングにおいても即座にユーザからの問いかけに対して応答することができます。

(https://a3rt.recruit.co.jp/product/talkAPI/)

# サンプルコード

```elixir:small_talk_api.exs
Mix.install([{:jason, "~> 1.2"}, {:httpoison, "~> 1.8"}])

defmodule Recruit.A3RT.Smalltalk do
  def call(query) do
    %{body: body, status_code: 200} =
      HTTPoison.post!(
        "https://api.a3rt.recruit.co.jp/talk/v1/smalltalk",
        {:form, [apikey: recruit_a3rt_smalltalk_apikey(), query: query]}
      )

    Jason.decode!(body)
    |> IO.inspect()
    |> handle_response()
  end

  defp handle_response(%{"status" => 0} = response) do
    response
    |> Map.get("results")
    |> Enum.map(fn r -> Map.get(r, "reply", "") end)
    |> Enum.join(" ")
  end

  defp handle_response(_response), do: :error

  defp recruit_a3rt_smalltalk_apikey, do: System.get_env("RECRUIT_A3RT_SMALLTALK_APIKEY")
end
```

# イゴかし方[^1]

[^1]: 「動かし方」の意。おそらく西日本の方言、たぶん。[NervesJP](https://nerves-jp.connpass.com/)ではおなじみ。少し古いオートレースの映像ですが、実況アナウンサーが「針[^2]イゴきます」とはっきり言っています。https://autorace.jp/netstadium/SearchMovie/Movie/iizuka?date=2017-01-04&p=5&race_number=11&pg= 

[^2]: 大時計の針のこと。針がイゴいてある地点まで到達すると選手はスタートを切って良い発走の合図。針がイゴきはじめると(おそらく)選手は緊張するし、スタートはその後のレース展開に大きく影響するので、車券を握りしめている観客たちがもっとも緊張する瞬間であるため、先の尖った鋭いものを連想させる針は緊張の暗喩としても言い得て妙。

## APIキー

https://a3rt.recruit.co.jp/product/talkAPI/

にてAPIキーを取得してください。

### 環境変数の設定

#### macOSの場合

```
$ export RECRUIT_A3RT_SMALLTALK_APIKEY="あなたの API KEYは、メールで届く"
```

#### Windowsの場合

Windowsの場合は以下を参考にしてください。

https://superuser.com/questions/212150/how-to-set-env-variable-in-windows-cmd-line/212153#212153


## Run

[Elixir](https://elixir-lang.org/)は1.12 or laterをインストールしておいてください。

```bash
$ iex
```

そうするとIExが立ち上がります。

```elixir
iex> c "small_talk_api.exs"

iex> Recruit.A3RT.Smalltalk.call("Hello")
```

### 結果 :tada::tada::tada:

```elixir
%{
  "message" => "ok",
  "results" => [
    %{"perplexity" => 4.650666957874292, "reply" => "スイスイ?"}
  ],
  "status" => 0
}
"スイスイ?"
```


<font color="purple">$\huge{Thanks\ a\ lot!!!}$</font>

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

[Talk API](https://a3rt.recruit.co.jp/product/talkAPI/)の[Elixir](https://elixir-lang.org/)でのサンプル実装を書きました。

Enjoy [Elixir](https://elixir-lang.org/):rocket::rocket::rocket:

---

# おまけ

[Elixir](https://elixir-lang.org/)を始めてみよう！　とおもった、あなたに参考情報(クリスマス🎄プレゼント)を贈ります。:gift::gift::gift:
**思い立ったが吉日です!!!**

## オススメの書籍 :books: 
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/) -- オーム社
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス
- [アルケミスト 夢を旅した少年](https://www.kadokawa.co.jp/product/199999275001/) -- 角川文庫

## Webアプリケーションを楽しむなら
- [Phoenix](https://www.phoenixframework.org/)

## IoTを楽しむなら
- [Nerves](https://www.nerves-project.org/)

## AIを楽しむなら
- [Nx](https://github.com/elixir-nx/nx) + [Livebook](https://github.com/livebook-dev/livebook)

## コミュニティ
-  [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slack workspaceに参加してみてください
    - マヂ、やさしい人ばっかりのコミュニティ
    - あなたの**困った**をきっと解決してくれるでしょう
- [NervesJP](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA) Slack workspaceでは、[Nerves](https://www.nerves-project.org/)やIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
- たくさんのコミュニティがあります
    - @kn339264 さん作の素敵な資料をご紹介します
    - [Elixirコミュニティ の歩き方〜国内オンライン編〜](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian) :clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:

![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)
@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
