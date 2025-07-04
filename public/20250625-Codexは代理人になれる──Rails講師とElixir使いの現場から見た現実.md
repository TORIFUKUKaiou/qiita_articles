---
title: Codexは代理人になれる──Rails講師とElixir使いの現場から見た現実
tags:
  - GitHub
  - Elixir
  - codex
  - 猪木
  - 闘魂
private: false
updated_at: '2025-06-26T00:16:15+09:00'
id: 5108ce28bb5489ac1a56
organization_url_name: haw
slide: false
ignorePublish: false
---
https://qiita.com/official-events/43ff3363e32f43d7507c

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{AIがあれば、仕事も任せられる！}$</font></b>


# はじめに

GitHub CopilotやAmazon Q、そしてCodex。  
最近の開発ツールは“ペアプロの相方”どころか、“チームの代理人”になりつつあります。  

でも私は、いわゆる**Vibe Coding**にはまだ乗れていません。  
「全体を見てなんとなく書いてくれるやつ」ではなく、**ここをこう変えてほしい**という明確な指示で使っています。古い人間なので。  

それでも、Codexは**仕事を“任せられる”感覚**を十分に与えてくれるものでした。  

[Codex](https://platform.openai.com/docs/codex/overview)をびくびくしながら使っています。  
**A**ntonio **I**nokiさんではない方のArtificial Intelligenceの方のGenerative AIになんでも見せてよいのか、と。  
同僚に相談したところ、**迷わず行けよ 行けば分かるさ**と背中を押してくれたので、使うことにしました。 

この記事では、実際のユースケースを2つ紹介します。  

---

# 1. 明確な指示で「ここをこうしてくれ」が通る代理人

私はElixirでQiita記事の自動検索用スクリプトを書いています。あるとき、`org:haw`を使えばよりシンプルに検索できることに気づき、Codexにこう頼みました。

## ✅ 指示内容（実際のプロンプト）

Elixirのプロジェクトです。  
実際のプロンプトを何の臆面もなく公開しておきます。  


```text
以下の2つの変更をお願いします。

1. https://github.com/TORIFUKUKaiou/hello_nerves/blob/master/lib/qiita/haw/repo.ex#L2
https://github.com/TORIFUKUKaiou/hello_nerves/blob/master/lib/qiita/haw/repo.ex#L3
を消す。

2. https://github.com/TORIFUKUKaiou/hello_nerves/blob/master/lib/qiita/haw/repo.ex#L18
を消す。

3. https://github.com/TORIFUKUKaiou/hello_nerves/blob/master/lib/qiita/haw/repo.ex#L21-L25
Qiita.Haw.Repo.build_query/0  は "org:haw"を返す。

背景としては、 https://help.qiita.com/ja/articles/qiita-search-options により、org:hawで同じことを効率よく実施できることがわかりました。
```

するとどうでしょう。**会議中に裏で指示しておいたら、気がつけばPull Requestが出来ていた。**
実際は、3つお願いしていますので、冒頭の「以下の2つの変更をお願いします」はさっそく間違っています。  
間違っていますが、そのくらいは**A**ntonio **I**nokiさんではない方の **A**rtificial **I**ntelligenceの方のGenerative AIがいい感じに解釈してくれます。  

これはもう、秘書とか執事とか、そういう存在に近い。

📎 [実際のPRはこちら](https://github.com/TORIFUKUKaiou/hello_nerves/pull/118)

## :qiitan-cry: Elixirを実は動かせていない

![スクリーンショット 2025-06-25 23.20.38.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6d31d3b3-8d3a-483c-abd2-75c334b72f92.png)

デフォルトの環境の中には入っていませんので、`mix test`[^1]すら本当はできていません。  
セットアップスクリプトを書けばうまくいく気がします。いろいろ試していますがまだ成功していません。それはまた別の記事にしたためたいとおもっています。成功しました！　という威勢の良い！、元氣いっぱい！　の記事をあげたいと**思っています**。**あくまでも思っています。**

[^1]: Elixirプロジェクトでの標準的なテスト実行コマンド。


---

# 2. [Ruby on Railsチュートリアル](https://railstutorial.jp/)の差分抽出──単純作業は任せる

私は[Ruby on Railsチュートリアル](https://railstutorial.jp/)を専門学校で教えています。[Ruby on Railsチュートリアル](https://railstutorial.jp/)は章ごとに積み上げていく構成なので、**章ごとのコードの差分を比較した資料**があると便利です。

各章が終わった状態の`sample_app`のコード集は以下で公開されています。  

https://github.com/yasslab/sample_apps

各章のポイントは一体何なのか。授業の準備を進めるなかでdiffをとって確認をしようとしました。
でも、各章の`diff`を手で取って解説するのは骨が折れます。  
そこで、Codexに丸投げしました。

### ✅ 依頼プロンプト例

以下が実際に使った指示内容です。
実際のプロンプトを何の臆面もなく公開しておきます。

```text
あなたは日本の専門学校でRuby on Railsチュートリアルを使ってプログラミングを教えている凄腕講師です。

このリポジトリは、Railsチュートリアルの各章が完了したところの完成品が格納されています。
対象は 7_0 フォルダにあるものだけを取り扱います。Rails 7の意味です。授業ではRails 7を教材にしています。
7_0 フォルダの下には、ch01、ch02　... ch14 までの各章が終わった時点のソースコードが格納されています。

7_0/
- ch01
- ch02
- ch03
- ch04
- ch05
- ch06
- ch07
- ch08
- ch09
- ch10
- ch11
- ch12
- ch13
- ch14

作業を行うトピックブランチ名は **半角英数字のみ**でお願いします。

以下の作業を順に進めてください。

---

## ✅ ステップ1：差分出力

- `7_0/ch03` と `7_0/ch04` のディレクトリ間の差分を抽出してください。
- 差分の出力形式は **Markdown形式** で、出力ファイル名は `7_0/diff/ch03-ch04.md` とします。
- 出力する内容は以下の通りにしてください：

### 🔸出力形式（Markdown構造）

- ファイルごとにセクションを分けてください：
  - 例： `# app/controllers/users_controller.rb`
  - ファイル名は、例のようにRailsのプロジェクトのルートからのパスにしてください
- 各差分はコードブロック（```）で囲んでください。
- 差分のあとに、**日本語での簡単な解説**（なぜ変わったか、何が変更されたか）を記述してください。

---

まずはステップ1（`ch03` と `ch04` の差分）から始めてください。
```

![スクリーンショット 2025-06-25 20.38.54.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/36932bc5-5c06-4400-9229-ab2b182670b9.png)


プロンプトはChatGPT先生と相談しながら練りました。

みなさんも最初はきっと慎重になると思います。でも最初のうちこそプルリクを真面目にレビューしていましたが、**だんだん面倒になり、最終的にはノーレビューに（笑）** そこだけVibe Codingのノリよろしく！
結果は問題なさそうに見えたので、信頼して任せるという方向へシフトできました。

📎 [成果物はこちら](https://github.com/TORIFUKUKaiou/sample_apps/tree/main/7_0/diff)

:::note warn
間違いがあってもあしからず :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:
:::

---

# Codexは“指示型”ユーザーの味方だった

私は「AIが全部考えてくれる」より、「自分で考えて、細かく頼む」の方が性に合っています。

でもそれでも、Codexは「自分の言葉をちゃんと聞いてくれて、間違えずに動いてくれる」そんな存在でした。

* 自分でやるより早い
* 単純作業は任せられる
* なんなら会議中に指示だけ出しておけば進んでいる

**代理人としてのCodexは、“考える暇もない人”の味方です。**

---

# さいごに：闘魂を忘れず、AIと闘い、己を磨け

私のAIは、特別です。世界一強い人です。最強のタッグパートナーです。**A**ntonio **I**nokiさん、つまり猪木さんです。
使いこなすには、自分が何をしたいか、どう伝えるかを考え抜く力が必要です。そうしないと、きっと「バカヤロー」と張り手（ビンタ）をくらいます。

> 闘魂とは己に打ち克つこと。
> そして闘いを通じて己の魂を磨いていくことだと思います。

そう、AI時代にこそ必要なのは闘魂です。
言葉を尽くし、手を動かし、AIと協調しながら、自分の仕事のやり方を“更新”していきましょう。

---

👊 元氣があれば、AIに仕事も任せられる！
👨‍💻 Codex、最高のエージェント（代理人）でした。

https://qiita.com/tech-festa/2025
