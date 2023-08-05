---
title: 'Enjoy Elixir #003 Pattern matching '
tags:
  - Elixir
private: false
updated_at: '2020-11-15T11:25:10+09:00'
id: 47b088f6c44ccf213226
organization_url_name: fukuokaex
slide: true
---
# はじめに
- [KFIE](https://kfieyaruki.connpass.com/)という近畿大学産業理工学部の情報系コミュニティがあります
- 最近は、毎週火曜日にLT会をやっているそうです
- 私が学生だったのはもうずいぶん昔のことなのですが、参加させてもらっています
- 毎週、5分間時間をもらって、[Elixir](https://elixir-lang.org/)いいよ！　を伝えていきたいとおもいます
    - [2020/6/16(火)の回](https://kfieyaruki.connpass.com/event/177837/)
- 今日は以下を学びます
    - Pattern matching 
- A journey of a thousand miles begins with a single step.
- この記事は[Elixir](https://elixir-lang.org/)を触るのがはじめてという方に向けて書いています

----

# もくじ
[001 mix new, iex -S mix, mix format](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af)
|> [002 型](https://qiita.com/torifukukaiou/items/1f5789dbd05498be1132)
|> [003 Pattern matching](https://qiita.com/torifukukaiou/items/47b088f6c44ccf213226)
|> [004 Modules and functions](https://qiita.com/torifukukaiou/items/2b6f30db0a7d37c4f139)
|> [005 Pipe operator and Enum module](https://qiita.com/torifukukaiou/items/70a350cfc45d0eb58371)
|> [006 HTTP GET!](https://qiita.com/torifukukaiou/items/e4416cca916497ee76fb)
|> [007 Flow](https://qiita.com/torifukukaiou/items/eb1aa2c8842adfc40637)
|> [008 AtCoderを解いてみる](https://qiita.com/torifukukaiou/items/98f875ee4d0f4038b5a2)
|> [999 Where to go next](https://qiita.com/torifukukaiou/items/4fa0747546aafa3fe89a)

----

# Pattern matching 

- `iex`を立ち上げていろいろ見てみましょう

```elixir
iex> x = 1
1
iex> 1 = x
1
iex> 1 = 1
1

# Tuple
iex> tuple = {:hello, "world", 42}
{:hello, "world", 42}
iex> {a, b, c} = tuple
{:hello, "world", 42}
iex> a
:hello
iex> b
"world"
iex> c
42
iex> {a, b} = tuple
** (MatchError) no match of right hand side value: {:hello, "world", 42}

# Map
iex> torifuku = %{name: "torifuku", age: 5, height: 200}
%{age: 5, height: 200, name: "torifuku"}
iex> %{name: name, age: age} = torifuku
%{age: 5, height: 200, name: "torifuku"}
iex> name
"torifuku"
iex> age
5
iex> %{name: name, age: age, weight: weight} = torifuku
** (MatchError) no match of right hand side value: %{age: 5, height: 200, name: "torifuku"}

# List
iex> list = [1, 2, 3, "ダー"]
[1, 2, 3, "ダー"]
iex> [one, two, three, d] = list
[1, 2, 3, "ダー"]
iex> one
1
iex> two
2
iex> three
3
iex> d
"ダー"
iex> [one, two, three] = list
** (MatchError) no match of right hand side value: [1, 2, 3, "ダー"]
iex> [head | tail] = list
[1, 2, 3, "ダー"]
iex> head
1
iex> tail
[2, 3, "ダー"]
iex> hd(list)
1
iex> tl(list)
[2, 3, "ダー"]
```

- [=/2](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#=/2)

> Matches the value on the right against the pattern on the left.

- [hd/1](https://hexdocs.pm/elixir/Kernel.html#hd/1)
- [tl/1](https://hexdocs.pm/elixir/Kernel.html#tl/1)

---

# 関数の結果を tuple で受け取る

- 以下、Pattern matching をどういうときに使うのかいくつか具体例をみていきましょう

```elixir
$ iex

iex> {:ok, content} = File.read("mix.exs")
{:ok,
 "defmodule PatternMatching.MixProject ..."}

iex> String.length(content)
589

iex> String.split(content, " ") |> Enum.count
133

iex> System.halt
```

- `589`や`133`の結果は、`mix.exs`ファイルの内容によります

----

# 準備
- ここからはプロジェクトを作って楽しんでいきましょう

```console
$ mix new pattern_matching
$ cd pattern_matching
```

----

# [フィボナッチ数](https://ja.wikipedia.org/wiki/%E3%83%95%E3%82%A3%E3%83%9C%E3%83%8A%E3%83%83%E3%83%81%E6%95%B0)

```math
f_0=0,\\f_1=1,\\f_{n}=f_{n-2}+f_{n-1}
```


```elixir:lib/pattern_matching.ex
defmodule PatternMatching do
  def fib(n) do
    if n == 0 do
      0
    else
      if n == 1 do
        1
      else
        fib(n - 2) + fib(n - 1)
      end
    end
  end
end
```

```elixir
$ iex -S mix
iex> PatternMatching.fib(10)
55
```

- 動いてはいますが、美しくありません
- [Elixir](https://elixir-lang.org/)っぽく書いてみましょう
- 最初にでてきた`数値 = 変数`を使います

```elixir:lib/pattern_matching.ex
defmodule PatternMatching do
  def fib(0 = n), do: 0
  def fib(1 = n), do: 1
  def fib(n), do: fib(n - 2) + fib(n - 1)
end
```
- 上記はさらに以下のようにスリムにすることができます

```elixir:lib/pattern_matching.ex
defmodule PatternMatching do
  def fib(0), do: 0
  def fib(1), do: 1
  def fib(n), do: fib(n - 2) + fib(n - 1)
end
```

- 数式と全く同じです!　美しい！
- マシンスペックにもよりますが、nが40を超える当たりからけっこう時間がかかるようになります
- 以下のようにしたほうが速く計算は終わります

```elixir:lib/pattern_matching.ex
defmodule PatternMatching do
  def fib(n), do: do_fib(n, 0, {0, 1})

  defp do_fib(n, i, {n_2, _n_1}) when i >= n, do: n_2
  defp do_fib(n, i, {n_2, n_1}), do: do_fib(n, i + 1, {n_1, n_2 + n_1})
end
```

```elixir
iex> recompile

iex> PatternMatching.fib(1000) 
43466557686937456435688527675040625802564660517371780402481729089536555417949051890403879840079255169295922593080322634775209689623239873322471161642996440906533187938298969649928516003704476137795166849228875
```

----

# [Fizz Buzz](https://ja.wikipedia.org/wiki/Fizz_Buzz)

- 3で割り切れる数の場合は`Fizz`を返す
- 5で割り切れる数の場合は`Buzz`を返す
- 3でも5でも割り切れる数の場合は`Fizz Buzz`を返す
- それ以外の数の場合は、その数字を返す

以下、関係があるところのみを書きます(フィボナッチ数の関数は残したままでも問題はありません)

```elixir:lib/pattern_matching.ex
defmodule PatternMatching do
  def fizz_buzz(n) do
    if rem(n, 15) == 0 do
      "Fizz Buzz"
    else
      if rem(n, 3) == 0 do
        "Fizz"
      else
        if rem(n, 5) == 0 do
          "Buzz"
        else
          n
        end
      end
    end
  end
end
```

- パターンマッチを使って美しく書き直してみましょう!

```elixir:lib/pattern_matching.ex
defmodule PatternMatching do
  def fizz_buzz(n), do: do_fizz_buzz(rem(n, 3), rem(n, 5), n)

  defp do_fizz_buzz(0, 0, _n), do: "Fizz Buzz"
  defp do_fizz_buzz(0, _, _n), do: "Fizz"
  defp do_fizz_buzz(_, 0, _n), do: "Buzz"
  defp do_fizz_buzz(_, _, n), do: n
end
```

```elixir
iex> recompile

iex> 1..15 |> Enum.map(&PatternMatching.fizz_buzz/1)
[1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14,
 "Fizz Buzz"]
```

----

# [クイックソート](https://ja.wikipedia.org/wiki/%E3%82%AF%E3%82%A4%E3%83%83%E3%82%AF%E3%82%BD%E3%83%BC%E3%83%88)

```elixir:lib/pattern_matching.ex
defmodule PatternMatching do
  def quicksort([]), do: []

  def quicksort([x | xs]) do
    smaller_or_equal = (for a <- xs, a <= x, do: a)
    larger = (for a <- xs, a > x, do: a)
    quicksort(smaller_or_equal) ++ [x] ++ quicksort(larger)
  end
end
```

```elixir
iex> recompile

iex> PatternMatching.quicksort([10,2,5,3,1,6,7,4,2,3,4,8,9])
[1, 2, 2, 3, 3, 4, 4, 5, 6, 7, 8, 9, 10]
```

- リストのパターンマッチの例として出しました
- ソートは[Enum.sort/1](https://hexdocs.pm/elixir/Enum.html#sort/1)や[Enum.sort/2](https://hexdocs.pm/elixir/Enum.html#sort/2)を使うとよいでしょう

----

# 参考
- [Pattern matching](https://elixir-lang.org/getting-started/pattern-matching.html)


----
# Wrapping Up
- `=`は束縛
- 次回は、すでにちょいちょいでてきていますが、[Modules and functions](https://qiita.com/torifukukaiou/items/2b6f30db0a7d37c4f139)を詳しくみていきたいとおもいます
    - 来週を待ちきれない方は、リソースやコミュニティの情報を [Where to go next](https://qiita.com/torifukukaiou/items/4fa0747546aafa3fe89a) にまとめていますのでダイブしてください！
- Enjoy!!!
