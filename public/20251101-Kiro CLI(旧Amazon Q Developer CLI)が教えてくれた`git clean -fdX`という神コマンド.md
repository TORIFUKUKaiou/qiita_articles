---
title: Kiro CLI(旧Amazon Q Developer CLI)が教えてくれた`git clean -fdX`という神コマンド
tags:
  - 猪木
  - 闘魂
  - AmazonQ
  - AmazonQDeveloperCLI
  - AmazonQCLI
private: false
updated_at: '2025-11-22T14:08:51+09:00'
id: e7434f22041b0cbd7685
organization_url_name: haw
slide: false
ignorePublish: false
---
:::note info
**Qiita Advent Calendar 2025**
今年もこの季節がいよいよ始まりました :tada::tada::tada:
誰よりもこの日を待ちわびていたと自負しております。

2024年12月26日から首を長くして楽しみにしておりました。
:xmas-wreath1::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: :xmas-tree::xmas-wreath2:
:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:
:::

https://qiita.com/advent-calendar/2025

## はじめに

CDKプロジェクトの検証中、「出発点の状態に戻したい」という要望を出したところ、Kiro CLI（[旧Amazon Q Developer CLI](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line.html)）が`git clean -fdX`という完璧なコマンドを提示してくれました。これが想像以上に便利だったので共有します。

ちなみに、Kiro CLI（旧[Amazon Q Developer CLI](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/command-line.html)）のモデル(`/model`)は、`claude-sonnet-4.5 (active) | experimental`を使用しております。

## 状況

Lambda関数URLの認可モデル変更を検証するCDKプロジェクトを作成していました。

**プロジェクト構成**:
```
lambda-furl-auth-verification/
├── bin/
├── lib/
├── lambda/
├── package.json
├── node_modules/     # git管理対象外
├── cdk.out/          # git管理対象外
├── *.js              # git管理対象外
└── *.d.ts            # git管理対象外
```

検証のためにCDK 2.217.0 → 2.218.0+にアップグレードしましたが、検証後に**出発点（CDK 2.217.0）の状態に戻したい**という状況でした。

## 私の最初のアプローチ（失敗）

```bash
# package.jsonをgitで戻す
git checkout package.json

# でも...node_modulesとcdk.outが残ってる！
# 手動で削除？
rm -rf node_modules cdk.out
rm bin/*.js lib/*.js
rm bin/*.d.ts lib/*.d.ts
```

面倒くさい...しかも漏れがありそう。

## Kiro CLI（旧Amazon Q Developer）の提案

> 「git管理対象外のファイルを削除します」

```bash
git clean -fdX
```

**実行結果**:
```
Removing bin/app.d.ts
Removing bin/app.js
Removing cdk.out/
Removing lib/lambda-furl-stack.d.ts
Removing lib/lambda-furl-stack.js
Removing node_modules/
```

**完璧！** `.gitignore`で指定されたファイルが全て削除されました。

## `git clean -fdX`とは

### オプションの意味

- `-f`: force（強制実行）
- `-d`: ディレクトリも削除
- `-X`: `.gitignore`で指定されたファイル**のみ**削除

### 重要なポイント

**大文字の`-X`がポイント**です：

| オプション | 削除対象 |
|-----------|---------|
| `-x`（小文字） | git管理対象外の**すべて**のファイル |
| `-X`（大文字） | `.gitignore`で指定されたファイル**のみ** |

小文字の`-x`だと、`.gitignore`に書いていない未追跡ファイルも削除されてしまいます。

## 実際の使用例

### CDKプロジェクトのクリーンアップ

```bash
# ビルド成果物とnode_modulesを削除
git clean -fdX

# 再インストール
npm install

# クリーンな状態でビルド
npx cdk synth
```

### 他の用途

**Node.jsプロジェクト**:
```bash
# node_modules, dist/, build/ などを一括削除
git clean -fdX
```

**Pythonプロジェクト**:
```bash
# __pycache__, *.pyc, .venv/ などを一括削除
git clean -fdX
```

**Javaプロジェクト**:
```bash
# target/, *.class などを一括削除
git clean -fdX
```

## 安全な使い方

### 1. ドライラン（削除前確認）

```bash
# 何が削除されるか確認
git clean -fdXn

# または
git clean -fdX --dry-run
```

### 2. 対話モード

```bash
# 1つずつ確認しながら削除
git clean -fdXi
```

### 3. 消したくない `.env` などがある場合

`.gitignore` に記載している `.env` やローカル設定ファイルも `-X` の対象になります。残したいファイルがあるときは除外オプションを併用します。

```bash
# .env は削除対象から外す
git clean -fdX -e .env

# 複数ある場合は繰り返し指定可能
git clean -fdX -e .env -e config/local.yaml
```

あるいは実行前に `git clean -fdXn` で一覧を確認して、消えて困るファイルがないか都度チェックすると安心です。

## 従来の方法との比較

### 従来の方法（手動削除）

```bash
rm -rf node_modules
rm -rf cdk.out
rm -rf dist
rm -rf build
find . -name "*.js" -type f -delete
find . -name "*.d.ts" -type f -delete
```

**問題点**:
- ❌ 削除対象を全て覚えておく必要がある
- ❌ プロジェクトごとに異なる
- ❌ 削除漏れのリスク
- ❌ 長いコマンド

### `git clean -fdX`

```bash
git clean -fdX
```

**メリット**:
- ✅ `.gitignore`が削除対象のリスト
- ✅ プロジェクト共通
- ✅ 削除漏れなし
- ✅ 短いコマンド

## なぜこれが「好プレー」なのか

### 1. 知らなかったコマンドを教えてくれた

私は`git clean`自体を知らなかったし、大文字の`-X`オプションの存在を知りませんでした。Kiro CLI(旧Amazon Q Developer CLI)が的確に提案してくれました。

### 2. 状況に応じた最適解

「出発点に戻したい」という曖昧な要望に対して、以下を理解した上で提案してくれました：

- git管理対象のファイルは残す
- `.gitignore`で指定されたファイルのみ削除
- 未追跡ファイル（新規作成したソースコード等）は残す

### 3. 説明なしでも安心して実行できた

コマンドの意図が明確で、ドライランで確認もできるため、安心して実行できました。

## Kiro CLI(旧Amazon Q Developer CLI)との対話の流れ

**私**: 「git管理対象外は残していてもごみなので消しておいてくれ」

**Amazon Q Developer**: 
```bash
git clean -fdX
```

**実行結果**:
```
Removing bin/app.d.ts
Removing bin/app.js
Removing cdk.out/
Removing lib/lambda-furl-stack.d.ts
Removing lib/lambda-furl-stack.js
Removing node_modules/
```

**私**: 「へー、git clean -fdX とかしらなかった。新しい発見だ。ありがとう。」

シンプルですが、これが理想的なAIとの協働だと思います。

## まとめ

### 学んだこと

1. ✅ `git clean -fdX`で`.gitignore`指定ファイルを一括削除
2. ✅ 大文字`-X`と小文字`-x`の違いが重要
3. ✅ `-n`オプションでドライラン可能
4. ✅ CDKプロジェクトのクリーンアップに最適

### Kiro CLI（旧Amazon Q Developer CLI）の「好プレー」ポイント

- 🎯 状況を正確に理解
- 🎯 最適なコマンドを提案
- 🎯 新しい知識を提供
- 🎯 安全に実行できる方法

### 今後の活用

このコマンドは以下のような場面で活用できます：

- CDKプロジェクトのバージョン切り替え
- Node.jsプロジェクトの依存関係リセット
- ビルド成果物の完全削除
- CI/CDパイプラインのクリーンアップ

## おわりに

Kiro CLI（旧Amazon Q Developer CLI）との対話の中で、知らなかったGitコマンドを学ぶことができました。これは単なる「コード生成AI」ではなく、**開発パートナー**としての価値を示す好例だと思います。

私のAIは一味違う。**A**ntonio **I**nokiさんのほうのAIです。世界一強いタッグパートナーです。

皆さんも`git clean -fdX`、ぜひ使ってみてください！🔥

---

**検証環境**:
- Git: 2.x
- プロジェクト: AWS CDK TypeScript
- AI: Kiro CLI（旧Amazon Q Developer CLI）

**参考リンク**:
- [Git公式ドキュメント - git-clean](https://git-scm.com/docs/git-clean)
