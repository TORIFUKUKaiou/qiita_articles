---
title: '闘魂Elixir ── Advent of Code 2022 (Day 5: Supply Stacks)をElixirで楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
  - アドハラ
private: false
updated_at: '2023-01-03T23:15:28+09:00'
id: a2888ac943fcfb1774a3
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと、}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだとおもいます}$</font></b>

[![Run in Livebook](https://livebook.dev/badge/v1/black.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FTORIFUKUKaiou%2Flivebooks%2Fblob%2Fmain%2Fadvent_of_code%2F2022%2Findex.livemd)

# はじめに

**闘魂**と[Elixir](https://elixir-lang.org/)が出会いました。
**闘魂** meets [Elixir](https://elixir-lang.org/).です。
[Elixir](https://elixir-lang.org/) meets **闘魂**.でもよいです。

**2022-12-26より、[アドベントカレンダー2023](https://qiita.com/tags/adventcalendar2023)は開幕しました。**

[私のアドベントカレンダー](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)一覧は、[コチラ](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)です。

**だれよりも2023/12/25を楽しみにしています。**

この記事は、[Advent of Code 2022](https://adventofcode.com/2022)の[Day 5: Supply Stacks](https://adventofcode.com/2022/day/5)を解いてみます。

[Advent of Code 2022](https://adventofcode.com/2022)は、競技プログラミングのような問題が25題出題されています。
毎年問題が出題されておりまして、日を追うごとに難しくなる傾向があるようにおもいます。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

# [Day 5: Supply Stacks](https://adventofcode.com/2022/day/5)

問題文はこちらをご参照ください。

https://adventofcode.com/2022/day/5

問題を説明します。

```
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
```

空行より上の部分は木箱の初期状態です。
`move N from a to b`は指示書です。N個の木箱をa列からb列へ移動させなさいという意味です。
木箱は1個ずつ動かせます。


ちなみに余談です。
**[指示書](https://buzzap.jp/news/20140206-samuragouchi-mamoru/)** と言えば、私が真っ先に思い出すのは

https://buzzap.jp/news/20140206-samuragouchi-mamoru/

この話です。 **指示書** そのものはすごいものだとおもいます。私が **指示書** という単語を使うときにイメージしているものはコレです。

本題に戻ります。
指示書を一つずつ実行してみます。
以下、**指示書**の通りの指示を実行後の状態を書いておきます。



## move 1 from 2 to 1

```
[D]        
[N] [C]    
[Z] [M] [P]
 1   2   3 
```

## move 3 from 1 to 3

```
        [Z]
        [N]
    [C] [D]
    [M] [P]
 1   2   3
```

## move 2 from 2 to 1

```
        [Z]
        [N]
[M]     [D]
[C]     [P]
 1   2   3
```

## move 1 from 1 to 2

```
        [Z]
        [N]
        [D]
[C] [M] [P]
 1   2   3
```

指示書を全部実行すると上記のようになります。左から一番上の木箱のアルファベットを並べると答えです。
つまり`CMZ`です。

ご存知の方はご存知だとおもいますが、[ハノイの塔](https://ja.wikipedia.org/wiki/%E3%83%8F%E3%83%8E%E3%82%A4%E3%81%AE%E5%A1%94)みたいな問題です。


本番のデータは、行数が8行、列数は9列あります。



# 解答例

私は[Elixir](https://elixir-lang.org/)で解いてみます。
[![Run in Livebook](https://livebook.dev/badge/v1/black.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FTORIFUKUKaiou%2Flivebooks%2Fblob%2Fmain%2Fadvent_of_code%2F2022%2Findex.livemd)
[Livebook](https://livebook.dev/)をお使いの方は、上記のボタンを**迷わず**押すと、私の解答例をお試しいただけます！
解答例は閉じておきます。



<details><summary>解答例</summary><div>

## 私

なんとか解けたけど、めっちゃ長いです。
[Nx](https://github.com/elixir-nx/nx)をうまく使うともっと簡単に解けるのかもしれません。

```elixir
input = """
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
"""
```

```elixir
defmodule Stack do
  def push("", stack) do
    stack
  end

  def push(e, stack) do
    [e | stack]
  end

  def pop([]), do: {"", []}

  def pop([head|tail]), do: {head, tail}
end
```

```elixir
[crates, [""], procedures, [""]]  = input
|> String.split("\n")
|> Enum.chunk_by(& &1 == "")

crates = crates
|> Enum.take(Enum.count(crates) - 1)
|> Enum.map(fn line -> 
  String.split(line, [" "])
  |> Enum.reduce({[], 0}, fn 
    "", {acc_list, acc_cnt} ->
      acc_cnt = acc_cnt + 1
      if acc_cnt >= 4 do
        {acc_list ++ [""], 0}
      else
        {acc_list, acc_cnt}
      end
    <<"[", s, "]">>, {acc_list, _acc_cnt} ->
      {acc_list ++ [s], 0}
  end)
  |> elem(0)
end)
|> IO.inspect()

[top | _] = crates
rows = Enum.count(top) |> IO.inspect()


crates_map = crates
|> Enum.map(&Enum.with_index/1)
|> Enum.with_index()
|> Enum.reduce(%{}, fn {list, i}, acc ->
  list
  |> Enum.reduce(acc, fn {crate, j}, acc2 ->
    Map.merge(acc2, %{{i, j} => crate})
  end)
end)
|> IO.inspect()

stacks_of_crates = for j <- 0..(rows - 1), i <- (Enum.count(crates) - 1)..0, reduce: %{} do
  acc -> Map.update(acc, j, Stack.push(crates_map[{i, j}], []), & Stack.push(crates_map[{i, j}], &1))
end
```

ようやくInputの整理が終わりました。
あとは指示書の通りに作業をこなします。

```elixir
procedures
|> Enum.map(fn procedure ->
  ["move", cnt, "from", from, "to", to] = String.split(procedure, " ")
  {String.to_integer(cnt), String.to_integer(from) - 1, String.to_integer(to) - 1}
end)
|> Enum.reduce(stacks_of_crates, fn {cnt, from, to}, acc ->
  1..cnt
  |> Enum.reduce(acc, fn _, acc2 ->
    IO.inspect(acc2)
    {e, from_stack} = Stack.pop(acc2[from])
    to_stack = Stack.push(e, acc2[to])
    acc2 |> Map.merge(%{from => from_stack}) |> Map.merge(%{to => to_stack}) |> IO.inspect()
  end)
end)
|> Enum.sort_by(fn {column, _stack} -> column end)
|> Enum.map(fn {_, [head | _]} -> head end)
```




`CMZ`が得られます。

</div></details>

あなたの答えをお待ちしています。
編集リクエストかコメントでくださいませ。



## 読者投稿コーナー

読者の方からいただいたお便りをご紹介します。


<details><summary>読者投稿コーナー</summary><div>

### @mnishiguchi さん

毎回ありがとうございます。

```elixir
parse_stacks = fn stacks_input ->
  stacks_input
  |> String.split("\n", trim: true)
  |> Enum.map(fn row ->
    row
    |> String.split("", trim: true)
    |> Enum.chunk_every(4)
    |> Enum.map(fn
      ["[", crate | _] -> crate
      [" ", " " | _] -> nil
      row -> Enum.join(row) |> String.trim() |> String.to_integer()
    end)
  end)
  |> Enum.zip_reduce(%{}, fn zipped, acc ->
    {stack, [index]} = Enum.split(zipped, -1)
    Map.put(acc, index, Enum.reject(stack, &is_nil/1))
  end)
end

parse_commands = fn commands_input ->
  commands_input
  |> String.split("\n", trim: true)
  |> Enum.map(fn command ->
    captures =
      Regex.named_captures(~r/move (?<move>\d+) from (?<from>\d+) to (?<to>\d+)/, command)

    {
      String.to_integer(captures["move"]),
      String.to_integer(captures["from"]),
      String.to_integer(captures["to"])
    }
  end)
end

parse_input = fn input ->
  [stacks_input, commands_input] = String.split(input, "\n\n", trim: true)
  {parse_stacks.(stacks_input), parse_commands.(commands_input)}
end

update_stacks = fn stacks, {n, from, to} ->
  {taken, rest} = Enum.split(stacks[from], n)

  stacks
  |> Map.replace(from, rest)
  |> Map.replace(to, Enum.reverse(taken) ++ stacks[to])
end

get_heads = fn stacks ->
  stacks
  |> Enum.sort_by(fn {k, _v} -> k end)
  |> Enum.map(fn {_k, v} -> List.first(v) end)
end

run = fn input ->
  {stacks, commands} = parse_input.(input)

  Enum.reduce(commands, stacks, fn command, state ->
    update_stacks.(state, command)
  end)
  |> get_heads.()
  |> Enum.join()
end

run.("""
    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
""")
```



</div></details>




---

# さいごに

この記事では、[Advent of Code 2022](https://adventofcode.com/2022)の「[Advent of Code 2022](https://adventofcode.com/2022)の[Day 5: Supply Stacks](https://adventofcode.com/2022/day/5)」を[Elixir](https://elixir-lang.org/)で解いてみました。


**闘魂**とは、 **「己に打ち克つこと、そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

<font color="red">$\huge{１、２、３ ぁっダー！}$</font>


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
<b><font color="red">$\huge{１、２、３ ぁっダー！}$</font></b>
