---
title: 闘魂Elixir ── ボーリングの点数計算をElixirで楽しむ
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
  - アドハラ
private: false
updated_at: '2023-01-07T02:51:14+09:00'
id: 48ba0b0939e6f1cd3c9e
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと、}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだとおもいます}$</font></b>



# はじめに

**闘魂**と[Elixir](https://elixir-lang.org/)が出会いました。
**闘魂** meets [Elixir](https://elixir-lang.org/).です。
[Elixir](https://elixir-lang.org/) meets **闘魂**.でもよいです。

**2022-12-26より、[アドベントカレンダー2023](https://qiita.com/tags/adventcalendar2023)は開幕しました。**

[私のアドベントカレンダー](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)一覧は、[コチラ](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)です。

**だれよりも2023/12/25を楽しみにしています。**

この記事は、ボーリングの点数計算をしてみます。
ご存知の方もいらっしゃるとおもいますが、「[TheBowlingGameKata](http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata)」です。


http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata


```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

# 作品

GitHubに公開しています。
[TORIFUKUKaiou/bowling_game_kata](https://github.com/TORIFUKUKaiou/bowling_game_kata)

https://github.com/TORIFUKUKaiou/bowling_game_kata

動かし方はREADMEをご参照くださいませ。

# 説明

点数計算のポイントとなるモジュールを`BowlingGameKata`と名付けて作りました。

```elixir:lib/bowling_game_kata.ex
defmodule BowlingGameKata do
  def score!(list) do
    {score, _} = score(list)
    score
  end

  def score(list) do
    {score, scores} = do_score(list, false, [], [])
    {score, Enum.zip(list, scores)}
  end

  defp do_score([], _spared, _strikes, scores), do: {Enum.sum(scores), scores}

  defp do_score([head | tail], spared, strikes, scores) do
    new_scores = scores(head, spared, strikes, scores)
    new_spared = spared(head)
    new_strikes = strikes(head, strikes)
    do_score(tail, new_spared, new_strikes, new_scores)
  end

  defp scores({10}, true, [], scores), do: scores ++ [10 + 10]

  defp scores({10}, false, [], scores), do: scores

  defp scores({10}, false, [10], scores), do: scores

  defp scores({10}, false, [10, 10], scores), do: scores ++ [30]

  defp scores({a, b, c}, true, [], scores), do: scores ++ [10 + a, a + b + c]

  defp scores({a, b, c}, false, [], scores), do: scores ++ [a + b + c]

  defp scores({a, b, c}, false, [10], scores), do: scores ++ [10 + a + b, a + b + c]

  defp scores({a, b, c}, false, [10, 10], scores),
    do: scores ++ [10 + 10 + a, 10 + a + b, a + b + c]

  defp scores({a, b}, true, [], scores) when a + b == 10, do: scores ++ [10 + a]

  defp scores({a, b}, false, [], scores) when a + b == 10, do: scores

  defp scores({a, b}, false, [10], scores) when a + b == 10, do: scores ++ [10 + a + b]

  defp scores({a, b}, false, [10, 10], scores) when a + b == 10,
    do: scores ++ [10 + 10 + a, 10 + a + b]

  defp scores({a, b}, true, [], scores), do: scores ++ [10 + a, a + b]

  defp scores({a, b}, false, [], scores), do: scores ++ [a + b]

  defp scores({a, b}, false, [10], scores), do: scores ++ [10 + a + b, a + b]

  defp scores({a, b}, false, [10, 10], scores), do: scores ++ [10 + 10 + a, 10 + a + b, a + b]

  defp spared({a, b}) when a + b == 10, do: true

  defp spared(_), do: false

  defp strikes({10}, []), do: [10]

  defp strikes({10}, [10]), do: [10, 10]

  defp strikes({10}, [10, 10]), do: [10, 10]

  defp strikes(_, []), do: []

  defp strikes(_, [10]), do: []

  defp strikes(_, [10, 10]), do: []
end
```

複雑に見えるかもしれませんが、書いている本人はそんなにたいへんでもなかったです。楽しみながら書きました。
一息に作ったわけではなく、

http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata

においてあるパワーポイント「[Bowling Game Kata.ppt](http://butunclebob.com/files/downloads/Bowling%20Game%20Kata.ppt)」を参考にしながら、TDDで少しずつ作りました。

プライベートの関数を4つ作りました。
各関数で行うことは一つだけに絞ることにして書いておりますので、見た目ほどたいへんな思いをして書いたわけではなく、関数の仕様に集中して書くことができました。
うまく言えませんが、データ変換パラダイムみたいなものを感じました。

## do_score/4

全体の処理を取りまとめる司令塔のような関数です。
引数の説明をします。

- 第一引数は、点数の記録のリストです。各要素はタプルで表現します。2回投げたら2個のタプル、1回(つまりストライク)だけ投げたら1個のタプル`{10}`、10フレーム目で3回投げたら3個のタプルという具合です
- 第ニ引数は、前回のフレームがスペアだったかどうかの`true` or `false`です
- 第三引数は、ストライクってその後の2回の投球がボーナスとして加算されるので、フレームの計算を保留しておくために記憶しておく一時的なリストです。`[]` or `[10]` or `[10, 10]`の3パターンがあります。
- 第四引数は、各フレームごとの点数を点数が確定したら末尾に追加していくリストです。最終的にはこのリストの総和が合計点数ということになります。

## scores/4

各フレームごとの点数をリストに格納する関数です。
点数計算をするために必要な要素を引数にもっています。
引数の説明をします。

- 第一引数は、投球内容です
- 第ニ引数は、前回のフレームがスペアだったかどうかの`true` or `false`です
- 第三引数は、ストライクってその後の2回の投球がボーナスとして加算されるので、フレームの計算を保留しておくために記憶しておく一時的なリストです。`[]` or `[10]` or `[10, 10]`の3パターンがあります。
- 第四引数は、前回までの計算で点数を確定できたフレームの点数がリストに格納されています。

## spared/1

投球がスペアかどうかを返します。`true` or `false`です。

## strikes/2

ストライクが続いている様を記録するリストを作ります。
出力は`[]` or `[10]` or `[10, 10]`の3パターンがあります。記事を書いていておもいましたが、リストじゃなくても実装できる気がします。
引数の説明をします。

- 第一引数は、投球内容です
- 第ニ引数は、前回までのストライク状況をリストで表したものです。`[]` or `[10]` or `[10, 10]`の3パターンがあります。もっとストライクが続いた場合は？　を疑問に思われた方がいらっしゃるかもしれませんので補足しておきます。このプログラムの基本的な考え方として、フレームの点数を確定できたら`scores`に格納して忘れちゃっていいみたいな感じなのです。（`scores`に格納して忘れているわけではないので説明が変な気がします。）ストライクは後続の2回の投球がボーナスとして加算されるので逆にいうと、前回2回までのストライク状況をおぼえておけば2回前のフレームの点数は確定できるという寸法です。うまく説明できていないかもしれませんが、雰囲気を感じてください。



# テストコード

テストケースは以下を挙げました。

- 「[Bowling Game Kata.ppt](http://butunclebob.com/files/downloads/Bowling%20Game%20Kata.ppt)」に書いてある４つのテスト
- いくつかの点数計算を解説しているサイトの点数計算例
- 10フレーム目のところがどうも気になるので重点的にテストを追加

「いくつかの点数計算を解説しているサイトの点数計算例」を加えることで、テストがコケてテスト観点として漏れがあったり、実装を勘違いしている箇所をあぶりだせました。

```elixir:test/bowling_game_kata_test.exs
defmodule BowlingGameKataTest do
  use ExUnit.Case
  doctest BowlingGameKata

  test "all 0" do
    list = List.duplicate({0, 0}, 10)
    assert BowlingGameKata.score!(list) == 0
  end

  test "all 1" do
    list = List.duplicate({1, 1}, 10)
    assert BowlingGameKata.score!(list) == 20
  end

  test "spare" do
    list = [{5, 5}, {3, 0}] ++ List.duplicate({0, 0}, 8)
    assert BowlingGameKata.score!(list) == 16
  end

  test "strike" do
    list = [{10}, {3, 4}] ++ List.duplicate({0, 0}, 8)
    assert BowlingGameKata.score!(list) == 24
  end

  test "perfect game" do
    list = List.duplicate({10}, 9) ++ [{10, 10, 10}]
    assert BowlingGameKata.score!(list) == 300
  end

  test "scoring bowling 1" do
    list = [{1, 4}, {4, 5}, {6, 4}, {5, 5}, {10}, {0, 1}, {7, 3}, {6, 4}, {10}, {2, 8, 6}]
    assert BowlingGameKata.score!(list) == 133
  end

  test "scoring bowling 2" do
    list = List.duplicate({1, 1}, 9) ++ [{1, 9, 1}]
    assert BowlingGameKata.score!(list) == 29
  end

  test "scoring bowling 3" do
    # https://hideo002.com/archives/5639
    list = [{3, 5}, {6, 1}, {3, 2}, {7, 1}, {10}, {9, 1}, {10}, {10}, {2, 5}, {2, 8, 3}]
    assert BowlingGameKata.score!(list) == 127
  end

  test "scoring bowling 4" do
    # https://nageyo.com/score/
    list = [{9, 1}, {8, 0}, {10}, {10}, {9, 0}, {10}, {10}, {10}, {7, 3}, {9, 1, 10}]
    assert BowlingGameKata.score!(list) == 199
  end

  test "scoring bowling 5" do
    # https://codezine.jp/article/detail/13320
    list = [{6, 4}, {8, 0}, {10}, {2, 7}, {5, 5}, {3, 4}, {10}, {9, 1}, {1, 2}, {7, 1}]
    assert BowlingGameKata.score!(list) == 116
  end

  test "scoring bowling 6" do
    # https://codezine.jp/article/detail/13320
    list = [{1, 8}, {9, 1}, {7, 2}, {10}, {0, 0}, {9, 1}, {3, 6}, {8, 0}, {5, 4}, {10, 8, 1}]
    assert BowlingGameKata.score!(list) == 103
  end

  test "scoring bowling 7" do
    list = List.duplicate({0, 0}, 7) ++ [{10}, {10}, {10, 10, 0}]
    assert BowlingGameKata.score!(list) == 80
  end

  test "scoring bowling 8" do
    list = List.duplicate({0, 0}, 7) ++ [{10}, {10}, {5, 5, 0}]
    assert BowlingGameKata.score!(list) == 55
  end

  test "scoring bowling 9" do
    list = List.duplicate({0, 0}, 7) ++ [{10}, {10}, {0, 0}]
    assert BowlingGameKata.score!(list) == 30
  end

  test "scoring bowling 10" do
    list = List.duplicate({0, 0}, 7) ++ [{10}, {5, 5}, {10, 10, 0}]
    assert BowlingGameKata.score!(list) == 60
  end

  test "scoring bowling 11" do
    list = List.duplicate({0, 0}, 7) ++ [{10}, {5, 5}, {5, 5, 0}]
    assert BowlingGameKata.score!(list) == 45
  end

  test "scoring bowling 12" do
    list = List.duplicate({0, 0}, 7) ++ [{10}, {5, 5}, {0, 0}]
    assert BowlingGameKata.score!(list) == 30
  end

  test "scoring bowling 13" do
    list = List.duplicate({0, 0}, 7) ++ [{5, 5}, {10}, {10, 10, 0}]
    assert BowlingGameKata.score!(list) == 70
  end

  test "scoring bowling 14" do
    list = List.duplicate({0, 0}, 7) ++ [{5, 5}, {10}, {5, 5, 0}]
    assert BowlingGameKata.score!(list) == 50
  end

  test "scoring bowling 15" do
    list = List.duplicate({0, 0}, 7) ++ [{5, 5}, {10}, {0, 0}]
    assert BowlingGameKata.score!(list) == 30
  end

  test "scoring bowling 16" do
    list = List.duplicate({0, 0}, 8) ++ [{5, 5}, {10, 10, 0}]
    assert BowlingGameKata.score!(list) == 40
  end

  test "scoring bowling 17" do
    list = List.duplicate({0, 0}, 8) ++ [{5, 5}, {5, 5, 0}]
    assert BowlingGameKata.score!(list) == 25
  end

  test "scoring bowling 18" do
    list = List.duplicate({0, 0}, 8) ++ [{5, 5}, {0, 0}]
    assert BowlingGameKata.score!(list) == 10
  end

  test "scoring bowling 19" do
    list = List.duplicate({0, 0}, 9) ++ [{10, 10, 0}]
    assert BowlingGameKata.score!(list) == 20
  end

  test "scoring bowling 20" do
    list = List.duplicate({0, 0}, 9) ++ [{5, 5, 0}]
    assert BowlingGameKata.score!(list) == 10
  end

  test "scoring bowling 21" do
    list = List.duplicate({0, 0}, 9) ++ [{0, 0}]
    assert BowlingGameKata.score!(list) == 0
  end
end
```





---

# さいごに

この記事では、ボーリングの点数計算を[Elixir](https://elixir-lang.org/)で楽しんでみました。
うまく説明できていませんが、データ変換パラダイムを私は感じました。
また、そこそこ複雑に見えるかもしれないソースコードではありますが、実際には小さな各関数の仕様を満たすことだけを考えてコーディングしたのでそんなに難しくはなかったです。

もっとスパッと、エレガントに解けるとおもいます。ぜひあなたの[Elixir](https://elixir-lang.org/)やErlangでの実装をお待ちしています。


**闘魂**とは、 **「己に打ち克つこと、そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

<font color="red">$\huge{１、２、３ ぁっダァー！}$</font>


<iframe width="910" height="512" src="https://www.youtube.com/embed/AWxwmqzbOaw" title="燃える闘魂 アントニオ猪木  追悼VTR" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

https://www.youtube.com/watch?v=FSz7N5hCltw

---

https://qiita.com/torifukukaiou/items/5e96f4e9f12ec3c4b3f4

https://qiita.com/torifukukaiou/items/b6361f98194f3687a13c

https://qiita.com/torifukukaiou/items/4c35ace6db3f02ac3897

https://qiita.com/torifukukaiou/items/17d55cf896c24b13350e

https://qiita.com/torifukukaiou/items/44db8a4997812518730a




---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
