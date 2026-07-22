---
title: 「This model is not available.」── さくらのAI Engineの提供モデルが厳選されていました
tags:
  - さくらのAI
  - さくらインターネット
  - 闘魂
  - 猪木
  - AIではなく人間が書いてます
private: false
updated_at: '2026-07-22T08:22:02+09:00'
id: ab729b521f14a017e6b6
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: bd14d28b53326d318fec
agreed_posting_campaign_term: true
---
## この記事は

「[OpenAI・Anthropic互換APIを無料で使おう！「さくらのAI Engine」3,000リクエスト使い切りチャレンジ](https://qiita.com/official-events/bd14d28b53326d318fec)」キャンペーンの応募記事です。

## きっかけは一通のエラー

さくらのAI Engine (`https://api.ai.sakura.ad.jp/v1/chat/completions`) を叩いていたLINE botが、ある日突然

```
400 This model is not available.
```

と言い出しました。使っていたモデルは `Qwen3-Coder-480B-A35B-Instruct-FP8` です。

## 観測範囲でのタイムライン

- 2026/07/20(月) 23:46 時点：動いていた
- 2026/07/21(火) 19:10 時点：動かなくなっていた

あくまで「観測した範囲」の話であり、正確な切り替わり時刻はわかりません。

## 調べてみた

- [さくらのAI Engine](https://ai.sakura.ad.jp/sakura-ai/ai-engine/) のページに `Qwen3-Coder-480B-A35B-Instruct-FP8` の記載はありません
- コントロールパネルの「利用可能なモデル」一覧にも記載はありません
- ちなみに `/models` のようなモデル一覧APIは提供されていないため、プログラムから動的に「今使えるモデル」を確認する手段は今のところなさそうです

## 対処

2026/07/22現在提供されている `gpt-oss-120b` に置き換えたところ、LINE botはあっさり正常に応答するようになりました :tada::tada::tada: 

```diff
- model: "Qwen3-Coder-480B-A35B-Instruct-FP8"
+ model: "gpt-oss-120b"
```

## まとめ

- 無料で使わせていただいている基盤モデル無償プラン（月3,000リクエスト）は本当にありがたい存在です
- とはいえ提供モデルは変わりうるので、決め打ちせず「動かなくなったら候補モデルに切り替える」くらいの運用が現実的だと感じました
- モデル一覧を取得するAPIがあると、こういうときに切り替え判断がしやすくなりそうです（僭越ながら、一利用者として要望申し上げたく候）

token消化ではなく、**闘魂昇華**。動かなくなったら、また鍛え直して使い切ります。

---

「[OpenAI・Anthropic互換APIを無料で使おう！「さくらのAI Engine」3,000リクエスト使い切りチャレンジ](https://qiita.com/official-events/bd14d28b53326d318fec)」に参加するすべてのみなさま、つまりは全人類を応援します！
