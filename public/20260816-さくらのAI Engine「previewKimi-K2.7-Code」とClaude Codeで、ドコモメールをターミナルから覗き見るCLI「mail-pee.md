---
title: >-
  さくらのAI Engine「preview/Kimi-K2.7-Code」とClaude
  Codeで、ドコモメールをターミナルから覗き見るCLI「mail-peek」を爆速開発した話
tags:
  - さくらのAI
  - さくらインターネット
  - ClaudeCode
  - 闘魂
  - 猪木
private: false
updated_at: '2026-08-16T21:46:51+09:00'
id: ab303a5646bf1bf20b2b
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: bd14d28b53326d318fec
agreed_posting_campaign_term: true
---
![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/54b2ab23-1e57-4f5c-92d4-7cc3c36deff4.png)


## はじめに

本記事は、さくらインターネット主催の記事投稿キャンペーン「[OpenAI・Anthropic互換APIを無料で使おう！「さくらのAI Engine」3,000リクエスト使い切りチャレンジ](https://qiita.com/official-events/bd14d28b53326d318fec)」への参加記事です。

やったことを一言でまとめると、こうなります。

**Claude Codeの頭脳に「さくらのAI Engine」の最新コーディング特化モデル `preview/Kimi-K2.7-Code` を接続し、スマホを開かずにターミナルからドコモメール（`@docomo.ne.jp`）をサクッと確認できるCLIツール [mail-peek](https://github.com/TORIFUKUKaiou/mail-peek) を開発してもらった。**

――これは、無料枠3,000リクエストに挑んだひとりのエンジニアが、DoCoMo IMAPのレガシーTLSという深い罠を前に、AIエージェントと共に粘り強く試行錯誤を重ね、tokenをただ消費するのではなく闘魂へと昇華させたドラマである。

---

## なぜ作ったのか？（開発の動機）

日常的にPCに向かって開発や仕事をしているとき、地味に困っていたのが **`@docomo.ne.jp` 宛てに届くキャリアメールの存在** でした。

- 普段の連絡や各種サービスからの通知、重要なお知らせがドコモメールに届く。
- しかし、ドコモメールは基本的にスマートフォンを開いて確認する必要がある。作業中にスマホを手に取るのは集中力が削がれるし、何より**見落とすことが多い**。
- 一応ブラウザで使える「[ドコモWebメール](https://mail.smt.docomo.ne.jp/mail/)」も提供されているものの、セキュリティの都合上、**ちょっと放置するとすぐにセッションタイムアウトで切断**されてしまい、毎回ログインし直すのが非常に面倒……。

**「ターミナルでコマンドを一発叩くだけで、新着メールの件名と差出人をササッと確認（覗き見）できる軽量CLIツールが欲しい！」**

エンジニアなら誰しも抱くこの切実な願望を叶えるべく、開発をスタートしました。

### ツールの名前は「mail-peek」

ツールの名前は **`mail-peek`** と名付けました。

- **peek** は英語で「ちょっと覗く」「チラ見する」という意味です。
- そして作者は大の漫画好き。『進撃の巨人』に登場する知性派で頼れる戦士、車力の巨人こと **ピーク・フィンガー（Pieck Finger）** も重ね合わせています。「さすがピークちゃん、お見事だよ」と言えるくらい、軽快かつ確実にメールを覗き見てくれるツールを目指しました。

---

## 使った技術と環境

- **言語**: Python 3.14（`imaplib`, `ssl` など標準ライブラリ中心）
- **エージェントハーネス**: [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)
- **AIモデル**: さくらのAI Engine `preview/Kimi-K2.7-Code`
- **リポジトリ**: [https://github.com/TORIFUKUKaiou/mail-peek](https://github.com/TORIFUKUKaiou/mail-peek)

### Claude CodeからさくらのAI Engineを呼び出す

さくらのAI Engineは Anthropic互換の Messages API を提供してくれています。
さくらインターネット公式コラム「[Claude CodeからさくらのAI Engineを使う](https://ai.sakura.ad.jp/column/claude-code-messages-api-2/)」を参考に、環境変数を設定して接続先をさくらのAI Engine上の `preview/Kimi-K2.7-Code` に切り替えました。

```bash
export ANTHROPIC_BASE_URL="[https://api.ai.sakura.ad.jp](https://api.ai.sakura.ad.jp)"
export ANTHROPIC_AUTH_TOKEN="<あなたのさくらAI Engine アカウントトークン>"

# Claude Code を さくらの Kimi-K2.7-Code モデルで起動
claude --model preview/Kimi-K2.7-Code

```

これにより、Anthropic側の課金を気にすることなく、さくらのAI Engineの**月3,000リクエスト無償枠**をフル活用してコーディングエージェントをぶん回せる最高の開発環境が爆誕します。

約200リクエストくらいでできあがりました。

![スクリーンショット 2026-08-16 21.34.26.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ef882c60-dc44-44d8-8fc5-8700c3f77c77.png)


---

## 最大の試行錯誤：DoCoMo IMAP TLS Compatibility の壁

「ドコモのIMAPサーバーに接続して最新メールを取得するCLIを作って」と Claude Code（Kimi-K2.7-Code）にお願いし、実装がスタートしました。

しかし、ここで**最大の難関**が立ちはだかりました。

### ドコモ IMAP 接続で観測した TLS ハンドシェイクエラー

検証した macOS 上の Python/OpenSSL 環境では、`imap.spmode.ne.jp` および `imap2.spmode.ne.jp` への TLS 接続が、デフォルトの SSL コンテキストでは次の例外で失敗しました。

```text
ssl.SSLError: [SSL: UNSAFE_LEGACY_RENEGOTIATION_DISABLED] unsafe legacy renegotiation disabled (_ssl.c:1007)
```

これは、接続先が secure renegotiation を利用できないと OpenSSL が判断し、初回 TLS ハンドシェイクを拒否したことを示します。実際に再ネゴシエーションが発生したことを意味するわけではありません。
この検証環境では、ssl.OP_LEGACY_SERVER_CONNECT を有効にすると両エンドポイントとの接続が成功しました。ただしこれはドコモが公開している仕様として確認したものではなく、現時点で観測した互換性問題への限定的な対応です。

### Kimi-K2.7-Code の粘り強さとプロのセキュリティ意識

安易なAIであれば、「SSL検証を全部スキップ（`CERT_NONE`）しちゃいましょう！」というセキュリティ的に最悪なコードを吐き出しかねない場面です。

しかし、`preview/Kimi-K2.7-Code` は違いました。
エラーログとドキュメントを読み解きながら、何度も粘り強く試行錯誤を重ね、**セキュリティを保ちつつドコモの仕様に適合させる完璧な設計方針**を導き出して実装してくれたのです。

その方針がこちらです。

```text
Docomo IMAP TLS Compatibility
Both known Docomo endpoints, imap.spmode.ne.jp and imap2.spmode.ne.jp, require ssl.OP_LEGACY_SERVER_CONNECT for TLS negotiation. Apply this exception only to these exact hostnames; never use a suffix match or enable it for arbitrary IMAP hosts. Retain ssl.create_default_context(), hostname verification, and TLS 1.2 as the minimum version. Do not remove or expand this exception without an authorized, authentication-free TLS handshake comparison against the affected endpoint.

```

要約すると：

1. 小文字化・末尾の `.` 除去で正規化したホスト名が、許可リストの `imap.spmode.ne.jp` または `imap2.spmode.ne.jp` に一致する場合にだけ、`ssl.OP_LEGACY_SERVER_CONNECT` を有効にする。
2. 後方一致や任意の IMAP ホストには適用しない。
3. `ssl.create_default_context()` による証明書検証・ホスト名検証と、TLS 1.2 を下限とする設定は維持する。ただし legacy renegotiation に関する保護を緩める互換性対応であるため、接続先が対応を更新した際には再検証して削除を検討する。

---

## 実際にできあがったもの：`mail-peek`

完成したリポジトリはこちらです。

👉 **[TORIFUKUKaiou/mail-peek - GitHub](https://github.com/TORIFUKUKaiou/mail-peek)**

ソースコードの全貌はリポジトリをご覧いただくとして、使い心地は極めてシンプル＆爽快です。

```bash
# ドコモメールの新着・未読をサクッと覗き見る！
uv run mailpeek unread

                                     Unread Emails                                     
┏━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┓
┃ ID  ┃ Date                            ┃ From                        ┃ Subject       ┃
┡━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╇━━━━━━━━━━━━━━━┩
│ 109 │ Sun, 16 Aug 2026 21:44:08 +0900 │ 山内修 <awesome@example.com> │ テストメール2 │
├─────┼─────────────────────────────────┼─────────────────────────────┼───────────────┤
│ 108 │ Sun, 16 Aug 2026 21:43:39 +0900 │ 山内修 <awesome@example.com> │ テストメール1 │
└─────┴─────────────────────────────────┴─────────────────────────────┴───────────────┘
```

ターミナルを叩けば、数秒で新着メールの件名、送信者、受信日時が一覧表示されます。
ブラウザを開く必要も、スマホを手に取る必要も、セッション切れにイライラさせられることもありません。

まさに「ちょっと覗く（peek）」用途に最適化されたCLIツールが完成しました！

---

## 一番アピールしたいこと

今回の開発で一番胸を打たれたのは、**さくらのAI Engine `preview/Kimi-K2.7-Code` の驚異的な粘り強さとコード品質**です。

単に動くコードを一度出すだけでなく、レガシーTLSネゴシエーションというインフラ寄りの難解なトラブルに直面しても、安全性を犠牲にすることなく試行錯誤を繰り返して突破してくれました。

そして何より、これを支えてくれたのが **さくらのAI Engineが提供する月3,000リクエストの無償枠** です。
コーディングエージェントを動かすと、試行錯誤やテスト実行のたびに何十回、何百回とリクエストが飛び交います。従量課金のメーターを気にしながらでは思い切った試行錯誤はできません。

「コストを気にせず、AIエージェントに限界まで挑戦させられる」という環境があったからこそ、この `mail-peek` は生まれました。

---

引き続き3,000リクエストを使い切る2兆個のアイデアを実践します。

token消化ではなく、**$\huge{闘魂昇華}$**。無料枠を、闘って、磨いて、使い切りますッ！！！

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

---

## おわりに

ドコモメールのセッション切れ問題という日常の小さなペインから始まった今回の開発ですが、さくらのAI EngineとClaude Codeのタッグによって、実用性抜群のCLIツールとして結実しました。

「さくらのAI Engine」のAnthropic互換Messages APIを使えば、使い慣れたコーディングエージェントのパワーをそのまま国産クラウドの安心感と圧倒的な無料枠で引き出すことができます。

皆さんもぜひ、3,000リクエストの無料枠を使って、自分だけのアイデアを形にしてみてください！

---

## 参考リンク

* [TORIFUKUKaiou/mail-peek - GitHub](https://github.com/TORIFUKUKaiou/mail-peek)
* [OpenAI・Anthropic互換APIを無料で使おう！「さくらのAI Engine」3,000リクエスト使い切りチャレンジ - Qiita](https://qiita.com/official-events/bd14d28b53326d318fec)
* [さくらのAI Engine 公式ページ](https://ai.sakura.ad.jp/sakura-ai/ai-engine/)
* [Claude CodeからさくらのAI Engineを使う - さくらのAIコラム](https://ai.sakura.ad.jp/column/claude-code-messages-api-2/)
* [ドコモメール（ブラウザ版）](https://mail.smt.docomo.ne.jp/mail/)
