---
title: 闘魂Elixir ーー AtCoder Beginner Contest 355(C)をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-06-14T19:39:55+09:00'
id: f27b1dbd101def5ecec0
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


# はじめに

[AtCoder Beginner Contest 355](https://atcoder.jp/contests/abc355)を[Elixir](https://elixir-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。


# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [C - Bingo 2](https://atcoder.jp/contests/abc355/tasks/abc355_c)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。


<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

`N`が

```math
2 \times 10^3
```

あります。

嫌な予感（TLE:Time Limit Exceeded)しかしません。

ビンゴゲームですが、人にとって一番関心がありそうなビンゴカードの「どこに穴が空いていて、どこに穴が空いていないか」という状態は、この問題を解く上では特に管理する必要はありません。ビンゴカードの状態を真面目に記録しておいて、ビンゴかどうか判定していると時間がかかりそうです。
そのかわりに、縦列毎に何個穴があいたのか、同じように横行毎に何個穴があいたのかを記録しておけばよさそうです。
あ、斜めもありました。左上から右下方向の斜めは、行番号と列番号が同じになります。
もう一つの斜めである右上から左下方向の斜めは、1はじまりだとすると、行番号と列番号を足すと`N + 1`になるものが該当します。
数字がどの位置（行番号、列番号）にあるのかをもっておいて、数字が読み上げられるたびに、縦列毎に何個穴があいたのか、横行毎に何個穴があいたのか、2つの斜めが何個穴が空いたのかを更新していけばよいわけです。
穴の個数が`N`になったら、ビンゴという寸法です。


まずは[Elixir](https://elixir-lang.org/)で解いてみました。
果たして……


```elixir
defmodule Main do
  def main do
    [n, _m] = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    turns = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    map = for i <- 1..n, j <- 1..n, into: %{} do
      {n * (i - 1) + j, {i, j}}
    end


    solve(map, turns, n)
    |> IO.puts()
  end
  
  def solve(map, turns, n) do
    turns
    |> Enum.with_index(1)
    |> Enum.reduce_while({0, 0, 0, %{}, 0, %{}}, fn {value, cnt}, {diagonal_1, diagonal_2, max_row_cnt, row_cnts, max_col_cnt, col_cnts} ->
      {i, j} = Map.get(map, value)

      new_diagonal_1 = if i == j, do: diagonal_1 + 1, else: diagonal_1
      new_diagonal_2 = if i + j == n + 1, do: diagonal_2 + 1, else: diagonal_2

      current_row_cnt = Map.get(row_cnts, i, 0)
      new_row_cnt = current_row_cnt + 1
      new_row_cnts = Map.put(row_cnts, i, new_row_cnt)
      new_max_row_cnt = if new_row_cnt > max_row_cnt, do: new_row_cnt, else: max_row_cnt
      
      current_col_cnt = Map.get(col_cnts, j, 0)
      new_col_cnt = current_col_cnt + 1
      new_col_cnts = Map.put(col_cnts, j, new_col_cnt)
      new_max_col_cnt = if new_col_cnt > max_col_cnt, do: new_col_cnt, else: max_col_cnt

      if new_diagonal_1 >= n or new_diagonal_2 >= n or new_max_row_cnt >= n or new_max_col_cnt >= n do
        {:halt, cnt}
      else
        {:cont, {new_diagonal_1, new_diagonal_2, new_max_row_cnt, new_row_cnts, new_max_col_cnt, new_col_cnts}}
      end
    end)
    |> do_solve()
  end

  defp do_solve({_, _, _, _, _, _}), do: -1
  defp do_solve(cnt), do: cnt
end
```

やっぱり(!?)、**TLE:Time Limit Exceeded**でした。
[Stream](https://hexdocs.pm/elixir/Stream.html)とか`:ets`とか駆使しないとだめでしょうか。

いやいや、そもそも考え違いをしているかもしれないので[Python](https://www.python.org/)で書いてみましたところ、あっさりパスしてしまいました。


```python
n, m = map(int, input().split())
turns = map(int, input().split())


d = {}
for i in range(1, n + 1):
    for j in range(1, n + 1):
        d[n * (i - 1) + j] = (i - 1, j - 1)

def index(value):
    return d[value]

row_cnts = []
col_cnts = []

for i in range(1, n + 1):
    row_cnts.append(0)
    col_cnts.append(0)

max_row_cnts = 0
max_col_cnts = 0
naname_1 = 0
naname_2 = 0

for cnt, t in enumerate(turns):
    i, j = index(t)
    row_cnts[i] = row_cnts[i] + 1
    if row_cnts[i] > max_row_cnts:
        max_row_cnts = row_cnts[i]
    col_cnts[j] = col_cnts[j] + 1
    if col_cnts[j] > max_col_cnts:
        max_col_cnts = col_cnts[j]
    if i == j:
        naname_1 = naname_1 + 1
    if i + j == n - 1:
        naname_2 = naname_2 + 1
    if naname_1 >= n or naname_2 >= n or max_row_cnts >= n or max_col_cnts >= n:
        print(cnt + 1)
        break
else:
    print(-1)
```

あっさりと言っても、1.5秒くらいかかっているようで、ギリギリの実装のようです。


## 2024-06-14 追記

その後、ElixirのコミュニティSlackでパスしてくださった方がいました。値の位置をMapで作っていたのが敗因でした。実は割り算の商と余りで位置を特定できるわけです。

以下はパスするプログラムです。

```elixir
defmodule Main do
  def main do
    [n, _m] = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    turns = IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    solve(turns, n)
    |> IO.puts()
  end
  
  def solve(turns, n) do
    turns
    |> Enum.with_index(1)
    |> Enum.reduce_while({0, 0, 0, %{}, 0, %{}}, fn {value, cnt}, {diagonal_1, diagonal_2, max_row_cnt, row_cnts, max_col_cnt, col_cnts} ->
      i = div(value - 1, n)
      j = rem(value - 1, n)

      new_diagonal_1 = if i == j, do: diagonal_1 + 1, else: diagonal_1
      new_diagonal_2 = if i + j == n - 1, do: diagonal_2 + 1, else: diagonal_2

      current_row_cnt = Map.get(row_cnts, i, 0)
      new_row_cnt = current_row_cnt + 1
      new_row_cnts = Map.put(row_cnts, i, new_row_cnt)
      new_max_row_cnt = if new_row_cnt > max_row_cnt, do: new_row_cnt, else: max_row_cnt
      
      current_col_cnt = Map.get(col_cnts, j, 0)
      new_col_cnt = current_col_cnt + 1
      new_col_cnts = Map.put(col_cnts, j, new_col_cnt)
      new_max_col_cnt = if new_col_cnt > max_col_cnt, do: new_col_cnt, else: max_col_cnt

      if new_diagonal_1 >= n or new_diagonal_2 >= n or new_max_row_cnt >= n or new_max_col_cnt >= n do
        {:halt, cnt}
      else
        {:cont, {new_diagonal_1, new_diagonal_2, new_max_row_cnt, new_row_cnts, new_max_col_cnt, new_col_cnts}}
      end
    end)
    |> do_solve()
  end

  defp do_solve({_, _, _, _, _, _}), do: -1
  defp do_solve(cnt), do: cnt
end
```

</details>




---

# さいごに

[AtCoder Beginner Contest 355](https://atcoder.jp/contests/abc355)を[Elixir](https://elixir-lang.org/)と今回は[Python](https://www.python.org/)で解くことを楽しみました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
