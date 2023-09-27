---
title: Phoenix LiveViewでDPlayerを使って.m3u8形式の動画を再生する (Elixir)
tags:
  - Elixir
  - Phoenix
  - autoracex
private: false
updated_at: '2021-07-31T22:18:31+09:00'
id: 849a73b4dd6e30931715
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)を楽しんでいますか :bangbang::bangbang::bangbang:
- この記事は[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)で、`.m3u8`形式の動画を再生してみます
- 動画の再生にはJavaScriptの動画再生ライブラリである[DPlayer](https://dplayer.js.org/)を使います
- 公式の解説は、https://hexdocs.pm/phoenix_live_view/js-interop.html#client-hooks あたりが該当します
- 2021/7/31(土) 00:00〜2021/8/2(月) 23:59開催の[Elixir](https://elixir-lang.org/)の純粋なもくもく会[autoracex #39](https://autoracex.connpass.com/event/220688/)の成果です
- [Elixir](https://elixir-lang.org/)は`1.11.4-otp-23`、[Eralng](https://www.erlang.org/)は`23.0.1`を使いました

# Setup
- https://hexdocs.pm/phoenix/installation.html#content
- をご参照ください

```
$ mix phx.new autorace_phoenix --live
$ cd autorace_phoenix
```

## Why autorace_phoenix?
- なぜ`autorace_phoenix`というプロジェクト名にしたかというと、[Vue.js](https://vuejs.org/)で、[オートレース](https://autorace.jp/)の過去動画を連続再生するアプリを最近つくりました
- https://torifukukaiou.github.io/autorace-app/#/
    - :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: [GitHub Pages](https://docs.github.com/ja/pages/getting-started-with-github-pages/about-github-pages)でイゴいています
    - ソースコード: https://github.com/TORIFUKUKaiou/autorace-app
- なんとなくJavaScriptに自信がついてきたので[Elixir](https://elixir-lang.org/)と組み合わせることをやってみたくなりました

# JavaScriptのライブラリをインストールする

```
$ cd assets
$ npm install dplayer --save
$ npm install --save hls.js
$ cd ..
```

- [DPlayer](https://dplayer.js.org/)
- [hls.js](https://github.com/video-dev/hls.js)
- `--save`の位置が異なるのはそれぞれの公式ページに書いてあった`npm install`の指示に従いました
    - どっちの順番でもいいとおもっています

# ソースコードを書く

## [Elixir](https://elixir-lang.org/)

### ルートを追加
```elixir:lib/autorace_phoenix_web/router.ex
  scope "/", AutoracePhoenixWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/player", PlayerLive # Add
  end
```

### [DPlayer](https://dplayer.js.org/)で動画を再生するコンポーネント
- `phx-hook="Player"`は、あとででてくるJavaScriptの`Hooks.Player`のように`Player`を一致させておきます

```elixir:lib/autorace_phoenix_web/live/components/player_component.ex
defmodule AutoracePhoenixWeb.PlayerComponent do
  use AutoracePhoenixWeb, :live_component

  def render(assigns) do
    ~L"""
    <div id="dplayer"
         phx-hook="Player"
         data-url="<%= @url %>">
    </div>
    """
  end
end
```

### Player
- Playボタンを押したら動画を再生します
- 動画は2つ用意していて、一個目の再生が終わったら、`handle_event("load-more", _, socket)`がコールバックされて、2つ目の動画を再生します
- 二個目の再生が終わったら、同じように`handle_event("load-more", _, socket)`がコールバックされて、`{:noreply, assign(socket, url: nil, index: 2)}`となりまして、いい感じに連続再生の動作は停止します
- 動画のURLは適当に見つけたものでして、2021/07/31 現在、再生可能でした

```elixir:lib/autorace_phoenix_web/live/player_live.ex
defmodule AutoracePhoenixWeb.PlayerLive do
  use AutoracePhoenixWeb, :live_view

  @urls [
    "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8",
    "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
  ]

  def mount(_params, _session, socket) do
    {:ok, assign(socket, url: nil, index: -1)}
  end

  def render(assigns) do
    ~L"""
    <button phx-click="play">
      Play
    </button>

    <%= if @url do %>
    <%= live_component @socket, AutoracePhoenixWeb.PlayerComponent, url: @url %>
    <% end %>
    """
  end

  def handle_event("play", _, socket) do
    index = socket.assigns.index + 1
    {:noreply, assign(socket, url: Enum.at(@urls, index), index: index)}
  end

  def handle_event("load-more", _, socket) do
    index = socket.assigns.index + 1
    {:noreply, assign(socket, url: Enum.at(@urls, index), index: index)}
  end
end
```

## JavaScript
- `assets/js/app.js`に全部書いてもいいとおもいます
- [The Pragmatic Studio Phoenix LiveView Course](https://pragmaticstudio.com/courses/phoenix-liveview)という動画学習サイトで学んだことを使ってみました

```javascript:assets/js/app.js
import Hooks from "./hooks"; // add

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks, params: {_csrf_token: csrfToken}}) 
// mod `hooks: Hooks, `を追加
```



```javascript:assets/js/hooks.js
import Player from "./player"

let Hooks = {};

Hooks.Player = {
  url() { return this.el.dataset.url; },
  play() {
    const player = new Player(this.url(), function() {
      this.pushEvent("load-more");
    }.bind(this));

    player.fullScreen();
    player.play();
  },
  mounted() {
    this.play()
  },
  updated() {
    console.log("updated", this.url());
    this.play();
  },
}

export default Hooks;
```

```javascript:assets/js/player.js
import DPlayer from "dplayer";
import Hls from "hls.js";

class Player {
  constructor(url, ended_handler) {
    this.dp = new DPlayer({
      container: document.getElementById("dplayer"),
      screenshot: true,
      video: {
        url: url,
        type: "customHls",
        customType: {
          customHls: function (video) {
            const hls = new Hls();
            hls.loadSource(video.src);
            hls.attachMedia(video);
          },
        },
      },
    });

    this.dp.on("ended", function() { 
      console.log("ended");
      ended_handler();
    });
    this.dp.on("abort", function() { console.log("abort"); });
    this.dp.on("error", function() { console.log("error"); });
    this.dp.on("canplay", function() { console.log("canplay"); });
    this.dp.on("playing", function() { console.log("playing"); });
  };

  fullScreen() {
    console.log("fullScreen");
    this.dp.fullScreen.request("web");
  }

  play() {
    console.log("play");
    this.dp.play();
  }
}

export default Player;
```

# Run

```
$ mix phx.server
```

- Visit: [http://localhost:4000/player](http://localhost:4000/player)
- このスクリーンショットだとちっともおもしろくありませんね
- Playボタンを押すと動画の再生が開始します :tada::tada::tada: 

![スクリーンショット 2021-07-31 21.52.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3260df91-b57d-1c4f-80a0-985affd62d8a.png)

# ソースコード
- https://github.com/TORIFUKUKaiou/autorace_phoenix

## コミット
- https://github.com/TORIFUKUKaiou/autorace_phoenix/commit/edd10a2f82e9e32a58a45220fe51e3cbe4c132ed

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm::lgtm: 
- Enjoy [Elixir](https://elixir-lang.org/) !!!
- [Surface UI](https://surface-ui.org/)を取り入れて完成を目指したいとおもいます


