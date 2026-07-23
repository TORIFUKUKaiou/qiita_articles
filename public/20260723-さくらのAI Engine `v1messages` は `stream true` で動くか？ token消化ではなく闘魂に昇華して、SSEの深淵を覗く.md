---
title: >-
  さくらのAI Engine `/v1/messages` は `stream: true` で動くか？
  token消化ではなく闘魂に昇華して、SSEの深淵を覗く
tags:
  - さくらのAI
  - さくらインターネット
  - 闘魂
  - 猪木
  - AIではなく人間が書いてます
private: false
updated_at: '2026-07-23T08:20:34+09:00'
id: b090f60b13c8dcdfce94
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: bd14d28b53326d318fec
agreed_posting_campaign_term: true
---
## はじめに

[「さくらのAI Engine 3,000リクエスト使い切りチャレンジ」](https://qiita.com/official-events/bd14d28b53326d318fec)の一環で、Anthropic互換エンドポイント `/v1/messages` の `stream: true` を試しました。

HTTPレスポンスとJSONは妥当に見えるのに、Anthropic公式Python SDKの `messages.stream()` では何も出力されません。

原因はJSONではなく、SSE（Server-Sent Events）の `event:` 行がないことでした。curl、httpx、SDKのソースコードの順に確認します。

:::note info
**検証時点について**

2026年7月23日の応答とAnthropic Python SDK v0.116.0が対象です。今後、実装が変わる可能性があります。SDKのリンクはコミット [d2f6543ee7995adcae74666a5d37b3d9743debfe](https://github.com/anthropics/anthropic-sdk-python/tree/d2f6543ee7995adcae74666a5d37b3d9743debfe) に固定しました。
:::

## まず結論

| 確認事項 | 結果 |
|---|---|
| HTTPステータス | `200` |
| `content-type` | `text/event-stream` |
| `data:` 内のJSON | `type` とイベント順序はAnthropic形式として妥当 |
| SSEの `event:` 行 | 存在しない |
| Anthropic SDK v0.116.0 | イベントをyieldせず、出力が空になる |
| httpxで `data:` を処理 | テキストを受信できる |

> `/v1/messages` はストリーミング応答を返す。しかしSDK v0.116.0はJSONより先にSSEの `event:` を調べるため、`event:` のない応答をyieldしない。

## SSE（Server-Sent Events）とは何か

SSE（Server-Sent Events）は、1本のHTTPレスポンスを開いたままイベントを順次送る仕組みです。AIの回答を生成途中から画面やCLIへ表示でき、体感待ち時間を短くできます。ただし、生成全体の所要時間まで必ず短くなるわけではありません。

[さくらのAPIリファレンス](https://manual.sakura.ad.jp/api/cloud/ai-engine/inference.html)は `stream` パラメーターを、[AnthropicのStreaming messages](https://platform.claude.com/docs/en/build-with-claude/streaming)は差分受信とイベント形式を説明しています。

## 発端：`messages.stream()` で何も出てこない

次は単独実行可能な例です。認証には `Authorization: Bearer ...` が必要なので、SDKの `auth_token` を使います。

```python
import os

import anthropic

BASE_URL = "https://api.ai.sakura.ad.jp"
MODEL = "preview/gemma-4-31B-it"
QUERY = "こんにちは。テストです。"


def main() -> None:
    auth_token = os.environ.get("SAKURA_AI_ENGINE_ACCOUNT_TOKEN")
    if not auth_token:
        raise RuntimeError("環境変数 SAKURA_AI_ENGINE_ACCOUNT_TOKEN を設定してください")

    client = anthropic.Anthropic(
        base_url=BASE_URL,
        auth_token=auth_token,
        timeout=30.0,
    )
    chunks: list[str] = []

    with client.messages.stream(
        model=MODEL,
        max_tokens=100,
        messages=[{"role": "user", "content": QUERY}],
    ) as stream:
        for text in stream.text_stream:
            chunks.append(text)
            print(text, end="", flush=True)

    print("\n[受信テキストなし]" if not chunks else "")


if __name__ == "__main__":
    main()
```

リクエストはエラーにならず、検証時は `[受信テキストなし]` と表示されました。`messages.create(stream=True)` でも同じ結果でした。

## curlで生のレスポンスを確認する

SDKを外して直接呼び出します。これも環境変数を設定すれば、そのまま実行できます。

```bash
curl -sS -N -X POST "https://api.ai.sakura.ad.jp/v1/messages" \
  -H "Authorization: Bearer $SAKURA_AI_ENGINE_ACCOUNT_TOKEN" \
  -H "anthropic-version: 2023-06-01" \
  -H "content-type: application/json" \
  -d '{
    "model": "preview/gemma-4-31B-it",
    "max_tokens": 100,
    "stream": true,
    "messages": [
      {"role": "user", "content": "こんにちは。テストです。"}
    ]
  }'
```

取得した応答は、概ね次の形式でした。

```text
data: {"type":"message_start", ...}

data: {"type":"content_block_start", ...}

data: {"type":"content_block_delta","delta":{"type":"text_delta","text":"こんにちは"}, ...}

...

data: {"type":"content_block_stop", ...}

data: {"type":"message_delta", ...}

data: {"type":"message_stop", ...}
```

JSONの `type` とイベント順序はAnthropicの基本フローと一致します。一方、Anthropicが示す名前付きイベントは次の形です。

```text
event: content_block_delta
data: {"type":"content_block_delta", ...}
```

検証時の応答には、`data:` と空行はあるものの `event:` がありませんでした。

## httpxでヘッダーと行構造を確認する

httpxでステータス、Content-Type、各行を表示します。

```python
import os

import httpx

BASE_URL = "https://api.ai.sakura.ad.jp"
MODEL = "preview/gemma-4-31B-it"
QUERY = "こんにちは。テストです。"


def main() -> None:
    auth_token = os.environ.get("SAKURA_AI_ENGINE_ACCOUNT_TOKEN")
    if not auth_token:
        raise RuntimeError("環境変数 SAKURA_AI_ENGINE_ACCOUNT_TOKEN を設定してください")

    with httpx.Client(timeout=30.0) as client:
        with client.stream(
            "POST",
            f"{BASE_URL}/v1/messages",
            headers={
                "Authorization": f"Bearer {auth_token}",
                "anthropic-version": "2023-06-01",
                "content-type": "application/json",
            },
            json={
                "model": MODEL,
                "max_tokens": 100,
                "stream": True,
                "messages": [{"role": "user", "content": QUERY}],
            },
        ) as response:
            print("status:", response.status_code)
            print("content-type:", response.headers.get("content-type"))
            response.raise_for_status()
            for line in response.iter_lines():
                print(repr(line))


if __name__ == "__main__":
    main()
```

結果は `200`、`text/event-stream` で、`data:` の後に空行が続きました。通信ではなくSDKのSSE解釈まで問題を絞れます。

## `data:` だけでもSSEとしては成立する

[WHATWG HTML Standard](https://html.spec.whatwg.org/multipage/server-sent-events.html#event-stream-interpretation)では、`event:` 省略時の既定種別は `message` です。今回の応答はSSEとして無効ではありません。

ただし、SSE標準のブラウザー向け処理と個々のSDK実装は別です。Anthropic Python SDK v0.116.0は、省略されたイベント名を内部で `"message"` に補完しません。

## SDK v0.116.0の実装を確認する

固定コミットの実装をたどると、空のイテレーターになる理由は3段階で説明できます。

1. [`SSEDecoder.decode()`](https://github.com/anthropics/anthropic-sdk-python/blob/d2f6543ee7995adcae74666a5d37b3d9743debfe/src/anthropic/_streaming.py#L471-L508)は `event:` を読んだときだけイベント名を設定し、[`ServerSentEvent`](https://github.com/anthropics/anthropic-sdk-python/blob/d2f6543ee7995adcae74666a5d37b3d9743debfe/src/anthropic/_streaming.py#L364-L382)は未設定の値を `None` として保持する。
2. [`Stream.__stream__()`](https://github.com/anthropics/anthropic-sdk-python/blob/d2f6543ee7995adcae74666a5d37b3d9743debfe/src/anthropic/_streaming.py#L86-L149)は、JSONを読む前に `sse.event` が既知の名前か選別する。`None` は通過しない。
3. 下位ストリームがイベントをyieldしないため、[`MessageStream.text_stream`](https://github.com/anthropics/anthropic-sdk-python/blob/d2f6543ee7995adcae74666a5d37b3d9743debfe/src/anthropic/lib/streaming/_messages.py#L128-L143)にもテキスト差分が届かない。

`data:` 内のJSONが妥当でも、それを読む入口まで到達しません。Anthropic公式SDKが期待するワイヤーフォーマットとは差があります。

## 回避策1：ストリーミングを使わない

逐次表示が必須でなければ、通常応答が最も単純です。

```python
import os

import anthropic

BASE_URL = "https://api.ai.sakura.ad.jp"
MODEL = "preview/gemma-4-31B-it"
QUERY = "こんにちは。テストです。"


def main() -> None:
    auth_token = os.environ.get("SAKURA_AI_ENGINE_ACCOUNT_TOKEN")
    if not auth_token:
        raise RuntimeError("環境変数 SAKURA_AI_ENGINE_ACCOUNT_TOKEN を設定してください")

    client = anthropic.Anthropic(
        base_url=BASE_URL,
        auth_token=auth_token,
        timeout=30.0,
    )
    response = client.messages.create(
        model=MODEL,
        max_tokens=100,
        messages=[{"role": "user", "content": QUERY}],
    )

    for block in response.content:
        if block.type == "text":
            print(block.text)


if __name__ == "__main__":
    main()
```

## 回避策2：`data:` を自前で処理する

逐次表示が必要なら、httpxでSSEの `data:` を組み立て、JSON内の `type` を処理できます。

```python
import json
import os
from collections.abc import Iterable, Iterator

import httpx

BASE_URL = "https://api.ai.sakura.ad.jp"
MODEL = "preview/gemma-4-31B-it"
QUERY = "こんにちは。テストです。"


def iter_sse_data(lines: Iterable[str]) -> Iterator[str]:
    data_lines: list[str] = []
    for line in lines:
        if line == "":
            if data_lines:
                yield "\n".join(data_lines)
                data_lines.clear()
            continue
        if line.startswith("data:"):
            value = line[5:]
            data_lines.append(value[1:] if value.startswith(" ") else value)
    if data_lines:
        yield "\n".join(data_lines)


def main() -> None:
    auth_token = os.environ.get("SAKURA_AI_ENGINE_ACCOUNT_TOKEN")
    if not auth_token:
        raise RuntimeError("環境変数 SAKURA_AI_ENGINE_ACCOUNT_TOKEN を設定してください")

    with httpx.Client(timeout=30.0) as client:
        with client.stream(
            "POST",
            f"{BASE_URL}/v1/messages",
            headers={
                "Authorization": f"Bearer {auth_token}",
                "anthropic-version": "2023-06-01",
                "content-type": "application/json",
            },
            json={
                "model": MODEL,
                "max_tokens": 100,
                "stream": True,
                "messages": [{"role": "user", "content": QUERY}],
            },
        ) as response:
            response.raise_for_status()
            for data in iter_sse_data(response.iter_lines()):
                payload = json.loads(data)
                if payload.get("type") == "error":
                    raise RuntimeError(f"ストリームエラー: {payload}")
                delta = payload.get("delta", {})
                if (
                    payload.get("type") == "content_block_delta"
                    and delta.get("type") == "text_delta"
                ):
                    print(delta.get("text", ""), end="", flush=True)
    print()


if __name__ == "__main__":
    main()
```

これは複数行の `data:` とエラーを扱う再現用の最小実装です。本番では、再接続、`id:`、`retry:`、未知のイベントも扱うSSEライブラリの利用が安全です。

## 僭越ながら、さくらのAI Engineへの改善要望

僭越ながら、Anthropic互換エンドポイントを公式SDKからも利用しやすくする改善として、JSONの `type` に対応する `event:` 行も送っていただくということでも解決します。なによりも、「Anthropic互換」がより安定感のある語感になることを五感で感じ取ることができます。

```text
event: content_block_delta
data: {"type":"content_block_delta", ...}
```

この形式ならAnthropicのドキュメント例に沿い、Python SDK v0.116.0のイベント選別も通過します。

## まとめ

- 検証時の `/v1/messages` は `text/event-stream` で、妥当な順序のJSONを `data:` として返した
- `event:` がないため、Anthropic Python SDK v0.116.0ではイベント名が `None` になり、テキスト差分がyieldされなかった
- 応答はSSEとして無効ではないが、Anthropic公式SDKが期待する名前付きイベント形式とは差がある
- 回避策は通常応答で一括取得するか、httpxで `data:` を処理すること

「JSONが合っているから互換」とは限りません。curl、httpx、SDKの順に確認する。単にtokenを消化するだけではなく、闘魂に昇華しました。地味な切り分けこそ再利用できる知見になりました。

## 参考資料

- [さくらのAI Engine Inference API](https://manual.sakura.ad.jp/api/cloud/ai-engine/inference.html)
- [Anthropic：Streaming messages](https://platform.claude.com/docs/en/build-with-claude/streaming)
- [WHATWG HTML Standard：Server-sent events](https://html.spec.whatwg.org/multipage/server-sent-events.html)
- [Anthropic Python SDK v0.116.0（固定コミット）](https://github.com/anthropics/anthropic-sdk-python/tree/d2f6543ee7995adcae74666a5d37b3d9743debfe)
