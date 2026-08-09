---
title: さくらのAI Engine「Text-to-Speech」の無償枠(月50リクエスト)、超過後のレートリミットを実際に調べてみた
tags:
  - さくらのAI
  - さくらインターネット
  - 闘魂
  - ずんだもん
  - TTS
private: false
updated_at: '2026-08-08T23:52:10+09:00'
id: 518673f87bc789e30184
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: bd14d28b53326d318fec
agreed_posting_campaign_term: true
---
![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2b5a93af-e4e2-46ca-aa5e-53a052cd54f5.png)


## はじめに

[さくらのAI Engine](https://ai.sakura.ad.jp/sakura-ai/ai-engine/)の「基盤モデル無償プラン」では、Audio speeches（読み上げ／TTS）は月50リクエストまで無償で利用できます。ドキュメントには「無料枠を使いきったら…利用制限がかかる（レートリミットが適用）」と書かれていますが、具体的にどのくらいの間隔を空ければ再び使えるようになるのかは明記されていません。

本記事は、8月に入って早々に50リクエストを使い切ってしまった実体験をきっかけに、超過後のレートリミットの挙動を実際に調べてみた記録です。

本記事は[「OpenAI・Anthropic互換APIを無料で使おう！『さくらのAI Engine』3,000リクエスト使い切りチャレンジ」](https://qiita.com/official-events/bd14d28b53326d318fec)への参加記事です。

## やらかした話：初日で50リクエストを使い切る

きっかけは自分のミスでした。生成AIにコーディングを依頼し、「題材群をまとめて、最後に1回だけTTSする」実装を頼んだつもりだったのですが、できあがったコードは題材1つ1つに対して個別にTTSを呼び出す実装になっていました。

コードをよく確認せずに実行してしまった結果、8月に入ってから最初の1日だけで50リクエストの無償枠を使い果たしてしまいました。実際、8月だけですでに61回コールしている状態です。

![スクリーンショット 2026-08-08 23.49.31.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b5fa8c4f-3248-4a1e-a9dc-84ca1332bc8b.png)


興味深いことに、50リクエストを超えたあとも成功するコールがあり、「じゃあ実際のレートリミットってどうなっているんだろう？」と気になったので、調査することにしました。

## Claude Code × さくらのAI Engineで調査

調査には、Claude CodeからさくらのAI Engine（preview/Kimi-K2.7-Code）を使いました。Claude CodeとさくらのAI Engineを連携させる方法は、以下の記事が詳しいです。

- [Messages APIを使ったさくらのAI EngineとClaude Codeの連携](https://ai.sakura.ad.jp/column/claude-code-messages-api-2/)

Claude Codeに教えてもらった、TTS（Audio speech）を試すためのcurlコマンドは以下の通りです。

```bash
curl -sS \
  --request POST \
  --url https://api.ai.sakura.ad.jp/v1/audio/speech \
  --header 'accept: audio/wav' \
  --header "Authorization: Bearer ${SAKURA_AI_ENGINE_ACCOUNT_TOKEN}" \
  --header 'Content-Type: application/json' \
  --data '{
    "model": "zundamon",
    "input": "こんにちは、これは音声合成のサンプルです。",
    "voice": "normal",
    "response_format": "wav"
  }' \
  -o ./audio-speech-output.wav \
  -D ./response-headers.txt \
  -w "HTTP Status: %{http_code}\nContent-Type: %{content_type}\nSize: %{size_download} bytes\nTotal time: %{time_total}s\n"
```

`model` に `zundamon`（ずんだもん）を指定して音声合成をリクエストしています。

## レートリミットに引っかかったときのレスポンス

50リクエストを超えている状態でも成功することはあるのですが、レートリミットに引っかかると次のようなレスポンスが返ってきます。

**HTTPステータス等**

```
HTTP Status: 429
Content-Type: application/json
Size: 43 bytes
Total time: 0.958935s
```

**`audio-speech-output.wav`（実際にはエラーのJSONが返る）**

```json
{"error":{"message":"rate limit exceeded"}}
```

**`response-headers.txt`**

```
HTTP/1.1 429 Too Many Requests
content-type: application/json
vary: Origin
x-request-id: 01KZGTFNM7E21YRK015HC8BSDW
date: Sat, 08 Aug 2026 13:55:01 GMT
content-length: 43
via: 1.1 sac-elb
retry-after: 60
```

レスポンスヘッダーには `retry-after: 60` が含まれており、これは「60秒後に再試行してください」という意味だそうです。

## `retry-after: 60` は、あくまで目安だった

`retry-after: 60` と返ってきているので「60秒待てば通るのでは」と思い、実際に60秒後・120秒後くらいに再コールしてみましたが、いずれも `429 Too Many Requests` のままでした。

何度か間隔を変えて試した私の体感としては、**30分以上の間隔を空けないと安定して通らない**という印象です。`retry-after` の値はあくまで目安であり、実際に必要な待機時間はそれより長いケースがある、ということは覚えておいた方がよさそうです。

## 実運用ではどうなっているか

以前、[さくらのAI Engineに書いてもらったコードで、さくらのAI Engineの「ずんだもん」に毎朝私は起こしてもらう](https://qiita.com/torifukukaiou/items/3c03c45da77e9cb7cf6b)という記事で紹介した通り、私は毎朝6:59と7:30の2回、ずんだもんの声で起こしてもらう運用をしています。

1日2回・30分ほど間隔を空けているこの運用では、今のところ2回とも成功しているようです（「ようだ」というのは、寝過ごして自分では気づいていない可能性もあるためです）。この体感とも、「30分程度は間隔が必要」という調査結果は矛盾しない結果でした。

## まとめ

- さくらのAI EngineのAudio speeches（TTS）無償枠は月50リクエスト
- 超過してもすぐにブロックされるわけではなく、成功することもある
- レートリミットに引っかかると `429 Too Many Requests` が返り、`retry-after: 60` ヘッダーが付与される
- ただし `retry-after` の60秒はあくまで目安で、実際には60秒後・120秒後の再試行でも失敗した
- 体感では、**30分以上の間隔**を空けると成功しやすい

無償枠は太っ腹な一方で、「1日にまとめて使い切ってしまう」ような実装ミスをすると、しばらく使えなくなってしまいます。ループ処理でAPIを呼ぶ実装をする際は、意図した回数だけ呼ばれているか、実行前にコードをよく確認することをおすすめします（自戒を込めて）。

## 参考リンク

- [さくらのAI Engine](https://ai.sakura.ad.jp/sakura-ai/ai-engine/)
- [Messages APIを使ったさくらのAI EngineとClaude Codeの連携](https://ai.sakura.ad.jp/column/claude-code-messages-api-2/)
- [さくらのAI Engineに書いてもらったコードで、さくらのAI Engineの「ずんだもん」に毎朝私は起こしてもらう](https://qiita.com/torifukukaiou/items/3c03c45da77e9cb7cf6b)
- [OpenAI・Anthropic互換APIを無料で使おう！「さくらのAI Engine」3,000リクエスト使い切りチャレンジ](https://qiita.com/official-events/bd14d28b53326d318fec)
