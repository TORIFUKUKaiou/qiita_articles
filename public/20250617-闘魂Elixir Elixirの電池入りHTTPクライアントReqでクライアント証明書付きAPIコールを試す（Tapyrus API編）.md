---
title: '闘魂Elixir: Elixirの電池入りHTTPクライアントReqでクライアント証明書付きAPIコールを試す（Tapyrus API編）'
tags:
  - Elixir
  - 猪木
  - req
  - Tapyrus
  - 闘魂
private: false
updated_at: '2025-06-28T11:32:22+09:00'
id: 6ea60dfc832e91074ff9
organization_url_name: haw
slide: false
ignorePublish: false
---
いよいよはじまりました！
[Qiita Tech Festa](https://qiita.com/tech-festa/2025) :tada::tada::tada: 

https://qiita.com/tech-festa/2025

---

# はじめに

[Elixir](https://elixir-lang.org/)の電池入りHTTP Clientに、[Req](https://github.com/wojtekmach/req)というライブラリがあります。
クライアント証明書を指定したAPIコールをしたくなりました。

# 人力調査

ここで解答を得ました。

https://github.com/wojtekmach/req/issues/412#issuecomment-2345455169

Thanksです。

# ソースコード例

ソースコードの例を示します。

```elixir:tapyrus_api_call.exs
Mix.install([{:req, "~> 0.5.0"}])

tapyrus_api_endpoint = System.get_env("TAPYRUS_API_ENDPOINT")
user_access_token = System.get_env("USER_ACCESS_TOKEN")

headers = [
  "Content-Type": "application/json",
  Authorization: "Bearer #{user_access_token}"
]

url = "#{tapyrus_api_endpoint}/api/v2/timestamps"

options = [
  connect_options: [transport_opts: [certfile: ~c"cert.pem"], timeout: 60_000],
  headers: headers,
  receive_timeout: 60_000
]

Req.get!(url, options) |> IO.inspect()
```



## 実行方法 Run!!!

`tapyrus_api_call.exs`ファイルと同じフォルダに`cert.pem`が置いてあることを確認して、迷わず、動かします。  
環境変数のセットも忘れずに！ `TAPYRUS_API_ENDPOINT`、`USER_ACCESS_TOKEN`。  

```bash
elixir tapyrus_api_call.exs
```

# 背景

順番が前後しますが、この記事を書いた背景です。
クライアント証明書を使うAPIの呼び出しを、[Req](https://github.com/wojtekmach/req)でしてみたかったのです。
[Tapyrus API](https://doc.api.tapyrus.chaintope.com/)を[Elixir](https://elixir-lang.org/)で使いたかったのです。

## Tapyrus とは

[Tapyrus](https://github.com/chaintope/tapyrus-core) は、[Bitcoin](https://bitcoin.org/) をベースにしたオープンソースのブロックチェーンプラットフォームです。日本の企業 [Chaintope](https://www.chaintope.com/) によって開発されており、企業や自治体での実用を想定した設計が特徴です。

### 主な特徴

- オープンソース: Bitcoin をフォークし、独自機能を追加
- ハイブリッド設計: 制御されたネットワークで運用しつつ、透明性も確保
- カスタムトークン: `OP_COLOR` による独自トークンの発行が可能

### 資料

- [Chaintope 公式サイト](https://www.chaintope.com/)
- [Tapyrus Core GitHub](https://github.com/chaintope/tapyrus-core)
- [Tapyrus Docker ドキュメント](https://github.com/chaintope/tapyrus-core/blob/master/doc/docker_image.md)

# さいごに

[Elixir](https://elixir-lang.org/)の電池入りHTTP ClientであるReqにクライアント証明書を設定してAPIコールすることができました。
あなたの[Elixir](https://elixir-lang.org/)ライフに潤いと輝きを提供できることを願ってこの記事を終えます。
