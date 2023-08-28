---
title: 'Phoenix 1.5でLiveViewを使いつつアクセス元のIPを取得したい[Elixir]'
tags:
  - Elixir
  - Phoenix
private: false
updated_at: '2020-06-05T16:07:26+09:00'
id: facd7e6b9c9bcff12268
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Phoenix](https://www.phoenixframework.org/) 1.5で[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)を使いつつアクセス元のIPを取得したいとおもっています
- [Monacoin testnet4 Faucet](https://monacoin-testnet-faucet.torifuku-kaiou.tokyo/monacoin/testnet)は[Ruby on Rails](https://rubyonrails.org/)を使って作りました
- だいぶ[Phoenix](https://www.phoenixframework.org/)にも慣れてきましたので作り直してみようとおもっています
- 同じIPからは一日一回だけコインを取得できることにしたいとおもっています
- アクセス元のIPはどうやって取得するのでしょうか

# 結論
- [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)の次のアップデートを待ちましょう
- ~~おそらく v0.12.2 (2020/5/3 14:07現在の最新は、v0.12.1)~~
- v0.13.0 での対応でした
- 以下のコミットがmasterにマージされています
    - [Expose connect_info to the LiveView mount/3](https://github.com/phoenixframework/phoenix_live_view/commit/72da87513c4886cb2af8b8bbdac3a774cf3f3e19)
    - [Fix connect_info docs](https://github.com/phoenixframework/phoenix_live_view/commit/4b4023c07b5c082505961139c4a5c92045c95e23)

# [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view) v0.13.0 でやればよいこと

```elixir:lib/xxx_web/endpoint.ex
  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [:peer_data, :x_headers, session: @session_options]]
```

```elixir:lib/xxx_web/page_live.ex
  def mount(_params, _session, socket) do
    if info = get_connect_info(socket) do
      {:ok, assign(socket, query: "", results: %{}, ip: ip(info))}
    else
      {:ok, assign(socket, query: "", results: %{}, ip: nil)}
    end
  end

  defp ip(info) do
    if Map.has_key?(info, :x_headers) && Enum.count(info.x_headers) > 0 do
      # Nginxが前にある場合(他にはELBとかを前に置いた場合もこっちな気がするがELBは未検証。Nginxは検証済)
      Enum.find(info.x_headers, {"x-forwarded-for", "127.0.0.1"}, fn {key, _value} ->
        key == "x-forwarded-for"
      end)
      |> elem(1)
    else
      info.peer_data.address
      |> Tuple.to_list()
      |> Enum.join(if tuple_size(info.peer_data.address) == 4, do: ".", else: ":")
    end
  end
```

以下、v0.13.0 リリース前に試していたことの記録です。

# とりあえず先行して取り込んでみて試してみました

```elixir:mix.exs
  defp deps do
    [
      ...
      {:phoenix_live_view,
       github: "phoenixframework/phoenix_live_view",
       ref: "72da87513c4886cb2af8b8bbdac3a774cf3f3e19",
       override: true},
       ...
     ]
```

# 実験 [Phoenix](https://www.phoenixframework.org/) アプリ
https://elixir-is-beautiful.torifuku-kaiou.tokyo/

- 以下SSLで公開した場合の話です
- macOSのChrome(81.0.4044.129)では、[Nginx](https://nginx.org/en/)が前にいないと、うまく動いていない気がします
    - [Nginx](https://nginx.org/en/)が前にいない場合、Chrome(81.0.4044.129)でもシークレットモードだとうごきます
- そういえば、[Build a real-time Twitter clone in 15 minutes with LiveView and Phoenix 1.5](https://www.youtube.com/watch?v=MZvmYaFkNJI)のビデオではSafariを使っていたなあとおもって、Safariを使うと[Nginx](https://nginx.org/en/)が前にいなくても動いていました

## ソースコード
https://github.com/TORIFUKUKaiou/chirp_demo

 - `feature/experimental` というブランチで文字通り実験をいろいろしています
 - @piacerex さんの[LiveViewでグラフィックをグリグリ動かす](https://qiita.com/piacerex/items/9b9e2fc59b74b529b66b) も[組み込ん](https://elixir-is-beautiful.torifuku-kaiou.tokyo/boxes)でみました

## 補足(わからないことなど) => 解決！
- ~~もともと[Phoenix](https://www.phoenixframework.org/)の前に[Nginx](https://nginx.org/en/)をおく構成にしていました~~
    - SSLは[Nginx](https://nginx.org/en/)で処理。[Nginx]https://nginx.org/en/) -> [Phoenix](https://www.phoenixframework.org/)間はhttp)
- ~~しかし、この方法だと取得できるIPが127.0.0.1になってしまったので、[Nginx](https://nginx.org/en/)は止めて、[Using SSL](https://hexdocs.pm/phoenix/using_ssl.html#content)を参考に動かしてみることにしました~~
- ~~IPアドレスは取得できるようになったのですが、Chromeで[Chirp](https://elixir-is-beautiful.torifuku-kaiou.tokyo/posts)が動かくなりました(Safariでは動いています)~~
- ~~[Nginx](https://nginx.org/en/)を使う場合は、`X-Forwarded-For`を取得できればいいのでしょうが、[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)ではどうやってやるのだろう？？？~~
- [Nginx](https://nginx.org/en/)を前においています
    - [how to get remote_ip from socket in phoenix-framework?](https://stackoverflow.com/questions/33276202/how-to-get-remote-ip-from-socket-in-phoenix-framework) 
    - ↑こちらは、[Phoenix](https://www.phoenixframework.org/) 1.4当時の記事で、1.5では少し書き方かわりますが`:x_headers`を追加しておくと`Phoenix.LiveView.get_connect_info`との組み合わせで、`X-Forwarded-For`が取得できるようになります


# 調査したことなど(単なる記録)

- 最初にみつけた記事。`conn.remote_ip`というものがあるらしいが、[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)使っている限り、`conn`なんて引数はない。
  - [How to get an IP address of a client?](https://stackoverflow.com/questions/40167750/how-to-get-an-ip-address-of-a-client)
- [Phoenix](https://www.phoenixframework.org/) 1.4だとこんな方法でできるよという記事。私のやり方が間違っているだけかもしれませんが、私が使っているのは1.5。うまくいかなかった。
  - [Phoenix socket/channels security / IP identification](https://elixirforum.com/t/phoenix-socket-channels-security-ip-identification/1463/4)
  - 前述の通り、`:x_headers`を書く場所を少しかえて、`Phoenix.LiveView.get_connect_info`と組み合わせると動きました
- これだ！　とおもってみつけたソースコード。ただし、[Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view) 0.12.1 には、`get_connect_info`なんて無いよといわれる。よくみるとまだ`master`ブランチにしかない。
  - [Expose connect_info to the LiveView mount/3](https://github.com/phoenixframework/phoenix_live_view/commit/72da87513c4886cb2af8b8bbdac3a774cf3f3e19)

# Wrapping Up
- 楽しい[Elixir](https://elixir-lang.org/)、[Phoenix](https://www.phoenixframework.org/)ライフを〜:rocket:
- 楽しみましょう！








