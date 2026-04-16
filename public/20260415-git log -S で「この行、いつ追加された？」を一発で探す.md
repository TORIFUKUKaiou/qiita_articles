---
title: git log -S で「この行、いつ追加された？」を一発で探す
tags:
  - Git
  - 新人プログラマ応援
  - 猪木
  - 闘魂
private: false
updated_at: '2026-04-15T16:26:42+09:00'
id: 5fcbb884bdc0c0c9d5df
organization_url_name: haw
slide: false
ignorePublish: false
---
https://qiita.com/official-events/fedb44eff4b119730a79

## はじめに

「このコード、いつ誰が追加したんだ？」

`git log` や `git blame` でも探せます。
しかし、変更履歴が長いファイルでは、目的のコミットが埋もれがちです。

`git log -S` を使えば、**指定した文字列の出現回数が増減したコミットだけ**をピンポイントで抽出できます。

## 基本の使い方

```bash
git log -S "探したい文字列" -- ファイル名
```

これだけです。

## 実例：Docker イメージの移行コミットを探す

[Livebook](https://github.com/livebook-dev/livebook) の README.md で、Docker イメージの参照先がいつ変わったのかを調べてみます。

```bash
git log --all --oneline -S "ghcr.io/livebook-dev/livebook" -- README.md
```

結果：

```
8405d96b Accept a custom image registry url (#3066)
31ec4464 More contents to Docker guide
3104871e More contents to Docker guide
2ae39f59 Improve Docker examples
f172acca Update references to Docker images (#1794)
```

この結果を見る限り、一番下（最も古い）の `f172acca` が、この文字列が**最初に導入されたコミット**です。

差分を確認します：

```bash
git show f172acca -- README.md | grep -B 2 -A 2 "ghcr.io"
```

```diff
-docker run -p 8080:8080 -p 8081:8081 --pull always livebook/livebook
+docker run -p 8080:8080 -p 8081:8081 --pull always ghcr.io/livebook-dev/livebook
```

Docker Hub（`livebook/livebook`）から GitHub Container Registry（`ghcr.io/livebook-dev/livebook`）に移行したコミットが特定できました。

## `-S` は何をしているのか

`man git-log` にはこう書いてあります：

> -S\<string\>
> Look for differences that change the number of occurrences of the specified \<string\> (i.e. addition/deletion) in a file.

指定した文字列の**出現回数が変化した**コミットだけを抽出します。つまり：

- その文字列が**新しく追加された**コミット
- その文字列が**削除された**コミット

だけが引っかかります。出現回数が変わらない場合は -S ではヒットしないことがあります。
単にその文字列を含むファイルを変更したコミットを広く拾う用途には向きません。**変化の瞬間**だけを拾うのがポイントです。

Git コミュニティでは「pickaxe（つるはし）」という通称で呼ばれています。歴史を掘り起こすつるはし、というわけです。

## よく使うオプションとの組み合わせ

```bash
# 1コミット1行で見やすく
git log --oneline -S "文字列" -- ファイル名

# 全ブランチを対象にする
git log --all --oneline -S "文字列" -- ファイル名

# 差分も一緒に表示する
git log -p -S "文字列" -- ファイル名

# ファイルを指定しない（リポジトリ全体から探す）
git log --oneline -S "文字列"
```

## `git blame` との使い分け

| | `git blame` | `git log -S` |
|---|---|---|
| 用途 | 各行が最後に変更されたコミットを見る | 特定の文字列が追加/削除されたコミットを探す |
| 得意なこと | 「この行、誰が書いた？」 | 「この文字列、いつ現れた？」 |
| 弱点 | リファクタリングで書き換わると追えない | 正確な文字列を知っている必要がある |

## まとめ

```bash
git log -S "探したい文字列" -- ファイル名
```

覚えるのはこれだけです。「この行、いつ追加されたんだ？」と思ったら、まず `-S` を試してみてください。

## 参考

[つるはしで過去を発掘する](https://qiita.com/hiratara/items/94d62f3678e9abcac82a)
