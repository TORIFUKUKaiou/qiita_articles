---
title: 闘魂Elixir ── 18. String.split
tags:
  - Elixir
  - 猪木
  - 40代駆け出しエンジニア
  - AdventCalendar2022
  - 闘魂
private: false
updated_at: '2022-12-19T07:22:44+09:00'
id: ad6b4ee6c46de5ac56ed
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>

https://qiita.com/advent-calendar/2022

https://qiita.com/advent-calendar/2022/elixir

# はじめに

闘魂と[Elixir](https://elixir-lang.org/)が出会いました。
闘魂 meets [Elixir](https://elixir-lang.org/).です。
[Elixir](https://elixir-lang.org/) meets 闘魂.でもよいです。

本日は、[String.split/3](https://hexdocs.pm/elixir/String.html#split/3)を説明します。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

# [String.split/3](https://hexdocs.pm/elixir/String.html#split/3)

文字列を分割してくれます。

それでは、[IEx](https://hexdocs.pm/iex/IEx.html)で確かめてみましょう。

```:CMD
iex
```

[IEx](https://hexdocs.pm/iex/IEx.html)が立ち上がったら、以下のプログラムを実行してみてください。

```elixir
iex> String.split("1 2 3", " ")
["1", "2", "3"]
```

第一引数の文字列を、第二引数のパターンで分割した文字列のリストを得られました :tada: 


# ワンポイントレッスン

ワンポイントレッスンです。

## 第二引数のパターン

第二引数のパターンには文字列だけではなく、文字列のリストや正規表現などを指定できます。
詳しくは、 [String.split/3](https://hexdocs.pm/elixir/String.html#split/3) をご参照ください。

省略もできます。

```elixir
iex> String.split("1 2 3")     
["1", "2", "3"]
```

## 第三引数のオプション

私は使ったことがありません。
公式の説明をペタっと貼っておきます。

![スクリーンショット 2022-12-07 23.26.53.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/43bc6bb6-02ad-6c53-2cf6-47145d9ace4f.png)


## AtCoder

AtCoderの問題を問いてみます。
問題は、[PracticeA - Welcome to AtCoder](https://atcoder.jp/contests/abs/tasks/practice_1)を取り上げます。

まず問題の説明をします。
Inputが

```
1
2 3
test
```

である場合に、Outputを

```
6 test
```

にしてくださいという問題です。1行目と2行目の数字を足して、三行目の文字列と並べて表示しなさいという問題です。

早速答えです。


```elixir
defmodule Main do
  def main do
    a = IO.read(:line) |> String.trim() |> String.to_integer()
    [b, c] =  IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    s = IO.read(:line) |> String.trim()

    IO.puts "#{a + b + c} #{s}"
  end
end
```

2行目の空白で区切られた数字の文字列を分割するときに、[String.split/3](https://hexdocs.pm/elixir/String.html#split/3)を使っています。


AtCoderを[Elixir](https://elixir-lang.org/)で闘うときに、[String.split/3](https://hexdocs.pm/elixir/String.html#split/3)は使う場面がよくあるとおもいます。

「[AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)」は私が書いた記事です。AtCoderに取り組まれる方は参考にしてください。

https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01













# 今日の<font color="#d00080">闘魂</font>

今日は、長嶋茂雄さんの言葉を紹介します。

---

スターというのはみんなの期待に応える存在。
でもスーパースターの条件は、その期待を超えること。

---

解説は、[こちら](https://www.kyoeihome.net/blog/?p=8261)をご参照ください。




猪木さん流に言うと、「**スターという人種は、注目を浴びれば浴びるほど能力を発揮する**」ということです。
:book:『[アントニオ猪木　最後の闘魂](https://presidentstore.jp/item/008105.html)』:book:より引用します。


> 周囲からの期待を重圧と感じてしまうのは、それに応える自信がないからといえるかもしれない。（中略）スターになるには日頃から研鑽を積み、「自分ならできる！」という自信を確かなものにしていくことが大切だ。それができれば、周囲の期待はプレッシャーではなく、エネルギーに変わる。（中略）一つひとつ大きな舞台を乗り越えることで、自信と真の力をつけていったのだ。

一言で言うと、つまりは **闘魂** です。
「闘魂」とは、 **「己に打ち克ち、闘いを通じて己の魂を磨いていくことである」**  と猪木さんはおっしゃられています。プレッシャーに負けるのは、己に負けたからなのです。王陽明先生は言いました。「山中の賊を破るは易く、心中の賊を破るは難し」と。

:book:『[アントニオ猪木　最後の闘魂](https://presidentstore.jp/item/008105.html)』:book:
みなさまもぜひこの本をお手にとられて、猪木さんが残されたメッセージを通じて、直接猪木さんから「元氣」をもらってください。

ちなみに長嶋茂雄さんとアントニオ猪木さんの共通点は誕生日が２月２０日だということです。さらに志村けんさんも２月２０日です。さらにさらにちなみに私のリスペクトする先輩のお兄さんも２月２０日生まれです。

https://www.shinchosha.co.jp/book/129721/

https://presidentstore.jp/item/008105.html

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/be8933f5-e3e2-d5f4-1561-f65f75abdf38.png)


# さいごに

[String.split/3](https://hexdocs.pm/elixir/String.html#split/3)を説明しました。

闘魂の意味は、 **「己に打ち克ち、闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。

<font color="red">$\huge{１、２、３ ぁっダー！}$</font>


<iframe width="910" height="512" src="https://www.youtube.com/embed/AWxwmqzbOaw" title="燃える闘魂 アントニオ猪木  追悼VTR" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

https://www.youtube.com/watch?v=FSz7N5hCltw

---

https://qiita.com/torifukukaiou/items/5e96f4e9f12ec3c4b3f4

---

# Twitter

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">Elixir Advent Calendar 3の18日目、いつもお馴染みの <a href="https://twitter.com/torifukukaiou?ref_src=twsrc%5Etfw">@torifukukaiou</a> さんで、Stringモジュールの第二段、「String .split」です💁‍♂️<a href="https://t.co/mm8xWRbG0A">https://t.co/mm8xWRbG0A</a><br><br>今回は、AtCoderの問題を問くようです😆<br><br>実践で良く使う、強力な関数なので、Elixirにまだ慣れていない方は、マスターすると良いですよー😌</p>&mdash; piacere (love Elixir, Gravity and VR/AR/Metaverse) (@piacere_ex) <a href="https://twitter.com/piacere_ex/status/1604491770985058305?ref_src=twsrc%5Etfw">December 18, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

---

<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
