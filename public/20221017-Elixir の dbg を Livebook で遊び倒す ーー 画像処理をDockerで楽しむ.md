---
title: Elixir の dbg を Livebook で遊び倒す ーー 画像処理をDockerで楽しむ
tags:
  - Elixir
  - Docker
  - 40代駆け出しエンジニア
  - Livebook
  - AdventCalendar2022
private: false
updated_at: '2022-10-18T13:31:50+09:00'
id: 34060e9b13c7bb55928e
organization_url_name: fukuokaex
slide: false
---
# はじめに

https://qiita.com/torifukukaiou/items/8598a1fb9d0a363fe674

を書きました。

上記の記事では、

<iframe width="751" height="422" src="https://www.youtube.com/embed/lyiqw3O8d_A" title="What's new in Livebook 0.7" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

の動画の内容を説明しました。

上記動画では、
@RyoWakabayashi さんの「[Elixir の dbg を Livebook で遊び倒す ーー 画像処理](https://qiita.com/RyoWakabayashi/items/7d9eff9df1041c705713#%E7%94%BB%E5%83%8F%E5%87%A6%E7%90%86)」がまんま紹介されています。

これを動かすにはいくつかミドルウェアが必要になります。
この記事は、Dockerコンテナで動かす方法を書いておきます。

[Livebook](https://livebook.dev/)が何なのかであったり、使い方はこの記事では説明していませんので、説明が必要な方は[コチラ](https://livebook.dev/)をご覧になってください。

# Dockerコンテナ

まずコンテナを立ち上げます。

```
docker pull hexpm/elixir:1.14.1-erlang-25.1.1-ubuntu-focal-20211006

docker run -d -it --rm -p 8080:8080 -p 8081:8081 --name livebook hexpm/elixir:1.14.1-erlang-25.1.1-ubuntu-focal-20211006

docker exec -it livebook bash
```

以下、コンテナの中での操作です。

```
apt-get update
apt-get install --no-install-recommends -y \
    libopencv-dev \
    build-essential \
    libgtk2.0-0 \
    erlang-dev \
    git \
    vim
apt-get install --reinstall ca-certificates
```

インストールの途中、タイムゾーンを聞かれたときには、私は`6. Asia`、`79. Tokyo`を選びました。
準備は整いました。
あとは、[livebook-dev/livebook](https://github.com/livebook-dev/livebook)を`git clone`して動かすのみです。

```
cd /root
git clone https://github.com/livebook-dev/livebook.git
cd livebook
git checkout -b tag-v0.7.1 v0.7.1
mix deps.get --only prod
```

一部ソースコードの変更が必要です。

```
vi config/prod.exs
```

`config/prod.exs`の変更点は以下の通りです。
ホストマシンからコンテナのPhoenixアプリ（この場合はLivebook）に接続できるようにしています。

```diff:config/prod.exs
 config :livebook, LivebookWeb.Endpoint,
-  http: [ip: {127, 0, 0, 1}, port: 8080],
+  http: [ip: {0, 0, 0, 0}, port: 8080],
   server: true
```

あとは迷わず実行してください！

```
MIX_ENV=prod mix phx.server
```

迷わずターミナルに表示されるURLに、ブラウザでアクセスしてください！
例: `http://localhost:8080/?token=qg67x6kzy4of7er75eoqtabo6lqpcpwe`
`token`の値は表示された通りのものを使ってください。

# notebook

notebookには以下のコードをコピペしてください。
Hexのインストールではバージョンを指定しませんでした。

2022-10-17現在、以下がインストールされました。
`Application.loaded_applications()`で調べました。

| Hex | バージョン |
|:-:|:-:|
| download  | 0.0.4  |
| evision  | 0.1.12  |
| kino  | 0.7.0   |
| nx  | 0.3.0  |

```elixir
Mix.install([
  :download, :evision, :kino, :nx
])
```




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


![スクリーンショット 2022-10-16 23.00.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/49d8b01f-2b53-cd2f-eca1-20dad38de7fd.png)

# おわりに

@RyoWakabayashi さんの「[Elixir の dbg を Livebook で遊び倒す ーー 画像処理](https://qiita.com/RyoWakabayashi/items/7d9eff9df1041c705713#%E7%94%BB%E5%83%8F%E5%87%A6%E7%90%86)」をDockerコンテナで動かす方法を書いておきました。
