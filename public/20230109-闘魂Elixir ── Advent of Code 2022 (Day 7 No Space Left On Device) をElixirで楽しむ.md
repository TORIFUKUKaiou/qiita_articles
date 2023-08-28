---
title: '闘魂Elixir ── Advent of Code 2022 (Day 7: No Space Left On Device) をElixirで楽しむ'
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
  - アドハラ
private: false
updated_at: '2023-01-09T22:21:10+09:00'
id: b4d2671c995f961b6dc8
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

この記事は、[Advent of Code 2022](https://adventofcode.com/2022)の[Day 7: No Space Left On Device](https://adventofcode.com/2022/day/7)を解いてみます。

[Advent of Code 2022](https://adventofcode.com/2022)は、競技プログラミングのような問題が25題出題されています。
毎年問題が出題されておりまして、日を追うごとに難しくなる傾向があるようにおもいます。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

# [Day 7: No Space Left On Device](https://adventofcode.com/2022/day/7)

問題文はこちらをご参照ください。

https://adventofcode.com/2022/day/7

問題を説明します。

```
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
```

コマンドの指示書が書いてあります。
`cd`や`ls`で`/`配下を巡っています。

ディレクトリ構造で書くと以下のようになります。

```
- / (dir)
  - a (dir)
    - e (dir)
      - i (file, size=584)
    - f (file, size=29116)
    - g (file, size=2557)
    - h.lst (file, size=62596)
  - b.txt (file, size=14848514)
  - c.dat (file, size=8504156)
  - d (dir)
    - j (file, size=4060174)
    - d.log (file, size=8033020)
    - d.ext (file, size=5626152)
    - k (file, size=7214296)
 ```

設問は、`at most 100000`のディレクトリを挙げて、サイズを足したものを答えななさいというものです。
ディレクトリ`/a/e`（584）と`/a`(94853)の2つのディレクトリが該当します。
これらのサイズの和`95437 (94853 + 584)`が答えとなります。




# 解答例

私は[Elixir](https://elixir-lang.org/)で解いてみます。
[![Run in Livebook](https://livebook.dev/badge/v1/black.svg)](https://livebook.dev/run?url=https%3A%2F%2Fgithub.com%2FTORIFUKUKaiou%2Flivebooks%2Fblob%2Fmain%2Fadvent_of_code%2F2022%2Findex.livemd)
[Livebook](https://livebook.dev/)をお使いの方は、上記のボタンを**迷わず**押すと、私の解答例をお試しいただけます！
解答例は閉じておきます。



<details><summary>解答例</summary><div>

## 私


```elixir
input = """
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
"""
```

```elixir
f = fn
  "$ cd ..", map, current, paths -> {map, Enum.slice(current, 0..-2), paths}
  "$ cd " <> dir, map, current, paths -> 
    new_current = current ++ [dir]
    new_paths = MapSet.put(paths, new_current)
    case get_in(map, new_current) do
      nil ->
        new_map = put_in(map, new_current, %{files: [], total_size: 0})
        {new_map, new_current, new_paths}
      %{files: _files} ->
        {map, current, new_paths}
    end
  "$ ls", map, current, paths -> {map, current, paths}
  "dir " <> _dir, map, current, paths -> {map, current, paths}
  line, map, current, paths ->
    file_name = line |> String.split(" ") |> Enum.at(-1)
    file_size = line |> String.split(" ") |> Enum.at(0) |> String.to_integer()
    files_path = current ++ [:files]
    total_size_path = current ++ [:total_size]
    {_, new_map} = get_and_update_in(map, files_path, &{&1, &1 ++ [{file_name, file_size}]})
                   |> elem(1)
                   |> get_and_update_in(total_size_path, &{&1, &1 + file_size})
    {new_map, current, paths}
end

{map, _, paths} = input
|> String.split("\n", trim: true)
|> Enum.reduce({%{}, [], MapSet.new()}, fn line, {acc_map, acc_current, acc_paths} ->
  f.(line, acc_map, acc_current, acc_paths)
end)

IO.inspect(map)
IO.inspect(paths)

total_sizes = paths
  |> Enum.reduce(%{}, fn path, acc ->
    key = Enum.join(path, "/")
    total_size = get_in(map, path ++ [:total_size])
    Map.update(acc, key, total_size, fn _ -> :error end)
  end)

IO.inspect(total_sizes)

sum_of_total_sizes = paths
  |> Enum.reduce(%{}, fn path, acc ->
    key = Enum.join(path, "/")
    sum_of_total_size = total_sizes
      |> Enum.filter(fn {path, _total_size} -> String.starts_with?(path, key) end)
      |> Enum.map(fn {_path, total_size} -> total_size end)
      |> Enum.sum()
    Map.update(acc, key, sum_of_total_size, fn _ -> :error end)
  end)

sum_of_total_sizes
|> Enum.filter(fn {_path, sum_of_total_size} -> sum_of_total_size <= 100000 end)
|> IO.inspect()
|> Enum.map(fn {_path, sum_of_total_size} -> sum_of_total_size end)
|> Enum.sum()
```




`95437` が得られます。

</div></details>

あなたの答えをお待ちしています。
編集リクエストかコメントでくださいませ。



## 読者投稿コーナー

読者の方からいただいたお便りをご紹介します。

<details><summary>読者投稿コーナー</summary><div>



まだありません。


</div></details>




---

# さいごに

この記事では、[Advent of Code 2022](https://adventofcode.com/2022)の「[Advent of Code 2022](https://adventofcode.com/2022)の[Day 7: No Space Left On Device](https://adventofcode.com/2022/day/7)」を[Elixir](https://elixir-lang.org/)で解いてみました。


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
