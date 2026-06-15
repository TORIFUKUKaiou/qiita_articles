---
title: Tauri Vanillaプロジェクト作成直後にbrotliでビルド失敗したので回避しました
tags:
  - Rust
  - cargo
  - 猪木
  - Tauri
  - 闘魂
private: false
updated_at: '2026-06-14T23:01:35+09:00'
id: e683ed4deccf5e1cb8ff
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>

Tauri の Vanilla プロジェクトを作成して、さあ動かそうと思ったら、いきなり Rust 側の依存関係でビルドが失敗しました。

この記事は、Tauri そのものの詳しい解説ではありません。

「いま Tauri の新規プロジェクトを作ったら、`brotli` 周辺で落ちた」
「とりあえず `npm run tauri dev` まで進みたい」

という人向けの、短命かもしれないトラブルシューティング記事です。

なお、本記事は 2026-06-14 時点の私の環境での記録です。

## 環境

私の環境です。

```text
macOS
Apple Silicon
Tauri v2
Vanilla
TypeScript
npm
```

Tauri の Vanilla プロジェクトを作成しました。

```bash
sh <(curl https://create.tauri.app/sh)
```

選択内容は次の通りです。

```text
Project name: tauri-app
Identifier: com.tauri-app.app
Frontend language: TypeScript / JavaScript
Package manager: npm
UI template: Vanilla
UI flavor: TypeScript
```

作成後、案内に従って実行しました。

```bash
cd tauri-app
npm install
npm run tauri dev
```

## 発生したエラー

`npm run tauri dev` を実行すると、Vite は起動しました。

```text
VITE v6.4.2  ready in 632 ms

➜  Local:   http://localhost:1420/
```

しかし、その後 Rust 側のビルドで失敗しました。

エラーの中心は `brotli` でした。

```text
error[E0277]: the trait bound `StandardAlloc: alloc::Allocator<ZopfliNode>` is not satisfied
```

ログには、次のようなメッセージが出ていました。

```text
note: there are multiple different versions of crate `alloc_no_stdlib` in the dependency graph
```

つまり、`alloc-no-stdlib` が複数バージョン入っていて、trait が別物扱いになっているようです。

## 依存関係を確認する

まず、`brotli` を誰が引いているのか確認しました。

```bash
cd src-tauri
cargo tree -i brotli
```

結果は次のようなものでした。

```text
brotli v8.0.3
├── tauri-codegen v2.6.2
│   └── tauri-macros v2.6.2
│       └── tauri v2.11.2
├── tauri-utils v2.9.2
│   ├── tauri-build v2.6.2
│   ├── tauri-codegen v2.6.2
│   ├── tauri-macros v2.6.2
│   └── tauri-plugin v2.6.2
└── tauri-utils v2.9.2
    ├── tauri v2.11.2
    ├── tauri-runtime v2.11.2
    └── tauri-runtime-wry v2.11.2
```

`brotli` は Tauri 側の依存として入っていました。

次に、`alloc-no-stdlib` を確認しようとしました。

```bash
cargo tree -i alloc-no-stdlib
```

すると、曖昧だと言われました。

```text
error: specification `alloc-no-stdlib` is ambiguous
help: re-run this command with one of the following specifications
  alloc-no-stdlib@2.0.4
  alloc-no-stdlib@3.0.0
```

つまり、やはり `alloc-no-stdlib` が 2つ入っています。

## Cargo.lock を見る

`Cargo.lock` を見ると、次のようになっていました。

```toml
[[package]]
name = "alloc-no-stdlib"
version = "2.0.4"

[[package]]
name = "alloc-no-stdlib"
version = "3.0.0"

[[package]]
name = "alloc-stdlib"
version = "0.2.3"
dependencies = [
 "alloc-no-stdlib 3.0.0",
]

[[package]]
name = "brotli"
version = "8.0.3"
dependencies = [
 "alloc-no-stdlib 2.0.4",
 "alloc-stdlib",
 "brotli-decompressor",
]

[[package]]
name = "brotli-decompressor"
version = "5.0.2"
dependencies = [
 "alloc-no-stdlib 3.0.0",
 "alloc-stdlib",
]
```

これを見ると、構図はこうです。

```text
brotli 8.0.3
  ├── alloc-no-stdlib 2.0.4
  ├── alloc-stdlib 0.2.3
  │     └── alloc-no-stdlib 3.0.0
  └── brotli-decompressor 5.0.2
        └── alloc-no-stdlib 3.0.0
```

Rust では、同じ名前の trait でも、crate のバージョンが違えば別物です。

そのため、

```text
alloc_no_stdlib 2.0.4 の Allocator
alloc_no_stdlib 3.0.0 の Allocator
```

が混ざってしまい、`StandardAlloc` が期待する trait を満たせない、というエラーになっていたようです。

# 回避策

私の環境では、`src-tauri/Cargo.toml` の `[dependencies]` に次の2つを追加すると回避できました。

```toml
brotli-decompressor = "=5.0.1"
alloc-stdlib = "=0.2.2"
```

例です。

```toml
[dependencies]
tauri = { version = "2", features = [] }
tauri-plugin-opener = "2"

# workaround for brotli / alloc-no-stdlib mismatch
brotli-decompressor = "=5.0.1"
alloc-stdlib = "=0.2.2"
```

その後、`Cargo.lock` と `target` を削除して、再ビルドします。

```bash
cd src-tauri
rm -f Cargo.lock
rm -rf target
cargo build
```

`Cargo.lock` を見ると、`alloc-no-stdlib` は `2.0.4` だけになりました。

```toml
[[package]]
name = "alloc-no-stdlib"
version = "2.0.4"
```

この状態で、再度実行します。

```bash
cd ..
npm run tauri dev
```

これでビルドが進むようになりました。

# 何が起きていたのか

今回の問題は、Tauri アプリのコードが間違っていたわけではありません。

新規作成した Vanilla プロジェクトで、Rust 側の依存解決により、`brotli` 周辺の crate バージョンが噛み合わなくなっていたようです。

ざっくり言うと、次のような状態でした。

```text
brotli 本体
  → alloc-no-stdlib 2.0.4 を使う

brotli-decompressor / alloc-stdlib
  → alloc-no-stdlib 3.0.0 を使う

結果
  → Allocator trait が別物扱いになり、ビルドエラー
```

`Cargo.lock` を読むと、何が混ざっているのかが見えてきます。

# 注意点

この回避策は、恒久対応というより一時的な回避策です。
今回の依存解決の問題が Tauri 側や依存 crate 側で修正されれば、この固定は不要になります。

また、今後は逆にこの固定が邪魔になる可能性もあります。
そのため、しばらく経ってから試す場合は、まず固定なしで動くか確認するのがよいと思います。

# まとめ

Tauri の Vanilla プロジェクトを新規作成した直後に、`brotli` 周辺で Rust のビルドエラーに遭遇しました。

私の環境では、次の2つを `src-tauri/Cargo.toml` に追加することで回避できました。

```toml
brotli-decompressor = "=5.0.1"
alloc-stdlib = "=0.2.2"
```

Tauri は Web 技術でデスクトップアプリを作れる便利なフレームワークです。

しかし、内部では Rust / Cargo が動いています。  
そのため、詰まったときには `Cargo.lock` や `cargo tree` を読む必要が出てきます。

少年老いやすく学成りがたし。  
ビルドエラーもまた学びの入口です。

迷わず行けよ、行けばわかるさ。

いままさに私と同じ問題に遭遇した人の助けになれば幸いです。
