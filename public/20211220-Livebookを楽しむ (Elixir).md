---
title: Livebookを楽しむ (Elixir)
tags:
  - Elixir
  - LiveView
  - autoracex
  - Livebook
private: false
updated_at: '2022-03-11T12:06:13+09:00'
id: 223ad0fe1aa67a9fb151
organization_url_name: fukuokaex
slide: true
ignorePublish: false
---

https://qiita.com/advent-calendar/2021/nervesjp

2021/12/20(月)の回です。

[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)もあります〜

https://qiita.com/torifukukaiou/items/27abc5b84f6f55f85d71


---

# 2021/12/21(火) 19:30 〜

https://liveviewjp.connpass.com/event/233092/

の発表資料です。

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Phoenix](https://www.phoenixframework.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[LiveView](https://github.com/phoenixframework/phoenix_live_view)を楽しんでいますか:bangbang::bangbang::bangbang:
[Livebook](https://github.com/livebook-dev/livebook)を楽しんでいますか:bangbang::bangbang::bangbang:

---

|  | 私の感じ方、ざっくりとした説明 |
|:-|:-|
| [Elixir](https://elixir-lang.org/)  | 世俗派関数型言語[^1]。ふんわりとなんとなく知らない間に「ワタシ、関数型言語でプログラミングしちゃってました」 てな具合にプログラミングを楽しめます。 |
| [Phoenix](https://www.phoenixframework.org/)  | Webアプリケーションの開発を楽しめます  |
| [LiveView](https://github.com/phoenixframework/phoenix_live_view)  | 高性能なバックエンド開発もリッチなフロントエンド開発も[Elixir](https://elixir-lang.org/)一本で楽しめます！  |
| [Livebook](https://github.com/livebook-dev/livebook)  | [Jupyter](https://jupyter.org/)に相当するもの。[LiveView](https://github.com/phoenixframework/phoenix_live_view)を利用したアプリケーションの代表例ともいうべき金字塔。[LiveView](https://github.com/phoenixframework/phoenix_live_view)を利用したアプリケーションのお手本であり、最高峰。  |

[^1]: @kikuyuta 先生の「[世俗派関数型言語 Elixir を関数型言語風に使ってみたらやっぱり関数型言語みたいだった](https://qiita.com/kikuyuta/items/afa4c264720eb29d9760)」より。[Elixir](https://elixir-lang.org/)はコワくないですよ〜。


---

# [Livebook](https://github.com/livebook-dev/livebook)の公式ページ

https://livebook.dev/

**Collaborate as a team**
はのちほどデモ

---

# 動かし方

---

## 動かし方 ── Docker

```
$ docker run -p 8080:8080 --pull always livebook/livebook
```

---

## 動かし方 ── 私がホストしているもの

https://livebook.torifuku-kaiou.app/

パスワードは`enjoyelixirwearethealchemists` です

---

### 私がホストしているもの ── どうやって構築したの？

別の記事に書いています。
ご興味のある方はぜひご覧になってください。

https://qiita.com/torifukukaiou/items/6f6e9297e5275b951094

---


# 白紙のノートブックで[Elixir](https://elixir-lang.org/)を楽しむ

右上の「New notebook」を押して、新しいノートブックを作ります。
ノートブックに[Elixir](https://elixir-lang.org/)でプログラミングを楽しんでいきます。

---

## メモリ使用量のグラフをかく

ここではメモリ使用量のグラフをかいてみます。
とりあえず以下を一個ずつコピペして、`Evaluate`ボタン押しながら進めるとおもしろいですよ。

---


```elixir
Mix.install([
  {:vega_lite, "~> 0.1.3"},
  {:kino, "~> 0.5.0"}
])

alias VegaLite, as: Vl

memory = [
  total: :red,
  processes: :yellow,
  atom: :green,
  binary: :pink,
  code: :orange,
  ets: :blue
]

layers = 
  for {layer, color} <- memory do
    Vl.new()
    |> Vl.mark(:line)
    |> Vl.encode_field(:x, "iteration", type: :quantitative)
    |> Vl.encode_field(:y, Atom.to_string(layer), type: :quantitative, title: "Memory usage (MB)")
    |> Vl.encode(:color, value: color, datum: Atom.to_string(layer))
  end

widget = Vl.new(width: 500, height: 200)
  |> Vl.layers(layers)
  |> Kino.VegaLite.new()
```

---


```elixir
Kino.VegaLite.periodically(widget, 200, 0, fn i ->
  point =
    :erlang.memory()
    |> Enum.map(fn {type, bytes} -> {type, bytes / 1_000_000} end)
    |> Map.new()
    |> Map.put(:iteration, i)

  Kino.VegaLite.push(widget, point, window: 1000)
  {:cont, i + 1}
end)
```

---


```elixir
for i <- 1..1_000_000 do
  :"atom#{i}"
end
```

---


## メモリ使用量のグラフをかく ── 動画

<iframe width="924" height="520" src="https://www.youtube.com/embed/Zqkflkh_-7s" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

---

# Collaborate as a team

デモをします。
イメージ画像

![スクリーンショット 2021-12-20 23.42.12.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/727f15bb-376d-0317-d73b-c57887941959.png)

https://livebook.torifuku-kaiou.app/

パスワードは`enjoyelixirwearethealchemists` です

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:
Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang: 





