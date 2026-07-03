---
title: Dependabot の npm 更新処理でも Takumi Guard を経由させる具体的な手順
tags:
  - Node.js
  - npm
  - dependabot
  - GitHubActions
  - 闘魂
private: false
updated_at: '2026-07-03T09:19:52+09:00'
id: f909806c20e2852fbae7
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: 783b7a849caf11eefd91
agreed_posting_campaign_term: true
---
こんにちは。
[Dependabot](https://docs.github.com/en/code-security/tutorials/secure-your-dependencies/dependabot-quickstart)を利用した依存関係の自動更新は便利です。  
しかし、自動化された更新ほど「どこから取得しているのか」を明示しておきたいものです。

npm パッケージのサプライチェーン攻撃対策として、 [Takumi Guard](https://flatt.tech/takumi/features/guard) があります。  
Takumi Guard は npm レジストリのプロキシとして動作し、悪性パッケージのインストールをブロックしてくれます。

ローカル開発環境や GitHub Actions で使う例は見かけます。  
この記事では、[GitHub Dependabot](https://docs.github.com/en/code-security/tutorials/secure-your-dependencies/dependabot-quickstart) の npm バージョンアップデートでも **Takumi Guard を経由させる設定**をまとめます。

最初に告白しておきます。
私は npm 界隈に詳しいわけではありません。

Takumi Guard 自体の紹介記事や、Dependabot の cooldown と組み合わせたサプライチェーン攻撃対策の記事は見つかりました。

しかし、Takumi Guard を Dependabot の `registries` に設定し、Dependabot の npm 更新処理でも Takumi Guard を経由させる具体的な手順は、私が調べた範囲では見つけられませんでした。

私のググり力が足りないだけかもしれません。笑

それでも、少なくとも自分が設定するときには少し迷いました。
この記事では、実際に試した内容を記録として残します。

## やりたいこと

Dependabot が npm パッケージを確認するときに、通常の npm レジストリへ直接アクセスするのではなく、Takumi Guard の npm プロキシを参照するようにします。

```text
Dependabot
  -> https://npm.flatt.tech/
  -> npm registry
```

設定するファイルは主にこの2つです。

- `.github/dependabot.yml`
- `.npmrc`


## 前提

この記事では npm を対象にします。

Takumi Guard の npm レジストリ URL は次の通りです。

```text
https://npm.flatt.tech/
```

Takumi Guard は匿名でも利用できます。  
一方、ダウンロード追跡や通知なども使いたい場合は、トークンを利用します。

今回は Dependabot からも認証付きで利用できるように、Dependabot Secret にトークンを登録する構成にします。

## 0. トークンの発行

まず、Takumi Guard のトークンを発行します。

「[ユーザー登録して利用する](https://shisho.dev/docs/ja/t/guard/quickstart/npm#setup-email-verified)」に書いてあります。
2026-07-03現在、「Shisho Cloud アカウントは不要で、無料で利用できます。」とのことです。

## 1. Dependabot Secret を登録する

次に、Takumi Guard のトークンを GitHub の **Dependabot secrets** に登録します。

ここで重要なのは、**GitHub Actions 用の Secret ではない**という点です。

Dependabot は Actions の Secret をそのまま読むわけではありません。  
Dependabot から参照したい値は、Dependabot 専用の Secret に登録します。

手順は以下です。

1. GitHub リポジトリを開く
2. **Settings** を開く
3. **Security** -> **Secrets and variables** -> **Dependabot** を開く
4. **New repository secret** を押す
5. 次の名前で登録する

```text
Name: TAKUMI_GUARD_TOKEN
Secret: tg_anon_... または tg_org_...
```

## 2. `.npmrc` を置く

リポジトリのルートに `.npmrc` を置きます。

```ini
registry=https://npm.flatt.tech/
```

## 3. `.github/dependabot.yml` を設定する

`.github/dependabot.yml` に、Takumi Guard の npm レジストリを `registries` として定義します。

```yaml
version: 2

registries:
  takumi-guard-npm:
    type: npm-registry
    url: https://npm.flatt.tech/
    token: ${{secrets.TAKUMI_GUARD_TOKEN}}

updates:
  - package-ecosystem: "npm"
    directory: "/"
    registries:
      - takumi-guard-npm
    schedule:
      interval: "weekly"
    cooldown:
      default-days: 5
      semver-major-days: 30
      semver-minor-days: 7
      semver-patch-days: 3

  - package-ecosystem: "github-actions"
    directory: "/"
    schedule:
      interval: "weekly"
```

これで npm の Dependabot update job では、`takumi-guard-npm` に定義したレジストリ情報を使います。

`github-actions` の更新は npm ではないため、ここでは Takumi Guard の registry を紐付けていません。

## `.npmrc` がないとエラーになることがある

私がつまずいたのはここです。

`dependabot.yml` に `registries` を書いただけで十分だと思っていました。  
しかし、リポジトリに `.npmrc` がない状態では、Dependabot の実行時に次のようなエラーになることがありました。

```text
Dependabot can't access a private package registry without explicit configuration

Dependabot was unable to resolve a private registry configuration for npm.flatt.tech.
Please add a .npmrc file to your repository, or configure explicit scope or replaces-base on your registry credentials in your dependabot.yml.
```

![スクリーンショット 2026-07-03 8.41.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2c775701-a1e5-48f7-b350-1d6d70cb258a.png)


原因は、Dependabot が npm の依存関係を解決するときに、どのパッケージをどのレジストリへ向けるのかを判断できないためです。

そのため、リポジトリのルートに `.npmrc` を置き、npm のデフォルトレジストリを明示します。

```ini
registry=https://npm.flatt.tech/
```

## lock ファイルの URL 表示について

uv の `uv.lock` では、設定した index URL が見えることがあります。

一方、npm の `package-lock.json` は見え方が少し違います。
各パッケージの `resolved` に tarball URL が記録されることはありますが、`.npmrc` に `registry=https://npm.flatt.tech/` を設定したからといって、lock ファイル内の URL が単純にすべて `https://npm.flatt.tech/` になる、というわけではありません。

npm 公式ドキュメントでは、`package-lock.json` の `resolved` について、registry 由来の依存関係では tarball のパスが registry URL からの相対パスとして扱われると説明されています。
また、npm の registry ドキュメントでは、デフォルト registry を使って作成された lock ファイルについて、lock ファイル内のデフォルト registry は「現在設定されている registry」という特別な意味を持つと説明されています。

つまり、npm では lock ファイル内の URL 表示だけを見て、Takumi Guard を通っているかどうかを単純には判断できません。

参考:

- [package-lock.json | npm Docs](https://docs.npmjs.com/cli/v8/configuring-npm/package-lock-json/)
- [registry | npm Docs](https://docs.npmjs.com/cli/v8/using-npm/registry/)

## まとめ

Dependabot の npm 更新でも Takumi Guard を経由させるには、次の設定を行います。

1. Takumi Guard のトークンを Dependabot Secret に登録する
2. `.npmrc` に `registry=https://npm.flatt.tech/` を書く
3. `.github/dependabot.yml` の `registries` に Takumi Guard を定義する
4. npm の `updates` にその registry を紐付ける

自動更新は便利です。  
しかし、便利なものほど、入口を固めておく価値があります。

Dependabot、GitHub Actions、ローカル開発環境。  
それぞれの取得経路をそろえておくと、依存関係更新の不安をひとつ減らせます。

## 参考リンク

- [npm | Takumi byGMO Docs](https://shisho.dev/docs/ja/t/guard/quickstart/npm/)
- [Guard機能 - Takumi byGMO](https://flatt.tech/takumi/features/guard)
- [Configuring access to private registries for Dependabot - GitHub Docs](https://docs.github.com/en/code-security/how-tos/secure-your-supply-chain/manage-your-dependency-security/configure-access-to-private-registries)
- [Configuration options for the dependabot.yml file - GitHub Docs](https://docs.github.com/en/code-security/reference/supply-chain-security/dependabot-options-reference)
