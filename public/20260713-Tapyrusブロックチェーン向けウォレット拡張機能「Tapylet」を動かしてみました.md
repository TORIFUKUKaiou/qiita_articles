---
title: Tapyrusブロックチェーン向けウォレット拡張機能「Tapylet」を動かしてみました
tags:
  - ブロックチェーン
  - 猪木
  - Tapyrus
  - 闘魂
  - Tapylet
private: false
updated_at: '2026-07-14T15:56:21+09:00'
id: 1159be14ff92e0449037
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: 783b7a849caf11eefd91
agreed_posting_campaign_term: true
---
## はじめに

[株式会社chaintope](https://www.chaintope.com/)が、開発・運営するパブリックブロックチェーン「[Tapyrus（タピルス）](https://github.com/chaintope/tapyrus-core)」向けのChrome拡張機能ウォレット「[Tapylet（タピレット）](https://github.com/chaintope/tapylet)」を動かしてみました。

https://www.chaintope.com/news/126906/

https://prtimes.jp/main/html/rd/p/000000054.000030542.html

## [Tapylet（タピレット）](https://github.com/chaintope/tapylet) とは?

https://www.chaintope.com/news/126906/

こちらが詳しいです。

それではさっそく使ってみます。

## ① Chrome拡張機能ウォレット「[Tapylet（タピレット）](https://github.com/chaintope/tapylet)」をインストールから初期設定

https://chromewebstore.google.com/detail/tapylet/fpoeppnajheilpoboemmkoamaemkjdfp

こちらから入手できます。

### 新規ウォレット作成

![スクリーンショット 2026-07-02 8.28.04.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/32ceba0a-53d3-4d31-8924-028ff80f403f.png)

### リカバリーフレーズを書き留めます

![スクリーンショット 2026-07-02 8.28.29.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0edaed13-7326-43cc-948b-092308c53e29.png)

### パスワード設定

![スクリーンショット 2026-07-02 8.29.40.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c92afd85-ff4f-4be5-bb98-0aa842c60001.png)

### 初期画面

![スクリーンショット 2026-07-02 8.30.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f54f5cfa-9cc1-47f8-8289-4088266d6da1.png)

無事インストールできました :tada:

当然、最初は0 TPCです。コインが欲しいです。

## ②🚰 Tapyrus Testnet Faucet からTPCをもらいます

https://testnet-faucet.tapyrus.dev.chaintope.com/

[https://testnet-faucet.tapyrus.dev.chaintope.com/](https://testnet-faucet.tapyrus.dev.chaintope.com/)

![スクリーンショット 2026-07-02 8.32.47.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c3cf0303-afb0-4819-a822-91003e434162.png)

Tapyletに表示されているaddressを入力して、「Get Coins!」です。

少し待つと、果たして。

![スクリーンショット 2026-07-02 8.33.30.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/fc7149f8-6e6e-469e-b1a8-9fc251d00bd3.png)

残高が増えています :tada::tada::tada:

## ③ カラードコイン（トークン）発行

せっかくTPCを持ちました。
続いて、カラードコイン（トークン）を発行してみます。

:::note
**カラードコイン（トークン）とは?**
> Tapyrusでは、基軸通貨（TPC）以外のトークンを取引するために、Colored Coinと呼ばれる仕組みを採用しています。 これはブロックチェーンの1stレイヤーでネイティブにサポートされるトークン機能で、 コンセンサスレベルでトークンの正当性が検証されます。
:::

https://site.tapyrus.chaintope.com/colored-coin/spec

### アセット発行

必要事項を入力します。
すごいトークンを発行してみます。

![スクリーンショット 2026-07-02 8.34.43.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a9fba014-4e48-4235-9b16-8ed71d434cfa.png)
![スクリーンショット 2026-07-02 8.34.53.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a4ef242e-2bd1-4f29-bb47-21becaa94f4c.png)

### アセット発行完了

![スクリーンショット 2026-07-02 8.35.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b89972a7-8cb8-458d-bfb8-edaf4affb0dc.png)

### レジストリを開く

「レジストリを開く」を押すと、自動的にGitHub Issuesが開きます。
一瞬何のことかはわかりませんでしたが、危ぶむことなく、歩を前へ進めます。迷わず行きます。

![スクリーンショット 2026-07-02 8.37.34.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/410c1149-8765-41e3-aa7f-d0e7557da39d.png)

「アセット発行完了」ポップアップに表示されていた内容で埋めることができます。
迷わず「Create」します。

少し待つと、IssueはCloseされます。

![スクリーンショット 2026-07-02 8.39.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/50c71280-11d1-4973-83b3-f284df8213fc.png)

### Tapyrus Token Registry

https://chaintope.github.io/tapyrus-token-registry/

[Tapyrus Token Registry](https://chaintope.github.io/tapyrus-token-registry/)に行くと、さきほど発行し、Issueで登録をした「すごいトークン」が一覧に表示されています。


![スクリーンショット 2026-07-02 8.40.22.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8c3c5387-b815-49b0-b0c9-8d8040870932.png)

さきほどのIssueが自動的に処理されて、一覧に追加されたようです。

![スクリーンショット 2026-07-02 9.04.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/70718fe5-1b96-4bf2-9cc6-a1baefb87129.png)

Issueのテンプレートを用意しておいて、Issueが発行されたら、それをトリガに処理するというところにすごく興味を持ちました。以下が関係してそうです。何かのときに使いたいと思います。あくまでもそう思っています。

- https://github.com/chaintope/tapyrus-token-registry/blob/main/.github/ISSUE_TEMPLATE/register-token.yml
- https://github.com/chaintope/tapyrus-token-registry/blob/main/.github/workflows/register-token.yml

## ④ Tapylet

ここまでの操作で、最終的にこういう画面になりました :+1:

![スクリーンショット 2026-07-02 9.05.47.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9a6537ef-3936-4c05-a0bf-2434f25db92c.png)

## おわりに

今回は、Tapyrus向けChrome拡張機能ウォレット **Tapylet** を使い、テストネットのTPC取得からカラードコインの発行、Token Registryへの登録までを試しました。

Tapyrusは、Bitcoin Coreをベースに開発されたパブリックブロックチェーンで、カラードコインの仕組みを標準で備えています。Tapyletを利用すると、ブラウザ上の操作だけでTPCの管理やトークンの発行を行えます。現在のTapyletはテストネット専用です。開発者や企業によるテスト、検証用途を想定して提供されているのだと思います。

今回発行したのは「すごいトークン」という名前だけの簡単なトークンです。

同じ仕組みを利用することで、トレーサビリティや産地証明、資格証明書、チケット、会員権などをブロックチェーン上で扱うアプリケーションへつなげられます。公式発表でも、こうした用途の開発や検証を容易にすることがTapyletの役割として挙げられています。

また、トークンのメタデータをオープンなToken Registryへ登録し、ウォレットやアプリケーションの間で共有できる仕組みも用意されています。実際の登録処理では、GitHub IssuesとGitHub Actionsが組み合わされていました。今回の一連の操作の中で、この自動化の仕組みに最も興味を持ちました。

Tapyletを使うことで、Tapyrus上でトークンを発行する流れを、コマンドを使わずに一通り体験できました。今後、プロダクション環境への対応やTapyrusを利用したアプリケーションとの連携が進むことで、ブラウザウォレットとしてどのように活用されていくのか楽しみです。
