---
title: blastengine x Elixirでメールの一斉送信を行うことを楽しむ
tags:
  - Elixir
  - 猪木
  - blastengine
  - 闘魂
  - AIではなく人間が書いてます
private: false
updated_at: '2025-11-22T12:00:15+09:00'
id: cecb955871df313149aa
organization_url_name: haw
slide: false
ignorePublish: false
---
https://qiita.com/advent-calendar/2025/blastengine

:::note info
**Qiita Advent Calendar 2025**
今年もこの季節がいよいよ始まりました :tada::tada::tada:
誰よりもこの日を待ちわびていたと自負しております。

2024年12月26日から首を長くして楽しみにしておりました。
:xmas-wreath1::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: :xmas-tree::xmas-wreath2:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:::

https://qiita.com/advent-calendar/2025

## はじめに
[エンジニアが知っておくべき メール送信・運用ノウハウ、メールの認証技術やセキュリティについて投稿しよう！ by blastengine Advent Calendar 2025](https://qiita.com/advent-calendar/2025/blastengine)応募作品です。

プログラミング言語に不老不死の霊薬が日本語訳であるElixirを使って、メール送信をします。
この記事では、一斉送信の実装内容を解説します。

## 一斉送信の前に一件送信
[/deliveries/transaction](https://blastengine.jp/documents/#tag/deliveries/operation/delivery-transaction-post) APIで行います。

Elixirでの実装例は、以前、記事を書きました。

https://qiita.com/torifukukaiou/items/0ee203ab0ad7ca47f5fc

昨年のことです。懐かしい思い出です。

## 一斉送信
一斉送信とは、同様の内容を複数の宛先に対して一斉に行うことです。

## 差し込みコード
全く同じ内容を送ることのほうがマレでしょう。本文や件名を宛先ごとにカスタマイズしたいわけです。そんな要望にも見事に応えてくださっています。これを[差し込みコード](https://blastengine.jp/documents/#tag/%E5%B7%AE%E3%81%97%E8%BE%BC%E3%81%BF%E3%82%B3%E3%83%BC%E3%83%89%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6)と呼ばれています。

![スクリーンショット 2025-11-16 9.04.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/cacf5a21-7e51-47da-bed3-a679e1886d3c.png)

APIドキュメントの図を転載させていただきます。この例では、 `__prop1__` から `__prop4__` の変数のようなものに値を設定して、宛先ごとに変更する例を示しています。

### キーの形式
キーの形式には実はルールがあります。ただしドキュメントには明記されていません。以下のエラーを出してしまいましたので推測をします。

```elixir
       body: %{
         "error_messages" => %{
           "to" => %{
             "0" => %{
               "insert_code" => %{
                 "0" => %{
                   "key" => ["name: invalid format.",
                    "the character length is not in the range 5 through 20."]
                 },
                 "1" => %{"key" => ["number: invalid format."]},
                 "2" => %{"key" => ["service: invalid format."]}
               }
             },
```

- 5文字以上、20文字以下
- `name`、`number`、`service`はだめで、前後に`__`を付けた`__name__`、`__number__`、`__service__` はOK


## 一斉送信の流れ
一斉送信の流れをざっくり説明します。

1. [配信登録・開始](https://blastengine.jp/documents/#tag/deliveries/operation/delivery-bulk-post)
1. [配信登録・更新](https://blastengine.jp/documents/#tag/deliveries/operation/delivery-bulk-update)
1. 配信登録: 完了(一斉配信: 即時 or 予約)

以下、冒頭に書いた通り、ざっくり説明します。

まず、「[配信登録・開始](https://blastengine.jp/documents/#tag/deliveries/operation/delivery-bulk-post)」でFromと件名、本文を設定します。件名と本文には差し込みコードが使えるので、宛先ごとに変えたい情報は、変数で設定しておきます。APIコールが成功すると、配信IDを払い出してもらえます。以降は、この配信IDを指定します。配信登録の更新では宛先ごとの値を設定します。最後に「配信登録: 完了」にて実際に配信を行います。即時と予約時間の指定ができます。以下のプログラム例では、即時で行っています。

## Elixirのプログラム
それではみなさまお待ちかねのElixirのプログラムコード例です。

```elixir:blastengine.exs
# You need to set BLASTENGINE_LOGIN_ID and BLASTENGINE_API_KEY environment variables
# Usage:

"""
docker run --rm -v $PWD:/app \
-e BLASTENGINE_LOGIN_ID=yourloginid -e BLASTENGINE_API_KEY=yourapikey \
hexpm/elixir:1.19.3-erlang-28.1.1-alpine-3.20.8 \
sh -c \
'cd /app && elixir blastengine.exs'
"""

Mix.install([
  {:req, "~> 0.5.16"}
])

defmodule Blastengine do
  @login_id System.get_env("BLASTENGINE_LOGIN_ID")
  @api_key System.get_env("BLASTENGINE_API_KEY")
  @bearer_token :crypto.hash(:sha256, "#{@login_id}#{@api_key}")
                |> Base.encode16(case: :lower)
                |> Base.encode64()
  @transaction_url "https://app.engn.jp/api/v1/deliveries/transaction"
  @bulk_begin_url "https://app.engn.jp/api/v1/deliveries/bulk/begin"
  @bulk_update_url "https://app.engn.jp/api/v1/deliveries/bulk/update"

  def transaction(from, to, subject, text) do
    Req.post(@transaction_url, json: make_payload(from, to, subject, text), headers: headers())
  end

  def bulk_begin(from, subject, text) do
    Req.post(@bulk_begin_url, json: make_payload(from, subject, text), headers: headers())
  end

  def bulk_update(delivery_id, to) do
    Req.put("#{@bulk_update_url}/#{delivery_id}", json: %{to: to}, headers: headers())
  end

  def bulk_commit_immediate(delivery_id) do
    make_bulk_commit_immediate_url(delivery_id)
    |> Req.patch(headers: headers())
  end

  defp headers do
    [
      {"Authorization", "Bearer #{@bearer_token}"},
      {"Content-Type", "application/json"}
    ]
  end

  defp make_payload(from, to, subject, text) do
    %{
      from: %{email: from},
      to: to,
      subject: subject,
      text_part: text
    }
  end

  defp make_payload(from, subject, text) do
    %{
      from: %{email: from},
      subject: subject,
      text_part: text
    }
  end

  defp make_bulk_commit_immediate_url(delivery_id) do
    "https://app.engn.jp/api/v1/deliveries/bulk/commit/#{delivery_id}/immediate"
  end
end

# 配信登録(トランザクション)
Blastengine.transaction(
  "Bill.gates@gatesfoundation.com",
  "sample@example.com",
  "ヘッドのハンティングです",
  "Are you awesome?"
)
|> IO.inspect()

# 一斉送信
{:ok, %{status: 201, body: %{"delivery_id" => delivery_id}}} = Blastengine.bulk_begin(
  "Bill.gates@gatesfoundation.com",
  "ヘッドのハンティングです",
"""
__name__ 様

（会員番号 __number__）

__service__ をご利用いただきありがとうございます。
"""
)
|> IO.inspect()

IO.puts delivery_id

to = [
  %{
    email: "sample@example.com",
    insert_code: [
      %{
        key: "__name__",
        value: "テスト太郎"
      },
      %{
        key: "__number__",
        value: "123456"
      },
      %{
        key: "__service__",
        value: "ブラストエンジン"
      }
    ]
  },
  %{
    email: "sample2@example.com",
    insert_code: [
      %{
        key: "__name__",
        value: "テスト次郎"
      },
      %{
        key: "__number__",
        value: "123457"
      },
      %{
        key: "__service__",
        value: "ブラストエンジン"
      }
    ]
  }
]

{:ok, %{status: 200, body: %{"delivery_id" => ^delivery_id}}} = Blastengine.bulk_update(delivery_id, to)
|> IO.inspect()

Blastengine.bulk_commit_immediate(delivery_id)
|> IO.inspect()
```

とても美しいと感じております。
動かし方は、`blastengine.exs`ファイルを作成し、冒頭のDockerコンテナで動かす例を参考に実行してください。
ちなみに、宛先（To）の`sample@example.com`と`sample2@example.com`は架空のメールアドレスです。

## さいごに
Elixirを使って、メールの一斉送信をしました。APIは、[blastengine](https://blastengine.jp/)を利用させていただきました。
この記事で一番有益なところは、差し込みコードのキーの形式を書いたことだと自負しております。自負しているだけにすぎません。そしてそのことに気づいたのは、ドキュメントの`__prop1__`ではなにがなんだかわからなくなるだろうからキー名は自由につけられるのだろうと思い、自由につけすぎたらエラーを出してしまったことから言及ができたわけで、つまりは何事も挑戦だと思っています。そういう感じ方は私の感じ方にすぎないことをくどくどと申し添えておきます。応募テーマにある「ノウハウ」だと思います。どなたかの時間を節約することになれば幸いです。

一番言いたいことは、一斉送信がElixirでできてうれしかったです。本当に楽しかったです。それがアドベントカレンダーの楽しみ方だと思いました。
