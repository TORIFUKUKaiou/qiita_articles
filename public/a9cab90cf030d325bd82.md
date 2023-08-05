---
title: Phoenixアプリの動きがおかしくなった、esbuildがエラーを吐いたときに確認してみるといいかもしれないこと
tags:
  - Elixir
  - Phoenix
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-07-23T19:08:57+09:00'
id: a9cab90cf030d325bd82
organization_url_name: fukuokaex
slide: false
---
# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか :bangbang::bangbang::bangbang:
Webアプリケーション開発を[Phoenix](https://www.phoenixframework.org/)を使って楽しんでいると、nodeモジュールを追加したあとあたりから以下の問題に遭遇するかもしれません。

- `live`でパスを定義しているのに、`.../#` 妙なGetパラメータのアクセスになったり(Phoenix 1.6.11)、POSTのルートが一致しないぞ(Phoenix 1.6.2)というエラーがブラウザにでて発狂しそうになる
- esbuildでエラーがでているぞ！　というターミナルにでるエラー


でも、大丈夫。
きっと解決策はあります。
私が出くわしたエラーとその解決策を記しておきます。
きっと誰かの、特に未来の自分の助けになるとおもっています。

# ハイライト

この記事のハイライトです。
`config/config.exs`に`esbuild`の設定を書き足します。

```diff:config/config.exs
config :esbuild,
   version: "0.14.29",
   default: [
     args:
-      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
+      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*
+      --platform=node --define:global=window --inject:js/env-proxy.js --loader:.svg=file),
```

# 前提

この記事では、[Fluid Player](https://www.fluidplayer.com/)を`assets`フォルダ配下で、`npm install fluid-player@^3.0.0`としたときに出くわしたエラーとその解決策を示します。

プロジェクト全体は以下にあります。

https://github.com/TORIFUKUKaiou/autorace_phoenix

## --platform=node

`mix phx.server`するとこんなエラーがターミナルにでています。
答えは書いてあります。
そのままesbuildの設定に、`--platform=node`を足してみましょう。

```
    node_modules/sax/lib/sax.js:233:25:
      233 │         var SD = require('string_decoder').StringDecoder
          ╵                          ~~~~~~~~~~~~~~~~

  The package "string_decoder" wasn't found on the file system but is built into node. Are you trying to bundle for node? You can use "--platform=node" to do that, which will remove this error.
``` 

## `live`でパスを定義しているのに、`.../#` 妙なGetパラメータのアクセスになったり(Phoenix 1.6.11)、POSTのルートが一致しないぞ(Phoenix 1.6.2)というエラーがブラウザにでて発狂しそうになる

`--platform=node`を追加したあと、一度`Ctl+C` x 2回で一度止めて、意気揚々と再度`mix phx.server`します。
ターミナルからエラーは消えました。
動作確認をしてみます。
そうすると、以下のエラーが発生しました。

- `live`でパスを定義しているのに、`.../#` 妙なGetパラメータのアクセスになった(Phoenix 1.6.11)
- POSTメソッドのルートが一致しないぞ(Phoenix 1.6.2)というエラーがブラウザにでた(Phoenix 1.6.2)

Phoenixのバージョンによってエラーの挙動がかわりましたし、アプリケーションの作り方によっては異なるエラーに遭遇するかとおもいます。
記事ではさらっと書いていますが、なにが起こったのかさっぱりわからず、けっこう悩みました。
自分を疑いました。

ターミナルからはヒントを得られないので、たとえばChromeブラウザなら、右クリック -> 検証 -> Consoleでこんな画面を表示して、なにか怒られていないか確認します。

![スクリーンショット 2022-07-22 23.35.06.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9aa2bcc2-b2dd-f597-61ca-b1a959f0ad6a.png)


`global is not defined`とでています。

`esbuild global is not defined`とかでぐぐって以下にたどり着きました。

https://github.com/evanw/esbuild/issues/73#issuecomment-616859952

`--define:global=window`という設定を書き足します。

## process is not defined

今度は、ブラウザのConsoleに、`process is not defined`とエラーがでました。

`esbuild process is not defined`とかでぐぐって以下にたどり着きました。

https://github.com/evanw/esbuild/issues/1374#issuecomment-861801905

```js:assets/js/env-proxy.js
export var process = {
  env: new Proxy({}, {
    get: () => '',
  })
}
```

というファイルを用意して、`--inject:js/env-proxy.js`という設定を追加します。

以上でだいたい私のアプリは動きはじめました。
ただ、[Fluid Player](https://www.fluidplayer.com/)がもっているcssが適用されていないようなので適用してみます。
するとまた新たなエラーに遭遇しました。
最後にその話を書きます。

## [ERROR] No loader is configured for ".svg" files: node_modules/

https://docs.fluidplayer.com/docs/integration/quick-setup/#css

を参考に以下の記述をたしました。

```css:assets/css/app.css
/* This file is for your main application CSS */
@import "./phoenix.css";
@import "../node_modules/fluid-player/src/css/fluidplayer.css";
```

そうして、`mix phx.server`するとターミナルに以下のエラーがでました。

```
[watch] build started (change: "css/app.css")
✘ [ERROR] No loader is configured for ".svg" files: node_modules/fluid-player/src/static/fluid-spinner.svg

    node_modules/fluid-player/src/css/fluidplayer.css:193:26:
      193 │     background-image: url("../static/fluid-spinner.svg");
          ╵                           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

✘ [ERROR] No loader is configured for ".svg" files: node_modules/fluid-player/src/static/skip-forward.svg

    node_modules/fluid-player/src/css/fluidplayer.css:1069:20:
      1069 │     background: url('../static/skip-forward.svg') no-repeat;
           ╵                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

✘ [ERROR] No loader is configured for ".svg" files: node_modules/fluid-player/src/static/fluid-icons.svg

    node_modules/fluid-player/src/css/fluidplayer.css:234:20:
      234 │     background: url('../static/fluid-icons.svg') no-repeat;
          ╵                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~

✘ [ERROR] No loader is configured for ".svg" files: node_modules/fluid-player/src/static/close-icon.svg

    node_modules/fluid-player/src/css/fluidplayer.css:260:28:
      260 │ ...ound: #000000 url("../static/close-icon.svg") no-repeat scroll...
          ╵                      ~~~~~~~~~~~~~~~~~~~~~~~~~~

✘ [ERROR] No loader is configured for ".svg" files: node_modules/fluid-player/src/static/skip-backward.svg

    node_modules/fluid-player/src/css/fluidplayer.css:1063:20:
      1063 │     background: url('../static/skip-backward.svg') no-repeat;
           ╵                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

5 errors
```

どうやってたどり着いたか忘れましたが、

https://esbuild.github.io/content-types/#file

を参考にしました。

`--loader:.svg=file`

これで冒頭の[ハイライト](https://qiita.com/torifukukaiou/items/a9cab90cf030d325bd82#%E3%83%8F%E3%82%A4%E3%83%A9%E3%82%A4%E3%83%88)に書いた追加の設定が出揃いました。

さらにブラウザのコンソールをみるとエラーがでていたので以下の変更を加えました。

```bash
cp assets/node_modules/fluid-player/src/static/*.svg priv/static/static
```

```elixir:lib/autorace_phoenix_web/endpoint.ex
  plug Plug.Static,
    at: "/",
    from: :autorace_phoenix,
    gzip: false,
    only: ~w(assets fonts images favicon.ico robots.txt static)
```

`static`を足しています。



# おわりに

[Fluid Player](https://www.fluidplayer.com/)の追加を題材にesbuildまわりのエラーの解決策を示しました。
追加するモジュールによってここには書ききれていないエラーに遭遇することがあるとおもいます。
でも大丈夫。
この記事のように一つ一つ潰していけば動きます。
私はできました。
あなたならきっとできる。やれるはずです。

ターミナルとブラウザのコンソールを注意深くみて、出てきたエラー文と`esbuild`をキーワードに検索をすれば答えは見つかります。
もし見つからなくて、そしてあなたが解決策をみつけた場合は記事にしておきましょう。
きっと誰かの助けになるし、それは小さな一歩かもしれませんが、人類の偉大な前進です。

そういう場を提供してくださっているQiitaさんに感謝の念を述べまして、この記事をおわります。
