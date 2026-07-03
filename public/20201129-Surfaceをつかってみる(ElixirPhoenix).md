---
title: Surfaceをつかってみる(Elixir/Phoenix)
tags:
  - Elixir
  - Surface
  - Phoenix
private: false
updated_at: '2021-07-19T12:25:51+09:00'
id: b5ae9eac42bd304b7aa3
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
この記事は、[Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2) 3日目です。
前日は、[LiveView uploadsを動かす 🎉🎉🎉(Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/c2b21e3658059927b577)でした。

# 2021/07/29(月) 追記
**この記事は[Surface](https://github.com/surface-ui/surface) 0.1.0時点のものです。**
**2021/07/19(月)時点では、だいぶ変わっているようですので、公式のドキュメントご確認ください :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:**
@piacerex さんにコメントいただきました。ありがとうございます！
https://qiita.com/torifukukaiou/items/b5ae9eac42bd304b7aa3#comment-b883f2c4088f456d49a3



# はじめに
- [Surface](http://surface-demo.msaraiva.io/)をつかってみます
    - 「A server-side rendering component library for [Phoenix](https://www.phoenixframework.org/)」です
    - [Vue.js](https://jp.vuejs.org/)にインスパイアされたそうで、`An HTML-centric templating language with built-in directives (:for, :if, ...) and syntactic sugar for attributes (inspired by Vue.js).`と書いてあります
    - `Surface`と聞くと[こちら](https://www.microsoft.com/ja-jp/surface)のWindowsマシンのことを私はまず想像してしまいますが、そうではありません
- つい先日、`0.1.0`が[リリース](https://twitter.com/MarlusSaraiva/status/1331678415108370433)されたばかりの[Hex](https://hex.pm/packages/surface)です
    - 2020/11/28現在、最新は`0.1.1`です
- この記事では、**導入方法**と**とりあえず使ってみました**ということまで書いておきます
    - [http://surface-demo.msaraiva.io/properties](http://surface-demo.msaraiva.io/properties)
    - ↑このページのサンプルと同じことをやってみます

## 使ったバージョン
- Elixir: 1.10.4-otp-23
- mix phx.new -v: v1.5.6
- node -v: v12.18.3
- psql --version: psql (PostgreSQL) 12.4

## ソースコード
- [TORIFUKUKaiou/my_app](https://github.com/TORIFUKUKaiou/my_app)

## デモ
- [https://triangular-basic-budgie.gigalixirapp.com/my-button](https://triangular-basic-budgie.gigalixirapp.com/my-button)
  - [Gigalixir](https://www.gigalixir.com/)で動かしていますのでどうぞ触ってみてください
  - [Gigalixir](https://www.gigalixir.com/)へのデプロイに興味のある方は、手間味噌な記事ですが[Hello Gigalixir (Phoenix/Elixir)](https://qiita.com/torifukukaiou/items/d2d0e9f56ffe3bb8eda1)などを参考に、[公式ページ](https://gigalixir.readthedocs.io/en/latest/getting-started-guide.html)をご参照ください
- しばらくはそのまま動かしておきます
    - アクセスできませんでしたら、他に興味が移って他のものを動かしているのだとご理解ください
- ボタンがくるくるしたり、角が丸くなったりする**だけ**のものです :point_down: :point_down_tone1: :point_down_tone2: :point_down_tone3: :point_down_tone4: :point_down_tone5:

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/378a36a0-0e38-c675-c442-8e6329b6c863.gif)

- 今回公開している内容は以上です :rocket::rocket:
 


# 0. 準備
- それではまず[Elixir](https://elixir-lang.org/)をインストールしましょう
- 手前味噌な記事ですが[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)などを参考にしてください
- `phx_new`、`node.js`、`PostgreSQL`などを[公式ドキュメント](https://hexdocs.pm/phoenix/installation.html#content)を参考にインストールしてください

# 1. プロジェクトの作成

```
$ mix phx.new my_web --live
$ cd my_web
$ mix ecto.create
```

# 2. [Surface](http://surface-demo.msaraiva.io/)の導入
- [Getting Started](http://surface-demo.msaraiva.io/getting_started)を参考に進めます

## `deps/0`

```diff:mix.exs
@@ -37,7 +37,7 @@ defmodule MyApp.MixProject do
       {:phoenix_ecto, "~> 4.1"},
       {:ecto_sql, "~> 3.4"},
       {:postgrex, ">= 0.0.0"},
-      {:phoenix_live_view, "~> 0.14.6"},
+      {:phoenix_live_view, "~> 0.15.0", override: true},
       {:floki, ">= 0.27.0", only: :test},
       {:phoenix_html, "~> 2.11"},
       {:phoenix_live_reload, "~> 1.2", only: :dev},
@@ -46,7 +46,8 @@ defmodule MyApp.MixProject do
       {:telemetry_poller, "~> 0.4"},
       {:gettext, "~> 0.11"},
       {:jason, "~> 1.0"},
-      {:plug_cowboy, "~> 2.0"}
+      {:plug_cowboy, "~> 2.0"},
+      {:surface, "~> 0.1.0"}
     ]
   end
```

## `import Surface`を追加します

```elixir:lib/my_app_web.ex
  def view do
    quote do
      use Phoenix.View,
        root: "lib/my_app_web/templates",
        namespace: MyAppWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
      import Surface
    end
  end
```

## [Bulma](https://bulma.io/)を追加

```diff:lib/my_app_web/templates/layout/root.html.leex
@@ -8,6 +8,7 @@
     <%= live_title_tag assigns[:page_title] || "MyApp", suffix: " · Phoenix Framework" %>
     <link phx-track-static rel="stylesheet" href="<%= Routes.static_path(@conn, "/css/app.css") %>"/>
     <script defer phx-track-static type="text/javascript" src="<%= Routes.static_path(@conn, "/js/app.js") %>"></script>
+    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.8.0/css/bulma.min.css" />
   </head>
   <body>
     <header>
```

## `.formatter.exs`

```diff:.formatter.exs
 [
-  import_deps: [:ecto, :phoenix],
+  import_deps: [:ecto, :phoenix, :surface],
   inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
   subdirectories: ["priv/*/migrations"]
 ]
```

## Visual Studio Code
- [Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)をお使いの方は[こちら](https://marketplace.visualstudio.com/items?itemName=msaraiva.surface)のExtensionを追加しておくとよいでしょう


## mix setup

```
$ mix setup
```

- `mix setup`は`mix.exs`に定義されているaliasです
- `["deps.get", "ecto.setup", "cmd npm install --prefix assets"]`をやってくれます
    - `ecto.setup`は`["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"]`をやってくれます
- これで準備は整いました :tada::tada::tada: 


# 2. ソースコードを書く

## lib/my_app_web/live/components/my_button.ex

```elixir:lib/my_app_web/live/components/my_button.ex
defmodule MyAppWeb.Components.MyButton do
  use Surface.Component

  prop loading, :boolean
  prop rounded, :boolean

  def render(assigns) do
    ~H"""
    <button class={{ "button", "is-info", "is-loading": @loading, "is-rounded": @rounded }}>
      <slot/>
    </button>
    """
  end
end
```

- [prop](http://surface-demo.msaraiva.io/properties)とか`~H`とか[Phoenix](https://www.phoenixframework.org/)の経験がある方でもはじめてみるものではないかとおもいます
- [Component](http://surface-demo.msaraiva.io/components_basics)を`lib/my_app_web/live/components`の下に配置したのは、[The Pragmatic Studio](https://pragmaticstudio.com/)の[Phoenix LiveView course](https://pragmaticstudio.com/phoenix-liveview)を参考にしてみました
    - 公開されている[ソースコード](https://github.com/pragmaticstudio/live_view_studio/blob/15-live-components-end/lib/live_view_studio_web/live/components/sandbox_calculator_component.ex)



## lib/my_app_web/live/my_button_live.ex

```elixir:lib/my_app_web/live/my_button_live.ex
defmodule MyAppWeb.MyButtonLive do
  use Surface.LiveView

  alias MyAppWeb.Components.MyButton

  data loading, :boolean, default: false
  data rounded, :boolean, default: false

  def mount(_params, _session, socket) do
    socket = Surface.init(socket)
    {:ok, assign(socket, checkboxes: [])}
  end

  def render(assigns) do
    ~H"""
    <MyButton loading={{ @loading }} rounded={{ @rounded }}>
      Change my style!
    </MyButton>

    <form phx-change="check_changed" style="margin-top: 30px">
      <input type="hidden" name="checkboxes[]" value="" />
      <label class="checkbox">
        <input type="checkbox" name="checkboxes[]" value="loading" checked={{ @loading }}>
        Loading
      </label>
      <label class="checkbox" style="margin-left: 20px">
        <input type="checkbox" name="checkboxes[]" value="rounded" checked={{ @rounded }}>
        Rounded
      </label>
    </form>

    <a href="https://qiita.com/torifukukaiou/items/b5ae9eac42bd304b7aa3">Surfaceをつかってみる(Elixir/Phoenix)</a>
    """
  end

  def handle_event(
        "check_changed",
        %{"_target" => ["checkboxes"], "checkboxes" => checkboxes},
        socket
      ) do
    loading = Enum.any?(checkboxes, &(&1 == "loading"))
    rounded = Enum.any?(checkboxes, &(&1 == "rounded"))
    {:noreply, assign(socket, loading: loading, rounded: rounded)}
  end
end
```

- [Surface.init/1](http://surface-demo.msaraiva.io/getting_started)
- [data](http://surface-demo.msaraiva.io/data)

## lib/my_app_web/router.ex

```elixir:lib/my_app_web/router.ex
  scope "/", MyAppWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live "/my-button", MyButtonLive # add
  end
```

# 3. Run

```
$ mix phx.server
```

- Visit: http://localhost:4000/my-button

# Wrapping Up :lgtm: :qiita-fabicon: :lgtm: 
- [Surface](http://surface-demo.msaraiva.io/)をとりあえず使ってみました
- 大注目の[Hex](https://hex.pm/packages/surface)です
- 私は[Vue.js](https://jp.vuejs.org/)は詳しくない[^1]のですが、ファミリアーな方は`<span v-once>This will never change: {{ msg }}</span>`こういう書き方と似ているようように感じていただけたのではないでしょうか
- Enjoy [Elixir](https://elixir-lang.org/) !!!


[^1]: たいていの他のこともたいして詳しいわけではない :man:
