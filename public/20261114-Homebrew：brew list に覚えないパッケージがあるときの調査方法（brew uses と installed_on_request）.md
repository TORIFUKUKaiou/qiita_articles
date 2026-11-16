---
title: Homebrew：brew list に覚えないパッケージがあるときの調査方法（brew uses と installed_on_request）
tags:
  - homebrew
  - macOS
  - CLI
  - tips
  - 闘魂連鎖
private: false
updated_at: '2026-11-15T23:54:02+09:00'
id: 9c965b5c28c26cb15fa1
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---

![eyecatch.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/52155572-c079-460f-8805-ade8f03a0e3e.jpeg)



## はじめに
おはヨーグルト。こんにちは。こんばんは。
名乗るほどの者ではございませんが、闘魂家の**A**wesome YAMAUCH**I**、略して**AI**です。

`brew list` を眺めていると、自分でインストールした覚えのないパッケージが入っていることがあります。たとえば `python@3.15`。

私は `uv` で Python を使っているつもりでいました。どうして Homebrew でも入っているのだろう。まあ、きっとなにかが依存しているのだろうとは想像がつきます。調べる方法はないのでしょうか。

あるんです！　そこの奥さん。

:::note info
今日の Tips
`brew list` で見覚えのないパッケージを見つけたら、`brew uses --installed <パッケージ名>` で依存元を調べ、`brew info --json=v2 <パッケージ名> | grep installed_on_request` で自分が直接入れたかどうかを確認すると正体がわかります。
:::

## 確かめ方

調査に使うコマンドは次の2つです。

1. どのインストール済みパッケージから依存されているかを調べる
   ```zsh
   brew uses --installed <パッケージ名>
   ```
2. 自分で明示的にインストールしたかどうかを調べる
   ```zsh
   brew info --json=v2 <パッケージ名> | grep installed_on_request
   ```

## 結果

手元の環境で、見覚えのなかった `python@3.15` に対して上記2つのコマンドを実行した結果は次の通りです。

```text
$ brew uses --installed python@3.15
awscli                                                            nmap

$ brew info --json=v2 python@3.15 | grep installed_on_request
          "installed_on_request": false
```

`brew uses --installed python@3.15` の出力から、`awscli` などが `python@3.15` に依存していることがわかりました。

あわせて `installed_on_request` が `false` であるため、`python@3.15` は自分で直接インストールしたものではなく、他のパッケージの依存関係として自動で入ったことが確認できました。

## 見分け方

2つのコマンドの結果を組み合わせると、そのパッケージがなぜ入っているかを次のように切り分けられます。

| `installed_on_request` | `brew uses --installed` の結果 | 判断 |
| --- | --- | --- |
| `false` | パッケージ名が出る（例: `awscli`） | 他のパッケージの依存関係として自動で入った |
| `true` | パッケージ名が出る / 出ない | 自分で明示的に `brew install` して入れた |
| `false` | 何も出ない | 以前は依存されていたが、現在は依存元が消えている可能性がある |

`installed_on_request` が `false` で、`brew uses --installed` に `awscli` のような普段使うツールが表示された場合は、そのツールを動かすために必要な依存パッケージです。

なお、`brew uses` は既定ではビルド時だけに使う依存（build dependency）を数えません。そのため、3行目に当てはまっても、すぐに不要とは言い切れません。不要になった依存は、次のコマンドで確かめられます。

```zsh
# 不要になった依存を一覧するだけで、削除はしない
brew autoremove --dry-run

# 依存として入ったが、いまはどこからも依存されていないもの
brew leaves --installed-as-dependency
```

## 補足：Homebrew に Python を入れさせず、`uv` の Python を使わせる設定はあるか？

「どうせなら Homebrew 側で勝手に `python@3.15` を入れず、`uv` で入れた Python を使ってほしい」と考えたくなりますが、調べた限りでは、フォーミュラが依存する Python を外部（`uv` など）の Python に差し替える公式の設定や環境変数はなさそうでした。

Homebrew の公式ドキュメント（[Language Runtimes and Packages](https://docs.brew.sh/Language-Runtimes-and-Packages)）によると、Python に依存するフォーミュラは Homebrew の Python に合わせてビルドされています。また、Homebrew の Python は PEP 668 の「externally managed」として扱われ、プロジェクトの依存は仮想環境に入れるよう案内されています。そのため、`brew` の Python は「`awscli` などを動かすための部品」と割り切り、普段の開発では `uv` で管理する Python を使うのが現実的です。

## おわりに

`brew list` で見覚えのないパッケージを見つけたら、`brew uses --installed` と `installed_on_request` の2つを確かめてみてください。正体がわかれば、`uv` の Python と二重に管理しているのではないかと悩まずに済みます。

![apios.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a20f8e73-ba77-4bcd-8e75-1717502aaefc.png)
