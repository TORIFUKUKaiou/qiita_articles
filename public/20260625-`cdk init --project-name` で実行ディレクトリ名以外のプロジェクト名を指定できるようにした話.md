---
title: '`cdk init --project-name` で実行ディレクトリ名以外のプロジェクト名を指定できるようにした話'
tags:
  - AWS
  - TypeScript
  - CDK
  - 猪木
  - 闘魂
private: false
updated_at: '2026-06-25T08:51:44+09:00'
id: d01fca30d48a777e6a3d
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに

プロジェクトを作るコマンドには、名前を連れて歩くものが多い。

たとえば Rails なら、

```bash
rails new my-app
```

Phoenix なら、

```bash
mix phx.new hello_world
```

というふうに、プロジェクトを作るコマンドでは、作りたいものの名前をコマンドの引数として渡すことが多い。

ところが AWS CDK の `cdk init` は、少し趣が違っていた。先にディレクトリを作り、そこへ移動し、それから `cdk init` を実行する。すると、その実行ディレクトリ名をもとに、`package.json` の `name` や、Stack のファイル名、クラス名などが生まれる。

```bash
mkdir hello-cdk
cd hello-cdk
cdk init app --language typescript
```

これはこれで、筋は通っている。

しかし、別の名前を与えたいこともある。作業ディレクトリ名と、生成されるプロジェクト名を分けたいこともある。そんなとき、`cdk init --help` を見ると、`--project-name` というオプションがある。

ならば、こう書けるはずである。

```bash
mkdir cdk-work
cd cdk-work
cdk init app --language typescript --project-name awesome-cdk
```

ところが、これが効いていなかった。

help にはある。だが、実際には効かない。こういうものは、ソフトウェアの世界ではしばしば、町の古い道標のように残っている。そこに道があるように見える。しかし歩いてみると、途中で草に埋もれている。

その道標を掘り返す Pull Request が、AWS CDK CLI にマージされた。

- PR: [aws/aws-cdk-cli#1644](https://github.com/aws/aws-cdk-cli/pull/1644)
- Merge commit: [3ff0bdf](https://github.com/aws/aws-cdk-cli/commit/3ff0bdfc8b006f6e131f7b58722f6b6c63381e07)
- Related issue: [aws/aws-cdk#31992](https://github.com/aws/aws-cdk/issues/31992)

この修正は、`aws-cdk@2.1128.1` に含まれている。

## きっかけ

発端は、別の記事だった。

[こちらの記事](https://qiita.com/torifukukaiou/items/09a7816a08fec5b50ba1)の技術検証を、Antigravity 2.0 Gemini 3.5 Flash(High) に頼んでいた。

こちらとしては、その記事の検証をしてほしかっただけである。ところが Antigravity は、頼んだ本筋から少し外れたところまで見に行った。AWS CDK CLI の中を読み、`cdk init --project-name` が効かない件について、これは直せる、と言ってきた。

余計な調査である。

しかし、世の中には、余計な調査から始まる仕事がある。むしろ、あとから振り返ると、余計に見えたものこそ本筋だった、ということがある。

時期もよかった。[Qiita Tech Festa 2026](https://qiita.com/tech-festa/2026) という、アウトプットを加速させる夏祭りがあった。今回のことがそれと直接関係している、と大げさに言うつもりはない。ただ、無関係と言い切るのも、少し味気ない。

人は、祭りがあると歩き出すことがある。

## 何が起きていたのか

`cdk init` には、すでに `--project-name` オプションが定義されていた。

`packages/aws-cdk/lib/cli/cli-config.ts` には、次のようなオプションがある。

```ts
'project-name': { type: 'string', alias: 'n', desc: 'The name of the new project', requiresArg: true },
```

つまり、ユーザーインターフェイスとしては存在していた。

また、yargs は kebab-case の `--project-name` を camelCase の `projectName` として扱う。ここまでは問題がなかった。実際、引数のパースそのものはできていた。

問題は、その先である。

CLI handler から `cliInit` に値を渡す箇所で、こうなっていた。

```diff
- projectName: args.name,
+ projectName: args.projectName,
```

`args.name` という存在しない値を見ていたため、`projectName` は `undefined` になっていた。結果として、`cdk init` は従来どおり、実行ディレクトリ名から名前を作っていた。

つまり、`--project-name` は入口にはあったが、奥の部屋へ通じる廊下で途切れていたのである。

修正の中心だけを見れば、たった1行だった。

しかし、たった1行だから簡単、とは限らない。OSS では、その1行が本当に正しいのか、また壊れないのかを示す必要がある。

## どう使えるようになったか

`aws-cdk@2.1128.1` 以降では、次のように実行ディレクトリ名とは別のプロジェクト名を指定できる。

```bash
mkdir cdk-work
cd cdk-work
cdk init app --language typescript --project-name awesome-cdk
```

この場合、作業ディレクトリは `cdk-work` でも、生成されるプロジェクト名は `awesome-cdk` になる。

TypeScript の app テンプレートなら、たとえば次のようなところに反映される。

- `package.json` の `name`
- `lib/awesome-cdk-stack.ts`
- `AwesomeCdkStack` というクラス名

ディレクトリ名に引きずられず、CDK プロジェクトとしての名前を決められるようになった。

この差は小さい。

だが、最初に生成される名前は、その後のファイル名やクラス名に残る。あとから直せばよい、と言えばそれまでだが、最初から意図した名前で始められるなら、そのほうが気持ちがよい。

## レビューで教わったこと

今回の相棒は、Antigravity 2.0 Gemini 3.5 Flash(High) だった。

そして Codex 5.5 推論(中) は、レビュー担当だった。

最初に追加したテストは、`--project-name` が `projectName` としてパースされることを確認するものだった。これはこれで意味がある。だが、今回の不具合を再発させないためには、十分ではなかった。

レビューで指摘されたのは、そこだった。

パースはもともとできていた。壊れていたのは、パースされた値が `cliInit` まで届く経路である。だから、引数パースのテストだけでは、今回のバグは捕まえられない。

必要だったのは、実際に `cdk init` コマンドを走らせ、生成物に名前が反映されることを確認するテストだった。

そこで、次のような観点のテストを追加した。

- `cdk init app --language typescript --project-name awesome-app --generate-only` を実行する
- 生成された `package.json` の `name` が `awesome-app` になる
- 生成された stack file と class name に `awesome-app` 由来の名前が反映される

この指摘は、ありがたかった。

コードを直すだけなら、1行で終わる。だが、OSS の Pull Request は、1行を直す場所であると同時に、その1行が再び崩れないように杭を打つ場所でもある。

## 以前は「使えない」で終わった

以前、Codex にも似た相談をしたことがあった。

`cdk init` で、フォルダ名由来ではない名前を使いたい。そう頼んだときは、使えない、で終わった。

それは間違いではなかったと思う。

help にあっても実際には動かない。通常の利用者としては、使えないと言うしかない。無理にリポジトリの奥へ入って、長い探索を始める必要はない。トークンを費やすにも、費やしどころがある。

ただ、今回は違った。

Antigravity は、頼んでもいない奥の方まで見に行った。そして、直せる、と言った。そこから PR になり、レビューを受け、テストを足し、マージされた。

一歩を踏み出すと、予想していなかった場所へ出ることがある。

## おわりに

`cdk init --project-name` は、新しく足された機能というより、help にありながら実際には働いていなかった道を、通れるようにした修正である。

関連 issue は 2024年11月2日に作られ、PR は 2026年6月22日にマージされた。1年半以上、そこにあった道標だった。

それを見つけたのは、記事の技術検証の途中だった。余計な調査だった。だが、その余計な一歩が、AWS CDK CLI へのマージにつながった。

以前、私は `npm install -g aws-cdk` なしで `cdk init` する記事を書いた。

グローバル環境に AWS CDK CLI を入れず、次のように `npx` で実行する方法である。

```bash
npx aws-cdk init app --language typescript
```

その記事の公開時点では、`--project-name` オプションは help に表示されるものの、期待どおりには反映されなかった。そのため、実行ディレクトリ名が生成物の名前に使われる、という話で終わっていた。

しかし、`aws-cdk@2.1128.1` 以降では、次のように実行ディレクトリ名とは別の名前で CDK プロジェクトを始められる。

```bash
npx aws-cdk@latest init app --language typescript --project-name awesome-cdk
```

グローバルインストールしている場合は、手元の `aws-cdk` のバージョンが古いままかもしれない。その場合は、`aws-cdk@2.1128.1` 以降に更新する必要がある。

一方、グローバルインストールせずに `npx aws-cdk@latest` で実行すれば、その時点の最新の AWS CDK CLI を使って `cdk init` できる。

アントニオ猪木さんの「道」の言葉を、ここで長く引くつもりはない。

ただ、歩く前には道に見えないものがある。歩いたあとで、あれは道だったのだとわかることがある。

今回の `cdk init --project-name` は、そういう小さな道だった。

リリースされた今、ぜひ使ってみてほしい。

```bash
npx aws-cdk@latest init app --language typescript --project-name awesome-cdk
```

実行ディレクトリ名とは別の名前で、CDK プロジェクトを始められる――

（了）
