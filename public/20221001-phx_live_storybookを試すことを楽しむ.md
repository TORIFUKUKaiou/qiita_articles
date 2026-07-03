---
title: phx_live_storybookを試すことを楽しむ
tags:
  - Elixir
  - Phoenix
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-10-01T10:45:58+09:00'
id: d69237193b153aed367b
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
# はじめに

[phx_live_storybook](https://github.com/phenixdigital/phx_live_storybook)を試すことを楽しんでみます。

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Hey there, we just released 0.4.0 of phx_live_storybook 🔥<br><br>A lot of work was involved in shipping new features, fixing bugs, refactoring code, and integrating feedback from both <a href="https://twitter.com/josevalim?ref_src=twsrc%5Etfw">@josevalim</a> &amp; <a href="https://twitter.com/chris_mccord?ref_src=twsrc%5Etfw">@chris_mccord</a> <a href="https://t.co/IGCjNaDyxC">https://t.co/IGCjNaDyxC</a><a href="https://twitter.com/hashtag/MyElixirStatus?src=hash&amp;ref_src=twsrc%5Etfw">#MyElixirStatus</a></p>&mdash; Christian Blavier (@cblavier) <a href="https://twitter.com/cblavier/status/1575521592725094400?ref_src=twsrc%5Etfw">September 29, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

[Elixir](https://elixir-lang.org/)の作者[José Valim](https://twitter.com/josevalim)さん、[Phoenix](https://www.phoenixframework.org/)の作者[Chris McCord](https://twitter.com/chris_mccord)さんの両御大がフィードバックをくれているそうです。

# What is [phx_live_storybook](https://github.com/phenixdigital/phx_live_storybook) ?

御両所も注目の[phx_live_storybook](https://github.com/phenixdigital/phx_live_storybook)とは、そもそも一体何でしょうか。

説明を読んでみます。

> PhxLiveStorybook provides a storybook-like UI interface for your Phoenix LiveView components.

JSの世界に、[Storybook](https://storybook.js.org/)というものが存在するそうです。

> Storybook is a frontend workshop for building UI components and pages in isolation. Thousands of teams use it for UI development, testing, and documentation. It’s open source and free.

[Storybook](https://storybook.js.org/)をよく知っている方はこの時点でピンとこられたこととおもいます。
私はこの世界を知らないので文章の説明だけでは、私はわかりませんでした。
それでとりあえずわからないものは触ってみるということで触ってみました。
そのことを書いておきます。

あとでわかることですが、自分で作成したUI componentをいろいろと試すことができるようです。

# デモ

https://phx-live-storybook-sample.fly.dev/storybook/colors

[phx_live_storybook](https://github.com/phenixdigital/phx_live_storybook)
作者の方がデモサイトを立ち上げてくださっています。
こちらを触ってみるのが一番わかりやすいとおもいます。

# 使用したElixirとErlang、Phoenixのバージョン

- Phoenix         v1.6.13
- elixir          1.14.0-otp-2
- erlang          25.0.3

# おことわり

[Phoenix](https://www.phoenixframework.org/) 1.7（未リリース）と組み合わせるほうがよさそうです。
理由は後述します。

とりあえず今日時点で動かした手順を書いておきます。

# mix phx.new

```
mix phx.new hello_storybook
cd hello_storybook
mix setup
```

# 依存Hexを追加

```elixir:mix.exs
  defp deps do
    {:phoenix_live_view, "~> 0.18.1"}, # change
    {:phoenix_live_dashboard, "~> 0.6", override: true}, # change

    ...
    {:phx_live_storybook, "~> 0.4.0"}, # add
    {:tailwind, "~> 0.1", runtime: Mix.env() == :dev}, # add
    {:heroicons, "~> 0.5.0"} # add
  end
```

`phx_live_storybook` 0.4.0は、`phoenix_live_view` 0.18以上が必要です。
それで、`mix phx.new`でもともと書かれていた、`phoenix_live_view`と`phoenix_live_dashboard`の指定を変更しています。

`tailwind`はのちほどの手順で`mix phx.gen.storybook`ということを行うのですが、そのときにTailwindの設定を書き換えるように指示されるのでインストールしました。
Tailwindは、

https://tailwindcss.com/docs/guides/phoenix

の手順に従って設定を進めてください。


`heroicons`は、`mix phx.gen.storybook`にてIconコンポーネントのサンプルが作られます。そのサンプルが依存するのでここでインストールしています。


```
mix deps.get
```

`phoenix_live_view`と`phoenix_live_dashboard`の指定を変更しないと以下のエラーでコケます。

```
Resolving Hex dependencies...

Failed to use "phoenix_live_view" (version 0.17.12) because
  phoenix_live_dashboard (version 0.6.5) requires ~> 0.17.7
  phx_live_storybook (versions 0.4.0 and 0.4.1) requires ~> 0.18
  mix.lock specifies 0.17.12

** (Mix) Hex dependency resolution failed, change the version requirements of your dependencies or unlock them (by using mix deps.update or mix deps.unlock). If you are unable to resolve the conflicts you can try overriding with {:dependency, "~> 1.0", override: true}
```

# mix phx.gen.storybook

`mix phx.gen.storybook`というインストールコマンドが使えるようになるので、実行します。
以下のファイルが作られます。

- assets/css/storybook.css
- assets/js/storybook.js
- lib/hello_storybook_web/storybook.ex
- storybook/components/icon.story.exs
- storybook/my_page.story.exs

またインストールの途中で手動で実行すべき作業が示されます。
その通りに手動で変更をします。

```elixir
* manual setup instructions:
  Add the following to your router.ex:

    use HelloStorybookWeb, :router
    import PhxLiveStorybook.Router

    scope "/" do
      storybook_assets()
    end

    scope "/", HelloStorybookWeb do
      pipe_through(:browser)
      live_storybook "/storybook", backend_module: HelloStorybookWeb.Storybook
    end


[Y to continue] [Yn] Y
* manual setup instructions:
  Add js/storybook.js as a new entry point to your esbuild args in config/config.exs:

    config :esbuild,
    default: [
      args:
        ~w(js/app.js js/storybook.js --bundle --target=es2017 --outdir=../priv/static/assets ...),
      ...
    ]


[Y to continue] [Yn] Y
* manual setup instructions:
  Add a new Tailwind build profile for css/storybook.css in config/config.exs:

    config :tailwind,
      ...
      default: [
        ...
      ],
      storybook: [
        args: ~w(
          --config=tailwind.config.js
          --input=css/storybook.css
          --output=../priv/static/assets/storybook.css
        ),
        cd: Path.expand("../assets", __DIR__)
      ]


[Y to continue] [Yn] Y
* manual setup instructions:
  Add a new endpoint watcher for your new Tailwind build profile in config/dev.exs:

    config :hello_storybook_web, HelloStorybookWeb.Endpoint,
      ...
      watchers: [
        ...
        storybook_tailwind: {Tailwind, :install_and_run, [:storybook, ~w(--watch)]}
      ]


[Y to continue] [Yn] Y
* manual setup instructions:
  Add a new live_reload pattern to your endpoint in config/dev.exs:

    config :hello_storybook_web, HelloStorybookWeb.Endpoint,
      live_reload: [
        patterns: [
          ...
          ~r"storybook/.*(exs)$"
        ]
      ]


[Y to continue] [Yn] Y
You are all set! 🚀
```

# mix phx.server

```
mix phx.server
```

立ち上がりません。エラー内容は、

```
== Compilation error in file lib/hello_storybook_web/views/layout_view.ex ==
** (CompileError) lib/hello_storybook_web/templates/layout/live.html.heex:4: undefined function live_flash/2 (expected HelloStorybookWeb.LayoutView to define such a function or for it to be imported, but none are available)
```

「[Phoenix](https://www.phoenixframework.org/) 1.7（未リリース）と組み合わせるほうがよさそうです」の理由です。
`mix.exs`のバージョン指定を変えたことで、[Phoenix.Component.live_flash/2](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#live_flash/2)が使えなくなっています。

ドキュメントは

![スクリーンショット 2022-10-01 7.47.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/fe99e047-fb5b-53ce-e389-cc4f8ab29b2c.png)

と書いてあります。
[Phoenix](https://www.phoenixframework.org/) 1.7を待ったほうがよさそうです。
`Phoenix.Flash`モジュールは探しましたが見当たりません。

# とりあえず先へ進みたい :fire::fire::fire:

[phx_live_storybook](https://github.com/phenixdigital/phx_live_storybook)を楽しむという目的にとっては、大勢には影響がなさそうな箇所なので、`lib/hello_storybook_web/templates/layout/live.html.heex`から[Phoenix.Component.live_flash/2](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#live_flash/2)の呼び出しを消しちゃいます。

```elixir:lib/hello_storybook_web/templates/layout/live.html.heex
 <main class="container">
   <p class="alert alert-info" role="alert"
     phx-click="lv:clear-flash"
-    phx-value-key="info"><%= live_flash(@flash, :info) %></p>
+    phx-value-key="info"></p>
 
   <p class="alert alert-danger" role="alert"
     phx-click="lv:clear-flash"
-    phx-value-key="error"><%= live_flash(@flash, :error) %></p>
+    phx-value-key="error"></p>
```

# 再度 mix phx.server

今度は立ち上がりました :fire::fire::fire:

Visit: http://localhost:4000/storybook

2 componentsのサンプルがあります。

![スクリーンショット 2022-10-01 7.07.21.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6261e795-3e67-9152-2b6e-1ebd7e00ee40.png)


![スクリーンショット 2022-10-01 7.07.31.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/fb0d524c-73b9-d157-5bc3-9803b729eea8.png)

# 自作コンポーネントを追加してみたい :rocket:

まず自作のコンポーネントを作ります。

```elixir:lib/hello_storybook_web/components/button.ex
defmodule HelloStorybookWeb.Components.Button do
  use HelloStorybookWeb, :component

  attr :label, :string, required: true, doc: "Button label"
  attr :theme, :atom

  def button(assigns) do
    assigns
    |> assign_new(:theme, fn -> :not_set end)
    |> assign_new(:label, fn -> "" end)
    |> assign_new(:"bg-color", fn -> "bg-indigo-600" end)
    |> assign_new(:"hover-bg-color", fn -> "hover:bg-indigo-700" end)
    |> assign_new(:"text-color", fn -> "text-white" end)
    |> render()
  end

  defp render(assigns) do
    ~H"""
    <button phx-click="boom" type="button" theme={@theme} class={"inline-flex items-center px-2.5 py-1.5 border border-transparent text-xs font-medium rounded shadow-sm #{assigns[:"text-color"]} #{assigns[:"bg-color"]} #{assigns[:"hover-bg-color"]} focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"}>
      <%= @label %>
    </button>
    """
  end
end
```

https://github.com/phenixdigital/phx_live_storybook_sample/blob/8178df34662b28bf0496b11b953b1a7145e5278f/lib/phx_live_storybook_sample/components/buttons/button.ex
を参考にしました。
（モジュール名を一部変えただけのコピペです）

続いて、storybookに表示されるようにします。

```elixir:storybook/components/button.story.exs
defmodule Storybook.Components.Button do
  alias HelloStorybookWeb.Components.Button

  use PhxLiveStorybook.Story, :component

  def function, do: &Button.button/1
  def description, do: "A simple button. If you click, I'll log a message!"

  def variations do
    [
      %Variation{
        id: :default,
        description: "Default button",
        attributes: %{
          label: "Boom!"
        }
      },
      %Variation{
        id: :custom_colors,
        description: "A button with custom colors",
        attributes: %{
          :label => "A button",
          :"bg-color" => "bg-green-600",
          :"hover-bg-color" => "bg-green-700"
        }
      }
    ]
  end
end

```

これもhttps://github.com/phenixdigital/phx_live_storybook_sample/blob/8178df34662b28bf0496b11b953b1a7145e5278f/storybook/components/buttons/button.story.exs
を参考にしました。
（モジュール名を一部変えただけのコピペです）

この2つのファイルを用意すると、storybookにメニューが追加されます。

![スクリーンショット 2022-10-01 7.16.27.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8b01b9a6-2783-7303-a611-063819372985.png)


:tada::tada::tada:

# おわりに

[phx_live_storybook](https://github.com/phenixdigital/phx_live_storybook)を試すことを楽しんでみました。

私は、[Phoenix](https://www.phoenixframework.org/)のアプリケーションでcomponentをちゃんと作ったことがあまりありませんし、JSの[Storybook](https://storybook.js.org/)のことは今日はじめて知りました。
わからないことが複数重なっているので、私にはその有り難みがまだよくわかっていません。
ただ、それは私がものを知らないだけです。

冒頭に紹介した通り、[José Valim](https://twitter.com/josevalim)さん、[Chris McCord](https://twitter.com/chris_mccord)さんの両御大がフィードバックをされているそうで、今後お世話になる機会はたくさん増えそうです。


[phx_live_storybook](https://github.com/phenixdigital/phx_live_storybook)が一人だけPhoenix 1.7+の世界を先取りしている感じが良いです :fire::fire::fire: 

注目のHexです。
