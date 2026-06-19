---
title: npm view gitHead と time で「GitHubでは修正済みだがnpmには未リリース」を確認する
tags:
  - Node.js
  - npm
  - 猪木
  - 闘魂
private: false
updated_at: '2026-06-18T21:06:57+09:00'
id: 9815f415bc937fc9f160
organization_url_name: haw
slide: false
ignorePublish: false
---
## はじめに

`npm audit` を見ていたら、 [@yao-pkg/pkg](https://www.npmjs.com/package/@yao-pkg/pkg) 配下の `esbuild` が警告対象になっていました。

GitHub上の後続コミットでは修正されているように見えましたが、手元の `@yao-pkg/pkg@6.20.0` にはまだ反映されていませんでした。

この記事では、`npm view` の `dependencies`、`gitHead`、`time` を使って、npmに公開されているパッケージの状態を確認したメモを書きます。

## dependenciesを見る

まず、`@yao-pkg/pkg@6.20.0` の依存を確認します。

```bash
npm view @yao-pkg/pkg@6.20.0 dependencies
```

結果の一部です。

```js
{
  ...
  '@yao-pkg/pkg-fetch': '3.6.3',
  esbuild: '^0.27.3',
  'into-stream': '^9.1.0',
  multistream: '^4.1.0',
  tar: '^7.5.7',
  unzipper: '^0.12.3'
}
```

`esbuild` はまだ `^0.27.3` でした。

## gitHeadを見る

次に、npmに公開されている `@yao-pkg/pkg@6.20.0` が、どのコミット由来なのかを確認します。

```bash
npm view @yao-pkg/pkg@6.20.0 gitHead
```

結果はこうでした。

[546bbf02f1cff07527c770cc0853b0d9d586eac7](https://github.com/yao-pkg/pkg/commit/546bbf02f1cff07527c770cc0853b0d9d586eac7)


一方、GitHub上では次のコミットで `esbuild` が更新されていました。

[68f41d5df50842a1edd7e3719fb48c8fddfb8d26](https://github.com/yao-pkg/pkg/commit/68f41d5df50842a1edd7e3719fb48c8fddfb8d26)

差分としては、次のような変更です。

```diff
-    "esbuild": "^0.27.3",
+    "esbuild": "^0.28.1",
```

つまり、状況はこうでした。

```text
npm 公開済み:
  @yao-pkg/pkg@6.20.0
  gitHead: 546bbf0...
  esbuild: ^0.27.3

GitHub 上の修正済みコミット:
  68f41d5...
  esbuild: ^0.28.1
```

GitHubでは修正済み。  
しかし、npmに公開されている `6.20.0` にはまだ入っていない、ということがわかりました。

## timeを見る

npm上で各バージョンの公開日時を見るには `time` を使います。

```bash
npm view @yao-pkg/pkg time
```

JSONで見たい場合はこうです。

```bash
npm view @yao-pkg/pkg time --json
```

特定バージョンだけ見るなら、`jq` を使えます。

```bash
npm view @yao-pkg/pkg time --json | jq '."6.20.0"'
```

latestの公開日時を見るなら、次のようにできます。

```bash
npm view @yao-pkg/pkg time --json | jq --arg v "$(npm view @yao-pkg/pkg@latest version)" '.[$v]'
```

## latestの状態を確認する

次のリリースで修正が入ったかを見るには、このあたりを確認します。

```bash
npm view @yao-pkg/pkg@latest version
npm view @yao-pkg/pkg@latest gitHead
npm view @yao-pkg/pkg@latest dependencies.esbuild
npm view @yao-pkg/pkg time --json | jq --arg v "$(npm view @yao-pkg/pkg@latest version)" '.[$v]'
```

見たいのは次の4点です。


- latest が 6.20.0 より上がったか
- gitHead が期待するコミット以降になったか
- dependencies.esbuild が ^0.28.1 になったか
- その version がいつ npm に公開されたか

## まとめ

今回使ったコマンドです。

```bash
npm view <package>@<version> dependencies
npm view <package>@<version> gitHead
npm view <package> time
npm view <package> time --json
npm view <package>@latest version
npm view <package>@latest dependencies.esbuild
```

学びはこれです。


- GitHubでは修正済みでも、npmにpublishされるまでは利用側には反映されない。
- npm view gitHead を見ると、npmに公開されたパッケージがどのコミット由来か確認できることがある。
- npm view time を見ると、各バージョンの公開日時を確認できる。


地味ですが、npmパッケージの状況確認に役立ちました。

## まとめのまとめ

Node.js に詳しい方には当たり前のことかもしれませんが、私は生成AIにいろいろとコマンドを教えてもらいました。
とても覚えられそうにないので、Qiitaに外部記憶装置として保存しました。そして、これを手打ちすることで、脳に「生きるために必要な大事なことなのだ」と錯覚させて、記憶を定着させます。これが、私がQiitaに投稿する理由であり、**アウトプットを加速させるQiitaの夏祭り**、そう [Qiita Tech Festa](https://qiita.com/tech-festa/2026) を盛り上げる私からのアンサーです。
