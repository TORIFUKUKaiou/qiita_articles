---
title: 「What's new in Livebook 0.7」YouTubeを楽しみました（Elixir）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - Livebook
  - AdventCalendar2022
private: false
updated_at: '2022-10-17T20:39:52+09:00'
id: 8598a1fb9d0a363fe674
organization_url_name: fukuokaex
slide: false
---
# はじめに

「[What's new in Livebook 0.7](https://www.youtube.com/watch?v=lyiqw3O8d_A)」と題したYouTubeがあります。
[José Valim](https://twitter.com/josevalim)さんが紹介していました。

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Official Livebook v0.7 announcement with a video showcasing some of the new features!<a href="https://twitter.com/hashtag/MyElixirStatus?src=hash&amp;ref_src=twsrc%5Etfw">#MyElixirStatus</a> <a href="https://t.co/KXUGWli5MS">https://t.co/KXUGWli5MS</a></p>&mdash; José Valim (@josevalim) <a href="https://twitter.com/josevalim/status/1579911074002137088?ref_src=twsrc%5Etfw">October 11, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

このツイートの[リンク先](https://news.livebook.dev/whats-new-in-livebook-0.7-2wOPsY)に、[YouTube](https://www.youtube.com/watch?v=lyiqw3O8d_A)の紹介があります。

<iframe width="751" height="422" src="https://www.youtube.com/embed/lyiqw3O8d_A" title="What's new in Livebook 0.7" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


# What's new in Livebook 0.7

1. Secret management
1. Visual representations of the running system (supervision trees, inter-process messaging, and more)
1. Interactive user interface to visualize and edit Elixir pipelines

上記3点です。
ひとつずつ見ていきます。
まず[動画](https://www.youtube.com/watch?v=lyiqw3O8d_A)をご覧になってください。
以下、[動画](https://www.youtube.com/watch?v=lyiqw3O8d_A)を見ている前提で、動画の中で使われているコードスニペットやポイントのみを記しておきます。
ただし、[動画](https://www.youtube.com/watch?v=lyiqw3O8d_A)で使われたコードスニペットはすべて書き写せているわけではありません。

# Livebookの起動

Dockerで動かします。

```
docker run -p 8080:8080 -p 8081:8081 --pull always livebook/livebook
```


# Secret management

左端の :lock: アイコンから設定します。

![スクリーンショット 2022-10-16 21.09.38.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b5d39405-10b3-e695-df6f-a30704eb6a2a.png)

NAMEを`API_USERNAME`とした場合、コードで読み出す場合は接頭辞`LB_`をつけて、`LB_API_USERNAME`として[System.fetch_env!/1](https://hexdocs.pm/elixir/1.13/System.html#fetch_env!/1)で読み出します。

[Req](https://hex.pm/packages/req)のインストールが未でしたら、インストールします。

```elixir
Mix.install([:req])
```


```elixir
api_username = System.fetch_env!("LB_API_USERNAME")
api_password = System.fetch_env!("LB_API_PASSWORD")

Req.get!("https://postman-echo.com/basic-auth", auth: {api_username, api_password})
```

# Visual representations of the running system (supervision trees, inter-process messaging, and more)

[kino](https://hex.pm/packages/kino)のインストールが未でしたら、インストールします。

```elixir
Mix.install([:kino])
```

```elixir
f = fn ->
  parent = self()

  child = 
    spawn(fn ->
      receive do
        :ping -> send(parent, :pong)
      end
    end)

  send(child, :ping)

  receive do
    :pong -> :ponged!
  end
end

Kino.Process.render_seq_trace(fn ->
  f.()
end)
```

![スクリーンショット 2022-10-16 21.23.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c0bf3dfb-744b-a319-36fb-f7aa95bbedd3.png)


```elixir
Kino.Process.render_seq_trace(fn ->
  1..4
  |> Task.async_stream(fn i ->
    i
  end)
  |> Stream.run()
end)
```

![スクリーンショット 2022-10-16 21.28.36.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8075db43-a5f5-7b20-e48c-e7120a1d0885.png)

```elixir
{:ok, supervisor_pid} =
  Supervisor.start_link(
    [
      {Task, fn -> Process.sleep(:infinity) end},
      {Agent, fn -> [] end}
    ],
    strategy: :one_for_one
  )
```

```elixir
Kino.Process.render_sup_tree(supervisor_pid)
```

```elixir
supervisor_pid
```

![スクリーンショット 2022-10-16 21.33.17.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/455f40bc-2a98-090a-55ec-93a94e49be70.png)




# Interactive user interface to visualize and edit Elixir pipelines

```elixir
"Elixir is cool!"
|> String.trim_trailing("!")
|> String.split()
|> List.first()
|> dbg()
```

まずこのコードで、[Kernel.dbg/2](https://hexdocs.pm/elixir/Kernel.html#dbg/2)の説明がされました。


## [Elixir の dbg を Livebook で遊び倒す](https://qiita.com/RyoWakabayashi/items/7d9eff9df1041c705713#%E7%94%BB%E5%83%8F%E5%87%A6%E7%90%86)

@RyoWakabayashi さんの記事がまんま紹介されていました。
こちらを試すときは、いくつかミドルウェアが必要です。

```
docker run -p 8080:8080 -p 8081:8081 --pull always livebook/livebook
```

の実行環境下では、[Mix.install/2](https://hexdocs.pm/mix/Mix.html#install/2)のときに以下のエラーが発生します。

```
12:43:02.464 [warning] Failed to load nif: {:load_failed, 'Failed to load NIF library /home/livebook/.cache/mix/installs/elixir-1.14.0-erts-12.3.2.2/bfadb99b0851f0ef64f7e431eb2b2d46/_build/dev/lib/evision/priv/evision: \'libgtk-x11-2.0.so.0: cannot open shared object file: No such file or directory\''}
```

そこでこの記事では、macOSで動かしてみます。
**参考：** Dockerコンテナで動かす方法は、「[Elixir の dbg を Livebook で遊び倒す ーー 画像処理をDockerで楽しむ](https://qiita.com/torifukukaiou/items/34060e9b13c7bb55928e)」にまとめています。

```
brew install ffmpeg@4
echo 'export PATH="/usr/local/opt/gettext/bin:$PATH"' >> ~/.zshenv
source ~/.zshenv
brew link --overwrite ffmpeg@4
```

上記は私のmacOSで行った手順です。
お試しされるマシンの状態により、必要に応じて調整してください。
特に、`brew link --overwrite ffmpeg@4` はよくよく意味をご理解した上で実施してください。
ちなみに私は説明できません。

ままよ、どうにでもなれ！　という気持ちで実行しています。

踏み出せば
その一足が道となり
その一足が道となる
迷わず行けよ（エンター押せよ）
行けばわかるさ
ありがとうーーーーッ！
の気持ちで実行しています。


```
git clone https://github.com/livebook-dev/livebook.git
cd livebook
git checkout -b tag-v0.7.1 v0.7.1
mix deps.get --only prod
MIX_ENV=prod mix phx.server
```

```elixir
Mix.install([
  :download, :evision, :kino, :nx
])
```

特にバージョンは指定せず実行しました。
2022-10-16現在、以下がインストールされました。
`Application.loaded_applications()`で調べました。

| Hex | バージョン |
|:-:|:-:|
| download  | 0.0.4  |
| evision  | 0.1.12  |
| kino  | 0.7.0   |
| nx  | 0.3.0  |


```elixir
alias Evision, as: OpenCV

defmodule Helper do
  def download!(url, save_as) do
    unless File.exists?(save_as) do
      Download.from(url, path: save_as)
    end

    save_as
  end

  def show_image(mat) do
    OpenCV.imencode(".png", mat)
    |> IO.iodata_to_binary()
    |> Kino.Image.new(:png)
  end

  def show_image_from_path(image_path) do
    image_path
    |> File.read!()
    |> Kino.Image.new(:jpeg)
  end
end
```

[元記事](https://qiita.com/RyoWakabayashi/items/7d9eff9df1041c705713)とは使用している[Evision](https://hexdocs.pm/evision/Evision.html)のバージョンが異なります。
私は、`0.1.12`を使っています。
`imencode!`は存在しないと言われたので、カンで`!`を外しました。
Hexのドキュメントをチラ見しつつ、カンで適当に変更しました。
動きました。



```elixir
image_path = "dog.jpg"

"https://raw.githubusercontent.com/pjreddie/darknet/master/data/dog.jpg"
|> Helper.download!(image_path)
|> Helper.show_image_from_path()
```

```elixir
move = 
  [
    [1, 0, 100],
    [0, 1, 50]
  ]
  |> Nx.tensor(type: {:f, 32})
  |> OpenCV.Nx.to_mat()

rotation = OpenCV.getRotationMatrix2D({512 / 2, 512 / 2}, 90, 1)

image_path
|> OpenCV.imread()
|> OpenCV.blur({9, 9})
|> OpenCV.warpAffine(move, {512, 512})
|> OpenCV.warpAffine(rotation, {512, 512})
|> OpenCV.rectangle({50, 10}, {125, 60}, {255, 0, 0})
|> OpenCV.ellipse({300, 300}, {100, 200}, 30, 0, 360, {255, 255, 0}, thickness: 3)
|> Helper.show_image()
|> dbg()
```

繰り返します。
[元記事](https://qiita.com/RyoWakabayashi/items/7d9eff9df1041c705713)とは使用している[Evision](https://hexdocs.pm/evision/Evision.html)のバージョンが異なります。
私は、`0.1.12`を使っています。
`!`付きのメソッドがなくなっていたり、関数の戻り値がタプルではなくなっていたり、引数がListではなくタプルで指定するようになっていたりしました。
Hexのドキュメントをチラ見しつつ、カンで適当に変更しました。
動きました:tada:


![スクリーンショット 2022-10-16 23.00.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/49d8b01f-2b53-cd2f-eca1-20dad38de7fd.png)

## 猫たち

```elixir
Mix.install([
  :kino
])
```

```elixir
urls = [
  "https://images.unsplash.com/photo-1603203040743-24aced6793b4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&h=580&q=80",
  "https://images.unsplash.com/photo-1578339850459-76b0ac239aa2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&h=580&q=80",
  "https://images.unsplash.com/photo-1633479397973-4e69efa75df2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&h=580&q=80",
  "https://images.unsplash.com/photo-1597838816882-4435b1977fbe?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&h=580&q=80",
  "https://images.unsplash.com/photo-1629778712393-4f316eee143e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&h=580&q=80",
  "https://images.unsplash.com/photo-1638667168629-58c2516fbd22?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&h=580&q=80"
]


images = 
  for {url, i} <- Enum.with_index(urls, 1) do
    image = Kino.Markdown.new("![](#{url})")
    label = Kino.Markdown.new("**Image #{i}**")
    Kino.Layout.grid([image, label], boxed: true)
  end

Kino.Layout.grid(images, columns: 3)
```

![スクリーンショット 2022-10-16 23.16.43.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7826e0ce-351f-0117-4a7c-ff1c6282314b.png)



# おわりに

「[What's new in Livebook 0.7](https://www.youtube.com/watch?v=lyiqw3O8d_A)」と題されたYouTubeを私は楽しみました。
見るだけではなくコードを書いたほうが楽しめますので私は書きました。
この記事では、そのコードスニペットを共有しました。

[Livebook](https://livebook.dev/) v0.7に追加された、3つの機能を紹介しました。


1. Secret management
1. Visual representations of the running system (supervision trees, inter-process messaging, and more)
1. Interactive user interface to visualize and edit Elixir pipelines

Enjoy [Elixir](https://elixir-lang.org/)!!!


---

# 追伸


私は、[動画](https://www.youtube.com/watch?v=lyiqw3O8d_A)をみながら文字起こししました。
よくよく[元記事](https://news.livebook.dev/whats-new-in-livebook-0.7-2wOPsY)をよくみると、コードスニペットは載っていました :sweat_smile: 
[Evision](https://hexdocs.pm/evision/Evision.html)のバージョンアップに伴う関数IFの変更に追従したのがこの記事のレゾンデートルです。
私自身は、写すことを楽しみました。

