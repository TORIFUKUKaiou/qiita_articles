---
title: delika API Version 1 をcurlで呼び出してみる
tags:
  - delika
  - 40代駆け出しエンジニア
  - AdventCalendar2022
  - Qiitadelika
private: false
updated_at: '2022-03-22T22:32:22+09:00'
id: ea8b91d935f03a51b2cf
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/official-events/30be12dd14c0aad2c1c2

**有明のつれなく見えし別れより暁ばかりうきものはなし**

Advent Calendar 2022 80日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

「[データに関する記事を書こう！](https://qiita.com/official-events/30be12dd14c0aad2c1c2)」と銘打たれたイベントが開催中です。

この記事は、 **テーマ１　『delikaを使った記事を書こう！』** の参加記事です。
[delika API Version 1](https://docs.delika.io/api/v1/)を使用してみます。

自分自身で書きました「[delikaのSign upをして、ダミーデータQiitadelikaDummyでクエリ実行する](https://qiita.com/torifukukaiou/items/8d59f139eb60ce881e8b)」の後続記事です。

https://qiita.com/torifukukaiou/items/8d59f139eb60ce881e8b

# 前提

[delika](https://delika.io/)のSign upを済ませておいてください。

Sign upがまだの方は、右上の`Sign up`ボタンからSign upをしてください。
「[さっそくつかってみよう ーー Sign up](https://qiita.com/torifukukaiou/items/8d59f139eb60ce881e8b#%E3%81%95%E3%81%A3%E3%81%9D%E3%81%8F%E3%81%A4%E3%81%8B%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%88%E3%81%86-%E3%83%BC%E3%83%BC-sign-up)」が参考になるかもしれません。


# [delika API Version 1](https://docs.delika.io/api/v1/)

[delika API Version 1](https://docs.delika.io/api/v1/)の公式ページは[こちら](https://docs.delika.io/api/v1/)です。

https://docs.delika.io/api/v1/

この記事ではTokenを入手して、Tokenが必要なAPIの呼び出しをします。
curlを使います。

# Token

APIを利用するには、HTTPヘッダに適切なTokenを設定する必要があります。
Tokenを正しく設定できていないと、 `{"Status":{"Code":401,"Message":"apim auth failed"}}` とAPI呼び出しが失敗します。

それではTokenを得てみましょう


## Refresh token を得る

https://docs.delika.io/api/v1/get-auth.html

Visit: https://api.delika.io/v1/auth
ブラウザでアクセスしてください。
Sign inすると、45日間有効なRefresh tokenを得ることができます。


## POST /v1/auth/token

https://docs.delika.io/api/v1/post-auth-token.html

さきほど得た`Refresh token`をパラメータに指定します。

```
curl -XPOST  \
-H "Content-Type: application/json" \
-d '{"RefreshToken":"Refresh token"} \
https://api.delika.io/v1/auth/token
```

# GET /v1/account/{AccountName}/datasets

`GET /v1/account/{AccountName}/datasets`をコールしてみます。
AccountNameには例えば以下を指定します。

AccountName = qiita_delika_article_campaign
AccountName = connecto-data

```
curl \
-H "Authorization: bearer <YOUR_TOKEN>" \
https://api.delika.io/v1/account/connecto-data/datasets
```

ステータスコード200の応答が返ってきました :tada::tada::tada: 

```json
{"Status":{"Code":200,"Message":"Found 2 datasets."},
"Data":{"DatasetCount":2,
  "DatasetList":[{"AccountName":"connecto-data","DatasetName":"ds-skills"},
                 {"AccountName":"connecto-data","DatasetName":"survey"}]}}
```

# ノウハウ 

以下の応答が返ってくることがあります。

```json
{"Status":{"Code":401,"Message":"apim auth failed"}}
```

HTTPヘッダーに`"Authorization: bearer <YOUR_TOKEN>"`を入れましょう。





---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

この記事では、 [delika API Version 1](https://docs.delika.io/api/v1/)をcurlでコールする方法を示しました。
`Access Token`をどのように得るかがポイントだと考えます。
[ドキュメント](https://docs.delika.io/api/v1/)に書いてある通りと言えば、その通りです。

`Access Token`は次の２ステップで取得します。

1. https://docs.delika.io/api/v1/get-auth.html にブラウザでアクセスしてSign inして、`Refresh token`を得る
1. 得た`Refresh token`を使って、 `POST /v1/auth/token` を行う（詳細は記事本文をご参照ください）

[delika](https://delika.io/)を楽しんでいきたいとおもいます！


以上です。


---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





