---
title: 'Earthly '
tags:
  - Elixir
  - Phoenix
  - Earthly
private: false
updated_at: '2021-01-06T07:49:21+09:00'
id: 35ef3e16bdad9ecd764a
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか :bangbang::bangbang::bangbang:
- [José Valim](https://twitter.com/josevalim)[^1]さんのこんな書き込みがありました

[^1]: [Elixir](https://elixir-lang.org/)の作者

[I am glad we took http://earthly.dev for a spin on @elixirphoenix! I can now easily reproduce our CI runs locally. The long and unproductive cycle of debugging, committing, and waiting for CI is gone! 🎉 To learn more, here is our Earthfile:](https://twitter.com/josevalim/status/1346404430275612683) 

# [Earthly](https://earthly.dev/)
> Earthly is a syntax for defining your build. It works with your existing build system. Get repeatable and understandable builds today.

![integration2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d45563b4-c6c5-64a2-d6a3-e12e457e2244.png)
(https://earthly.dev/)

- なんだかよくわかっていませんがインストールして使ってみます
- `Earthfile`というものを書くらしいです

# インストール
- [Installation](https://docs.earthly.dev/installation)に従います
- 予めDockerとGitが必要なのだそうです
    - いつインストールしたのか忘れましたがインストール済でした
- 私はmacOS 10.15.7 を使いました

```
$ brew install earthly
```

```
$ earthly github.com/earthly/hello-world:main+hello
           buildkitd | Starting buildkit daemon as a docker container (earthly-buildkitd)...
           buildkitd | ...Done
      busybox:1.32.0 | --> Load metadata linux/amd64
g/e/hello-world:main+base | --> FROM busybox:1.32.0
g/e/hello-world:main+base | [          ] resolve docker.io/library/busybox:1.32.0@sha256:bde48e1751173b709090c2539fdf12d6ba64e88ec7a4301591227ce925f3c678 [██████████] resolve docker.io/library/busybox:1.32.0@sha256:bde48e1751173b709090c2539fdf12d6ba64e88ec7a4301591227ce925f3c678 ... 100%
g/e/hello-world:main+base | [██████████] sha256:ea97eb0eb3ec0bbe00d90be500431050af63c31dc0706c2e8fb53e16cff7761f ... 100%
g/e/hello-world:main+base | [          ] extracting sha256:ea97eb0eb3ec0bbe00d90be500431050af63c31dc0706c2e8fb53e16cff7761f ... 0%                        [██████████] extracting sha256:ea97eb0eb3ec0bbe00d90be500431050af63c31dc0706c2e8fb53e16cff7761f ... 100%
g/e/hello-world:main+hello | --> RUN echo 'Hello, world!'
g/e/hello-world:main+hello | Hello, world!
              output | --> exporting outputs
              output | [██████████] sending tarballs ... 100%
=========================== SUCCESS ===========================
```

- インストールできたようです :tada::tada::tada:
- 指定している `Earthfile` は以下の通りです
    - https://github.com/earthly/hello-world/blob/ed881f6de1378eae795af4655d7ef5ba76fdc8ad/Earthfile

```Earthfile
FROM busybox:1.32.0

hello:
  RUN echo 'Hello, world!'
```

# [Phoenix](https://www.phoenixframework.org/)
- [Elixir](https://qiita.com/tags/elixir)タグを付けたいので、[Elixir](https://elixir-lang.org/)に関係することをやってみます
- [Phoenix](https://www.phoenixframework.org/)は、Webアプリケーションフレームワークです

```
$ earthly github.com/<アカウント or グループ>/<リポジトリ>:ブランチ+<target>
```
という並びだとおもったらばっちりそう[^2]だったので、もう :rocket: `Earthfile`がある[Phoenix](https://www.phoenixframework.org/)を指定してみます

[^2]: [Target, artifact and image referencing](https://docs.earthly.dev/guides/target-ref)


```
$ earthly -P github.com/phoenixframework/phoenix:master+all  

g/p/phoenix:master+test *failed* |   1) test with 1.0.0 serializer Phoenix.Socket.V1.JSONSerializer sends phx_error if a channel server abnormally exits (Phoenix.Integration.LongPollChannelsTest)
g/p/phoenix:master+test *failed* |      test/phoenix/integration/long_poll_channels_test.exs:429
g/p/phoenix:master+test *failed* |      ** (MatchError) no match of right hand side value: []
g/p/phoenix:master+test *failed* |      code: [_phx_reply, _user_entered, _joined, chan_error] = resp.body["messages"]
g/p/phoenix:master+test *failed* |      stacktrace:
g/p/phoenix:master+test *failed* |        test/phoenix/integration/long_poll_channels_test.exs:446: (test)

g/p/phoenix:master+test *failed* |      The following output was logged:
g/p/phoenix:master+test *failed* |      
g/p/phoenix:master+test *failed* |      22:46:04.663 [info]  JOINED room:test with 1.0.0 serializer Phoenix.Socket.V1.JSONSerializer sends phx_error if a channel server abnormally exits in 44µs
g/p/phoenix:master+test *failed* |        Parameters: %{}
g/p/phoenix:master+test *failed* |      
g/p/phoenix:master+test *failed* |      22:46:04.815 [error] GenServer #PID<0.5361.0> terminating
g/p/phoenix:master+test *failed* |      ** (RuntimeError) boom
g/p/phoenix:master+test *failed* |          test/phoenix/integration/long_poll_channels_test.exs:46: Phoenix.Integration.LongPollChannelsTest.RoomChannel.handle_in/3
g/p/phoenix:master+test *failed* |          (phoenix 1.6.0-dev) lib/phoenix/channel/server.ex:315: Phoenix.Channel.Server.handle_info/2
g/p/phoenix:master+test *failed* |          (stdlib 3.8.2.4) gen_server.erl:637: :gen_server.try_dispatch/4
g/p/phoenix:master+test *failed* |          (stdlib 3.8.2.4) gen_server.erl:711: :gen_server.handle_msg/6
g/p/phoenix:master+test *failed* |          (stdlib 3.8.2.4) proc_lib.erl:249: :proc_lib.init_p_do_apply/3
g/p/phoenix:master+test *failed* |      Last message: %Phoenix.Socket.Message{event: "boom", join_ref: nil, payload: %{}, ref: nil, topic: "room:test with 1.0.0 serializer Phoenix.Socket.V1.JSONSerializer sends phx_error if a channel server abnormally exits"}
g/p/phoenix:master+test *failed* |      State: %Phoenix.Socket{assigns: %{user_id: nil}, channel: Phoenix.Integration.LongPollChannelsTest.RoomChannel, channel_pid: #PID<0.5361.0>, endpoint: Phoenix.Integration.LongPollChannelsTest.Endpoint, handler: Phoenix.Integration.LongPollChannelsTest.UserSocket, id: nil, join_ref: "1", joined: true, private: %{log_handle_in: :info, log_join: :info}, pubsub_server: Phoenix.Integration.LongPollChannelsTest, ref: nil, serializer: Phoenix.Socket.V1.JSONSerializer, topic: "room:test with 1.0.0 serializer Phoenix.Socket.V1.JSONSerializer sends phx_error if a channel server abnormally exits", transport: :longpoll, transport_pid: #PID<0.5356.0>}
g/p/phoenix:master+test *failed* |      
g/p/phoenix:master+test *failed* | ....................................................................................................................

g/p/phoenix:master+test *failed* | Finished in 128.0 seconds
g/p/phoenix:master+test *failed* | 11 doctests, 737 tests, 1 failure

g/p/phoenix:master+test *failed* | Randomized with seed 43391
g/p/phoenix:master+test *failed* | Command /bin/sh -c 'mix test' failed with exit code 1
g/p/phoenix:master+test *failed* | g/p/phoenix:master+test *failed* | ERROR: Command exited with non-zero code: RUN mix test
```

- `failed`... :sweat_smile: 
- `-P`はつけないとエラーがでたのでつけました

> --allow-privileged, -P          Allow build to use the --privileged flag in RUN commands

# Wrapping Up 🎍🎍🎍🎍🎍
- 今回はインストールして、`Earthfile`があるプロジェクトを指定して動かしてみました
- また理解が進んだら記事を書きたいとおもいます
- ([Quick Tutorial: Build a Go App in Earthly](https://www.youtube.com/watch?v=B7Q7S2lpshw)のElixir版を陽気に紹介したい)
- Enjoy [Elixir](https://elixir-lang.org/) 🚀🚀🚀
