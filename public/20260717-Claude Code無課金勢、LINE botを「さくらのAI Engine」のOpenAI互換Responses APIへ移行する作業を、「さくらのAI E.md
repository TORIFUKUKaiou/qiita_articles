---
title: >-
  Claude Code無課金勢、LINE botを「さくらのAI Engine」のOpenAI互換Responses APIへ移行する作業を、「さくらのAI
  Engine」自身に実装させたらCodexレビューを通過した
tags:
  - さくらのAI
  - 猪木
  - 闘魂
  - ClaudeCode
  - codex
private: false
updated_at: '2026-07-18T00:12:42+09:00'
id: c3adf542824e4d5ae7b2
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: bd14d28b53326d318fec
agreed_posting_campaign_term: true
---
## はじめに

私は、[Claude Code](https://claude.com/ja/product/claude-code)をこれまで一度も使ったことがなかった。

Claudeの有料プランにも加入していない。

私は、**Claude Code無課金勢**である。

そんな私が、さくらのAI Engineの公式記事を見つけた。

https://ai.sakura.ad.jp/column/claude-code-messages-api-2/

[さくらのAI Engine](https://ai.sakura.ad.jp/sakura-ai/ai-engine/)は、Anthropic互換のMessages APIを提供している。つまり、Claude Codeという道具へ、Claudeではなく、さくらのAI Engineが提供するモデルを接続できる。

![スクリーンショット 2026-07-17 11.45.43.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/18d7cf78-a161-4998-9e31-3a358f879b77.png)


公式ページによると、この記事を書いている時点で、Messages APIで利用できるモデルは `preview/Kimi-K2.6` である[^1]。Claude Codeの頭脳をKimi K2.6へ載せ替えてみた。

[^1]: https://ai.sakura.ad.jp/sakura-ai/ai-engine/ には、2026-07-16現在、「※ 現在ご利用いただけるモデルは「preview/Kimi-K2.6」のみとなります。」と書いてある。ただし、私の観測では、MessagesAPI対応 のタグがついた `preview/gemma-4-31B-it` も動いた。1ファイルのテトリスを書き出させ、ブラウザで実際に遊べるところまでは確認した。ただし、この程度の検証だけで、Claude Codeとの互換性や実用性まで評価するつもりはない。このへんは、実際の提供内容の進化と広報のズレがとても現代的だと思った。

これはおもしろい。

私は、さくらのAI EngineをClaude Codeへ接続し、実際のコード変更を任せてみることにした。

題材は、LINE botが使っている[ai&](https://www.aiand.com/jp/)のOpenAI互換Responses APIを、さくらのAI EngineのOpenAI互換Responses APIへ載せ替える作業である。

多少の誤解を恐れずにいえば、**さくらのAI Engineへの移行を、さくらのAI Engine自身に実装させる。**

---

![スクリーンショット 2026-07-17 19.17.53.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ccfac938-1da5-49b6-8511-74a0a4c80886.png)


**さくらが、さくらを実装し、さくらを呼び出す。**
**AI輪廻転生図**。

---


さくらのAI Engineで動くClaude Codeが、LINE botを、さくらのAI Engineで動くように書き換える。

入れ子である。自己参照である。やるしかない。

今しかないぞ、俺たちがやるのは。[^3]

[^3]: 長州力の名言。 https://note.com/naka_accord/n/n190b24a851e5

## 「エージェントハーネス」とは何か

この記事では、Claude Codeを「エージェントハーネス」と呼ぶ。

私が勝手に格好をつけているわけではない。[Anthropicの解説](https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents)では、エージェントハーネス（または `scaffold`）を、モデルがエージェントとして行動できるようにする仕組み――入力を処理し、ツール呼び出しを取り回し、結果を返すシステム――と説明し、Claude Codeをその例に挙げている。

私は、**モデルが頭脳なら、ハーネスは仕事場と手足と段取りを与えるもの**と解釈している。

今回おもしろかったのは、Claude Codeというハーネスはそのままに、中で働くモデルをさくらのAI Engine側へ差し替えた点である。

## 使い切りチャレンジ

私は[Kiro CLI](https://kiro.dev/cli/)をAmazon Q Developer CLIと呼ばれていたころから使っている。Codex CLI、Gemini CLI、Antigravity CLIの経験もある。最近はCodexのアプリとAntigravity 2.0を主に使っている。それぞれ約3,000円/月のプランに入っている。

Antigravity 2.0の方は使用量に不足を感じたことはない。利用量の上限はもちろんあるが、実質無制限と思えるくらい私は使えている。もちろんもっと高度な使い方をしている人からすると、全然足りないのかもしれないが、私は価格のわりに多くの回数を使えていると評価している。ちなみに、Google Driveの保存容量が5TBになり、[YouTube Premium Liteの特典](https://support.google.com/googleone/answer/17101453?hl=ja)もある。

Codexではいま、GPT-5.6の登場を祝うかのように、連日のように週次上限がリセットされているが、その祭りもいずれ終わるだろう。こちらは常に使用量を気にしながら使っている。成果はものすごくいい。

しかし、Codexはいつも弾切れが気になる。他の選択肢を持っておきたいと思っていた。

そんなとき、次のキャンペーンを見つけた。

https://qiita.com/official-events/bd14d28b53326d318fec

**「さくらのAI Engine」3,000リクエスト使い切りチャレンジ。**

ネーミングがいい。

**$\huge{使い切りチャレンジ}$**

使うしかない。いまやるしかない！！！

token消化ではなく、**$\huge{闘魂昇華}$**。無料枠を、闘って、磨いて、使い切りますッ！！！

## まずCodex CLIでは、うまく動かなかった

最初はCodex CLIへさくらのAI Engineを接続した。Claude Codeはインストールすらしておらず、試すのを面倒に感じていた。

チャットはできた。マインスイーパーを作ってと言えば作った。しかし、既存リポジトリを読み、APIを載せ替える仕事を頼むと、作業を始めてすぐにReady状態へ戻ってきた。

根気よく指示を出せば進んだのかもしれない。設定が悪かった可能性も否定できない。しかし、そこまで付き合いきれないと思った。

Claude Codeでも同じ結果になるのではないか。

私は半信半疑だった。それでも公式がClaude Codeとの連携を掲げている。試さないわけにはいかない。

果たして――。

## 正解は、すでにある

今回の対象は、AWS CDKで構築したLINE botである。

もともとOpenAIのResponses APIを使っていたが、以前、ai& InferenceのOpenAI互換APIへ移行した。

https://qiita.com/torifukukaiou/items/4041ef2b82f096398ce5

そして、さくらのAI Engineへの移行も、実はすでにCodex（GPT-5.6 Luna、xhigh）で完成させていた。`main` ブランチには、私がレビュー済みの正解がある。

https://qiita.com/torifukukaiou/items/747284dcd98157bdfad6

そこで移行前のコミットへ戻し、Claude CodeとさくらのAI Engineへ同じ仕事を頼んだ。

- 移行前のコード
- Claude Codeが作る実装
- Codexが作った正解

これらを比較できる。

「なんとなく動きそう」ではない。正解のある実験である。

## 最初の `/init`、4分32秒

Claude Codeで最初に `/init` を実行した。リポジトリを読み、作業指針となる `CLAUDE.md` を作るコマンドである。

API Errorが何度も起きた。リトライまで60秒待たされることもあった。

正直、この時点では厳しいと思った。

しかし、Claude Codeは4分32秒かけて `CLAUDE.md` を作り切った。

そこには、Receiver LambdaとWorker Lambdaの分担、非同期呼び出し、DynamoDBの会話メモリ、SSM Parameter Store、CloudWatch、GitHub Actions、ビルドやテストのコマンドまで書かれていた。

READMEを写しただけではない。コードを読んだ形跡があった。

少し期待が高まった。

## さくらのAI Engineへの移行を頼む

Claude Codeへ、エンドポイント、利用モデル、公式ドキュメントを示し、ai&からさくらのAI Engineへ載せ替えるよう依頼した。

> このリポジトリはAI&のOpenAI互換APIを使っています。  
> さくらのAI Engineへの載せ替えを考えています。  
> エンドポイントは `https://api.ai.sakura.ad.jp/v1/responses` です。  
> モデルは `llm-jp-3.1-8x13b-instruct4` を考えています。  
> コーディングしてください。  
> ドキュメントは、 https://manual.sakura.ad.jp/cloud/ai-engine/02-howto.html#api です。

表面だけなら変更は三つに見える。

1. `baseURL`
2. モデル名
3. APIキー

だが、実際には環境変数、SSM Parameter Store、LambdaのIAMポリシー、CDK、GitHub Actions、テスト、READMEまでつながっている。

単純な文字列置換では終わらない。

Claude Codeは途中でWeb検索の許可を求めた。許可すると公式仕様を調べ、コードを書き始めた。

相変わらずAPI Errorは頻発する。60秒待つ。

しかし、仕事をやめなかった。

- リポジトリを読む
- コードとREADMEを変更する
- `npm run build` と `npm test` を実行する
- 差分を確認する
- Gitへコミットする

実装には13分54秒。コミットには、さらに1分35秒かかった。

API Errorがなければもっと速かっただろう。それでも、最後まで終えた。

```text
commit addb4e54ada589274d114444bb0c2d9dd83fe686 (HEAD -> commit-bf42fa6437d16410228349b7ecf6fd10eff2f041)
Author: Awesome YAMAUCHI <torifuku.kaiou@gmail.com>
Date:   Thu Jul 16 23:06:26 2026 +0900

    feat: migrate text generation API from AI& to Sakura AI

    - Update endpoint to https://api.ai.sakura.ad.jp/v1
    - Switch model to llm-jp-3.1-8x13b-instruct4
    - Rename AIAND_API_KEY_PARAM_NAME to SAKURA_API_KEY_PARAM_NAME
    - Update CI/CD, tests, README, and CLAUDE.md accordingly

    Co-Authored-By: Claude <noreply@anthropic.com>
```

:::note warn
`API Error` について

記事中、`API Error` が何度も発生したと書いている。これは、2026年7月16日（木）22:00〜23:30ごろの話である。

Claude Codeのようなエージェントハーネスは、1回の指示を完了するまでに、モデルとのやり取りを何度も重ねるものだと私は理解している。そのため、何らかのレート制限にかかった可能性もあれば、私のネットワーク環境に問題があった可能性もある。

原因は特定できていない。

この記事では、私が体験したことをそのまま書いている。
:::

## 何を変えたのか

中心となる変更は、これである。

```diff
- new OpenAI({ baseURL: "https://api.aiand.com/v1", apiKey: aiANDAPIKey })
+ new OpenAI({ baseURL: "https://api.ai.sakura.ad.jp/v1", apiKey: sakuraApiKey })
```

OpenAI SDKはそのまま使う。接続先をOpenAI互換Responses APIへ差し替える。

そして、その変更に合わせて次も更新した。

- モデル名
- 環境変数名とTypeScriptの変数名
- SSM Parameter Storeを読むIAMポリシー
- Worker Lambdaへ渡す環境変数
- GitHub Actionsのテスト・デプロイ設定
- CDKテスト
- README

コードだけ直して、周囲を放置することはなかった。

## Codexという別の審判へ

Claude Codeの仕事を、GPT-5.6 Solを使うCodexへレビューさせた。贅沢なレビューである。

正解である `main` と比較し、LINE botとして成立するかを調べるよう依頼した。

最初の結論はこうだった。

> LINEボットとしての動作を妨げる問題は見つかりませんでした。指摘事項なしです。

Codexは、ベースURL、トークンの受け渡し、`responses.create()`、環境変数、IAMポリシー、WebhookからWorkerまでの流れ、フォールバック返信、会話メモリ更新を確認した。

さらに、実際に検証した。

```text
npm test -- --runInBand     3スイート、8テスト成功
npx cdk synth               成功
LambdaのTypeScriptバンドル  Worker・Receiverとも成功
git diff --check            問題なし
```

有効なトークンを使った実際のAPIへの疎通までは行っていない。それでもCodexは、コードに重大な不成立要因はないと判断した。

**動作する実装は、できていた。**

参考までに、Codexが作った模範解答のコミットも紹介しておく。チラ見してもらえば分かると思うが、移行にはそれなりの量の変更が必要だった。Claude Code版は、この模範解答ほど高い整合性はなかったものの、LINE botとして動作するものを作り上げていた！

https://github.com/TORIFUKUKaiou/line-bot-cdk/commit/3fb6a1042dd6a246562c898afa22ff23f39bc9ac

## ただし、正解と比べると甘さはある

もう一段厳しく見ると、Claude Code版には不足もあった。

- READMEのトークン例が、正しい `<UUID>:<シークレット>` 形式を伝えていない
- Mermaidの図に `AIAND` や `OpenAI` が残っている
- さくらのAI EngineとGeminiのエラーなのに、ログ名が `[OPENAI_ERROR]` のまま[^2]
- APIの接続先、Responses API、`output_text`、SSM権限を直接固定するテストがない

[^2]: `[OPENAI_ERROR]` については、ai& Inferenceへ載せ替えたときに、「まあいいか」と私がそのままにしていたところなので、責められるべきは私のほうかもしれない。

通知は動く。コードも動く。だが、説明とテストの仕上げはCodex版のほうが一段丁寧だった。

## 60点

私の生成AIに対する評価基準では、55点を出せれば十分である。

55点とは完璧という意味ではない。**人間がレビューを始める価値がある成果物**という意味だ。

今回のClaude CodeとさくらのAI Engineは、60点だった。

必要なコード、IAM、CI/CD、READMEを変更し、ビルドし、テストし、コミットし、別のAIによるレビューを通過した。

一方、認証形式の説明、古い用語、監視名、移行固有のテストには甘さが残った。

それでも、動作する。

これは合格である。

## モデルだけではなく、仕事を続ける仕組み

今回、Claude Codeの評判が高い理由を少し理解した。

評判が高いことは、もちろん知っていた。ただし、使ったことのない私にとっては、Codex CLIのClaude版のようなものだろう、くらいの理解だった。

先に試したCodex CLIとさくらのAI Engineの組み合わせでは、チャットはできた。マインスイーパーも作った。しかし、既存リポジトリを読み、複数のファイルへまたがるAPI移行を任せると、作業を始めてすぐにReady状態へ戻ってきた。

少なくとも今回、私がやらせたかった仕事には、まるで使い物にならなかった。

Claude Codeも同じように止まるのではないか。私はそう疑っていた。

しかし、Claude Codeは止まらなかった。

正確にいえば、API Errorで何度も止められた。次のリトライまで60秒待たされることもあった。それでも仕事そのものは投げ出さなかった。

リポジトリを読み、Webを調べ、複数のファイルを変更し、ビルドし、テストし、差分を確認し、最後にはコミットした。

速かったことよりも、完走したことが重要である。

やり遂げたのである。

Codex CLIとClaude Codeでは、利用したAPIや設定も異なる。この一度の体験だけで、両者の優劣を一般化するつもりはないし、できもしない。しかし、少なくとも今回は、同じさくらのAI Engineを利用して、前者はすぐに仕事を止め、後者は最後まで仕事を進めた。

Claude Codeの評判が高い理由を少し理解したのは、この差を目の当たりにしたからである。

もちろん成果は、モデルだけでもハーネスだけでも生まれない。今回見たのは、さくらのAI Engineのモデルと、Claude Codeというエージェントハーネスが組み合わさった仕事である。

モデルへコードを書かせるだけではない。仕事を前へ進め、終わるところまで持っていく。その仕組みまで含めてClaude Codeなのだと、私は理解した。

## Claude Code無課金勢にも、入口はある

私はClaudeへ課金せず、Claude Codeを初めて使い、実際のリポジトリ変更を最後までやり遂げた。

さくらのAI Engineには月間の無償リクエスト枠がある。プランや利用条件は各自で確認してほしい。

> Claude Codeを試したい。けれど、いきなりClaudeへ課金するほどではない。

という人にとって、これはおもしろい入口になり得る。

そして私は、Claude Code無課金勢のまま、さくらのAI Engineへの移行を、さくらのAI Engineに実装させた。

おもしろい体験ができた。

それもこれも、素敵なキャンペーンを企画してくださったさくらインターネット様とQiita様のおかげである。感謝の言葉しかない。

<b><font color="red">$\huge{ありがとうーーーッ！！！}$</font></b>

賞がとれる、とれないは関係ない。それは結果論である。

はじめは少し疑っていたが、私は試した。API Errorに待たされた。それでも最後まで見届けた。正解と比べ、別のAIにもレビューさせた。そして、動くものが残った。

アントニオ猪木さんの言葉を借りるなら、「迷わず行けよ、行けばわかるさ」である。

使い切ったかどうかではない。
私は、無料枠を闘魂へ昇華した。単なるtokenの消化ではない。

それだけでも、十二分に楽しかった。

3,000リクエストは、まだ使い切れていない。
それでも私は、もう使い切ったかのような満足感を覚えている。

だが、ここで歩みを止めては使い切れない。実はあと2兆個のネタを思いついている。次回作にも期待してほしい。
