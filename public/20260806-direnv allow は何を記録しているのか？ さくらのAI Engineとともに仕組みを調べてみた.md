---
title: direnv allow は何を記録しているのか？ さくらのAI Engineとともに仕組みを調べてみた
tags:
  - さくらのAI
  - direnv
  - 闘魂
  - 猪木
  - ClaudeCode
private: false
updated_at: '2026-08-06T09:27:44+09:00'
id: 7fd7c5f3c40bef8ed07e
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: bd14d28b53326d318fec
agreed_posting_campaign_term: true
---
![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1ed00f05-30b5-4088-9d5f-d6d15b42220f.png)


:::note
[Messages APIを使ったさくらのAI EngineとClaude Codeの連携](https://ai.sakura.ad.jp/column/claude-code-messages-api-2/)を参考に、Claude CodeにさくらのAI Engineが提供する `preview/Kimi-K2.7-Code` を接続して、記事の大筋を書いてもらいました。
私が使用している`direnv`のバージョンを調べ、そのソースコードを`git clone`して解析してくれました。

さくらのAI Engineの活用事例として、本記事はキャンペーンに応募します。
:::

## はじめに

`direnv` は、**ディレクトリごとに環境変数を自動で切り替えるツール**です。

プロジェクトごとに `.envrc` を用意しておけば、ディレクトリへ移動するだけで、そのプロジェクト専用の環境変数を読み込んでくれます。

毎回 `source` を実行する必要がなく、さくらのAI Engineの[アカウントトークン](https://manual.sakura.ad.jp/cloud/ai-engine/02-howto.html#id9)や各種APIキーを扱う開発では非常に便利なツールです。

この記事では **macOS + Homebrew** を前提に説明します。

## インストール

Homebrewを利用している場合は、次のコマンドでインストールできます。

```bash
brew install direnv
```

続いて、使用しているシェルに `direnv` を組み込みます。

zsh の場合は `~/.zshrc` に次を追加します。

```bash
eval "$(direnv hook zsh)"
```

設定を反映します。

```bash
source ~/.zshrc
```

これで `direnv` が利用できるようになります。

## direnvとは

`direnv` は、**ディレクトリごとに環境変数を自動で切り替えるツール**です。

プロジェクトごとに `.envrc` を用意しておけば、

```bash
cd project-a
```

で Project A 用の環境変数が設定され、

```bash
cd ../project-b
```

で Project B 用へ自動で切り替わります。

毎回 `source` を実行する必要がないため、とても便利です。

初めて `.envrc` を作成すると、次のようなメッセージが表示されます。

```text
direnv: error <絶対パス>/.envrc is blocked. Run `direnv allow` to approve its content
```

なぜ、わざわざ `direnv allow` が必要なのでしょうか。

## なぜ `direnv allow` が必要なのか

`.envrc` は設定ファイルのように見えます。

しかし実際には **シェルスクリプト**です。

つまり、

- 環境変数を書き換える
- APIキーを送信する
- `rm` を実行する
- `curl` を実行する

といった、任意のコードを書けます。

もし `git clone` しただけで勝手に `.envrc` が実行されたら、とても危険です。

そこで `direnv` は、

> **内容を確認した人だけが実行を許可する**

という仕組みになっています。

その確認操作が

```bash
direnv allow
```

です。

## `direnv allow` は何を記録しているのか

`direnv` は、「このディレクトリを信用した」のではありません。

**その時点の `.envrc` の内容**を信用したことを記録しています。

ソースコードを調べると、`direnv` は次の内容から SHA-256 ハッシュを計算しています。

```text
.envrc の絶対パス
+
改行（LF）
+
.envrc の内容
```

そのハッシュ値をファイル名として保存します。

つまり、

```text
内容が1文字でも変わる
↓
ハッシュ値が変わる
↓
以前許可したものと一致しない
↓
もう一度 direnv allow が必要
```

という流れです。

## ハッシュ値を自分で計算してみる

macOSなら、次のコマンドで `direnv` と同じハッシュ値を計算できます。

```bash
envrc="$(pwd -P)/.envrc"

{
  printf '%s\n' "$envrc"
  cat "$envrc"
} | shasum -a 256
```

表示された値が、direnv allow を記録するファイルのファイル名になります。

では、次の疑問としていったいどこに保存されているのでしょうか。

## direnv allow の記録はどこに保存される？

macOSで `XDG_DATA_HOME` を設定していなければ、保存先は

```text
~/.local/share/direnv/allow/
```

です。

実際に`ls`で確認すると、

```text
24d0c6baccc7a8cc2744a940de15c5de4f5c2d56435911e66358e7fef6fe6860
6989343539d49db3a6faa164f55b3e9654923f666d75518902ea2a49e907e936
```

のようなファイルが並びます。

中身を見ると、

```bash
cat ~/.local/share/direnv/allow/<ハッシュ値>
```

`.envrc` の絶対パスだけが保存されていることが分かります。

## まとめ

`direnv allow` は、

> **「この内容の `.envrc` は確認済みなので実行してよい」**

という記録を残す仕組みです。

`.envrc` が1文字でも変わればハッシュ値が変わるため、以前の許可は自動的に無効になります。

そのため、再び `direnv allow` が必要になるのです。

---

## 編集後記

この記事を書くにあたり、さくらのAI Engineから本記事執筆専用[アカウントトークン](https://manual.sakura.ad.jp/cloud/ai-engine/02-howto.html#id9)を払い出しました。
そして専用ディレクトリ配下だけで有効な環境変数を定義したく、`direnv`を使いました。

調査および、記事の下書きに使用したリクエスト数は92回でした。

入力トークン（闘魂）が`4,639,140`で、出力トークン（闘魂）が`44,007`でした。
トークン単価で計算すると、約300円くらいを使用させていただきました。
ありがとうございます。

![スクリーンショット 2026-08-06 6.56.41.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ddcaec1f-f392-4270-8791-7b79ee81b6dc.png)

---

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c0f8edf8-7ba0-4f97-8667-31f00ad9348f.png)
