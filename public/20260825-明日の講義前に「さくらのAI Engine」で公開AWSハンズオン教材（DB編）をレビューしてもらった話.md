---
title: 明日の講義前に「さくらのAI Engine」で公開AWSハンズオン教材（DB編）をレビューしてもらった話
tags:
  - さくらのAI
  - AWS
  - 闘魂
  - 猪木
  - ClaudeCode
private: false
updated_at: '2026-08-26T11:16:32+09:00'
id: de5fa805e3c9c6f16904
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: bd14d28b53326d318fec
agreed_posting_campaign_term: true
---
## はじめに

現在、AWS Academyなどで学ぶ学生や初学者向けに、Webブラウザから誰でも閲覧できるAWS学習用ハンズオン教材をオープンソースとして公開しています。

- **公開ページ**: [AWS学習ハンズオン教材](https://haw.github.io/aws-education-hands-on/)
- **リポジトリ**: [GitHub - haw/aws-education-hands-on](https://github.com/haw/aws-education-hands-on)

まさに**明日**、このカリキュラムの3日目となる **[Day 3: データベース接続ハンズオン（db-lab）](https://haw.github.io/aws-education-hands-on/day3/db-lab/)** の講義を控えています。

「学生がつまずきやすいポイントはないか？」「手順の説明に抜け漏れはないか？」を直前に最終チェックするべく、**「さくらのAI Engine」** のAPIを利用して教材Markdownのレビューを実施してみました。

---

## Claude Code x さくらのAI Engine(Kimi-K2.7-Code) によるレビュー

「[Messages APIを使ったさくらのAI EngineとClaude Codeの連携](https://ai.sakura.ad.jp/column/claude-code-messages-api-2/)」を参考に、Claude CodeとさくらのAI Engineを連携させ、レビューをしてもらいました。

---

## レビューの実施方法

さくらのAI Engine（OpenAI互換APIエンドポイント）に対して、対象のハンズオン手順書（Markdown）をプロンプトとして渡し、初学者目線でのフィードバックを求めました。

### 投入したプロンプトのイメージ

```text
レビューしてください。 day3/db-lab/README.md
```

**ゼロショットプロンプティング** です。

---

## さくらのAI Engineからのレビュー結果

 `day3/db-lab/README.md` をレビューしました。

## 総評

AWS Academy Sandbox を想定した初学者向けハンズオンとして、全体的に丁寧に書かれています。絵文字や図版参照、注意喚起を効果的に使い、初心者がつまずきやすいポイント（VPCの作成が必要な理由、プライベートサブネットの確認、RDS作成後の待機など）をカバーできています。

ただし、**トラブルシューティングや学習ポイントに実際の手順と矛盾する記述がいくつかあり、初学者を混乱させる恐れがある**ので、優先して修正することをおすすめします。

---

## 修正が必要な問題

### 1. トラブルシューティングで「ポート80」を確認する記述が誤り
**該当:** `README.md:365`

> `2. セキュリティグループでポート80が開いているか確認`

このハンズオンではWebアプリが **3000番ポート** で動作しており、セキュリティグループ `web-server-sg` にも **ポート3000** のルールしか追加していません（`README.md:143`）。「ポート80」と記載されていると、受講者が間違った方向で調査してしまいます。

**修正案:**
```markdown
2. セキュリティグループでポート3000が開いているか確認
```

などの **9つもの指摘をいただきました！**

## まとめ

| 優先度 | 項目                                          |
| :----- | :-------------------------------------------- |
| **高** | トラブルシューティングのポート80を3000に修正  |
| **高** | 高可用性/Multi-AZの記述を実際の構成に合わせる |
| **高** | Phase 3→Phase 2の参照ミスを修正               |
| 中     | DBセキュリティグループのルール説明を整理      |
| 中     | Day 4分岐テキストの配置を見直す               |
| 低     | `tail -f` の使い方を明示                      |
| 低     | キーペア不要の理由を追記                      |

全体的な構成は良く、上記の誤りを修正すれば、より信頼性の高いハンズオン資料になります。


---

## おわりに

さくらのAI Engineを活用することで、講義直前の短い時間でも教材の客観的な見直しを行うことができ、安心して明日の授業に臨む準備が整いました。

APIのレスポンスもスムーズで、日本語の文脈に沿った的確なアドバイスをもらえるため、こうした「教育コンテンツや技術ドキュメントの事前チェック」にも非常に有用だと実感しました。

教材自体は全人類の共有財産として [GitHub Pages](https://haw.github.io/aws-education-hands-on/) にて完全公開していますので、AWSを学ぶ方はぜひご活用ください！

---

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

![ai-back.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b84b2736-c4a6-4c31-8fa5-ae55387eba08.png)

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d648527b-6c59-4c85-9681-bf5d01b0b6f4.png)

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c0f8edf8-7ba0-4f97-8667-31f00ad9348f.png)

