---
title: "LiveView uploadsを動かす \U0001F389\U0001F389\U0001F389(Elixir/Phoenix)"
tags:
  - Elixir
  - Phoenix
private: false
updated_at: '2020-12-02T11:56:51+09:00'
id: c2b21e3658059927b577
organization_url_name: fukuokaex
slide: false
---
この記事は、[Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2) 2日目です。
前日は[[87, 101, 32, 97, 114, 101, 32, 116, 104, 101, 32, 65, 108, 99, 104, 101, 109, 105, 115, 116, 115, 44, 32, 109, 121, 32, 102, 114, 105, 101, 110, 100, 115, 33]](https://qiita.com/torifukukaiou/items/badb4725a9c17788f8b1)でした。

# 2020/11/22 追記
- [Phoenix LiveView uploads](https://dev.to/torifukukaiou/phoenix-liveview-uploads-37i)と題して、 https://dev.to/ にも英語で書いてみました

# はじめに
- [Here's a little sneak peek of Phoenix LiveView uploads](https://twitter.com/chris_mccord/status/1299377514545057792) を動かしたいです
- **2020/11/21現在、動作することを確認しました ！！！**
    - [Phoenix LiveView 0.15 is out with the new uploads feature! I'm super excited to see what folks build with this. We put together a 30 minute deep dive that takes you step-by-step thru adding uploads to an app, including direct to S3 support](https://twitter.com/chris_mccord/status/1329836988485275652)
- ~~2020/10/24現在、絶賛レビュー中です~~
    - [Add live uploads #1184](https://github.com/phoenixframework/phoenix_live_view/pull/1184)
    - 上記のプルリクは、2020/11/6にマージされています :tada::tada::tada: 
- が、2020/11/7現在、私はまだアップロード動作を確認できていません
    - といいますのもまだまだ更新は続いているようで、たとえば[Do not recover forms on first join #1211](https://github.com/phoenixframework/phoenix_live_view/pull/1211)というプルリクが続いたりしています
- 試してみたことの記録を残しておきます
- 先の[プルリクエスト](https://github.com/phoenixframework/phoenix_live_view/pull/1184)は絶賛レビュー中で日々コミットが増えている状況ですので、また明日試すと結果は変わっているかもしれません
- `mix deps.update --all`で最新の更新内容が取り込めます

# 履歴
- 2020/11/21
    - Phoenix LiveView [0.15.0](https://github.com/phoenixframework/phoenix_live_view/blob/9ab1963b477c59255590a3d12b5cee976f8b937f/CHANGELOG.md)でuploadsは対応されました
- 2020/11/7
    - [486c4accf6f792d777fe61427e86d69a4025f369](https://github.com/phoenixframework/phoenix_live_view/pull/1211/commits/486c4accf6f792d777fe61427e86d69a4025f369)まで試しています
    - 結果は`Phoenix.LiveView.UploadChannel.handle_in/3`の同じところでエラーがでています
    - `cd deps/phoenix_live_view/assets/ && npm install && node node_modules/webpack/bin/webpack.js --mode development`しています
    - いまはこうしておかないと、`deps/phoenix_live_view/assets/js/phoenix_live_view.js`の変更が自身のアプリにとりこまれないからです
    - 正式リリース時には不要な手順になるとおもいます

- 2020/10/24
    - [f2aa53eb21cbe47042f764f6c7e0d26a01d9ee66](https://github.com/phoenixframework/phoenix_live_view/pull/1184/commits/f2aa53eb21cbe47042f764f6c7e0d26a01d9ee66)まで試しています
    - `(FunctionClauseError) no function clause matching in Phoenix.LiveView.UploadChannel.handle_in/3`

# [Add live uploads #1184](https://github.com/phoenixframework/phoenix_live_view/pull/1184)にコメントして取り込んでいただいたもの
- GitHubの[suggestion](https://docs.github.com/ja/free-pro-team@latest/github/collaborating-with-issues-and-pull-requests/commenting-on-a-pull-request#%E3%83%97%E3%83%AB%E3%83%AA%E3%82%AF%E3%82%A8%E3%82%B9%E3%83%88%E3%81%AB%E8%A1%8C%E3%82%B3%E3%83%A1%E3%83%B3%E3%83%88%E3%82%92%E8%BF%BD%E5%8A%A0%E3%81%99%E3%82%8B)で修正案を書いてみました(勝手にレビューに参加しています:rocket:)
- なんとか動かそうとドキュメントを読んでいて気づいた誤りにsuggestionをしてみましたというところです
- [Update lib/phoenix_live_view/helpers.ex](https://github.com/phoenixframework/phoenix_live_view/pull/1184/commits/1e6a856a3ccf55c17eb03190b4455ba6e1f8cb47)
- [Update lib/phoenix_live_view.ex](https://github.com/phoenixframework/phoenix_live_view/pull/1184/commits/46d870c9f0101dcdf721807053c9ca2bd0c9f766)
- [Update guides/server/uploads.md](https://github.com/phoenixframework/phoenix_live_view/pull/1184/commits/84a9c39fb0e90c5ecf81316e26e0e839bab6788a)

# 0. インストール
- [Installation](https://hexdocs.pm/phoenix/installation.html#content)に従って進めてください

# 1. プロジェクト作成

```
$ mix phx.new demo
$ cd demo
$ mix setup
```

# 2. [Phoenix LiveView](https://github.com/phoenixframework/phoenix_live_view)は`0.15.0`

```diff:mix.exs
--- a/mix.exs
+++ b/mix.exs
@@ -37,7 +37,7 @@ defmodule Demo.MixProject do
       {:phoenix_ecto, "~> 4.1"},
       {:ecto_sql, "~> 3.4"},
       {:postgrex, ">= 0.0.0"},
-      {:phoenix_live_view, "~> 0.14.6"},
+      {:phoenix_live_view, "~> 0.15.0"},
       {:floki, ">= 0.27.0", only: :test},
       {:phoenix_html, "~> 2.11"},
       {:phoenix_live_reload, "~> 1.2", only: :dev},
```

- オプションの詳しいところが気になる方は、`mix help deps`でご確認ください

```
$ mix deps.get
```

# 3. Uploadsを利用する

- [guides/server/uploads.md](https://github.com/phoenixframework/phoenix_live_view/blob/9ab1963b477c59255590a3d12b5cee976f8b937f/guides/server/uploads.md)を参考にしています


```diff:lib/demo_web/router.ex
@@ -18,6 +18,7 @@ defmodule DemoWeb.Router do
     pipe_through :browser
 
     live "/", PageLive, :index
+    live "/upload", UploadLive, :index
   end
```

```elixir:lib/demo_web/live/upload_live.ex
defmodule DemoWeb.UploadLive do
  use DemoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:uploaded_files, [])
     |> allow_upload(:avatar, accept: :any, max_entries: 3)}
  end

  def handle_event("validate", params, socket) do
    {:noreply, socket}
  end

  @impl true
  def handle_event("save", params, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :avatar, fn %{path: path}, _entry ->
        dest = Path.join("priv/static/uploads", Path.basename(path))
        File.cp!(path, dest)
        Routes.static_path(socket, "/uploads/#{Path.basename(dest)}")
      end)

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
  end
end
```

```elixir:lib/demo_web/live/upload_live.html.leex
<h1>Uploads</h1>


<%= for {_ref, err} <- @uploads.avatar.errors do %>
  <p class="alert"><%= Phoenix.Naming.humanize(err) %></p>
<% end %>

<%= for entry <- @uploads.avatar.entries do %>
  <%= entry.client_name %> - <%= entry.progress %>%
  <%= live_img_preview entry, width: 75 %>
<% end %>

<form phx-submit="save" phx-change="validate">
  <%= live_file_input @uploads.avatar %>
  <button type="submit">Upload</button>
</form>
```

- `/upload`にアクセスすると以下のような感じで表示されます

![スクリーンショット 2020-10-24 23.54.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e656ec8a-a137-80ba-de45-74294b15034b.png)

- 試しにファイルを一つ選択してみます
    - :lgtm::lgtm::lgtm: 

![スクリーンショット 2020-10-24 23.54.46.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a701b1d2-ecf1-479b-1a93-150475fa3770.png)

- UPLOADボタンを押す！
- こんなエラーがでました :sweat_smile: 

```
[error] GenServer #PID<0.629.0> terminating
** (File.CopyError) could not copy from "/var/folders/q6/5rpg5x9n6rx6357m9vztp_w00000gp/T//plug-1605/live_view_upload-1605895070-182994678098385-1" to "priv/static/uploads/live_view_upload-1605895070-182994678098385-1": no such file or directory
    (elixir 1.10.4) lib/file.ex:814: File.cp!/3
    (demo 0.1.0) lib/demo_web/live/upload_live.ex:21: anonymous fn/3 in DemoWeb.UploadLive.handle_event/3
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/upload_channel.ex:85: Phoenix.LiveView.UploadChannel.handle_call/3
    (phoenix 1.5.7) lib/phoenix/channel/server.ex:269: Phoenix.Channel.Server.handle_call/3
    (stdlib 3.13) gen_server.erl:706: :gen_server.try_handle_call/4
    (stdlib 3.13) gen_server.erl:735: :gen_server.handle_msg/6
    (stdlib 3.13) proc_lib.erl:226: :proc_lib.init_p_do_apply/3
Last message (from #PID<0.628.0>): {:consume, %Phoenix.LiveView.UploadEntry{cancelled?: false, client_last_modified: nil, client_name: "photo.png", client_size: 14517, client_type: "image/png", done?: true, preflighted?: true, progress: 100, ref: "0", upload_config: :avatar, upload_ref: "phx-FklJDbRnhJBw6wNh", uuid: "1093de58-ca7a-4466-b20d-accf0f470745", valid?: true}, #Function<0.15802900/2 in DemoWeb.UploadLive.handle_event/3>}
State: %Phoenix.Socket{assigns: %{chunk_timeout: 10000, chunk_timer: nil, done?: true, handle: #PID<0.630.0>, live_view_pid: #PID<0.628.0>, max_file_size: 14517, path: "/var/folders/q6/5rpg5x9n6rx6357m9vztp_w00000gp/T//plug-1605/live_view_upload-1605895070-182994678098385-1", uploaded_size: 14517}, channel: Phoenix.LiveView.UploadChannel, channel_pid: #PID<0.629.0>, endpoint: DemoWeb.Endpoint, handler: Phoenix.LiveView.Socket, id: nil, join_ref: "9", joined: true, private: %{connect_info: %{session: %{"_csrf_token" => "yw03HO6sYtcwV-OPt41fHesj"}}, log_handle_in: false, log_join: :info}, pubsub_server: Demo.PubSub, ref: nil, serializer: Phoenix.Socket.V2.JSONSerializer, topic: "lvu:0", transport: :websocket, transport_pid: #PID<0.623.0>}
Client #PID<0.628.0> is alive

    (stdlib 3.13) gen.erl:208: :gen.do_call/4
    (elixir 1.10.4) lib/gen_server.ex:1020: GenServer.call/3
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/upload_channel.ex:14: Phoenix.LiveView.UploadChannel.consume/3
    (elixir 1.10.4) lib/enum.ex:1396: Enum."-map/2-lists^map/1-0-"/2
    (demo 0.1.0) lib/demo_web/live/upload_live.ex:19: DemoWeb.UploadLive.handle_event/3
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/channel.ex:338: anonymous fn/3 in Phoenix.LiveView.Channel.view_handle_event/3
    (telemetry 0.4.2) /Users/yamauchi/Documents/13_Elixir/phoenix_projects/demo/deps/telemetry/src/telemetry.erl:262: :telemetry.span/3
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/channel.ex:203: Phoenix.LiveView.Channel.handle_info/2
    (stdlib 3.13) gen_server.erl:680: :gen_server.try_dispatch/4
    (stdlib 3.13) gen_server.erl:756: :gen_server.handle_msg/6
    (stdlib 3.13) proc_lib.erl:226: :proc_lib.init_p_do_apply/3
[error] GenServer #PID<0.628.0> terminating
** (stop) exited in: GenServer.call(#PID<0.629.0>, {:consume, %Phoenix.LiveView.UploadEntry{cancelled?: false, client_last_modified: nil, client_name: "photo.png", client_size: 14517, client_type: "image/png", done?: true, preflighted?: true, progress: 100, ref: "0", upload_config: :avatar, upload_ref: "phx-FklJDbRnhJBw6wNh", uuid: "1093de58-ca7a-4466-b20d-accf0f470745", valid?: true}, #Function<0.15802900/2 in DemoWeb.UploadLive.handle_event/3>}, 5000)
    ** (EXIT) an exception was raised:
        ** (File.CopyError) could not copy from "/var/folders/q6/5rpg5x9n6rx6357m9vztp_w00000gp/T//plug-1605/live_view_upload-1605895070-182994678098385-1" to "priv/static/uploads/live_view_upload-1605895070-182994678098385-1": no such file or directory
            (elixir 1.10.4) lib/file.ex:814: File.cp!/3
            (demo 0.1.0) lib/demo_web/live/upload_live.ex:21: anonymous fn/3 in DemoWeb.UploadLive.handle_event/3
            (phoenix_live_view 0.15.0) lib/phoenix_live_view/upload_channel.ex:85: Phoenix.LiveView.UploadChannel.handle_call/3
            (phoenix 1.5.7) lib/phoenix/channel/server.ex:269: Phoenix.Channel.Server.handle_call/3
            (stdlib 3.13) gen_server.erl:706: :gen_server.try_handle_call/4
            (stdlib 3.13) gen_server.erl:735: :gen_server.handle_msg/6
            (stdlib 3.13) proc_lib.erl:226: :proc_lib.init_p_do_apply/3
    (elixir 1.10.4) lib/gen_server.ex:1023: GenServer.call/3
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/upload_channel.ex:14: Phoenix.LiveView.UploadChannel.consume/3
    (elixir 1.10.4) lib/enum.ex:1396: Enum."-map/2-lists^map/1-0-"/2
    (demo 0.1.0) lib/demo_web/live/upload_live.ex:19: DemoWeb.UploadLive.handle_event/3
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/channel.ex:338: anonymous fn/3 in Phoenix.LiveView.Channel.view_handle_event/3
    (telemetry 0.4.2) /Users/yamauchi/Documents/13_Elixir/phoenix_projects/demo/deps/telemetry/src/telemetry.erl:262: :telemetry.span/3
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/channel.ex:203: Phoenix.LiveView.Channel.handle_info/2
    (stdlib 3.13) gen_server.erl:680: :gen_server.try_dispatch/4
    (stdlib 3.13) gen_server.erl:756: :gen_server.handle_msg/6
    (stdlib 3.13) proc_lib.erl:226: :proc_lib.init_p_do_apply/3
Last message: %Phoenix.Socket.Message{event: "event", join_ref: "4", payload: %{"event" => "save", "type" => "form", "value" => ""}, ref: "12", topic: "lv:phx-FklJDajpq0ivUgrD"}
State: %{components: {%{}, %{}, 1}, join_ref: "4", serializer: Phoenix.Socket.V2.JSONSerializer, socket: #Phoenix.LiveView.Socket<assigns: %{flash: %{}, live_action: :index, uploaded_files: [], uploads: %{__phoenix_refs_to_names__: %{"phx-FklJDbRnhJBw6wNh" => :avatar}, avatar: #Phoenix.LiveView.UploadConfig<accept: :any, ...>}}, changed: %{}, endpoint: DemoWeb.Endpoint, id: "phx-FklJDajpq0ivUgrD", parent_pid: nil, root_pid: #PID<0.628.0>, router: DemoWeb.Router, view: DemoWeb.UploadLive, ...>, topic: "lv:phx-FklJDajpq0ivUgrD", transport_pid: #PID<0.623.0>, upload_names: %{avatar: {"phx-FklJDbRnhJBw6wNh", nil}}, upload_pids: %{#PID<0.629.0> => {"phx-FklJDbRnhJBw6wNh", "0", nil}}}
[error] GenServer #PID<0.631.0> terminating
** (stop) exited in: GenServer.call(#PID<0.628.0>, {:phoenix, :register_entry_upload, %{channel_pid: #PID<0.631.0>, cid: nil, entry_ref: "0", ref: "phx-FklJDbRnhJBw6wNh"}}, 5000)
    ** (EXIT) no process: the process is not alive or there's no process currently associated with the given name, possibly because its application isn't started
    (elixir 1.10.4) lib/gen_server.ex:1023: GenServer.call/3
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/upload_channel.ex:28: Phoenix.LiveView.UploadChannel.join/3
    (phoenix 1.5.7) lib/phoenix/channel/server.ex:376: Phoenix.Channel.Server.channel_join/4
    (phoenix 1.5.7) lib/phoenix/channel/server.ex:298: Phoenix.Channel.Server.handle_info/2
    (stdlib 3.13) gen_server.erl:680: :gen_server.try_dispatch/4
    (stdlib 3.13) gen_server.erl:756: :gen_server.handle_msg/6
    (stdlib 3.13) proc_lib.erl:226: :proc_lib.init_p_do_apply/3
Last message: {Phoenix.Channel, %{"token" => "SFMyNTY.g2gDaAJhBHQAAAADZAADY2lkZAADbmlsZAADcGlkWGQADW5vbm9kZUBub2hvc3QAAAJ0AAAAAAAAAABkAANyZWZoAm0AAAAUcGh4LUZrbEpEYlJuaEpCdzZ3TmhtAAAAATBuBgAyI87mdQFiAAFRgA.BLOubQZKWUBTDL0TroHDprRup-O21gKvFnUzrDj9AEo"}, {#PID<0.623.0>, #Reference<0.2303790502.3383492609.21550>}, %Phoenix.Socket{assigns: %{}, channel: Phoenix.LiveView.UploadChannel, channel_pid: nil, endpoint: DemoWeb.Endpoint, handler: Phoenix.LiveView.Socket, id: nil, join_ref: "13", joined: false, private: %{connect_info: %{session: %{"_csrf_token" => "yw03HO6sYtcwV-OPt41fHesj"}}}, pubsub_server: Demo.PubSub, ref: nil, serializer: Phoenix.Socket.V2.JSONSerializer, topic: "lvu:0", transport: :websocket, transport_pid: #PID<0.623.0>}}
State: #Reference<0.2303790502.3383492609.21552>
[error] exited in: GenServer.call(#PID<0.628.0>, {:phoenix, :register_entry_upload, %{channel_pid: #PID<0.631.0>, cid: nil, entry_ref: "0", ref: "phx-FklJDbRnhJBw6wNh"}}, 5000)
    ** (EXIT) no process: the process is not alive or there's no process currently associated with the given name, possibly because its application isn't started
[error] GenServer #PID<0.632.0> terminating
** (KeyError) key "phx-FklJDbRnhJBw6wNh" not found in: %{"phx-FklJDyZBcshtwQPB" => :avatar}
    :erlang.map_get("phx-FklJDbRnhJBw6wNh", %{"phx-FklJDyZBcshtwQPB" => :avatar})
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/upload.ex:166: Phoenix.LiveView.Upload.get_upload_by_ref!/2
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/upload.ex:107: Phoenix.LiveView.Upload.update_progress/4
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/channel.ex:139: anonymous fn/4 in Phoenix.LiveView.Channel.handle_info/2
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/channel.ex:992: Phoenix.LiveView.Channel.write_socket/4
    (phoenix_live_view 0.15.0) lib/phoenix_live_view/channel.ex:137: Phoenix.LiveView.Channel.handle_info/2
    (stdlib 3.13) gen_server.erl:680: :gen_server.try_dispatch/4
    (stdlib 3.13) gen_server.erl:756: :gen_server.handle_msg/6
    (stdlib 3.13) proc_lib.erl:226: :proc_lib.init_p_do_apply/3
Last message: %Phoenix.Socket.Message{event: "progress", join_ref: "16", payload: %{"entry_ref" => "0", "event" => nil, "progress" => %{"error" => "failed"}, "ref" => "phx-FklJDbRnhJBw6wNh"}, ref: "17", topic: "lv:phx-FklJDajpq0ivUgrD"}
State: %{components: {%{}, %{}, 1}, join_ref: "16", serializer: Phoenix.Socket.V2.JSONSerializer, socket: #Phoenix.LiveView.Socket<assigns: %{flash: %{}, live_action: :index, uploaded_files: [], uploads: %{__phoenix_refs_to_names__: %{"phx-FklJDyZBcshtwQPB" => :avatar}, avatar: #Phoenix.LiveView.UploadConfig<accept: :any, ...>}}, changed: %{}, endpoint: DemoWeb.Endpoint, id: "phx-FklJDajpq0ivUgrD", parent_pid: nil, root_pid: #PID<0.632.0>, router: DemoWeb.Router, view: DemoWeb.UploadLive, ...>, topic: "lv:phx-FklJDajpq0ivUgrD", transport_pid: #PID<0.623.0>, upload_names: %{}, upload_pids: %{}}
```

- フォルダがないと言っているようにみえたので、`priv/static/uploads`フォルダをこさえてみました
- それから気を取り直してもう一度やってみました
- おっ！　今度はエラーがでなくなりました
- **`priv/static/uploads`を覗くとファイルができています！！！**
    - [Phoenix LiveView Uploads Deep Dive](https://www.phoenixframework.org/blog/phoenix-live-view-upload-deep-dive)の動画でも`mkdir`しているのを確認しました
- `open`コマンドで開いてみると画像が表示されることを確認しました :tada::tada::tada: 


# Wrapping Up :qiitan: 
- ~~絶賛レビュー中なので待て:dog:ということかもしれませんが、[プルリクエスト](https://github.com/phoenixframework/phoenix_live_view/pull/1184)の対象[ブランチ](https://github.com/phoenixframework/phoenix_live_view/tree/cm-uploads-merge)が更新されたら取り込んでみて動作確認してみようとおもいます~~
- ~~[LiveView uploads](https://twitter.com/chris_mccord/status/1299377514545057792)できたよ！　という方はぜひコメントをください！~~
- [Phoenix LiveView Uploads Deep Dive](https://www.phoenixframework.org/blog/phoenix-live-view-upload-deep-dive)で動画で説明されているのでぜひ見てみてください(~~私はまだみていない~~ |> みた！ :smile_cat: )
- Enjoy [Elixir](https://elixir-lang.org/) !!! :fire::rocket::rocket::rocket:


