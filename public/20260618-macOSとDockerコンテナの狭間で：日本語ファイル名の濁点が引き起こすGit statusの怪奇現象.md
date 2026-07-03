---
title: macOSとDockerコンテナの狭間で：日本語ファイル名の濁点が引き起こすGit statusの怪奇現象
tags:
  - Git
  - Unicode
  - devcontainer
  - 猪木
  - 闘魂
private: false
updated_at: '2026-06-18T22:37:48+09:00'
id: 3c4e750bd8564144c178
organization_url_name: haw
slide: false
ignorePublish: false
posting_campaign_uuid: 3af9413ea59cb9f9b1d8
agreed_posting_campaign_term: true
---
macOS（ホスト）とDocker（Linuxコンテナ）を組み合わせて開発していると、時々 **「Mac側ではクリーンなのに、コンテナ内でだけ特定のファイルが `Untracked files` として検出される」** という現象に遭遇することがあります。

今回は、この現象の背景にある Unicode 正規化形式（NFC / NFD）と、私が取った対策をメモします。

## 発生した現象

Macで開発しているプロジェクトを、VS Code の Dev Containers で開いたときのことです。

ホスト側で `git status` を実行すると、作業ツリーはクリーンでした。

```bash
# Mac（ホスト）側
git status
```

```text
On branch main
nothing to commit, working tree clean
```

ところが、コンテナ内で同じように `git status` を実行すると、特定のファイルが `Untracked files` として表示されました。

```bash
# Dockerコンテナ（Linux）側
git status
```

```text
On branch main
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        "Projects/HAW/AWS/02_AWS \343\202\242\343\202\253\343\202\246\343\203\263\343\203\210\344\275\234\346\210\220\343\201\250\347\204\241\346\226\231\345\210\251\347\224\250\346\236\240\343\201\256\343\201\223\343\202\231\346\241\210\345\206\205.md"
```

8進数でエスケープされていて読みにくいですね。

読める形にすると、ファイル名は次のようなものです。

```text
Projects/HAW/AWS/02_AWS アカウント作成と無料利用枠のご案内.md
```

問題になっていたのは、ファイル名中の **「ご」** でした。

## 「ご」には複数の表現方法がある

Unicodeでは、見た目が同じ文字でも、内部表現が異なることがあります。

今回の「ご」は、主に次の2通りで表現できます。

### NFC

「ご」を1文字として表現する形式です。

```text
ご
```

UTF-8のバイト列では、次のようになります。

```text
e3 81 94
```

Gitの出力で8進エスケープされると、次のように見えます。

```text
\343\201\224
```

### NFD

「こ」と結合用濁点を分けて表現する形式です。

```text
こ + ゙
```

UTF-8のバイト列では、次のようになります。

```text
e3 81 93 + e3 82 99
```

Gitの出力で8進エスケープされると、次のように見えます。

```text
\343\201\223\343\202\231
```

つまり、見た目は同じ **「ご」** でも、内部的には次のように異なる表現になりえます。

```text
NFC: \343\201\224
NFD: \343\201\223\343\202\231
```

今回、コンテナ内の `git status` に出ていたファイル名には、次の部分が含まれていました。

```text
\343\201\223\343\202\231
```

これは、NFD形式の「こ + ゙」に相当します。

## なぜMac側ではクリーンで、コンテナ内ではUntrackedになったのか

今回の現象は、ざっくり言うと次のようなズレで起きていたようです。

```text
Gitインデックス側のファイル名:
  NFCの「ご」

コンテナ内から見える実ファイル名:
  NFDの「こ + ゙」
```

Mac側のGitでは `core.precomposeUnicode` により、macOSで分解されたUnicodeファイル名を合成済みの形へ戻して扱う仕組みがあります。

一方、コンテナ内のGitはLinux上で動いています。  
そのため、Mac向けGitの `core.precomposeUnicode` による変換は期待できません。

結果として、Linuxコンテナ側のGitからは、次のように見えたようです。

```text
インデックスにある名前:
  ご案内

実ファイルとして見える名前:
  ご案内
```

見た目はほぼ同じです。  
しかし、内部表現が違うため、Gitは別名の未追跡ファイルとして検出したようです。

## 対策

### 対策A：ファイル名に日本語、特に濁点・半濁点を含めない

最も安全だと思う対策は、ファイル名を半角英数字中心にすることです。

たとえば、次のようなファイル名にします。

```text
02_aws-account-creation-and-free-tier.md
```

表示名として日本語を使いたい場合は、Markdownの見出し、frontmatter、Obsidianのaliasなどで補うのがよさそうです。

### 対策B：ファイル名をリネームする

今回のファイルは、英数字中心のファイル名へリネームしました。

```text
Before:
02_AWS アカウント作成と無料利用枠のご案内.md

After:
02_aws-account-creation-and-free-tier.md
```

これで、コンテナ内の `git status` でも意図しない `Untracked files` は出なくなりました。

### 対策C：正規化スクリプトで変換する

NFCへ寄せるために、Pythonで正規化してリネームする方法も考えられます。

```python
import os
import unicodedata

src = "Projects/HAW/AWS/02_AWS アカウント作成と無料利用枠のご案内.md"
dst = unicodedata.normalize("NFC", src)

if src != dst:
    tmp = src + ".tmp"
    os.rename(src, tmp)
    os.rename(tmp, dst)
```

ただし、環境やエディタによっては、その後の保存や移動で再び別の正規化形式になる可能性があります。  
そのため、継続運用を考えるなら、私は英数字中心のファイル名へ寄せるほうが扱いやすいと感じました。

## まとめ

macOSホストとDockerコンテナを組み合わせて開発していると、Unicode正規化形式の違いにより、Gitの見え方がズレることがあります。

今回のポイントです。

- 見た目が同じ「ご」でも、NFCとNFDで内部表現が異なる
- Mac側のGitではクリーンでも、Linuxコンテナ側のGitでは別名に見えることがある
- `core.precomposeUnicode` はMac OS実装のGit向けの設定
- 濁点・半濁点を含む日本語ファイル名は、OSやコンテナをまたぐ開発ではトラブルの原因になりうる
- 迷ったら、ファイル名は半角英数字中心にするのが堅い

地味ですが、`git status` の怪奇現象に見えたものの正体が少し見えました。

## 参考

- [Git - git-config Documentation: core.precomposeUnicode](https://git-scm.com/docs/git-config)
