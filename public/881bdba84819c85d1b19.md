---
title: 闘魂Elixir ── Advent of code 2023 Day 15をElixirで楽しむ
tags:
  - Elixir
  - AdventofCode
  - 40代駆け出しエンジニア
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-24T00:57:05+09:00'
id: 881bdba84819c85d1b19
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


https://qiita.com/advent-calendar/2023/elixir

:::note info
今年2023年アドベントカレンダーにおいて25記事目の記念記事です :tada::tada::tada::tada::tada::tada: 
:::

**完走してからが本当の闘いです。**
**ようやくスタートラインにつきました。**

![スクリーンショット 2023-12-22 20.22.03.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6adeddb4-93c6-31c4-c766-212c0f48a2cb.png)


# はじめに

今年もいよいよやってまいりました！ :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5: 
[Elixir](https://elixir-lang.org/)で、[Advent of code 2023](https://adventofcode.com/2023)の問題を解いてみます。

https://adventofcode.com/2023

1日1題ずつ問題が出題されます。
実行時間は問われません。

# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があるのですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

# [Day 15: Lens Library](https://adventofcode.com/2023/day/15)

[Day 15: Lens Library](https://adventofcode.com/2023/day/15)を解いてみます。
問題はリンク先をご参照ください。

Google翻訳を使って問題を理解しました。
英文が（私にとって長く）なかなか意味がわかりませんでした。

今回のPart 1は普通に問いてできました。
Part 2は問題の意味がちっともわかりませんでした。Pythonの[解答例](https://github.com/tmo1/adventofcode/blob/main/2023/15b.py)をみて、問題の意味をようやく理解できました。

## 私の答え Part 1

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>


```elixir
input = """
rn=1,cm-,qp=3,cm=2,qp-,pc=4,ot=9,ab=5,pc-,pc=6,ot=7
"""

defmodule Awesome do
  def run(input) do
    parse(input)
    |> solve()
  end

  def hash(list) do
    list
    |> Enum.reduce(0, fn n, acc ->
      algorithm(acc, n)
    end)
  end

  defp solve(list_of_charlists) do
    list_of_charlists
    |> Enum.reduce(0, fn charlists, acc ->
      acc + hash(charlists)
    end)
  end

  defp algorithm(init, n), do: init |> Kernel.+(n) |> Kernel.*(17) |> rem(256)

  defp parse(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&(&1 |> String.trim() |> String.to_charlist()))
  end
end

Awesome.run(input)
```

</details>


## 私の答え Part 2

私の答えです。
折りたたんでおきます。
▶を押して開いてください。

---

<details><summary>私の答え</summary>

[if/2](https://hexdocs.pm/elixir/1.15.7/Kernel.html#if/2)や[cond/1](https://hexdocs.pm/elixir/1.15.7/Kernel.SpecialForms.html#cond/1)を使わないことと、ソースコードのインデントが深くならないように工夫しました。


```elixir
defmodule Awesome2 do
  def run(input) do
    parse(input)
    |> solve()
  end

  def hash(list) do
    list
    |> Enum.reduce(0, fn n, acc ->
      algorithm(acc, n)
    end)
  end

  defp solve(list_of_charlists) do
    list_of_charlists
    |> Enum.reduce(%{}, fn charlists, acc ->
      do_solve(charlists, acc, Enum.any?(charlists, &(&1 == ?=)))
    end)
    |> calc_total_focusing_power()
  end

  defp do_solve(charlists, map, true), do: do_update(map, charlists)
  defp do_solve(charlists, map, false), do: do_remove(map, charlists)

  defp calc_total_focusing_power(map) do
    map
    |> Enum.reduce(0, fn {key, list}, power ->
      list
      |> Enum.reverse()
      |> Enum.map(&elem(&1, 1))
      |> Enum.with_index(1)
      |> Enum.reduce(0, fn {focal_length, slot}, acc ->
        acc + (key + 1) * focal_length * slot
      end)
      |> Kernel.+(power)
    end)
  end

  defp do_update(map, charlists) do
    current_label = current_label(charlists, 0..-3)
    hash = current_label |> hash()
    value = value(charlists)
    list = Map.get(map, hash, [])
    index = find_index(list, current_label)
    new_list = new_list(list, index, {current_label, value})

    Map.put(map, hash, new_list)
  end

  defp do_remove(map, charlists) do
    current_label = current_label(charlists, 0..-2)
    hash = current_label |> hash()
    list = Map.get(map, hash, [])
    index = find_index(list, current_label)
    new_list = new_list(list, index)

    Map.put(map, hash, new_list)
  end

  defp current_label(charlists, range), do: Enum.slice(charlists, range)

  defp value(charlists), do: Enum.slice(charlists, -1..-1) |> Enum.at(0) |> Kernel.-(?0)

  defp find_index(list, current_label) do
    Enum.find_index(list, fn {label, _} -> current_label == label end)
  end

  defp new_list(list, nil = _index, label_value_tuple) do
    [label_value_tuple | list]
  end

  defp new_list(list, index, label_value_tuple) do
    List.replace_at(list, index, label_value_tuple)
  end

  defp new_list(list, nil = _index), do: list
  defp new_list(list, index), do: List.delete_at(list, index)

  defp algorithm(init, n), do: init |> Kernel.+(n) |> Kernel.*(17) |> rem(256)

  defp parse(input) do
    input
    |> String.split(",", trim: true)
    |> Enum.map(&(&1 |> String.trim() |> String.to_charlist()))
  end
end

Awesome2.run(input)
```

</details>


---

解けました :tada::tada::tada: 

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">I just completed &quot;Lens Library&quot; - Day 15 - Advent of Code 2023 <a href="https://t.co/H4eAUNnD3L">https://t.co/H4eAUNnD3L</a> <a href="https://twitter.com/hashtag/AdventOfCode?src=hash&amp;ref_src=twsrc%5Etfw">#AdventOfCode</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1738142546935820402?ref_src=twsrc%5Etfw">December 22, 2023</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# さいごに

[Advent of code 2023](https://adventofcode.com/2023)の[Day 15: Lens Library](https://adventofcode.com/2023/day/15)を[Elixir](https://elixir-lang.org/)で解きました。
[Advent of code 2023](https://adventofcode.com/2023)は己との闘い、まさに闘魂です。

リポジトリにあげておきます。

https://github.com/TORIFUKUKaiou/livebooks

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
