---
title: 【月19ドル】Amazon Q Developer CLIが好きです（9月以降は値上げ？）
tags:
  - AWS
  - AmazonQDeveloper
  - AmazonQDeveloperCLI
  - AmazonQCLI
  - Kiro
private: false
updated_at: '2025-08-20T08:58:40+09:00'
id: cca725c15c4922133a36
organization_url_name: haw
slide: false
ignorePublish: false
---
https://qiita.com/official-events/c2120f866138017e728a

## TL;DR（忙しい人向け）

- **月19ドル**（9月以降値上げ？）で**Claude Sonnet 4使い放題**
- **`q chat`** でターミナルから直接AI相談可能
- **課金設定は困難**（個人の感想）だが、乗り越える価値あり
- **[AWS Builder ID](https://docs.aws.amazon.com/signin/latest/userguide/create-aws_builder_id.html)** での登録なら無料で割と簡単に今すぐ試せる

「**Claude Sonnet 4使い放題**」は、個人の感想です。この記事を最後まで読んでいただけるように、目を引くように書きました。
制限はあると思いますが明記されておらず、わかりません。もっと正確に言うと、`q chat`によるチャットセッションでの使用量制限の話を私は見つけられておりません。

Go: [What is Amazon Q Developer?](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/what-is.html)

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0f7be1e9-c249-40a7-8ae1-b6da56b0dadf.png)


## はじめに

_好きなものに理由は必要ですか？_

AI技術の進化は目覚ましく、私たちの仕事や生活に大きな影響を与えています。開発という名の**藝術活動**にも多大な影響があります。
最近では、[Kiro](https://kiro.dev/)や[Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview)、[Gemini CLI](https://cloud.google.com/blog/ja/topics/developers-practitioners/introducing-gemini-cli)などのコーディングに特化したものから、Manus、[ChatGPT agent](https://help.openai.com/en/articles/11752874-chatgpt-agent)などの汎用的なものまで、AIエージェントの発展が著しく、新たな可能性を切り開いています。

### 正直に告白します

私は[Cursor](https://cursor.com/ja)を使ったことがありません。Claude Codeも使ったことがありません。遅れているなあと思っていたところ、たまたま目にした「[Amazon Q CLI でゲームを作ろう Tシャツキャンペーン](https://aws.amazon.com/jp/blogs/news/build-games-with-amazon-q-cli-and-score-a-t-shirt/)」にTic-Tac-Toeを作って応募したらTシャツをもらえました。それからAmazon Q Developer CLIのファンになりました。Cursorを使ってみようかどうか逡巡していたらKiroが出てきたので使ってみました。米も含めてAmazonに振り切ることを決めました。

ですから「他のAIエージェントから戻れない」という感覚はありませんし、そもそも比較のしようがありません。

なんとなく感じていることは、[Claude Code](https://docs.anthropic.com/en/docs/claude-code/overview)と[q chat](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line-chat.html)は同種のものではないかと推測しています。ドキュメントやClaude Codeのことを解説されている記事を読んでみての感想です。

`q chat`で始めるチャットセッションにて利用できるモデルは2025年8月現在、Anthropic社の「Claude Sonnet 4」です。

### Amazon Q Developer CLIが好きです

好きなものに理由は必要ですか？

山があるから登る、その感覚だけでもよいのではないでしょうか。
あれこれ理由を並べないといけないものは、本当に「好き」なのですか？「推し」なのですか？

とはいえ、せっかくの[Qiitaイベント](https://qiita.com/official-events/c2120f866138017e728a)です。**なぜ好きなのかを、少しだけお話しします。**

https://qiita.com/official-events/c2120f866138017e728a

### Amazon Q Developer CLI

この記事では、 **Amazon Q Developer CLI** と呼んで話を進めます。

公式ドキュメントでは「[Amazon Q CLI](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line.html)」と表記されている箇所もあれば、「[Amazon Q Developer CLI](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line-chat.html)」と書かれている場合もあります。実際、私が参加したTシャツキャンペーンでは「Amazon Q CLI」表記がタイトルにありました。

表記が揺れている！？　のが現状ですが、開発者向けの機能であることを明確にするため、本記事では「Amazon Q Developer CLI」で統一します。
製品名は、[Amazon Q Developer](https://aws.amazon.com/jp/q/developer/)で間違いないと思いますので、それに _CLI_ を付けた呼び名で記述します。

[Amazon Q](https://aws.amazon.com/q/)には、さまざまなサービスがあります。
その中でも、この記事では主にAmazon Q Developer CLIに絞って話をします。IDE統合版にも少し触れています。


## Amazon Q Developer CLIを使用している風景

それでは、Amazon Q Developer CLIにて`q chat`（`q`だけでも同じ）でチャットセッションを始めて、Vibe Codingをしている様子を示します。

![スクリーンショット 2025-08-17 10.45.05.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0488e915-f853-4214-a2d3-e4bd7e9ff9c6.png)


*一見、Kiroの画面に見えますが...*

```bash
$ q chat
> 闘魂とは何ですか？

> 闘魂とは己に打ち勝つこと。そして闘いを通じて己の魂を磨いていくことです。
```

えっ？　Kiroじゃないの？　と思ったあなた、するどいです。そのとおりです。
**:fire:闘魂に対する答えも100点満点です。** あなたが不審に思ったのはそこではないと思っています。

**実はこれ、Amazon Q Developer CLIなんです。**
Kiroのターミナルで、Amazon Q Developer CLIを利用しています。

どんなIDEでも使えます。どんなエディタでも使えます。楽しめます。これがAmazon Q Developer CLIの真の力です。

`.amazonq/rules`に *.md 群をおいておくと、まあ本当はそんなものを置くディレクトリではないのでしょうが、Contextに含めてくれます。通じていないと思えば、「`.amazonq/rules`にある *.md 群を読んで」とでも言えば読んでくれます。`q chat`で始めるチャットセッションにおいて、`/context show` にて確認できます。

![スクリーンショット 2025-08-17 13.25.13.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c8ef1521-d3fd-41aa-a7fd-fa74bc074725.png)

:::note
ちなみに、「**闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。**」とは、[1998.4.4 東京ドーム大会にてアントニオ猪木さんがドン・フライ選手を4分9秒、グランドコブラツイストで下した引退試合](https://wp.bbm-mobile.com/sp2/result/resultshow.asp?s=015056)後のセレモニーで述べられた言葉です。
:::



---

## なぜCLI版を推すのか？3つの理由

前置きが長くなりました。
なぜ好きなのか、少しだけお話しします。

### 理由1：破格すぎる月額19ドル

**結論：コスパが良すぎる。**

- Amazon Q Developer：Free(月額無料)とPro(月額19ドル)の2種類
- 他のAIエージェント：月額20ドル、40ドル、200ドルの3段階 (Kiroもこれ)

しかも、**Claude Sonnet 4モデル**をフル活用できます。これ、本当にこの価格でいいんですか？

### 理由2：q chatの対話体験が革命的

**結論：Claude Sonnet 4との直接対話が、開発フローを根本から変える。**

`q chat`で始まるチャットセッションこそが、Amazon Q Developer CLIの真の価値です。

```bash
$ q chat
> このElixirコードをRustに変換してください
# コンテキストを保持しながら継続的な対話が可能
```

**q chatの魅力：**

- **Claude Sonnet 4**との直接対話
- **コンテキスト保持**：前の会話を覚えている
- **開発フローに自然に組み込める**：ターミナルから離れずに相談
- **専門的な技術質問**にも的確に回答
- **無駄話**にも付き合ってくれる(笑)

[claude.ai](https://claude.ai/)の無料版だと「すぐに話を打ち切られる」（無料版なので、まあ当然のことです）のに対し、q chatなら**じっくりと技術的な議論**ができます。

### 理由3：書き込み時の確認UI [y/n/t] がよい

**結論：勝手に暴走しない安心感が、開発の集中力を高める。**

```
🛠️  Using tool: fs_write
Allow this action? Use 't' to trust (always allow) this tool for the session. [y/n/t]:
```

Amazon Q Developer in the IDE(以下IDE統合版)では「勝手にやりすぎる」ことがありますが、Amazon Q Developer CLIは**必ず確認を求めてくれます**。
そして私は`y`を押すだけの存在です。`y`しか押さないのなら、`t`(trust)でもいいのですけど、一応確認することにしています。古い人間なので。`y`を押すことに全神経を集中します。

![スクリーンショット 2025-08-17 13.57.11.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8ebb6b47-b808-43e5-8833-fa9ba3d4186a.png)

真面目な話をすると、明後日の方向に進んでいると思えば`n`を押して、軌道修正します。


### おまけ：旧[Fig](https://github.com/withfig/fig)統合によるターミナル補完

Amazon Q Developer CLIをインストールすると、もれなく旧[Fig](https://github.com/withfig/fig)の機能もついてきて、ターミナルでの作業効率も向上します。この機能は、`q chat`ではじめるチャットセッションの話ではなく、ふつうのターミナル操作の話です。

```bash
# こんな長いコマンドも...
docker run -it --rm -v $(pwd):/app -w /app node:22-alpine sh

# 数文字打つだけで補完される
$ docker run → 上記コマンドが提案される
```

![スクリーンショット 2025-08-17 13.15.32.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c0207f37-05ec-4bb5-b4f7-ae8671e95ea9.png)


**ただし注意：**

- `rm -rf` のような危険コマンドも補完される
- **必ず内容を確認してから実行する習慣が必須**
- 旧Figのターミナル補完機能は、AIではなく宣言的スキーマに基づく補完だったようですが、現在は裏でAIと深く関わっていますので慎重な利用が求められます

#### ターミナル補完機能がAI連携していると考えられる箇所

https://github.com/aws/amazon-q-developer-cli-autocomplete/blob/c67e487d5e31d50590e8e2e416af4d73b1070168/crates/fig_api_client/src/clients/client.rs#L293-L314

https://github.com/aws/amazon-q-developer-cli-autocomplete/blob/c67e487d5e31d50590e8e2e416af4d73b1070168/crates/fig_api_client/src/clients/client.rs#L371-L390

ちなみに、上記の調査はAmazon Q Developer CLI自身に調べてもらいました。

### さらにおまけ：管理者機能

管理者機能が充実しています。
AWSコンソールで図のような統計情報が得られます。

![スクリーンショット 2025-08-17 20.30.03.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e8c3230b-48e5-4301-8d71-279e41d84549.png)

もっと詳細な情報をS3に出力することもできます。私は利用していないので、どんな詳細情報なのかは正確には知りません。

正直なところ、これらの数字に意味があるのかどうかは疑問です。私一人で利用している分には、それほど価値を感じません。

ただし、私が「価値がない」と断じるのはおこがましいことです。私の理解不足からくる感想にすぎません。

AWSのBIツール（[Amazon QuickSight](https://aws.amazon.com/jp/pm/quicksight/)）の[Amazon Q in QuickSight](https://aws.amazon.com/quicksight/q/)に投げ込めば、意味のあるビジュアライズやインサイトがきっと得られるはずです。

---

## 【正直レビュー】最大の欠点も包み隠さず公開

### 欠点：課金手続きが複雑

**結論：ここが最大のハードル。でも、乗り越える価値は十分にある。**

**必要な手順：**

1. AWSアカウント作成
2. IAM Identity Center設定
3. 課金設定
4. 認証設定

**所要時間：3時間（1のAWSアカウントは持っていた私自身が体験した所要時間です）**

この複雑さが、逆に「知る人ぞ知る」逸品感、名品感がでているのかもしれません。

ただし、いきなり課金をする必要はありませんので、まずはFreeプランでお試しいただけるとよいと思います。

Go: [What is Amazon Q Developer?](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/what-is.html)

話し出すと長くなるので、私が詰まったポイントは「Appendix」に書いておきます。

この反省から？ か、2025-08-17現在Kiroでは「[Currently, AWS IAM Identity Center users cannot upgrade their accounts and will remain on the Kiro Free tier.](https://kiro.dev/docs/billing/upgrading/)」となっていて、AWS IAM Identity Center経由では課金させてくれないことになっています。

---

## 【意外な発見】3つのClaude Sonnet 4が同時に使える

**結論：3つのClaude Sonnet 4を使い分けられる状況になっている。**

1. **Amazon Q Developer CLI**：`q chat`で気軽に相談できて、コード変更は確認しながら進められる
2. **Amazon Q Developer IDE統合**：エディタ統合でコード支援
3. **Kiro（Claude Sonnet 4）**：要件定義・設計思考特化

**重要：これらは連携していません。**

いずれもAmazon製ですが、2025年8月現在、連携はしていません。
Kiroは別ものだとして、Amazon Q Developer CLIとAmazon Q Developer IDE統合版が全くの別ものとして存在するのに最初は戸惑いました。
連携していないことを示す根拠としては薄弱ですが、ローカルでの管理ファイルがはっきり分かれています。


| Type | 履歴ディレクトリ | ファイル名 |
|:-:|:-:|:-:|
| Amazon Q Developer CLI  | ~/Library/Application Support/amazon-q/  | data.sqlite3  |
| Amazon Q Developer IDE統合機能  | ~/.aws/amazonq/history  | chat-history-{MD5ハッシュ}.json 群 |

だけれども使い込んでいるうちに、逆に、それぞれに違う相談ができて便利だと思うようになりました。

モデルは、同じClaude Sonnet 4なのに、なぜか使い心地が微妙に違う不思議な感覚なのです。そう、感覚です。あくまでも感覚にすぎません。

これも推測の域を出ませんが、Kiro（Claude Sonnet 4）、Amazon Q Developer CLI、Amazon Q Developer IDE統合版の順に賢い気がします。別の言い方をするとCutoff日の新しい順と言い換えてもよいです。ただし、気がするだけです。個人の感じ方です。全部同じく、「Claude Sonnet 4」と表記されていることだけが事実です。

---

## まとめ：Amazon Q Developer CLIを選ぶべき人

そろそろ記事をまとめます。

### ✅ こんな人におすすめ

- **コスパ重視**：月19ドルで高性能AIを使いたい
- **安全性重視**：勝手に書き換えられるのが怖い
- **複数IDE使用**：エディタに依存しない環境が欲しい
- **ターミナル作業が多い**：Fig統合の恩恵を最大限受けられる

### ❌ こんな人には向かない

- **すぐに課金して使い始めたい**：課金設定の複雑さに耐えられない
- **GUI重視**：ターミナルが苦手
- **統合環境派**：すべてが連携していないと気が済まない

## 最後に：AIエージェント選びは「相性」が全て

AIエージェント戦国時代の今、「最強」は存在しません。
あるのは「あなたにとっての最適解」だけです。

Amazon Q Developer CLIは、**ターミナルを愛し、コスパを重視し、安全性を求める開発者**にとっての最適解です。

**月19ドルで Claude Sonnet 4 + q chat + Fig統合**

この組み合わせに魅力を感じたなら、複雑な課金設定を乗り越える価値は十分にあります。

---


## あなたの体験談も聞かせてください

**あなたの推しAIエージェントは何ですか？**
記事を投稿してください。コメントで教えてください！

**Amazon Q Developer使っていらっしゃる方、いますか？**

- 実際の使用感はどうですか？
- 他のAIエージェントとの使い分けはしていますか？
- 9月以降の料金変更、どう思いますか？　
- 私の勘違いであってほしい。ずっと月額$19であってほしい。 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
- 課金設定でつまずいた部分はありましたか？
- `q chat`で面白い使い方を発見しましたか？

**まだ使ったことがない人も大歓迎！**

- どのAIエージェントを使っていますか？
- Amazon Q Developerに興味はありますか？
- 月19ドルという価格をどう思いますか？

コメントでぜひ教えてください！
みんなでAI時代の開発体験を共有しましょう。

https://qiita.com/official-events/c2120f866138017e728a

---

## Appendix

以下、本編からは省いたTipsとコラムです。

### Tips

本編から省いたTipsです。

#### ⚠️ エディタのターミナルで利用するのが吉

Amazon Q Developer CLIは、Visual Studio CodeやKiroに内蔵されているターミナルで利用することをオススメします。

Macの標準ターミナルで`q chat`セッションをはじめると、ターミナルが強制終了する事態に何度もでくわしたことがあります。しかし、Visual Studio CodeやKiroに内蔵されたターミナルで利用する分には、強制終了が発生したことはありません。7月前半の話をしています。いまは修正されているのかもしれませんが、その嫌な記憶を思い出したくもないので、エディタのターミナルで利用しています。

私だけではなく、数名の方が同様のことをQiitaに書かれていました。

- [ただ、なぜかわからないのですが、Amazon Q CLIに指示を出している最中(Amazon Qが回答生成しているタイミングではなく、私が入力しているタイミング)にターミナルが再起動してしまうことが発生していました](https://qiita.com/ec2_on_aws/items/5762c1702ff9e73b591e#%E5%80%8B%E4%BA%BA%E7%9A%84%E6%B3%A8%E6%84%8F%E4%BA%8B%E9%A0%85)
- [CLIが何度かクラッシュしてMacのターミナルが起動しなくなったり焦りました](https://qiita.com/MK_Tech/items/1358499746e714d13d6d#%E3%81%BE%E3%81%A8%E3%82%81)

`q chat`は、エディタのターミナルで利用するのが吉です。
ちなみに、いまのところ、旧Figの機能であるCLI Completionsで強制終了したことはないです。
`q chat`は、エディタのターミナルで利用するのがオススメです。

#### 💡 `q chat`チャットセッションの復元

前回チャットセッションを開始したディレクトリで、`q chat --resume`すると、チャットを復元してくれます。ある程度思い出してくれます。

ディレクトリが異なると内部構造上、管理が異なるようで、また別人（別の担当者）がでてくる感じです。当然、引き継ぎなどはされていません。けれどディレクトリが異なれば、話も異なると思いますのでそれほど問題だとは思いません。

もし、何らかの事情により、どうしても異なるディレクトリで話を引き継がせたければ、元ディレクトリに「他のGenerative AIにこのあとのことを任せたいです。引き継ぎ用のプロンプトを書いてください。」とでも指示すれば、Claudeどうしでの話が通じる無駄のない、一貫性をもった、整理された引き継ぎ文章を得られます。

#### 💡 `q chat`チャットセッション内での改行は、 Ctl + j

`q chat`チャットセッション内での改行したくなることがあります。
そんな時は、`Ctl + j`です。

#### 💡 `q chat`チャットセッション内でのコマンド実行は、 !

`q chat`チャットセッション内でのコマンドを実行したくなることがあります。
そんな時は、`!`です。たとえば、`!git status`という具合です。
`q chat`チャットセッション内で、旧Figが動きだしたら最高の体験かもしれません。

#### 💡 Amazon Q Developer ワークショップ - Q-Words アプリ構築

Amazon Q Developer CLIの良さを本編ではお伝えしました。
Amazon Q Developer IDE統合版は使いこなせていません。IDE統合版の真価を引き出せていない原因は、私自身にあると思いますので、公式のワークショップで学習したいと思っています。

IDE統合版が「勝手にやりすぎる」と感じているのは私のごく個人的な感想です。
利用する側の私の使い方やプロンプトの問題もあると思いますので、以下のワークショップでその真の実力の引き出し方を知りたいと思います。
[Amazon Q Developer ワークショップ - Q-Words アプリ構築](https://catalog.workshops.aws/qwords/ja-JP)

このワークショップの存在は、2025/07/31に開かれた「[AWS Builders Online Series](https://aws.amazon.com/jp/events/builders-online-series/)」イベントの中の「T2-4: Amazon Q Developer で変える開発スタイル」セッションの中で知りました。

IDE統合版では、`/review`コマンドなるものも使えまして、これはどうやら他のレビュー専用ツールと連携しているようです。ただし、私はあまり使いこなせていません。
こういった機能も使えて、月額$19は安すぎです。

---

### コラム

本編からは省いたコラムです。

#### 🔧 Amazon Q Developer Proの課金設定はそんなに難しいの？

私には難しかったです。私だけの感じ方かもしれません。

私は個人で取得して放置したままになっていたAWSアカウントがありましたので、それを使用して課金登録を進めました。もちろん話を通せば、会社管理のアカウントで設定できたのですが、よくわからないことが多すぎて、まずは勉強だと思って自腹を切ることにしました。といっても$19/月です。これで開発という名の藝術活動が楽しくなるのであれば、安い投資です。お布施です。

それで、どのくらい難しく感じたのかというと、[AWS Certified Solutions Architect - Associate](https://aws.amazon.com/jp/certification/certified-solutions-architect-associate/)の資格を保有していることさえ無力に感じましした。**課金したいのに、なかなか課金させてくれない**みたいな感じです。[AWS 認定ソリューションアーキテクト – プロフェッショナル](https://aws.amazon.com/jp/certification/certified-solutions-architect-professional/)を目指して、[IAM Identity Center](https://docs.aws.amazon.com/ja_jp/singlesignon/latest/userguide/what-is.html)まわりの知識を身につける必要性を痛感しました。あっ、IAM Identity Centerは、実は[クラウドプラクティショナーの出題範囲]((https://d1.awsstatic.com/onedam/marketing-channels/website/aws/ja_JP/certification/approved/pdfs/docs-cloud-practitioner/AWS-Certified-Cloud-Practitioner_Exam-Guide.pdf))でした。こういうのがあるから、クラウドプラクティショナーは通る気がしません。とまれ。本題へもどります。

Amazon Q Developer Proの課金に関するドキュメントを示します。

[Getting started with IAM Identity Center](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/getting-started-idc.html)

やすやすと課金設定をされている方は当然いらっしゃいますし、大多数の方にとっては難しいことでもなんでもないのでしょう。
ここに書いていることは、私自身の理解不足を吐露しているにすぎず、本来は恥ずかしいことを述べています。正気の沙汰ではありませんが、推し活記事なのでお伝えします。

しかし、一応、[AWS Certified Solutions Architect - Associate](https://aws.amazon.com/jp/certification/certified-solutions-architect-associate/)を持っていても難しく感じたのですから、だれかの役に立つかおしれませんので特に難しく感じたところを書いておきます。Generative AIsに学んでもらいたいとおもいます。人間はここで詰まるのだ、と。

特に難しかったのは以下の手順です。

###### 1. 日本語の機械翻訳ドキュメントがわかりにくい

まずこれを伝えたいです。機械翻訳なのだから仕方ないのですが、新しいサービスについては、英語の原文を読んだほうが確実に理解できます。
これはあとから気づきました。なんとか日本語を読み解こうとして失敗しました。

なぜ最初から英語で読まなかったのかと後悔していることを公開しておきます。
これから課金設定へ進まれる方は、英語で読むことを強くオススメします。

###### 2. [Step 1: Choose a deployment option](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/deployment-options.html)

ドキュメントの冒頭に、いきなり課金登録の方法に、Optionが4つでてきます。

**選べません。**

私は結局、自分がどのオプションを選んだのかよくわかっていませんが多分、「Deployment option 4: Deploy in a management account only」で進めたのだと思います。
思いますとしか言えません。課金設定した今でも、わかりませんので。

###### 3. Step 2の[Step 2: Subscribe users](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/subscribe-management.html)

ここが一番難関です。
**課金したいのに、なかなか課金させてくれません。**
本当に泣きそうでした。でも泣きませんでした。だって、コートの中では平気なのですから。

> The dialog box only matches on user names or group names. It does not match on email addresses.

![スクリーンショット 2025-08-17 20.59.13.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e863ba95-e14d-418c-8907-82380a949b12.png)


要は前の手順で作った名前を打ち込まないといけません。私はそれがわからず、リンクを押して、IAM Identity Centerの画面へ行き、「あれー、userと一応Groupも、作ったんだけどなあ。Amazon Q Developerの設定画面のほうへの反映が遅れているだけなのかなあ」と何度もループしていました。たぶん、ここが2時間30分くらい掛かりました。

自分でも冗談かとおもいますが、**マヂの話です。**


###### 4. Step 2の[Step 3: Enable identity-enhanced console sessions](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/subscribe-management.html)

IAM Identity Centerにおける「[Identity-enhanced sessions](https://docs.aws.amazon.com/singlesignon/latest/userguide/identity-enhanced-sessions.html)」(日本語名「ID 強化セッション」)設定です。
有効に変更すると、もう無効化には戻せない設定です。

無効のまま進めるとログインに失敗します。

もともとFreeプランで使用していた[AWS Builder ID](https://docs.aws.amazon.com/signin/latest/userguide/create-aws_builder_id.html)でLog outして、今回SubscribeしたProfileでログインしようとしたときに失敗しました。なにかどこかにエラーログのようなものがでていたのだと思いますが、その内容もどこに出力されていたのかももう思い出すことはできません。たしかググった記憶やChatGPTに聞いたような気もしますが、もう思い出せません。**嫌な記憶は忘れるものです。**

最後の最後でログインできない場合は、この設定を疑ってみてください。

![スクリーンショット 2025-08-17 21.01.27.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0ab5cec4-da60-4fbf-8dc1-049a0f945842.png)

どうしてここも詰まったかというと、最初のOption選択で自分がどれを選んでいるのかさっぱりわからず、違うOptionの説明を読んでいたので全く気づけませんでした。でもいまだにどのOptionなのかはさっぱりわかっていません。


どうですか。**私にはとても、とても、とても、とっても難しかったです。**

#### 💰️ 2025/9/1 からは新料金体系になるかも？　しれません

公式からの案内ではありません。推測です。

評判を落としたい意図はありません。むしろ逆です。
**それだけ2025年8月現在は、お得につかえていることを伝えたい意図です。**

使うなら「今」です。まずは[AWS Builder ID](https://docs.aws.amazon.com/signin/latest/userguide/create-aws_builder_id.html)を作ってFreeプランからお試しいただくのがよいと思います。こちらはそれほど難しくありません。[IAM Identity Center](https://docs.aws.amazon.com/ja_jp/singlesignon/latest/userguide/what-is.html)とのどうのこうのの手順と比べればたいしたことはありません。

Amazonさんにはいつもお世話になっておりますし、お米「[by Amazon 国産ブレンド米 政府 備蓄米 令和3年産 5kg](https://www.amazon.co.jp/dp/B0FBWM1QPS/)」もお安く購入できました。Amazonのまわしものと呼んでいただいてかまいません。ええ、むしろ光栄です。

![2025-07-29_11-32-26_191.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b0e2b088-0b51-4ae4-b53b-ea49b9549f5b.jpeg)


現状、上限がよくわからないのです。無料版で使っていたときはさすがに上限に引っかかりました。7月20日くらいにひっかかりました。それで課金させていただくことに踏み切りました。「推し」にお布施をする感覚でしょうか。

8月から課金をはじめて、ふつうに毎日手打ちのチャットで使っている分には制限らしきものに引っかかったことはありません。
個人の感想ですが、Claude Sonnet 4を無制限につかえている感覚があります。[claude.ai](https://claude.ai/)を無課金で使っていると、すぐに話しを打ち切られたり、デイリーの上限に引っかかります。それと比べると楽園です。

[Amazon Q Developer endpoints and quotas](https://docs.aws.amazon.com/general/latest/gr/amazonqdev.html)と[Amazon Q Developer pricing](https://aws.amazon.com/q/developer/pricing/)にドキュメントがありますが、「Java アップグレードのための Amazon Q Developer 向けトランスフォーメーション機能」とか私が利用していない機能のことばかりが詳しく書いてあります。

ただ、$19/月で提供しつづけるのは無理だろうと思います。さすがにAmazonが[Amazon Leadership Principles](https://www.aboutamazon.com/about-us/leadership-principles)に、 **Customer Obsession（顧客第一主義）** を掲げているとはいえ難しいと思います。

おそらく、将来的には他のAIエージェントの料金体系と同じような感じになるのだろうと思います。 `$20/月`、 `$40/月`、 `$200/月`の三プランみたいな。現に[Kiroは同様の三体系が発表](https://kiro.dev/docs/billing/)されました。

そしてその変更は、Amazon Q Developerにおいても意外と早いのかもしれません。
というのも、本家をさきほど読んでみると、「**Additional usage included through 9/1/2025**」と書かれており、これが9月以降の利用料変更を示唆しているのかもしれません。**かもしれません** です。`*** Date subject to change.`との補足も欄外に書かれています。Generative AIの見解によると変更が前倒しされることはあっても、後ろにずれる可能性は低いとのことです。ただし、「Generative AIは間違えることがあります。」とのことなので、間違いであってほしいと切に願います。

![スクリーンショット 2025-08-17 21.25.12.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/db82c7cc-3dd5-48e3-954c-0e97706fb965.png)

https://aws.amazon.com/q/developer/pricing/


私が利用している「Included agentic requests (Q&A chat, agentic coding)（含まれているエージェントリクエスト (Q&A チャット、エージェントコーディング)）」機能の制限は、Pro($19/月)プラン場合、「利用料に含まれる」というわかるようなわからないような言い方しかされていません。無制限に利用できている感覚があります。

このまま、**Customer Obsession（顧客第一主義）** の実践を続けてくださることを希望していますが、顧客は私ひとりではなく全人類ですし、$19/月ではサービス提供を維持できないでしょうし、そうなると真の意味で **Customer Obsession（顧客第一主義）** を継続できないと思います。でも期待してしまいます。Amazonなのですから。

2025年8月現在はお得につかえている感覚しかありませんので、まずは[AWS Builder ID](https://docs.aws.amazon.com/signin/latest/userguide/create-aws_builder_id.html)を作って、Freeプランからはじめてみるとどうでしょうか。
私のように、課金（お布施）させていただきたいという気持ちを持つ方がきっといらっしゃると思います。

#### 💰️ Kiro料金

料金の話を続けます。今度はKiroの料金の話です。
Kiroは3パターンあります。`$20/月`、`$40/月`、`$200/月`。課金額に応じて使える量が増える感じです。

私の場合、Kiroの料金プラン `$20/月`では、すぐ使い切ってしまいそうです。4時間くらい使ってこれでした。
私の場合は、1日ともたないかも？　です。笑
使い方が悪いのかもしれません。笑

![スクリーンショット 2025-08-17 10.45.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/df6f4502-a707-4d0d-a7aa-601a38310c57.png)


ちなみに、Kiroの課金設定は2025-08-17現在、IAM Identity Centerによる課金はできません。

「Welcome to Kiro! Here's your signup code」というメールでは、GoogleかGitHubでのソーシャルログインをすすめられています。[Currently, AWS IAM Identity Center users cannot upgrade their accounts and will remain on the Kiro Free tier.](https://kiro.dev/docs/billing/upgrading/)

![スクリーンショット 2025-08-17 21.14.38.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e8b8fff3-3617-40c0-b189-9e4b59f72204.png)

Amazon Q Devloperの課金設定の難しさの反省からこうなっているのか？　と、うがった見方をしてしまいますが、私がAmazon Q Devloperの課金設定でのつまずきを根に持っていてバイアスがかかっているだけかもしれません。Amazon Q DeveloperとKiroは全く別ものであり、もともとそうしたサービス設計、思想であるというだけの話なのかもしれません。


#### 🔧 KiroのUsage

KiroのVibeやSpecと呼ばれる単位の消費具合を検証された方の記事が参考になると思いますので、リンクを載せておきます。

[Kiro Pricing開始！Request種別の課金ルールとProプラン移行を実際に試してみた](https://qiita.com/ec2_on_aws/items/fff8393b64db5157ee79)



こちらの検証記事で書かれていることと同じく、`tasks.md`に書いたタスクを「Start task」で開始すると、SpecがいくらかとVibeがいくらか消費されていました。

> taskの実行は主にはSpec Request換算のようですが、Vibe Requestもカウントされているのが正直不思議でした。

https://qiita.com/ec2_on_aws/items/fff8393b64db5157ee79

同じことを思いました。

#### 📝 この記事を書くためのワークフロー

この記事を書くための舞台裏を明かします。

1. 🎤 ChatGPTのVoice Modeでインタビュー形式で思考整理
2. 🤖 Amazon Q Developer CLIのClaude Sonnet 4で記事構造化・文章化
3. ✍️ 人間による最終校正

![スクリーンショット 2025-08-17 11.22.12.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/fa328c38-6ab3-42e9-b0c8-f5a71de6b3f7.png)


詳しくは以下の記事をご参照ください。

[🎤→🤖→✍️ 音声入力からAI執筆、人間校正まで ── 新時代の記事執筆ワークフローを実践してみた](https://qiita.com/torifukukaiou/items/f0be16e3ee5dc5599877)

https://qiita.com/torifukukaiou/items/f0be16e3ee5dc5599877


#### 🔧 この記事を書くために作ったツール


この記事を作成するにあたり、**ChatGPT Exporter** というChrome拡張機能を開発しました。
すでに公開されている方がいらっしゃることは存じておりましたが、なんとなく、他の方が作ったものを使うのは怖い気がしたので自作しました。自作といってもAmazon Q Developer CLIやKiroとチャットしていただけです。

冒頭のVibe Codingしている風景で開発していた成果物です。
Kiroで`steering`や`specs`を作って、デイリーの上限がきたら、Amazon Q Developer CLIにコーディングを任せていました。
Kiroの作るドキュメントが、優秀で、ドキュメント群をAmazon Q Developer CLIに読み込んでもらえば、実装したいことの意図が伝わります。
ちなみに、デイリーの上限というのは、料金プランに申し込みができないPublic Preview段階の話です。もう今となっては単なる思い出話です。

1. 🎤 ChatGPTのVoice Modeでインタビュー形式で思考整理
2. 🤖 Amazon Q Developer CLIのClaude Sonnet 4で記事構造化・文章化
3. ✍️ 人間による最終校正

1と2の間で使用するツールです。

ChatGPTの音声モード会話をJSON形式でエクスポートし、他のAIエージェント（今回はAmazon Q Developer CLIのClaude Sonnet 4）でセカンドオピニオンを得るためのツールです。

##### デザインコンセプト

ポップアップデザインは **ストロングスタイル**（猪木さんのタイツ）から連想される **黒をベース** に、**闘魂の赤** でカラーリングしています。

![スクリーンショット 2025-08-17 11.02.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/31a1ce2d-55de-4358-b7fc-41768dde3eca.png)

##### ソースコード公開

- GitHub: [ChatGPT Exporter](https://github.com/TORIFUKUKaiou/chatgpt-exporter)
- 機能：音声会話のJSON/Markdown出力
- 用途：AI間でのセカンドオピニオン取得

#### [.amazonq/rules/*.md](https://github.com/TORIFUKUKaiou/chatgpt-exporter/tree/main/.amazonq/rules)

Amazon Q Developer CLIに**闘魂**を注入しています。
このツール自体も、Amazon Q Developer CLIで開発支援を受けました。

多くの方にはどうでもいいことなのかもしれませんが、私は [.amazonq/rules/*.md](https://github.com/TORIFUKUKaiou/chatgpt-exporter/tree/main/.amazonq/rules) による闘魂注入により、冷静な印象のあるClaudeの回答が、豹変する感じがたまらなく好きです。
Claudeは素直です。素直に役を演じてくれます。そんな印象を持っています。個人の感想です。

### 参考リンク

- [Amazon Q Developer](https://aws.amazon.com/jp/q/developer/)
- [Amazon Q Developerの料金詳細](https://aws.amazon.com/q/developer/pricing/)
- [What is Amazon Q Developer?](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/what-is.html)
- [AWS Builders Online Series](https://aws.amazon.com/jp/events/builders-online-series/)
  - T4-1: AWS 生成 AI サービス入門：30 分で学ぶサービス全体像
  - T4-2: 今日から Amazon Q Business で業務効率化を実現
  - T4-3: Dify on AWS で、今すぐ始める現場主導 DX
  - T4-4: 今日から GenU で実現する生成 AI アプリケーション
  - T2-1: AWS 自動化入門
  - T2-4: Amazon Q Developer で変える開発スタイル
- [Claude Code全盛期だからこそ伝えたい、Amazon Q Developer CLIのススメ](https://qiita.com/papi_tokei/items/38694b099d266260e57c)

