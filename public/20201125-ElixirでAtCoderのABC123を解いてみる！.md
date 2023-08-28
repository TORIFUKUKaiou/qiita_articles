---
title: ElixirでAtCoderのABC123を解いてみる！
tags:
  - Elixir
  - fukuoka.ex
private: false
updated_at: '2020-12-04T19:04:10+09:00'
id: 75d5db21d98fdf4459e2
organization_url_name: fukuokaex
slide: false
---
この記事は、[fukuoka.ex Elixir／Phoenix Advent Calendar 2020](https://qiita.com/advent-calendar/2020/fukuokaex) 3日目です。
前日は、@marocchino さんの[優しいエラーメッセージを書きたい](https://qiita.com/marocchino/items/f8b4baa6f6ee294f6b79)でした。


# はじめに :christmas_tree::christmas_tree::christmas_tree: 

- [Elixir](https://elixir-lang.org/)で[AtCoder Beginner Contest 123](https://atcoder.jp/contests/abc123)をやってみました
- **12月3日 |> 123 |> 一二三 |> 加藤一二三九段 |> 1月1日生まれ |> 私も1月1日** ということでお贈りいたします :qiitan:
- 問題はA問題、B問題、C問題、D問題とあるのですが、今回はA問題、B問題を解きます
- C問題、D問題については**2021/12/3**の[fukuoka.ex Elixir／Phoenix Advent Calendar 2021](https://qiita.com/advent-calendar/2021/fukuokaex)で記事にしたいと思います
    - @koyo-miyamura さんにご紹介いただいた[問題解決力を鍛える!アルゴリズムとデータ構造](https://www.amazon.co.jp/dp/4065128447/)を進めていきたいとおもっています
- 文字通り、首を長くしてお待ちください :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:  

# 今年のごくワタシ的[Elixir](https://elixir-lang.org/)活動まとめ
- [昨年](https://qiita.com/advent-calendar/2019/fukuokaex)と比べて、1年間の間にずいぶんできることは増えたように感じています
- 本題に入る前に少しご紹介させてください

## [ElixirConf EU Virtual](https://www.elixirconf.eu/archives/virtual_2020/)
- 2020/06/18-19に行われた[ElixirConf EU Virtual](https://www.elixirconf.eu/archives/virtual_2020/)にてLightning Talkを行いました
- :raised_hand: 手をあげる勇気ーー**[蛮勇](https://qiita.com/zacky1972/items/6a3bc8d41dff1ae9d9bf#lonestar-elixirconf-2019-%E3%81%A7%E3%81%AE-lunchisode)**さえあれば誰でもLTをさせてくれたようにおもいます
- リモートで開催されたのでおもいきってやってみました
- [資料 ツイート](https://twitter.com/torifukukaiou/status/1274020337223516160)

## [Interface(インターフェース) 2021年 1 月号](https://interface.cqpub.co.jp/magazine/202101/)
- @takasehideki 先生のお手伝いという形でいっしょに書かせていただいて、[名乗るほどのものではない名前](https://interface.cqpub.co.jp/wp-content/uploads/if2101_152.pdf)を載っけてもらいました！
- [IoT向きモダン言語Elixirの研究 第7回　IoTシステム開発にトライ!(サンプル)](https://interface.cqpub.co.jp/wp-content/uploads/if2101_152.pdf)

## Enjoy Elixirシリーズ！
- [Enjoy Elixir](Enjoy Elixir #001 -- mix new, iex -S mix, mix format)と題して、[Elixir](https://elixir-lang.org/)を少しずつ学んでいく連載を書いてみました
    - 慣れてきたらぜひ[公式ドキュメント](https://hexdocs.pm/elixir/Kernel.html)をご参照ください
    - 実行例がたくさん書いてあってわかりやすいです
    - [Enum](https://hexdocs.pm/elixir/Enum.html#content)モジュールと仲良くなれるとできることがいろいろ増える実感が湧いてきます
- これから[Elixir](https://elixir-lang.org/)はじめてみよう！　という方の最初の入り口に使っていただけると幸いです
- [Enjoy Elixir #001 -- mix new, iex -S mix, mix format](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af)
- [Enjoy Elixir #999 -- Where to go next](https://qiita.com/torifukukaiou/items/4fa0747546aafa3fe89a)

## コミット
- ドキュメントの修正が中心ではありますがプルリク等を採用してもらえました
- こうして並べてみると、けっこう有名な[Hex](https://hex.pm/)たちが並んでいるようにおもいます

### [phoenix_live_view](https://github.com/phoenixframework/phoenix_live_view)
- [Update lib/phoenix_live_view/helpers.ex](https://github.com/phoenixframework/phoenix_live_view/pull/1184/commits/1e6a856a3ccf55c17eb03190b4455ba6e1f8cb47)
- [Update lib/phoenix_live_view.ex](https://github.com/phoenixframework/phoenix_live_view/pull/1184/commits/46d870c9f0101dcdf721807053c9ca2bd0c9f766)
- [Update guides/server/uploads.md](https://github.com/phoenixframework/phoenix_live_view/pull/1184/commits/84a9c39fb0e90c5ecf81316e26e0e839bab6788a)

### [nerves-project/nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)
- [Improve new task message](https://github.com/nerves-project/nerves_bootstrap/commit/d7b23afaffb02574e2c3a9ab536a042178c37372)
    - ソースコードの改善！ :rocket::rocket::rocket: 

### [timex](https://github.com/bitwalker/timex)
- [Fix a typo in Timex.shift/2 doc](https://github.com/bitwalker/timex/commit/24bcdc71db493bee8bf09d7a9d145594717cdf0d)

### [crawly](https://github.com/oltarasenko/crawly)
- [Format sample config.exs on README](https://github.com/oltarasenko/crawly/commit/c53a3301a568cb09576d256a3110ce1a2f0fbd72)


# 問題
- それでは本題に入ります
- [AtCoder Beginner Contest 123](https://atcoder.jp/contests/abc123)
- A〜Bまで解いてみます

## [AtCoder](https://atcoder.jp/home)について
- 世界最高峰の競技プログラミングサイトです
- だいたい毎週土曜や日曜の21時すぎにコンテストが行われているようです
- 出題された問題の答えを出力するプログラムを書いて提出することで自動的に採点されます
- 実行時間が長かったり、メモリの使用量が多いとパスできません
- 競技プログラミングというもの自体に私は馴染みがなかったのですが、今年からはじめました
- [Elixir](https://elixir-lang.org/)で解く際に使える初歩的なノウハウは[Zenn.dev](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)にまとめています


# 準備
- [Elixir](https://elixir-lang.org/)をインストールしましょう
    - 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)等ご参考にしてください
- プロジェクトを作っておきます

```console
$ mix new at_coder
$ cd at_coder
```

# [問題A - Five Antennas](https://atcoder.jp/contests/abc123/tasks/abc123_a)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_123_a.ex
defmodule Abc123A do
  def main do
    a = IO.read(:line) |> String.trim() |> String.to_integer()
    b = IO.read(:line) |> String.trim() |> String.to_integer()
    c = IO.read(:line) |> String.trim() |> String.to_integer()
    d = IO.read(:line) |> String.trim() |> String.to_integer()
    e = IO.read(:line) |> String.trim() |> String.to_integer()
    k = IO.read(:line) |> String.trim() |> String.to_integer()

    solve(a, b, c, d, e, k)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc123/tasks/abc123_a

  ## Examples

      iex> Abc123A.solve(1, 2, 4, 8, 9, 15)
      "Yay!"
      iex> Abc123A.solve(15, 18, 26, 35, 36, 18)
      ":("

  """
  def solve(a, b, c, d, e, k) do
    [b - a, c - a, d - a, e - a, c - b, d - b, e - b, d - c, e - c, e - d]
    |> Enum.filter(&(&1 > k))
    |> Enum.empty?()
    |> if(do: "Yay!", else: ":(")
  end
end
```

- `## Examples`のところに書いてあるものは、[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれるものでしてテストができます
    - 詳しくは[ExUnit.DocTest](https://hexdocs.pm/ex_unit/ExUnit.DocTest.html)をご参照ください
- 解答のキモとなる関数について、問題に書いてある入力例をインプットして出力例の通りアウトプットされるかを確かめています
- `test/at_coder_test.exs`に設定を足しておきましょう

```elixir:test/at_coder_test.exs
defmodule AtCoderTest do
  use ExUnit.Case
  doctest Abc123A
```

```console
$ mix test
..........

Finished in 0.2 seconds
9 doctests, 1 test, 0 failures
```

- [提出](https://atcoder.jp/contests/abc123/submissions/17933398)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:
- この調子で問題を解いていきます

# [問題B - Five Dishes](https://atcoder.jp/contests/abc123/tasks/abc123_b)
- 問題文はリンク先をご参照くださいませ :bow:

```elixir:lib/abc_123_b.ex
defmodule Abc123B do
  def main do
    a = IO.read(:line) |> String.trim() |> String.to_integer()
    b = IO.read(:line) |> String.trim() |> String.to_integer()
    c = IO.read(:line) |> String.trim() |> String.to_integer()
    d = IO.read(:line) |> String.trim() |> String.to_integer()
    e = IO.read(:line) |> String.trim() |> String.to_integer()

    solve(a, b, c, d, e)
    |> IO.puts()
  end

  @doc ~S"""
  https://atcoder.jp/contests/abc123/tasks/abc123_b

  ## Examples

      iex> Abc123B.solve(29, 20, 7, 35, 120)
      215
      iex> Abc123B.solve(123, 123, 123, 123, 123)
      643

  """
  def solve(a, b, c, d, e) do
    list = [a, b, c, d, e]

    last_order = last_order(list)

    List.delete(list, last_order)
    |> Enum.map(&ceil_tens_point/1)
    |> Enum.sum()
    |> Kernel.+(last_order)
  end

  defp last_order(list) do
    list
    |> Enum.map(&{rem(&1, 10), &1})
    |> Enum.reject(fn {ones_place, _} -> ones_place == 0 end)
    |> Enum.min_by(fn {ones_place, _} -> ones_place end, fn -> {nil, 0} end)
    |> elem(1)
  end

  defp ceil_tens_point(n) when rem(n, 10) == 0, do: n

  defp ceil_tens_point(n), do: n + 10 - rem(n, 10)
end
```

- [提出](https://atcoder.jp/contests/abc123/submissions/17940471)の際にはモジュール名は`Main`にしておいてください
- :tada::tada::tada:


# [問題C - Five Transportations](https://atcoder.jp/contests/abc123/tasks/abc123_c)
- [2021/12/03 fukuoka.ex Elixir／Phoenix Advent Calendar 2021](https://qiita.com/advent-calendar/2021/fukuokaex) 解答掲載予定 :santa: 
- :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: 

# [問題D - Cake 123](https://atcoder.jp/contests/abc123/tasks/abc123_d)
- [2021/12/03 fukuoka.ex Elixir／Phoenix Advent Calendar 2021](https://qiita.com/advent-calendar/2021/fukuokaex) 解答掲載予定 :santa:
- :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: 

# Wrapping Up :qiita-fabicon: 
- AとBは自力でいけました！ :smile:
- 2020/12/03は複数記事を同時に投稿しました
    - 過去の使いまわしもあります :relaxed:
    - えっ、他には何を投稿したのだって？　ぜひ以下をご参照ください！
        - [【毎日自動更新】QiitaのElixir LGTMランキング！](https://qiita.com/torifukukaiou/items/1edb3e961acf002478fd) 
- Enjoy [Elixir](https://elixir-lang.org/)!!! :fire::rocket::rocket::rocket:
- 4日目は、@takasehideki 先生の 「[ElixirでIoT#4.1.2：Docker(とVS Code)だけ！でNerves開発環境を整備する](https://qiita.com/takasehideki/items/27005ba9c0d9eb693ea9)」 です。続けてお楽しみください。



# おまけ :lgtm::lgtm::lgtm: 

```elixir
iex> [87, 101, 32, 97, 114, 101, 32, 116, 104, 101, 32, 65, 108, 99, 104, 101, 109,
 105, 115, 116, 115, 44, 32, 109, 121, 32, 102, 114, 105, 101, 110, 100, 115,
 33]
'???????????????????'
```

- IExに貼ってご確認ください
- 作り方は以下の通りです

```elixir
iex> IEx.configure(inspect: [limit: :infinity, charlists: :as_lists])
:ok

iex> "your string" |> String.to_charlist()                           
[121, 111, 117, 114, 32, 115, 116, 114, 105, 110, 103]
```

