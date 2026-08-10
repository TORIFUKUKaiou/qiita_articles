---
title: さくらのAI Engineの「/v1/models」を使ってモデル一覧を取得する
tags:
  - さくらのAI
  - Python
  - OpenAI
  - Anthropic
  - 闘魂
private: false
updated_at: '2026-08-09T20:18:10+09:00'
id: 018f08ee99a0f332741c
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: bd14d28b53326d318fec
agreed_posting_campaign_term: true
---
## はじめに

この記事は、Qiita公式キャンペーン「[OpenAI・Anthropic互換APIを無料で使おう！『さくらのAI Engine』3,000リクエスト使い切りチャレンジ](https://qiita.com/official-events/bd14d28b53326d318fec)」への応募記事です。

[さくらのAI Engine](https://ai.sakura.ad.jp/sakura-ai/ai-engine/) で利用できるモデル一覧を取得するため、`GET /v1/models` を試しました。

参照した [Inference API](https://manual.sakura.ad.jp/api/cloud/portal/?api=ai-engine-inference-api) と [RAG API](https://manual.sakura.ad.jp/api/cloud/portal/?api=ai-engine-rag-api) のマニュアルには、`/v1/models` の記載を見つけられませんでした。

しかし、エンドポイントへ直接リクエストすると、モデル一覧を取得できます。curlだけでなく、OpenAI SDKとAnthropic SDKからも取得できました。

## curlで取得する

APIトークンを環境変数に設定します。

```bash
export SAKURA_AI_ENGINE_ACCOUNT_TOKEN="発行したアカウントトークン"
```

あとは次のcurlを実行します。

```bash
curl --location 'https://api.ai.sakura.ad.jp/v1/models' \
  --header 'Accept: application/json' \
  --header "Authorization: Bearer $SAKURA_AI_ENGINE_ACCOUNT_TOKEN"
```

レスポンスは次のような形式です。

```json
{
  "object": "list",
  "data": [
    {
      "id": "gpt-oss-120b",
      "created": 1755765369,
      "object": "model",
      "owned_by": "sakura"
    }
  ]
}
```

`data` にモデル情報が配列で返ります。モデルの提供状況は変わり得るため、モデルIDを確認したい場合に便利です。

### Anthropic用のヘッダーを付ける

`anthropic-version` ヘッダーを付けても取得できます。

```bash
curl --location 'https://api.ai.sakura.ad.jp/v1/models' \
  --header 'Accept: application/json' \
  --header "Authorization: Bearer $SAKURA_AI_ENGINE_ACCOUNT_TOKEN" \
  --header 'anthropic-version: 2023-06-01'
```

今回、ヘッダーなしとヘッダーありで比較した結果は次のとおりでした。

| 比較項目 | 結果 |
|---|---|
| モデル件数 | どちらも12件 |
| モデルIDの集合 | 一致 |
| 各レコードの内容 | 順序を無視すると一致 |
| `data` の配列順 | 異なる |

つまり、今回の取得では、**レスポンスのモデル一覧は同じですが、並び順が変わりました**。

## SDKから取得する

今回使用したSDKのバージョンは、以下の通りです。

- `openai==2.52.0`
- `anthropic==0.120.2`

### OpenAI SDK

OpenAI SDKでは、`base_url` に `/v1` を含めます。

```python
import os

from openai import OpenAI


client = OpenAI(
    api_key=os.environ["SAKURA_AI_ENGINE_ACCOUNT_TOKEN"],
    base_url="https://api.ai.sakura.ad.jp/v1",
)

models = client.models.list()
for model in models.data:
    print(model.id)
```

### Anthropic SDK

Anthropic SDKでは、`base_url` に `/v1` を含めません。Bearerトークンを使うため、`auth_token` にトークンを渡します。

```python
import os

import anthropic


client = anthropic.Anthropic(
    auth_token=os.environ["SAKURA_AI_ENGINE_ACCOUNT_TOKEN"],
    base_url="https://api.ai.sakura.ad.jp",
)

models = client.models.list()
for model in models.data:
    print(model.id)
```

こちらもモデル一覧を取得できました。今回の実行結果をまとめると、次のとおりです。

| 呼び出し方法 | 件数 | モデルID | 順序 |
|---|---:|---|---|
| curl（ヘッダーなし） | 12 | 同じ | 変わる |
| curl（`anthropic-version` あり） | 12 | 同じ | 変わる |
| OpenAI SDK | 12 | 同じ | 変わる |
| Anthropic SDK | 12 | 同じ | 変わる |

`openai==2.52.0` の `model_dump()` では、モデル1件のフィールドは `id`、`created`、`object`、`owned_by` でした。`anthropic==0.120.2` では、これらに加えて `capabilities`、`created_at`、`display_name`、`max_input_tokens`、`max_tokens`、`type` が含まれ、今回取得した12件では追加フィールドの値がすべて `null` でした。そのため、SDKのモデルオブジェクト全体を比較すると差が出ますが、モデルIDの集合は同じです。

## まとめ

さくらのAI Engineでは、マニュアルに掲載されていない `GET /v1/models` を直接呼び出して、利用可能なモデル一覧を取得できます。

- curlで取得できる
- `anthropic-version` ヘッダーを付けても取得できる
- OpenAI SDK、Anthropic SDKの `models.list()` でも取得できる
- 今回はどの方法でも同じ12件のモデルIDを取得できた
- ただし、`data` の並び順は変わる

## 参考リンク

- [さくらのAI Engine](https://ai.sakura.ad.jp/sakura-ai/ai-engine/)
- [AI Engine Inference API](https://manual.sakura.ad.jp/api/cloud/portal/?api=ai-engine-inference-api)
- [AI Engine RAG API](https://manual.sakura.ad.jp/api/cloud/portal/?api=ai-engine-rag-api)
- [Qiita公式キャンペーン](https://qiita.com/official-events/bd14d28b53326d318fec)
