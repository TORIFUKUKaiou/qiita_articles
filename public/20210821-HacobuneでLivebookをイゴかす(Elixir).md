---
title: HacobuneでLivebookをイゴかす(Elixir)
tags:
  - Elixir
private: false
updated_at: '2021-11-20T21:28:36+09:00'
id: eab0dbebf3623e4e0b47
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
- 今日は、[Hacobune（はこぶね） β版](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)にて[Livebook](https://github.com/livebook-dev/livebook)をイゴかしてみます
- 現在、[Hacobune（はこぶね）](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)は、オープンβ版にて無料で利用できるとのことでつかってみました
- デプロイ方法は次の３種類とのことです
    - **①パブリックのDockerイメージを使用**
    - ②プライベートのDockerイメージを使用
    - ③GitHubレポジトリをHacobuneに接続して使用（Dockerfileが必須）
- 今回は、**①パブリックのDockerイメージを使用**でやってみます

## できたもの :tada::tada::tada::tada:
- https://livebook.c1.hacobuneapp.com/
    - パスワードには`securesecret`を入力してください
- [Livebook](https://github.com/livebook-dev/livebook)とは、[Elixir](https://elixir-lang.org/)を実行できるノートブックです
    - 上記をご自由に触ってみてください

## [Hacobune（はこぶね）](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)を知ったきっかけ
- [チャレキャラ](https://challecara.org/)という九州の学生のための育成型アプリコンテストの2021/8/21(土)イベントに先生役で参加しました
- イベント終了後、@zembutsu さんによる**Dockerコンテナ開発入門**というセミナーがありました
- 私は学生ではありませんが、参加してもよいとのことでしたので、[Docker](https://www.docker.com/)について基礎から学ばせていただきました
    - ありがとうございました！

# [Hacobune（β版）ドキュメント](https://manual.c1.hacobuneapp.com/docs) に従って設定を進めます

- アプリケーションの設定は以下のような感じです

![スクリーンショット 2021-08-21 21.17.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c82b8ab0-1491-f997-2244-b609e9399488.png)

- アプリケーション名は、小文字から始める必要があるようです
- ポートは、`8080`にします
- 環境変数`LIVEBOOK_PASSWORD`は、公式の通りに設定をしました
- 環境変数`LIVEBOOK_PORT`を設定しておかないと以下のエラーがでました
    - コンソールの「アプリケーションログ」から確認しました

```
ERROR!!! [Livebook] expected LIVEBOOK_PORT to be an integer, got: "tcp://10.233.58.201:8080"
```

- リソースはスタンダード(CPU 1 core、メモリ 2GB)を選びました


# Run
- Visit: https://livebook.c1.hacobuneapp.com/
  - パスワードには`securesecret`を入力してください

## イゴかし方

### Explore
- いろいろ探検してください!
- `Elixir and Livebook`がわかりやすいかとおもいます
- プログラムが書いてあるところにカーソルをあわせると、`Evaluate`というボタンがでてきますので、迷わず押してみてください
- [Elixir](https://elixir-lang.org/)のプログラムが実行されて結果が表示されます
- [Elixir](https://elixir-lang.org/)を楽しんでください！！！

![スクリーンショット 2021-08-21 21.27.27.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/58ff166a-eb64-5563-847a-2f22a8467dba.png)

### New notebook
- 今度は自分でElixirのプログラムを書いてみましょう
- 右上に**New notebook**という青のボタンがあります
- 適当にポチポチおしていくとElixirのプログラムが書けます

#### [Qiita API](https://qiita.com/api/v2/docs)
- Elixirタグのついた最新記事を20件取得して、そのタイトルの一覧を表示してくれます

```elixir
Mix.install([
  {:httpoison, "~> 1.8"},
  {:jason, "~> 1.2"}
])

"https://qiita.com/api/v2/items?query=tag:Elixir"
|> HTTPoison.get!()
|> Map.get(:body)
|> Jason.decode!()
|> Enum.map(& &1["title"])
```

#### グラフ表示
- メモリ使用量をグラフに書いてみます
- 3つのパートにわけて、[Elixir](https://elixir-lang.org/)のプログラムを書いてみましょう

```elixir
Mix.install([
  {:kino, "~> 0.3.0"},
  {:vega_lite, "~> 0.1.0"}
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

```elixir
for i <- 1..1_000_000 do
  :"atom#{i}"
end
```

- `Evaluate`するとこんなグラフが表示されます

![スクリーンショット 2021-08-21 22.02.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/45839b62-acae-72be-7ad2-b949c31ddde9.png)

# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- [Hacobune（はこぶね）](https://www.sakura.ad.jp/information/announcements/2021/08/12/1968207782/)を使うことで簡単に、[Livebook](https://github.com/livebook-dev/livebook)をイゴかすことができました
    - ありがとうございます！
- 次はデータベースと組み合わせた[Phoenix]()アプリケーションをデプロイしてみたいとおもいます
    - おもいっています
    - あくまでもおもっています
    - β版の間にぜひイゴかしておきたいとおもっています
    - 書きました!
        - [Hacobuneにデータベースを使うPhoenix Chatアプリをデプロイする(Elixir)](https://qiita.com/torifukukaiou/items/e45406000046638fb9a8)
- Enjoy [Elixir](https://elixir-lang.org/) :bangbang::bangbang::bangbang:


