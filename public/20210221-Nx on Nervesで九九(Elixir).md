---
title: Nx on Nervesで九九(Elixir)
tags:
  - Elixir
  - Nerves
  - 40代駆け出しエンジニア
private: false
updated_at: '2021-02-26T22:57:47+09:00'
id: d335033bc30fd3d5b37e
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか :bangbang::bangbang::bangbang:
- 話題の[Nx](https://github.com/elixir-nx/nx)を触ってみました
    - 本当に文字通りさわってみただけです
    - [Nerves](https://nerves-project.org/)で動かしてみただけです
        - [Nerves](https://nerves-project.org/)とは、[ElixirのIoTでナウでヤングなcoolなすごいヤツです🚀](https://twitter.com/torifukukaiou/status/1201266889990623233)
    - 公式の[Examples](https://github.com/elixir-nx/nx/tree/main/nx#examples)を写した + 九九(大筋は @kikuyuta 先生のコード例を拝借 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:)
- [Introducing Nx - José Valim | Lambda Days 2021](https://www.youtube.com/watch?v=fPKMmJpAGWc)
    - [Elixir](https://elixir-lang.org/)作者である[José Valim](https://twitter.com/josevalim)さんの講演 :video_camera: 
- 2021/02/22(月)に開催予定の[autoracex #11](https://autoracex.connpass.com/event/204656/)ので成果です
- 私の使った環境です
    - macOS 10.15.7
    - Raspberry Pi 2(令和三年なのに、2です、twoです)

# 結論
- 公式の[Examples](https://github.com/elixir-nx/nx/tree/main/nx#examples)はそのままイゴきました :rocket::rocket::rocket: 
- 予想通りといえば予想通りですが、パソコン上でうごいたらそのまま[Nerves](https://nerves-project.org/)アプリとして、Raspberry Pi 2等でイゴくというのはいいですよね:bangbang::bangbang::bangbang:
    - な〜んにもかえなくて、そのままイゴきました
    - というか私自身はいまだに[Nerves](https://nerves-project.org/)アプリのほうで特殊なことをしないと動かなかったというものに出会ったことはありません


## 参考
- すでによい記事がいくつもできあがっています
    - 私も 🌊🌊🌊 :surfer::surfer_tone1::surfer_tone2::surfer_tone3::surfer_tone4::surfer_tone5: 🌊🌊🌊に乗ります 
- [Elixirでディープラーニング①：革新的ライブラリ「Nx」の導入](https://qiita.com/piacerex/items/db33fbe80751fdd30e48) -- @piacerexさん
- [Elixirの革新的ライブラリ「Nx」をMacでも動かしてみた](https://qiita.com/mokichi/items/1716b75709559b18ef6c) -- @mokichiさん
- [Nxで始めるゼロから作るディープラーニング 準備編](https://qiita.com/the_haigo/items/1a2f0b371a3644960251) -- @the_haigoさん
- [Elixirでディープラーニング②：Nxのdefn＋XLAでGPUを動か…せなかった(T_T)](https://qiita.com/piacerex/items/cb369ff43b1504f12d86) -- @piacerexさん
- [Nxで九九 (Elixir)](https://qiita.com/torifukukaiou/items/7380eab3bf12dc326a64) - @torifukukaiou (私自身の手前味噌)


# 環境構築
- 楽しむためには少しの準備が必要です
- [Nerves](https://nerves-project.org/)の準備をしましょう
- @takasehideki 先生の記事がオススメです
    - [ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
    - [ElixirでIoT#4.1.2：[使い方篇] Docker(とVS Code)だけ！でNerves開発環境を整備する](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9)

# [Nerves](https://nerves-project.org/)アプリの開発
- ここから先は、[Nerves](https://nerves-project.org/)アプリ開発の経験がおアリ:ant:の前提で書きます
- おいて行かないでくれ〜　これからだよ〜　という方は、@kentaroさんの「[ウェブチカでElixir/Nervesに入門する](https://qiita.com/kentaro/items/e8df79aa93b9fe9a567e)」がオススメです


# [Nx](https://github.com/elixir-nx/nx)の導入

```elixir:mix.exs
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:nx, "~> 0.1.0-dev", github: "elixir-nx/nx", branch: "main", sparse: "nx"}
    ]
  end
end

```

- 2021/2/20時点はこんな感じです
    - おそらく今後は、[hex](https://hex.pm/)のほうにも登録されてもっと簡単な指定方法ですむようになるとおもいます
- `mix.exs`を書き換えたらターミナルで以下のコマンドをうって、[Nx](https://github.com/elixir-nx/nx)を導入します

```
> export MIX_TARGET=rpi2
> mix deps.get
> mix firmware
> mix upload
```

- 一気にファームウェアの更新までやっちゃいました
    - 最初の一回はmicroSDカードをパソコンにさして焼きこむ必要がありますが、以降はネットワーク越しにファームウェアを書き換えることができます
    - [Nerves](https://nerves-project.org/)アプリ開発を続けているとこれがあたりまえになって、ついついそのありがたみを忘れがちなのですし、これを言葉で説明するのはなかなか難しいのですが、実際にやってみるとものすごく便利です:bangbang::bangbang::bangbang:
    - 普段の開発でも便利ですし、このへんの仕組みっていうのは、めぐりめぐって[NervesHub](https://www.nerves-hub.org/)につながるものだとおもっています
        - NervesHub is an extensible web service that allows you to manage over-the-air (OTA) firmware updates of devices in the field. Built with Phoenix, NervesHub delivers first-class support for hardware deployments directly from the command line.
    - 遠く離れたところにあるデバイスのファームウェアをOTAで書き換えられるのってすごくないですか:bangbang::bangbang::bangbang:

# Run
- 私は現段階ではAI?、ML?、TensorFlow?の区別すらよくわかっていないのでとりあえず写しただけです

## [Examples](https://github.com/elixir-nx/nx/tree/main/nx#examples)を写してみます

```
# ssh nerves-rpi2.local
```

- IExで実行してみます[^1]

[^1]: `config/target.exs`で`hostname`を指定しています。@nishiuchikazumaさんの「[`nerves.local` の名前を `orenonerves.local` にする](https://qiita.com/nishiuchikazuma/items/e1f9bb17794ce31efadf)」を参考にしてください。

```elixir
iex(pi@nerves-rpi2.local)1> t = Nx.tensor([[1, 2], [3, 4]])
#Nx.Tensor<
  s64[2][2]
  [
    [1, 2],
    [3, 4]
  ]
>

iex(pi@nerves-rpi2.local)2> Nx.shape(t)
{2, 2}

iex(pi@nerves-rpi2.local)3> t = Nx.tensor([[1, 2], [3, 4]])
#Nx.Tensor<
  s64[2][2]
  [
    [1, 2],
    [3, 4]
  ]
>

iex(pi@nerves-rpi2.local)4> Nx.divide(Nx.exp(t), Nx.sum(Nx.exp(t)))
#Nx.Tensor<
  f64[2][2]
  [
    [0.03205860328008499, 0.08714431874203257],
    [0.23688281808991013, 0.6439142598879722]
  ]
>

iex(pi@nerves-rpi2.local)5> defmodule MyModule do
...(pi@nerves-rpi2.local)5>   import Nx.Defn
...(pi@nerves-rpi2.local)5> 
...(pi@nerves-rpi2.local)5>   defn softmax(t) do
...(pi@nerves-rpi2.local)5>     Nx.exp(t) / Nx.sum(Nx.exp(t))
...(pi@nerves-rpi2.local)5>   end
...(pi@nerves-rpi2.local)5> end
{:module, MyModule,
 <<70, 79, 82, 49, 0, 0, 10, 64, 66, 69, 65, 77, 65, 116, 85, 56, 0, 0, 1, 157,
   0, 0, 0, 36, 15, 69, 108, 105, 120, 105, 114, 46, 77, 121, 77, 111, 100, 117,
   108, 101, 8, 95, 95, 105, 110, 102, 111, ...>>, {:softmax, 1}}

iex(pi@nerves-rpi2.local)6> MyModule.softmax 1
#Nx.Tensor<
  f64
  1.0
>
```
- <font color="purple">$\huge{イゴいています！}$</font>




## 九九
- Special Thanks: @kikuyuta 先生

```elixir
iex(pi@nerves-rpi2.local)12> s = Enum.map(1..9, &List.duplicate(&1, 9)) |> Nx.tensor()
#Nx.Tensor<
  s64[9][9]
  [
    [1, 1, 1, 1, 1, 1, 1, 1, 1],
    [2, 2, 2, 2, 2, 2, 2, 2, 2],
    [3, 3, 3, 3, 3, 3, 3, 3, 3],
    [4, 4, 4, 4, 4, 4, 4, 4, 4],
    [5, 5, 5, 5, 5, 5, 5, 5, 5],
    [6, 6, 6, 6, 6, 6, 6, 6, 6],
    [7, 7, 7, 7, 7, 7, 7, 7, 7],
    [8, 8, 8, 8, 8, 8, 8, 8, 8],
    [9, 9, 9, 9, 9, 9, 9, 9, 9]
  ]
>

iex(pi@nerves-rpi2.local)13> t = Nx.transpose(s)
#Nx.Tensor<
  s64[9][9]
  [
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [1, 2, 3, 4, 5, 6, 7, 8, 9]
  ]
>

iex(pi@nerves-rpi2.local)14> Nx.multiply(s,t)
#Nx.Tensor<
  s64[9][9]
  [
    [1, 2, 3, 4, 5, 6, 7, 8, 9],
    [2, 4, 6, 8, 10, 12, 14, 16, 18],
    [3, 6, 9, 12, 15, 18, 21, 24, 27],
    [4, 8, 12, 16, 20, 24, 28, 32, 36],
    [5, 10, 15, 20, 25, 30, 35, 40, 45],
    [6, 12, 18, 24, 30, 36, 42, 48, 54],
    [7, 14, 21, 28, 35, 42, 49, 56, 63],
    [8, 16, 24, 32, 40, 48, 56, 64, 72],
    [9, 18, 27, 36, 45, 54, 63, 72, 81]
  ]
>
```
- <font color="purple">$\huge{イゴいています！}$</font>



# Wrapping Up :lgtm::lgtm::lgtm::lgtm::lgtm:
- とりあえず触ってみました
    - 触ってみただけです
    - 雰囲気すごそうな感じはしています
    - まだみなさんと語り合うレベルにはないので周辺知識とかをつけていきたいと強く感じました
    - <font color="purple">$\huge{2021/02/25(木) 19:00〜}$</font>
    - [NervesJP #15 Nxを触ってみる回](https://nerves-jp.connpass.com/event/205125/)の予習ができました:bangbang:
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket::rocket::rocket: 


**ありがとナイス:flag_cn:！**

れっつじょいなす(Let's join us) :bangbang::bangbang::bangbang:
:point_down::point_down_tone1::point_down_tone2::point_down_tone3::point_down_tone4::point_down_tone5: 
[NervesJP Slackへの参加URL](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)
:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: 


![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/447253f9-3060-8bb7-7132-7754ef4aead5.png)
