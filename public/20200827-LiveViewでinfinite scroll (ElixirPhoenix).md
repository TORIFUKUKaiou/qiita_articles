---
title: LiveViewでinfinite scroll (Elixir/Phoenix)
tags:
  - Elixir
  - Phoenix
private: false
updated_at: '2020-08-27T21:51:01+09:00'
id: c3e37813c6c32fb6d5d2
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [How can I implement an infinite scroll in liveview?](https://elixirforum.com/t/how-can-i-implement-an-infinite-scroll-in-liveview/30457)
- ここに書いてある通りです
- [LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)でinfinite scrollをやってみます

![InfiniteScroll.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d25c4d23-1177-efae-11ce-23aab396f1eb.gif)

- こんな感じです
    - 右側のバーが最初は長いのですが、スクロールをすると短くなっていく様子がわかるとおもいます
    - いつも動いているかは自信がありませんが、[Koto Faucet](https://faucet.torifuku-kaiou.tokyo/koto/) で同様の操作ができます
- [Phoenix](https://www.phoenixframework.org/) v1.5.4
- [Elixir](https://elixir-lang.org/) 1.10.4-otp-23
- Erlang 23.0.1
- [OkazaKirin.beam #26](https://okazakirin-beam.connpass.com/event/187367/)での成果です

# phx.newからやってみる
- [Elixir](https://elixir-lang.org/)や[Phoenix](https://www.phoenixframework.org/)の準備はできているものとします
    - 準備がまだの方は以下を参考にしてください
    - [Installation](https://hexdocs.pm/phoenix/installation.html#content)
    - [インストール](https://fukuoka-ex.github.io/phoenix-guide-ja/guides/1.4/introduction/installation.html)
- 以下、ざざっと変更内容をまとめておきます

```
$ mix phx.new hello --live
$ mix ecto.create
$ mix phx.server
$ mix phx.gen.live Accounts User users username email phone_number
```

```elixir:lib/hello_web/router.ex 
  scope "/", HelloWeb do
    pipe_through :browser

    live "/", PageLive, :index

    live "/users", UserLive.Index, :index # 追加
    live "/users/new", UserLive.Index, :new # 追加
    live "/users/:id/edit", UserLive.Index, :edit # 追加

    live "/users/:id", UserLive.Show, :show # 追加
    live "/users/:id/show/edit", UserLive.Show, :edit # 追加
  end
```

```elixir:priv/repo/seeds.exs
for i <- 1..1000 do
  {:ok, _} =
    Hello.Accounts.create_user(%{
      username: "user#{i}",
      name: "User #{i}",
      email: "user#{i}@test",
      phone_number: "555-555-5555"
    })
end
```

```
$ mix ecto.migrate
$ mix run priv/repo/seeds.exs
```

```elixir:lib/hello_web/live/user_live/index.html.leex
  <tbody id="users"
         phx-update="append"
         phx-hook="InfiniteScroll"
         data-page="<%= @page %>">
```

```elixir:lib/hello_web/live/user_live/index.ex
defmodule HelloWeb.UserLive.Index do
  use HelloWeb, :live_view

  alias Hello.Accounts
  alias Hello.Accounts.User

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(page: 1, per_page: 10)
     |> fetch(), temporary_assigns: [users: []]}
  end

  defp fetch(%{assigns: %{page: page, per_page: per}} = socket) do
    assign(socket, users: Accounts.list_users(page, per))
  end

  def handle_event("load-more", _, %{assigns: assigns} = socket) do
    {:noreply, socket |> assign(page: assigns.page + 1) |> fetch()}
  end
```

```elixir:lib/hello/accounts.ex 
  def list_users(current_page, per_page) do
    Repo.all(
      from u in User,
        order_by: [asc: u.id],
        offset: ^((current_page - 1) * per_page),
        limit: ^per_page
    )
  end
```

```javascript:assets/js/app.js
let Hooks = {}

let scrollAt = () => {
  let scrollTop = document.documentElement.scrollTop || document.body.scrollTop
  let scrollHeight = document.documentElement.scrollHeight || document.body.scrollHeight
  let clientHeight = document.documentElement.clientHeight

  return scrollTop / (scrollHeight - clientHeight) * 100
}

Hooks.InfiniteScroll = {
  page() { return this.el.dataset.page },
  mounted(){
    this.pending = this.page()
    window.addEventListener("scroll", e => {
      if(this.pending == this.page() && scrollAt() > 90){
        this.pending = this.page() + 1
        this.pushEvent("load-more", {})
      }
    })
  },
  updated(){ this.pending = this.page() }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {hooks: Hooks, params: {_csrf_token: csrfToken}})
```

- visit http://localhost:4000/users

# Wrapping Up
- [JavaScript interoperability](https://hexdocs.pm/phoenix_live_view/js-interop.html#client-hooks)
- Enjoy Elixir!
