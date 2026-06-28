---
title: AIにREADMEを直させるため、わざとREADMEが嘘をつくサンプルリポジトリを作った
tags:
  - Node.js
  - AI
  - Readme
  - 闘魂
  - Antigravity
private: false
updated_at: '2026-06-27T22:04:10+09:00'
id: b720bb5887466cd6c385
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに

[Antigravity SDK](https://antigravity.google/docs/sdk/overview)の [doc_maintenance_agent.py](https://github.com/google-antigravity/antigravity-sdk-python/blob/main/examples/deep_dives/doc_maintenance_agent.py) を試しました。

その記事はこちらです。

https://qiita.com/torifukukaiou/items/658d89d4d7a08b89845c

`doc_maintenance_agent.py` は、ざっくり言うと、ドキュメント保守のエージェント例です。

ソースコードとMarkdownドキュメントを見比べて、古くなったREADMEやAPIドキュメントを直してくれます。

これを試すには、実験台が必要でした。

普通のプロジェクトでは困ります。

READMEが正しすぎると、直すところがありません。  
READMEが壊れすぎていると、実験になりません。  
実装が複雑すぎると、何が起きたのかわかりにくくなります。

そこで、こういうプロジェクトを作ることにしました。

**コードは正しい。READMEは少し嘘をついている。**

そんなサンプルリポジトリです。

## 作ったリポジトリ

作ったリポジトリはこちらです。

https://github.com/TORIFUKUKaiou/antigravity-doc-maintenance-sample

リポジトリの説明はこうしました。

```text
A tiny app where the code tells the truth and the README lies.
```

コードは真実を語り、READMEは嘘をつく。

Antigravity SDKのドキュメント保守Agentに、ちょうどよいリングを用意したかったわけです。


## ChatGPTに作ってもらった

このサンプルアプリは、ChatGPTに作ってもらいました。

つまり、こういう構図です。

```text
AIにREADMEを直させるための実験台を、AIに作ってもらった。
```

少しややこしいですが、これが2026年の開発体験なのかもしれません。

最初に欲しかったのは、小さなサンプルアプリです。

条件はだいたい次のようなものでした。

- Node.jsの小さなアプリにする
- 依存はできるだけ増やさない
- 実装とREADMEの内容をわざとズラす
- 後でAntigravity SDKの `doc_maintenance_agent.py` に直させる
- 実験結果が `git diff` でわかりやすく出るようにする

最終的には、依存ゼロのNode.jsアプリになりました。

`node:http` を使ってAPIを作り、`public/` 配下にHTML/CSS/JavaScriptを置く構成です。

```text
antigravity-doc-maintenance-sample/
  package.json
  README.md
  docs/
    api.md
    maintenance-prompt.md
  public/
    index.html
    style.css
    app.js
  src/
    server.js
    tasks.js
```

ExpressもHonoも使っていません。

小さく、読みやすく、壊しやすく、直しやすい。  
そんな実験台にしました。

## ただのAPIでは少し寂しい

最初は、ただの小さなAPIサンプルでもよいと思っていました。

しかし、せっかく Antigravity です。  
反重力です。  
少し浮いていてほしい。

そこで、フロントエンドも付けることにしました。

ただの管理画面ではなく、少しだけ宇宙っぽい画面にしたい。

ここで出てきたのが、小宇宙(コスモ)です。
聖闘士星矢です。

Antigravity。  
反重力。  
宇宙。  
小宇宙。

だんだん話がつながってきました。

最終的に、画面名は `Cosmo Task Console` になりました。

## コスモ演出のインプット

コスモ演出を作るとき、ChatGPTには参考として次の2つを渡しました。

- [index.ejs](https://github.com/haw/aws-education-hands-on/blob/main/day3/db-lab/materials/app/views/index.ejs)
- [style.css](https://github.com/haw/aws-education-hands-on/blob/main/day3/db-lab/materials/app/public/style.css)

これは、以前作った教材用アプリの画面とスタイルです。
公開リポジトリならChatGPTは読み取ってくれます。

具体的には、AWS教育用ハンズオンのアプリで使っていた画面です。

- `views/index.ejs`
- `public/style.css`

この2つを参考にして、今回のサンプル用に新しく作ってもらいました。

その結果、`public/index.html`、`public/style.css`、`public/app.js` を持つ、少し宇宙っぽいタスク管理画面ができました。

![スクリーンショット 2026-06-27 21.14.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ddbe49e5-7d86-4ed9-8f36-1b091a670c8f.png)

背景には星のような点が流れます。  
フォームからタスクを追加できます。  
完了ボタンを押すと、タスクの状態が変わります。

本格的なアプリではありません。

しかし、Antigravity SDKの実験台としては十分です。  
むしろ、ちょうどよいです。

## わざと入れたズレ

このプロジェクトの目的は、正しいアプリを作ることではありません。

目的は、Antigravity SDKの `doc_maintenance_agent.py` に直させるためのズレを作ることです。

そのため、実装とREADMEの間に、わざと差を入れました。

実装では、次のようになっています。

- サーバーは `3000` 番ポートで起動する
- `/` にブラウザ用のフロントエンドがある
- `GET /tasks?status=todo` のようにステータスで絞り込みできる
- タスク完了APIは `PATCH /tasks/:id/complete`
- タスクには `status`, `priority`, `dueDate` がある
- `POST /tasks` は `201 Created` を返す

一方で、READMEや `docs/api.md` には古い情報を残しました。

- サーバーは `8080` 番ポートで起動すると書いてある
- フロントエンドはないと書いてある
- query parameter は未対応と書いてある
- タスク完了APIは `PATCH /tasks/:id/done` と書いてある
- タスクには `done` フィールドがあると書いてある
- `POST /tasks` は `200 OK` を返すと書いてある

つまり、コードは真実を語ります。

READMEは嘘をつきます。

その嘘を、Antigravity SDKのAgentに見抜いてもらう作戦です。

## なぜ専用リポジトリを作ったのか

手元の実プロジェクトで試してもよかったのかもしれません。

しかし、最初の実験としては怖いです。

いきなり本物のプロジェクトにAgentを入れると、何をどこまで触るのか気になります。  
差分が大きくなりすぎると、何が起きたのか追いにくくなります。  
記事にも書きにくくなります。

そこで、専用のサンプルリポジトリを作りました。

小さい。  
依存が少ない。  
実装とドキュメントのズレが明確。  
`git diff` で結果が見やすい。

こういう実験台があると、AIエージェント系のツールを試しやすくなります。

Antigravity SDKだけではありません。

Codex、Claude Code、Gemini CLI、Kiroなど、他のAI開発ツールを試すときにも使えそうです。

## 実際に役に立った

このサンプルリポジトリは、実際に役に立ちました。

`doc_maintenance_agent.py` を実行すると、READMEと `docs/api.md` が実装に合わせて更新されました。

たとえば、次のような修正が入りました。

- ポート番号が `8080` から `3000` に修正された
- フロントエンドなし、という説明が削除された
- `GET /tasks` の `status` query parameter が追記された
- `POST /tasks` のレスポンスが `201 Created` に修正された
- 完了APIが `PATCH /tasks/:id/done` から `PATCH /tasks/:id/complete` に修正された
- タスクのフィールドが `done` から `status`, `priority`, `dueDate` に修正された

つまり、実験台としてちゃんと機能しました。

サンプルを作った時点では、少し遊びすぎかとも思いました。

しかし、結果的には、遊びがあったほうが記事としても実験としてもわかりやすくなりました。

反重力には、少しくらい小宇宙があったほうがよいのです。

## 裏話

裏話をすると、最初から完璧な構成が見えていたわけではありません。

最初は、もっと普通のAPIだけのサンプルでもよいと思っていました。

しかし、途中で「フロントエンドも欲しい」と思いました。  
さらに「どうせならド派手にしたい」と思いました。  
そして「コスモを感じたい」と思いました。

そこで、過去に作った教材用アプリの `index.ejs` と `style.css` をインプットとして渡し、ChatGPTに今回用の画面を作ってもらいました。

結果として、ただのAPIサンプルではなく、少し浮いたアプリになりました。

この「**少し浮いた**」が大事です。

Antigravityですから。

## まとめ

AIにREADMEを直させるため、わざとREADMEが嘘をつくサンプルリポジトリを作りました。

しかも、そのサンプルリポジトリ自体をChatGPTに作ってもらいました。

AIに直させるための実験台を、AIに作らせる。  
なかなか現代的です。

このリポジトリでは、コードは真実を語ります。  
READMEは少し嘘をつきます。  
そして、Antigravity SDKのAgentがその嘘を見抜きます。

小さなNode.jsアプリ。  
少し古いREADME。  
少し宇宙っぽい画面。  
少しだけ闘魂注入された実験台。

AIエージェントを試すには、こういうリングがあると便利です。

反重力の実験には、小宇宙がよく似合います。
