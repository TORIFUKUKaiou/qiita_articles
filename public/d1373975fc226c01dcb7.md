---
title: Elixir製NotebookLMクローン「Notex」をDocker (Ubuntu 24.04) で動かす（さくらのAI Engine検証）
tags:
  - Elixir
  - Notex
  - さくらのAI
  - 闘魂
  - 猪木
private: false
updated_at: '2026-08-06T21:49:29+09:00'
id: d1373975fc226c01dcb7
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: bd14d28b53326d318fec
agreed_posting_campaign_term: true
---
## はじめに

こんにちは！
@piacerex さんが制作された噂のNotebookLMクローンプロジェクト **「[notex](https://github.com/piacerex/notex)」** を、Docker（Ubuntu 24.04 LTSベース）環境で動かしてみました。

https://x.com/piacere_ex/status/2074144458229305685

前回、こんな記事を書きました。

https://qiita.com/torifukukaiou/items/78314be5a6db95b13286

今回は、[さくらのAI Engine](https://ai.sakura.ad.jp/sakura-ai/ai-engine/)と組み合わせて動作させてみました。
**OpenAI互換APIであるため、予想通り何ら詰まることもなく動作させることができました:tada::tada::tada:**


---

## 1. コンテナのビルドと起動

Dockerfileやパッチの話は、『[Elixir製NotebookLMクローン「Notex」をDocker (Ubuntu 24.04) で動かす＆ai& Inference検証](https://qiita.com/torifukukaiou/items/78314be5a6db95b13286)』をご参照ください。
パッチを当てた後、以下のコマンドでDockerイメージをビルドし、環境変数を指定してコンテナを起動します。

```bash
# 1. ビルド
docker build -t notex .

# 2. さくらのAI EngineのAPIを使用して起動
docker run -p 4000:4000 \
  -e NOTEX_LLM_PROVIDER="openai" \
  -e OPENAI_API_KEY="$SAKURA_AI_ENGINE_ACCOUNT_TOKEN" \
  -e NOTEX_LLM_MODEL="gpt-oss-120b" \
  -e NOTEX_LLM_BASE_URL="https://api.ai.sakura.ad.jp/v1" \
  -e NOTEX_OPEN_JTALK_RATE="1.0" \
  -e NOTEX_VIDEO_FONTFILE="/usr/share/fonts/opentype/noto/NotoSansCJK-Regular.ttc" \
  -e NOTEX_LLM_REASONING_EFFORT="low" \
  notex
```

:::note info
NOTEX_LLM_PROVIDER の指定について

Notexの内部実装では、環境変数 NOTEX_LLM_PROVIDER に指定された文字列（"openai" / "codex_app_server"）によって、どの通信モジュールをロードするかを分岐しています。

さくらのAI EngineなどのOpenAI互換APIサービスを利用する場合、内部でHTTP通信用のクライアント（Notex.LLM.OpenAI）をロードさせる必要があるため、プロバイダー名には "openai" を指定する必要があります。
:::

:::note info
NOTEX_LLM_MODEL の指定について

「[さくらのAI Engine が提供しているモデル](https://manual.sakura.ad.jp/cloud/ai-engine/03-operation-guide.html#service-name)」をご参照の上、モデルをお選びください。2026-08-06時点で提供されている「gpt-oss-120b」を使用した例を本文には書いています。
:::

## 2. 実際に使ってみた結果

ブラウザで `http://localhost:4000` にアクセスすると、無事にNotebookLMそっくりのモダンなUIが立ち上がりました！

Video, Cards, Report, Audio, Slides, MindMapの作成を確認できました :tada:

![スクリーンショット 2026-08-06 21.39.09.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a900bd79-0b99-49e4-b8bc-b86bb102d9d3.png)


![スクリーンショット 2026-08-06 21.41.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/061d5f80-615f-4eed-b339-8e746892b553.png)






---

## まとめ

ローカルで動作する、Elixir Phoenix製NotebookLMクローン「Notex」をさくらのAI Engineと組み合わせて動かすレポートでした。

さくらのAI Engineは、OpenAI互換APIなので、全く何ら詰まることなく、「Notex」で使用できました。本当に、真にOpenAI互換です！

---

## 編集後記

`NewPJ` (新プロジェクト) ということだと思いますが、私には、New Japanつまり、新日本（プロレス）にしか見えませんでした。新日本プロレスを創設したのは、もちろんアントニオ猪木さんです。

---

## おわりに──token消化ではなく、**闘魂昇華**

![ai-back.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b84b2736-c4a6-4c31-8fa5-ae55387eba08.png)

:::note
**TokenをTokonへ**

AIが扱うのは、Token。

```math
\mathrm{Token}
-
\mathrm{見\ (Ken)}
+
\mathrm{魂\ (Kon)}
=
\mathrm{Tokon\ (闘魂)}
```

現段階の生成AIは、突き詰めればベクトルの数理遊びである。

どのモデルが賢い、速い、勝つ。
外から眺め、比べ、論評するだけでは、まだTokenだ。

だから「見（Ken）」を引く。

見る側から、使う側へ。
そこに目的と意味を与え、執念を持ち込み、魂を込めるのは人間である。

token消化ではなく、**$\huge{闘魂昇華}$** :fire:
Don't just consume Tokens. Forge them into Tokon.
:::

無料枠を、闘って、磨いて、使い切りますッ！！！

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d648527b-6c59-4c85-9681-bf5d01b0b6f4.png)

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c0f8edf8-7ba0-4f97-8667-31f00ad9348f.png)
