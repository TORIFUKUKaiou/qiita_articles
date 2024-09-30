---
title: 闘魂Elixir ── 表の整形「次の行のデータを使って列を加えることをElixirで楽しむ」
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-01-03T16:26:35+09:00'
id: 795b2886785b1cc0f1a7
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

:::note info
この記事は、2024年に私が書いたはじめての記事です。
:::


# はじめに

こういう表があったとします。動画の目次と開始秒数だと思ってください。`title`と`start`の順番は狂うことなく正しくならんでいるものとします。

| title | start |
|:-:|:-:|
| :a  | 0  |
| :b  | 79  |
| :c  | 123  |

この表に`ending`列を足します。`ending`は次の行の`start`とします。具体的にはこんな感じです。

| title | start | ending |
|:-:|:-:|:-:|
| :a  | 0  | 79 |
| :b  | 79  | 123 |
| :c  | 123  | nil |

最後の行の`ending`には動画の総時間数を入れればよいでしょう。この記事で伝えたいことの本質とはズレるので、ここでは`nil`にすることとします。

[Elixir](https://elixir-lang.org/)では、たとえばこんな変換をする感じです。InputとOutputを示して説明します。

## Input

Inputはマップのリストで表現します。

```elixir
[
  %{title: :a, start: 0},
  %{title: :b, start: 79},
  %{title: :c, start: 123}
]
```

## Output

アウトプットはリストの各要素のマップに`:ending`キーと値が追加されます。

```elixir
[
  %{title: :a, start: 0, ending: 79},
  %{title: :b, start: 79, ending: 123},
  %{title: :c, start: 123, ending: nil}
]
```

さて、[Elixir](https://elixir-lang.org/)ではどうやって書くとよいでしょうか。


# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があるのですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

---

# [Elixir](https://elixir-lang.org/)で、プログラミング グー:+1:グー:+1:グー:+1:グー:+1:グー:+1:グー:+1:グー:+1:グー:+1:グー:+1:

四の五の言わずに[Elixir](https://elixir-lang.org/)でプログラミングします。
いろいろやり方はあるとおもいますが、主に[Enum.reduce/3](https://hexdocs.pm/elixir/Enum.html#reduce/3)を使って実装してみます。

## まずは愚直に実装

まずは愚直に実装してみます。

```elixir
list = [%{title: :a, start: 0}, %{title: :b, start: 79}, %{title: :c, start: 123}]

list
|> Enum.reduce({[], 0}, fn %{title: title, start: start}, {acc, index} ->
  next = Enum.at(list, index + 1)
  ending = if next, do: next.start

  {acc ++ [%{title: title, start: start, ending: ending}], index + 1}
end)
|> elem(0)
```

注目している行の次の行の値をとって処理しています。エクセルで人が操作するときの手順に近いかもしれません。

これでも所望の結果は得られます。
しかしながら、Inputの行数が大きくなると[Enum.at/3](https://hexdocs.pm/elixir/Enum.html#at/3)の呼び出しのところが問題となりそうです。

## 逆順にして処理する

```elixir
list = [%{title: :a, start: 0}, %{title: :b, start: 79}, %{title: :c, start: 123}]

list
|> Enum.reverse()
|> Enum.reduce({[], nil}, fn %{title: title, start: start}, {acc, ending} ->
  {[%{title: title, start: start, ending: ending} | acc], start}
end)
|> elem(0)
```

さきほどの例よりこちらのほうがよいとおもいます。なんとなく関数型言語っぽい感じがします。
アウトプットのリストを作る際に`|`を使って、先頭に追加するのもGoodな気がします。
逆から処理しているからこそこれが使えるのですね。（まあ、前の例でも使えないことはないです。最後にリバースすれば）



# さいごに

次の行のデータを使って列を加えることをElixirで楽しみました。

こんなふうにやるといいよ！　と思いつかれた方はぜひぜひ**お便り**をください。

**本年もどうぞよろしくお願いいたします。**


---

人類は不老不死の霊薬を意味する素敵なプログラミング言語[Elixir](https://elixir-lang.org/)を手に入れました。並行処理を他のプログラミング言語よりも比較的容易に書くことができます。それはきっとコンピュータ資源を有効活用できることにつながるでしょう。巡り巡って世界平和に貢献できることでしょう。

さあ、そこのあなたも[Elixir](https://elixir-lang.org/)の世界へようこそ。
_手始めに[エリクサーチ](https://elixir-lang.info/)なんていかがでしょうか。私のオススメです。_

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**









---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
