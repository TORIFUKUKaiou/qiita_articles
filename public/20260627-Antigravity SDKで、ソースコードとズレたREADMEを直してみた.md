---
title: Antigravity SDKで、ソースコードとズレたREADMEを直してみた
tags:
  - Google
  - AI
  - Gemini
  - 闘魂
  - Antigravity
private: false
updated_at: '2026-06-28T00:29:36+09:00'
id: 658d89d4d7a08b89845c
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: 9d632f51614ebd7b333c
agreed_posting_campaign_term: true
---
## はじめに

前回、Antigravity SDKを触ってみました。

https://qiita.com/torifukukaiou/items/7f041125bcf109c5e2c7

最初は、Antigravity SDKが何なのかよくわかりませんでした。

LINE SDKやSlack SDKなら、意味はわかります。  
APIを直接HTTPで叩く代わりに、認証やリクエスト、レスポンス処理を使いやすく包んでくれる道具です。

しかし、Antigravity SDKは少し違いました。

これは何をラップしているのか。  
Gemini APIなのか。  
Antigravityというアプリなのか。  
それとも、エージェントという作業単位そのものなのか。

そこで、公式サンプルを動かしました。

`hello_world.py` は、Agentと会話する最小例でした。  
`quick_start.py` では、Agentがカレントディレクトリを見に行き、ファイル一覧を返してくれました。

ここで少し見えてきました。

Antigravity SDKは、単なるチャットAPIのラッパーではなさそうです。  
ローカル環境とつながったAgentを、自分のPythonプログラムから扱うための部品に見えます。

今回は、もう少し実戦的なサンプルに踏み込みます。

試すのは、公式リポジトリの Deep Dives にある `doc_maintenance_agent.py` です。

https://github.com/google-antigravity/antigravity-sdk-python/blob/main/examples/deep_dives/doc_maintenance_agent.py

ソースコードとズレたREADMEを、Antigravity SDKのエージェントで直せるのか。

反重力の火種に、少しだけ闘魂注入してみます。

## 対象プロジェクトを用意する

今回の対象は、自分で用意した小さなNode.jsプロジェクトです。

https://github.com/TORIFUKUKaiou/antigravity-doc-maintenance-sample

このプロジェクトは、わざと実装とMarkdownドキュメントの内容をずらしています。

リポジトリの説明はこうです。

```text
A tiny app where the code tells the truth and the README lies.
```

コードは真実を語り、READMEは少し嘘をついている。  
そんなプロジェクトです。

![スクリーンショット 2026-06-27 21.14.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/990da42c-8efd-4f0b-8edb-52b87d4a63a5.png)

このプロジェクトの作成については次の記事にまとめています。

https://qiita.com/torifukukaiou/items/b720bb5887466cd6c385


## 実装とドキュメントのズレ

実装では、次のようになっています。

- サーバーは `3000` 番ポートで起動する
- `/` にブラウザ用のフロントエンドがある
- `GET /tasks?status=todo` のようにステータスで絞り込みできる
- タスク完了APIは `PATCH /tasks/:id/complete`
- タスクには `status`, `priority`, `dueDate` がある
- `POST /tasks` は `201 Created` を返す

一方で、READMEや `docs/api.md` には古い情報を残してあります。

- サーバーは `8080` 番ポートで起動すると書いてある
- フロントエンドはないと書いてある
- query parameter は未対応と書いてある
- タスク完了APIは `PATCH /tasks/:id/done` と書いてある
- タスクには `done` フィールドがあると書いてある
- `POST /tasks` は `200 OK` を返すと書いてある

これなら、ドキュメント保守Agentの実験台としてちょうどよさそうです。

## まずは無料枠のAPI Keyで実行してみる

最初は、Google AI Studioで作った無料枠プロジェクトのAPI Keyで実行しました。

```bash
export GEMINI_API_KEY="YOUR_API_KEY"
```

実行します。

```bash
uv run python doc_maintenance_agent.py ~/repos/antigravity-doc-maintenance-sample
```

しかし、途中で止まりました。

```text
google.antigravity.types.AntigravityExecutionError: model unreachable: Error 429, Message: You exceeded your current quota, please check your plan and billing details.
...
Quota exceeded for metric: generativelanguage.googleapis.com/generate_content_free_tier_requests, limit: 5, model: gemini-3.5-flash
...
Status: RESOURCE_EXHAUSTED
```

無料枠のリクエスト上限に当たったようです。

`doc_maintenance_agent.py` は、単発のチャットではありません。

対象ディレクトリを見て、ファイルを読み、内容を判断し、必要な修正を行います。  
そのため、最小サンプルよりもAPI呼び出しが多くなるのだと思います。

ここで一度、無料枠のAPI Keyでの実行はあきらめました。

## Tier 1 のプロジェクトのAPI Keyに切り替える

そこで、Tier 1 有料設定になっているプロジェクトにAPI Keyを追加しました。
API Keyの追加を私は、 [https://aistudio.google.com/api-keys](https://aistudio.google.com/api-keys) からしました。

そのAPI Keyを環境変数に設定し直します。

```bash
export GEMINI_API_KEY="YOUR_TIER1_PROJECT_API_KEY"
```

もう一度、気を取り直して実行します。

```bash
uv run python doc_maintenance_agent.py ~/repos/antigravity-doc-maintenance-sample
```

## ログがたくさん流れる

実行すると、ログが流れます。

かなり流れます。

```text
Streaming agent output:
INFO:root:RAW WS MSG: {"seqNum":"1", "timestampMicros":"1782561295711971", "trajectoryStateUpdate":{"trajectoryId":"6bffec8792c7783dc0635f403fa34b17", "state":"STATE_RUNNING"}}

...略...

INFO:root:RAW WS MSG: {"seqNum":"214", "timestampMicros":"1782561375366886", "trajectoryStateUpdate":{"trajectoryId":"6bffec8792c7783dc0635f403fa34b17", "state":"STATE_IDLE"}}

INFO:root:Stopping Agent session
INFO:root:harness stderr: Stdin closed, cleaning up...
```

最後に `stderr` という文字が見えました。

失敗したのかと思いました。

しかし、ここで大事なのはログではありません。

成果物です。

`git diff` を見ます。

```bash
cd ~/repos/antigravity-doc-maintenance-sample
git diff
```

## READMEが直っていた

差分を見ると、READMEが修正されていました。

```diff
-Task Tracker API is a small Node.js API for managing tasks.
-
-This project provides an API only. It does not include a browser-based frontend.
+Task Tracker API is a small Node.js API and cosmic web interface (Cosmo Task Console) for managing tasks.
```

フロントエンドなし、という古い説明が消えました。

そして、Cosmo Task Console という実装上のフロントエンドに合わせた説明へ修正されています。

ポート番号も修正されました。

```diff
-The server starts on port `8080`.
+The server starts on port `3000`. You can access the Cosmo Task Console by open http://localhost:3000 in your browser.
```

`8080` から `3000` へ直っています。

さらに、`GET /tasks` の query parameter も追記されています。

```diff
+Supported query parameters:
+- `status`: Filter tasks by status (`todo` or `done`).
```

完了APIも修正されました。

```diff
-### PATCH /tasks/:id/done
+### PATCH /tasks/:id/complete
```

タスクのフィールドも、実装に合わせて直っています。

```diff
-- id
-- title
-- done
+- `id` (number): A unique identifier for the task.
+- `title` (string): The description of the task.
+- `status` (string): The completion status, either `"todo"` or `"done"`.
+- `priority` (string): The task priority, either `"high"`, `"medium"`, or `"low"`.
+- `dueDate` (string | null): The target due date.
```

これは、はっきり動いています。

## docs/api.md も直っていた

`docs/api.md` も修正されていました。

Base URLは `8080` から `3000` へ。

```diff
-http://localhost:8080
+http://localhost:3000
```

フロントエンドなし、という説明も修正されています。

```diff
-This project does not provide a frontend page.
+The application serves a browser-based static interface (Cosmo Task Console) at the following paths:
+- `GET /`: Serves the primary HTML page (`index.html`).
+- `GET /style.css`: Serves CSS stylesheets.
+- `GET /app.js`: Serves browser-side JavaScript application code.
```

さらに、実装に存在する `/health` も追記されています。

```diff
+## GET /health
+
+Returns the health status of the application.
+
+Response status: `200 OK`
+
+Response payload sample:
+```json
+{
+  "ok": true
+}
+```
```

`GET /tasks` の query parameter も修正されています。

```diff
-Query parameters are not supported.
+### Query Parameters
+
+| Parameter | Type | Required | Description |
+| --- | --- | --- | --- |
+| status | string | no | Filter tasks by completion status (`todo` or `done`). |
```

`POST /tasks` のレスポンスステータスも、`200 OK` から `201 Created` へ直っています。

```diff
-Response status: `200 OK`
+Response status: `201 Created`
```

完了APIも、実装に合わせて `PATCH /tasks/:id/complete` へ修正されています。

```diff
-## PATCH /tasks/:id/done
+## PATCH /tasks/:id/complete
```

かなり実装を読んでいます。

## maintenance-prompt.md も少し変わっていた

`docs/maintenance-prompt.md` にも小さな差分がありました。

```diff
-Use this prompt when running the official Antigravity SDK example.
+Use this prompt when running the official Google Antigravity SDK example.
```

ここは大きな変更ではありません。

ただ、対象ディレクトリ内のMarkdownを見て、必要だと判断したものを更新していることはわかります。

## 実行時間は約79秒

ログの `timestampMicros` を見ると、開始と終了は次のようになっていました。

```text
1782561375366886 - 1782561295711971 = 79654915
```

単位はマイクロ秒なので、

```text
79654915 マイクロ秒 = 約79.7秒
```

1分少々待つと、Markdownが実装に合わせて更新されました。

## これはかなりおもしろい

正直、これはかなりおもしろいです。

[hello_world.py](https://github.com/google-antigravity/antigravity-sdk-python/blob/main/examples/getting_started/hello_world.py) は、ただの挨拶に見えました。

[quick_start.py](https://antigravity.google/docs/sdk/overview) は、カレントディレクトリのファイル一覧を返してくれました。

そして今回の `doc_maintenance_agent.py` は、実装を読んで、古いMarkdownを直しました。

これは、単なるファイル一覧ではありません。

実装とドキュメントの差分を見つけ、Markdownを更新しています。

「自分用 Antigravity を作る部品」という感覚が、かなり強くなりました。

## 費用はいくらかかったのか？

正確なことはわかりません。

これを実行した前後で、クレジット残高は60円くらい減っていました。

すぐに減っていたわけではなく、5h後くらいに気づきました。

ただし、この約60円が純粋に今回の実行だけによるものかは、正直わかりません。
同じプロジェクトでLINEボットの画像生成も試しているため、その利用分が混ざっている可能性があります。
とはいえ、直近では画像生成をした気配がないので、体感としてはほぼ今回の検証による利用分ではないかと思っています。

## まとめ

Antigravity SDKの公式exampleである `doc_maintenance_agent.py` を使って、ソースコードとズレたREADMEを直してみました。

結果として、READMEと `docs/api.md` は実装通りの内容へ更新されました。

直った内容は、たとえば次の通りです。

- ポート番号が `8080` から `3000` に修正された
- フロントエンドなし、という古い説明が削除された
- `GET /tasks` の `status` query parameter が追記された
- `POST /tasks` のレスポンスが `201 Created` に修正された
- 完了APIが `PATCH /tasks/:id/done` から `PATCH /tasks/:id/complete` に修正された
- タスクのフィールドが `done` から `status`, `priority`, `dueDate` に修正された

無料枠のAPI Keyでは、429エラーで止まりました。  
一方で、Tier 1 のプロジェクトのAPI Keyに切り替えると、最後まで実行できました。

Antigravity SDKは、単なるチャットAPIではありません。

ローカル環境とつながったAgentを、自分のPythonプログラムから扱うためのSDK。  
そう考えると、かなり夢があります。

やる気さえあれば、自分用の小さなAntigravity的ツールも作れそうです。

文字にすると、淡々と書いているように見えるかも知れませんが、これを書いている私はいまとても興奮しています！  
Antigravity ―― 反重力だけに、少し浮きました。
