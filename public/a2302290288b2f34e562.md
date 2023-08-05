---
title: "Phoenix + NES.css(ファミコン風CSSフレームワーク) でPENAL!? \U0001F631 (Elixir)"
tags:
  - Elixir
  - Phoenix
  - 40代駆け出しエンジニア
  - autoracex
private: false
updated_at: '2021-02-07T22:35:19+09:00'
id: a2302290288b2f34e562
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか:bangbang::bangbang::bangbang:
- [無料で使えるかわいい8bitデザインのファミコン風CSSフレームワーク「NES.css」](https://gigazine.net/news/20210204-nes-css/) という記事をみました
- こんなの作りました(適用しました、くらいですかね)
    - ただ`phx.new`して、
    - [NES.css](https://nostalgic-css.github.io/NES.css/)に書いてある通りのことをやった感じです
- 2021/2/8(月)開催予定の[autoracex #9](https://autoracex.connpass.com/event/203961/)という[Elixir](https://elixir-lang.org/)のもくもく会の成果といたしますです :tada:


![スクリーンショット 2021-02-07 22.06.49.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f92a2d52-ad25-828c-cae5-056ac41de605.png)



# インストール
- なにをはじめるにも最初の準備が肝心です
- [Phoenix](https://www.phoenixframework.org/)を楽しむためにもまずは環境構築を進めましょう
- 以下のいずれかを参考にしてください
    - 公式 「[Installation](https://hexdocs.pm/phoenix/installation.html#content)」
    - 手前味噌な記事 「[Phoenixのdevcontainer (Elixir)](https://qiita.com/torifukukaiou/items/636bb0a08d6a0b597a69)」

# プロジェクト作成
- 準備が整ったところで楽しんでいきましょう！

```
$ mix phx.new nes --live
$ cd nes
$ mix ecto.create
```
- 今回はデータベースは使いません
- `mix phx.new nes --no-ecto`でプロジェクトを作るでもよいです
    - この場合は、`mix ecto.create`はいらないです

# [NES.css](https://nostalgic-css.github.io/NES.css/)のインストール
- https://github.com/nostalgic-css/NES.css
- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:に従います

```
$ cd assets
$ npm install nes.css
$ cd ..
```

- `assets/package-lock.json`と`assets/package.json`に変化があるでしょう

```scss:assets/css/app.scss
@import "./phoenix.css";
@import "../node_modules/nprogress/nprogress.css";
@import "../node_modules/nes.css/css/nes.css";
```

# 少しだけ書き換え

- `lib/nes_web/templates/layout/app.html.eex`を書き換えます
    - [Press Start 2P](https://fonts.google.com/specimen/Press+Start+2P?selection.family=Press+Start+2P)というフォントの読み込みを追加しました
    - `Phoenix Framework`という画像を表示しているところを適当に書き換えました

```html:lib/nes_web/templates/layout/root.html.leex
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <%= csrf_meta_tag() %>
    <%= live_title_tag assigns[:page_title] || "Nes", suffix: " · Phoenix Framework" %>
    <link href="https://fonts.googleapis.com/css?family=Press+Start+2P" rel="stylesheet">  <!-- add -->
    <link phx-track-static rel="stylesheet" href="<%= Routes.static_path(@conn, "/css/app.css") %>"/>
    <script defer phx-track-static type="text/javascript" src="<%= Routes.static_path(@conn, "/js/app.js") %>"></script>
  </head>

...

        <a href="https://phoenixframework.org/" class="phx-logo">
          <!-- <img src="<%= Routes.static_path(@conn, "/images/phoenix.png") %>" alt="Phoenix Framework Logo"/> -->
          <span><i class="nes-jp-logo"></i></span>
          <span style="font-weight: bold; font-size: xx-large;">Phoenix</span>
          <span>Framework</span>
        </a>
```

# Run

```
$ mix phx.server
```

- 私はこれでうまくいきました(macOS 10.15.7)
- Visit: http://127.0.0.1:4000
- もしうまくいかなかったら手動で以下を行ってあげるとよいとおもいます

```
$ cd assets
$ node node_modules/webpack/bin/webpack.js --mode development
```

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm: 
- [PETAL](https://thinkingelixir.com/petal-stack-in-elixir/)ならぬPENAL:interrobang:[^1]
- <font color="purple">$\huge{PENAL}$</font>
    - https://ejje.weblio.jp/content/penal
        - **刑罰の、刑事上の、刑法の、刑罰の対象となる、苛酷な** :scream::scream::scream::scream::scream:
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket: 

[^1]: ジョークです。冗談です。[tailwindcss](https://tailwindcss.com/)と併用して使えるとおもうので、[PETAL](https://thinkingelixir.com/petal-stack-in-elixir/)は[PETAL](https://thinkingelixir.com/petal-stack-in-elixir/)のままです。[^2]
[^2]: と、断りをいれたところで、それはそれで本当かなあ？　とフロントエンドまわりは私が弱くて自信がなくなってきたので、それはそれで調べて記事にしてみようとおもいます。
