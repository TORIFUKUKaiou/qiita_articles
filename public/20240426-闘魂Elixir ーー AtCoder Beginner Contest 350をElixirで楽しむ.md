---
title: 闘魂Elixir ーー AtCoder Beginner Contest 350をElixirで楽しむ
tags:
  - AtCoder
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-04-26T14:57:46+09:00'
id: 54ec41d12a4f84dd1773
organization_url_name: haw
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>


# はじめに

[AtCoder Beginner Contest 350](https://atcoder.jp/contests/abc350)を[Elixir](https://elixir-lang.org/)で解いてみます。

[AtCoder](https://atcoder.jp/)を解くのが趣味で、休憩時間に解いているという若い人がいて、それってすごい意識の高い休憩時間の過ごし方だと思って、私も真似してみることにしました。

私達[ハウインターナショナル](https://www.haw.co.jp/)では、社名をもじって[ハウッカソン](https://www.haw.co.jp/office/hawckathon/)という名のイベントを毎月最終金曜日に実施しています。

**HAW + Hackathon = Hawckathon!!**

[ハウッカソン](https://www.haw.co.jp/office/hawckathon/)のテーマに競技プログラミングを選ぶメンバーもいます。

# [AtCoderをElixirでやってみる](https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01)

入力の読み取り方や解答の作り方は、別の記事にまとめています。


https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

ご参照くださいませ。

[Elixir](https://elixir-lang.org/)で[AtCoder](https://atcoder.jp/)を楽しむためには、エントリポイントを`Main.main/0`にする必要があります。つまり`Main`モジュールを作って、その中に`main/0`関数を定義するわけです。

# [A - Past ABCs](https://atcoder.jp/contests/abc350/tasks/abc350_a)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。


<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_


入力値"`ABCNNN`"(Nは数字)から`"NNN"`を取り出して、文字列から整数に変換してあげればよさそうです。
パターンマッチで`NNN`を取り出せます。`"ABC" <> num = ...`が該当します。

`"000"`も入力にはあり得えるようです。Runさせてみて、 *WA (Wrong Answer)* がでて気づきました。
第316回は`No`判定にする必要があります。
以上を踏まえると、変換後の整数を`X`としたとき、1 < X <= 315 or 317 <= X < 350のときに`Yes`それ以外は`No`です。

`if`は使わずにパターンマッチでスッキリと書けます。

```elixir
defmodule Main do
  def main do
    "ABC" <> num = IO.read(:line) |> String.trim()
    
    num
    |> String.to_integer()
    |> solve()
    |> IO.puts()
  end
  
  def solve(316), do: "No"
  def solve(0), do: "No"
  def solve(num) when num < 350, do: "Yes"
  def solve(_num), do: "No"
end
```
</details>


# [B - Dentist Aoki](https://atcoder.jp/contests/abc350/tasks/abc350_b)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

数字が偶数回でてくると歯は生えています。数字が奇数回だと歯がなくなっています。
それに気づけば、数字の出現回数を調べて、奇数回の数字の個数をNから引いてあげると、生えている歯の本数を求めることができます。
リストの中に含まれる要素の出現回数といえば、 [Enum.frequencies/1](https://hexdocs.pm/elixir/1.16.2/Enum.html#frequencies/1)を使えばよいでしょう。

```elixir
defmodule Main do
  def main do
    [n, _q] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    ts =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    solve(ts, n)
    |> IO.puts()
  end
  
  def solve(list, n) do
    list
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.filter(& rem(&1, 2) == 1)
    |> Enum.count()
    |> Kernel.-()
    |> Kernel.+(n)
  end
end
```
</details>

# [C - Sort](https://atcoder.jp/contests/abc350/tasks/abc350_c)

問題はリンク先をご参照くださいませ。
私の解答を貼っておきます。

<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

苦労しました。[Elixir](https://elixir-lang.org/)だと、 「**TLE** (Time Limit Exceeded): 問題で指定された実行時間以内にプログラムが終了しませんでした。」が出そうな問題です。

以下2点の改善でなんとか 「**TLE** (Time Limit Exceeded)」を克服できました。

- `indexes |> Enum.zip(list) |> Map.new()`を[Enum.zip/2](https://hexdocs.pm/elixir/1.16.2/Enum.html#zip/2)ではなく、[Enum.with_index/2](https://hexdocs.pm/elixir/1.16.2/Enum.html#with_index/2)を使うようにした点
- 結果の格納をListではなく、`:ets`というインメモリストアに保存するようにした点
    - `:ets`は、「[Erlang Term Storage (ETS)](https://elixirschool.com/ja/lessons/storage/ets)」が詳しいです

これでギリギリ2秒以内に終わるようになりました。


```elixir
defmodule Main do
  def main do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
    list =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    indexes = 0..(n - 1)
    index_map = list |> Enum.with_index(fn element, index -> {index, element} end) |> Map.new()
    value_map = list |> Enum.with_index() |> Map.new()

    db = :ets.new(:example_db, [:ordered_set, :named_table])

    solve(indexes, index_map, value_map, db)
    |> IO.puts()
  end

  def solve(indexes, index_map, value_map, db) do
    indexes
    |> Enum.reduce({index_map, value_map, 0}, fn i, {acc_index_map, acc_value_map, cnt} ->
      value = acc_index_map[i]
      expected_value = i + 1
      if value == expected_value do
        {acc_index_map, acc_value_map, cnt}
      else
        index = acc_value_map[expected_value]
        new_acc_index_map = %{acc_index_map | i => expected_value, index => value}
        new_acc_value_map = %{acc_value_map | expected_value => i, value => index}

        :ets.insert(db, [{cnt, "#{expected_value} #{value}"}])
        new_cnt = cnt + 1
        {new_acc_index_map, new_acc_value_map, new_cnt}
      end
    end)
    |> elem(2)
    |> format()
  end

  defp format(0), do: "0"

  defp format(k) do
    str_operations = ((k - 1)..0)
    |> Enum.reduce("", fn i, acc ->
      [{_, operation}] = :ets.lookup(:example_db, i)

      "#{acc}\n#{operation}"
    end)
    
    "#{k}#{str_operations}"
  end
end
```




</details>



---

# 参考記事

https://qiita.com/GeekMasahiro/items/0970d7300f2bfcb28464

---

# さいごに

[AtCoder Beginner Contest 350](https://atcoder.jp/contests/abc350)を[Elixir](https://elixir-lang.org/)で解くことを楽しみました。
C問題まで解きました。

あなたのお好きなプログラミング言語でお楽しみください。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
