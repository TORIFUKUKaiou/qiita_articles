---
title: ElixirでSlackの絵文字(emoji)を一括エクスポート
tags:
  - Elixir
  - Slack
private: false
updated_at: '2019-06-29T21:42:12+09:00'
id: 4ebd31dbc0804c3f1dd3
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- タイトルの通りです。
- Slackのワークスペースを引っ越しするというイベントがございました。
- すでに諸先輩方に書いていただいたものを[Elixir](https://elixir-lang.org/)で書いてみただけです。
    - はじめは[Ruby](https://www.ruby-lang.org/ja/)で書いてみました
        - [Ruby版はこちら](https://qiita.com/torifukukaiou/items/49b0e472844fe466a89d)
- 画像のダウンロード処理は1枚1枚丁寧にダウンロードするより一気にがーっとできるんじゃないかとおもいまして[Flow](https://hexdocs.pm/flow/Flow.html)を使ってみました
    - はやい! はやい!
    - 次の引っ越しイベントではこれを使おう
        - いや、そんなのもうないかな……

# Special Thanks
- [Slackのカスタム絵文字を全てダウンロードする](https://qiita.com/kure/items/7938d92532bb7577d8b8)
- [Slackの絵文字(emoji)を一括エクスポート＆インポートする](https://qiita.com/ne-peer/items/cbdef4f02b1bb6103e51)

# こちらでSlackのAPI(emoji.list)をお試しいただけます
- [slack api](https://api.slack.com/methods/emoji.list/test)

# 作品
```Elixir:
defmodule SlackEmoji.EmojiList do
  def download(token) do
    "https://slack.com/api/emoji.list?token=#{token}"
    |> HTTPoison.get()
    |> decode_response
    |> Poison.decode!()
    |> decode_emojis
    |> Flow.from_enumerable()
    |> Flow.reject(fn {_, url} -> String.starts_with?(url, "alias") end)
    |> Flow.partition()
    |> Flow.each(fn {key, url} ->
      File.mkdir_p("images/")

      body =
        url
        |> HTTPoison.get()
        |> decode_response

      ("images/" <> key <> "." <> extension(url))
      |> File.write(body)
    end)
    |> Enum.to_list()
  end

  def decode_response({:ok, %{body: body}}), do: body

  def decode_response(res) do
    IO.inspect(res)
    System.halt(1)
  end

  def decode_emojis(%{"emoji" => emojis}), do: emojis

  def decode_emojis(h) do
    IO.inspect(h)
    System.halt(2)
  end

  def extension(url), do: url |> String.split(".") |> Enum.at(-1)
end
```
- [ソースコード全文](https://github-elixir-slack-emoji.torifuku-kaiou.tokyo/)

# 作品どうしの処理時間比較
- 1501枚

## [Ruby版](https://qiita.com/torifukukaiou/items/49b0e472844fe466a89d)
```
$ time ruby downloader.rb 
100 %
real	9m23.978s
user	0m20.733s
sys	0m2.458s
```

## Elixir版
```
$ time ./slack_emoji --token xoxp-****

real	0m57.278s
user	0m5.763s
sys	0m1.488s
```

# 動作確認環境
```
$ elixir -v
Erlang/OTP 22 [erts-10.4.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe] [dtrace]

Elixir 1.9.0 (compiled with Erlang/OTP 22)
```
- MacBook Pro (13-inch, 2017, Two Thunderbolt 3 ports)
- macOS Mojave バージョン 10.14.5
