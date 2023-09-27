---
title: Slackのカスタム絵文字の数を数える(ElixirとRubyを使って)
tags:
  - Ruby
  - Elixir
  - Slack
private: false
updated_at: '2020-04-01T07:55:18+09:00'
id: ab208b7a126ec3e9c96a
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [はてな社内のSlackには、カスタム絵文字が2028個！ 連携アプリ46個で、飲み会ダッシュボタンも爆誕！](https://internet.watch.impress.co.jp/docs/column/slack_info/1235656.html)
- あなたが参加しているワークスペースには何個のカスタム絵文字がありますでしょうか?

# カスタム絵文字数

- 1,667個ありました

# カウント方法
- SlackのAPI [emoji.list](https://api.slack.com/methods/emoji.list)を使います
- tokenが必要になります
    - トークンの取得方法は、[Slack API 推奨Tokenについて](https://qiita.com/ykhirao/items/3b19ee6a1458cfb4ba21) の記事が詳しいです
    - ありがとうございます :bow:
    - 必要なスコープは、`emoji:read`が必要になります
- 以下、[Ruby](https://www.ruby-lang.org/ja/)と[Elixir](https://elixir-lang.org/)を使って書いてみます

# Ruby
```Ruby:slack_emoji_list_count.rb
require 'open-uri'
require 'json'

TOKEN = "xoxp-...secret..."

body = URI.open("https://slack.com/api/emoji.list?token=#{TOKEN}", &:read)
puts JSON.parse(body)["emoji"].reject { |k, v| v.start_with?('alias:') }.size()
```

## 実行結果
```
% ruby -v
ruby 2.7.0p0 (2019-12-25 revision 647ee6f091) [x86_64-darwin19]
% ruby slack_emoji_list_count.rb
1667
```

# Elixir
```elixir:lib/sandbox/slack_emoji_list.ex
defmodule Sandbox.SlackEmojiList do
  @token "xoxp-...secret..."

  def run do
    url()
    |> HTTPoison.get!()
    |> Map.get(:body)
    |> Jason.decode!()
    |> Map.get("emoji")
    |> Enum.reject(fn {_key, value} -> String.starts_with?(value, "alias:") end)
    |> Enum.count()
    |> IO.puts()
  end

  defp url do
    "https://slack.com/api/emoji.list?token=#{@token}"
  end
end
```

以下、Elixirの環境が整っていない方向けに説明をします。

## 1. インストール
- [Installing Elixir](https://elixir-lang.org/install.html)
- macOSの方は、[asdf-vm](https://asdf-vm.com/#/)がオススメです
    - とりあえず試したい場合には[Homebrew](https://brew.sh/index_ja)を使って、`brew install elixir`でのインストールでもよいとおもいます

## 2. プロジェクト作成
```
% mix new sandbox
% cd sandbox
```

## 3. 依存ライブラリを追加
- HTTPクライアントの[HTTPoison](https://hex.pm/packages/httpoison)
- _A blazing fast JSON parser and generator in pure Elixir_の[Jason](https://hex.pm/packages/jason)をmix.exsに追加します
    - (意訳) 純なElixirで書かれた爆速で[Hot! Hot!](https://www.nicovideo.jp/watch/sm15878681)なJSON パーサー、ジェネレーター

```elixir:mix.exs
  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.1"}
    ]
  end
```

- 依存ライブラリのダウンロード
```
% mix deps.get
```

## 4. ソースコードを追加
- lib/sandbox/slack_emoji_list.ex (前述)を作る

## 5. 実行

```
% iex -S mix
Erlang/OTP 22 [erts-10.5.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Interactive Elixir (1.10.0) - press Ctrl+C to exit (type h() ENTER for help)
iex> Sandbox.SlackEmojiList.run
1667
:ok
```

ありがとうございます:rocket:

# おまけ
- 同僚に、https://${workspace}.slack.com/customize/emoji にアクセスしたときに表示される画面に数がてているとおしえてもらいました
![2c471a8a-02a9-431a-8c44-eb05f56bfa92.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2c13809c-f17a-0c92-24d8-da0bbb8f226f.png)

- ただ上の結果と1個ずれています
- 少し調査したところ、画像URLの先頭からの文字列が２種類あることがわかりました

```Elixir
%{"https://a.slack-edge.com/" => 1, "https://emoji.slack-edge.com/" => 1666}
```
- "https://a.slack-edge.com/" で始まるほうが無効なカスタム絵文字になっているのかなとおもいましたが、ふつうに使えていました
- これが使えなければ、ああ、これがだめなやつでカウントされていないのだなと納得したわけですが、そうではありませんでしたので謎だけが残りました

