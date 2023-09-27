---
title: NimbleTOTPを楽しむ（Elixir）
tags:
  - Elixir
  - LiveView
  - 猪木
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-10-23T10:52:06+09:00'
id: 415e6b163ebe6566157c
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに

[NimbleTOTP](https://hexdocs.pm/nimble_totp/NimbleTOTP.html)を楽しんでみます。

# What is [NimbleTOTP](https://hexdocs.pm/nimble_totp/NimbleTOTP.html) ?

> NimbleTOTP is a tiny library for Two-factor authentication (2FA) that allows developers to implement Time-Based One-Time Passwords (TOTP) for their applications.

二段階認証のアレです。（アレって何ですか？ :relaxed:）

二段階認証ってそもそもなんだっけ？　どうしてサーバ側とスマートフォンアプリのワンタイムパスワードが一致するのかが気になりました。
QRコードをスマートフォンアプリ(Google AuthenticatorやMicrosoft Authenticatorなど）で読み込むと30秒に一回パスワードが更新されて、ログインのときに入力をするアレです。
使い方はわかるけど仕組みはどうなっているのだ？　とおもったわけです。

https://www.rfc-editor.org/rfc/rfc6238

に書いてあります。

詳しいことは他の方の説明に譲るとして、仕組みは割と単純です（※私は[上記RFC](https://www.rfc-editor.org/rfc/rfc6238)をちゃんと読んでいません！）。
サーバ側で作ったシークレットがあのQRコードに埋め込まれていて、スマートフォンアプリはそれを端末に保存します。
シークレットと時間があればパスワードは導出できるアルゴリズムとなっています。
別の言い方をすると、シークレットさえわかれば時間の変化ととともに刻々と変化するパスワードがつくれるわけです。
サーバ側では、ユーザアカウントとシークレットを紐付けています。

![totop.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3bfefa58-7b56-37ee-f2fe-a0e584f24d75.png)



[usage](https://github.com/dashbitco/nimble_totp#usage)と[lib/nimble_totp.ex](https://github.com/dashbitco/nimble_totp/blob/master/lib/nimble_totp.ex)をみるとなんとなくわかるとおもいます。
細かな部分を完全には理解していませんが、シークレットと時間をパラメータにして、パスワードが変化することを読み取れるとおもいます。
ライブラリを使う分には不自由はありません。
以外と短くてびっくりします。

# [excalidraw](https://excalidraw.com/)

ちょっと横道にそれます。

さきほどの手書き風の図は、[excalidraw](https://excalidraw.com/)で描きました。
最近、私がお気に入りのツールです。

https://www.hotrails.dev/turbo-rails/crud-controller-ruby-on-rails

で知りました。
凄腕の開発者がホワイトボードになぐり書きした感じが良いです。

# 使ってみる

phx.gen.authと組み合わせて認証処理を組み込みましたーーーーッ！　が正攻法だとおもいます。
私はへそ曲がりなので、スマートフォンのアプリのような刻々とパスワードが変化するものをLiveViewで作ってみました。

できあがったものの様子はこちらです。

![](https://media.giphy.com/media/vcpl9iRfhCfotM4nZO/giphy-downsized-large.gif)

比較用に、同じシークレットを読み込ませたMicrosoft Authenticatorのワンタイムパスワードを画面の下側で動かしています。
（手ブレしていてグラグラしてて、見ていると気持ち悪くなりますね:money_mouth:）

Microsoft Authenticatorはandroidの録画機能で撮影してみましたが真っ黒になって動画に入っていませんでした。それで原始的な方法で別のカメラで撮影しました。

シークレットは、RubyのGem、 [mdp/rotp](https://github.com/mdp/rotp)の[サンプル](https://github.com/mdp/rotp#working-example)で使われている`JBSWY3DPEHPK3PXP`を使いました。

# Phoenixアプリのnew

プロジェクトを作ります。

```
mix phx.new hello
```

`mix.exs`を編集します。

```diff:mix.exs
-      {:plug_cowboy, "~> 2.5"}
+      {:plug_cowboy, "~> 2.5"},
+      {:nimble_totp, "~> 0.1.0"}
```

ソースコードを作ります。

```diff:lib/hello_web/router.ex
     pipe_through :browser
 
     get "/", PageController, :index
+    live "/totp", TotpLive
   end
```

```elixir:lib/hello_web/live/totop_live.ex
defmodule HelloWeb.TotpLive do
  use HelloWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1><%= format_password(@password) %></h1>
    <%= @remain %> s
    """
  end

  def mount(_params, _session, socket) do
    if connected?(socket), do: Process.send_after(self(), :update, 1000)

    {:ok, update_socket(socket)}
  end

  def handle_info(:update, socket) do
    Process.send_after(self(), :update, 1000)
    {:noreply, update_socket(socket)}
  end

  defp update_socket(socket) do
    now_one_time_password = Hello.DummyTotp.verification_code()

    index =
      0..30
      |> Enum.map(&Hello.DummyTotp.verification_code/1)
      |> Enum.find_index(&(&1 != now_one_time_password))

    socket
    |> assign(:password, now_one_time_password)
    |> assign(:remain, index)
  end

  defp format_password(password) do
    String.slice(password, 0..2) <> " " <> String.slice(password, 3..5)
  end
end

```

```elixir:lib/hello/dummy_totp.ex
defmodule Hello.DummyTotp do
  @secret Base.decode32!("JBSWY3DPEHPK3PXP")

  def verification_code(offset \\ 0) do
    NimbleTOTP.verification_code(@secret, time: System.os_time(:second) + offset)
  end
end
```

あとは以下のコマンドです。

```
cd hello
mix setup
mix phx.server
```

迷わず動かしてください。
残り３秒になったら、この動画の[最後のほう](https://www.youtube.com/watch?v=AWxwmqzbOaw&t=221s)をご覧になり、ご唱和ください。

<iframe width="910" height="512" src="https://www.youtube.com/embed/AWxwmqzbOaw" title="燃える闘魂 アントニオ猪木  追悼VTR" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

「１、２、３ダー！」誕生までの軌跡は、[こちら](https://www.youtube.com/watch?v=FSz7N5hCltw)に詳しくまとめられています。

https://www.youtube.com/watch?v=FSz7N5hCltw

# おわりに

[NimbleTOTP](https://hexdocs.pm/nimble_totp/NimbleTOTP.html)を楽しみました。

<font color="red">$\huge{１、２、３ダー！}$</font>


