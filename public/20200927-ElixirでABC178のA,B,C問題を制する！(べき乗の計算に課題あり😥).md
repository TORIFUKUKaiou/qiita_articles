---
title: "ElixirでABC178のA,B,C問題を制する！(べき乗の計算に課題あり\U0001F625)"
tags:
  - Elixir
private: false
updated_at: '2022-04-06T18:29:24+09:00'
id: 2f739c12c031325016a2
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
:::note info
Elixir 1.13 or laterでは ** が追加されています！
:::

[**/2](https://hexdocs.pm/elixir/Kernel.html#**/2)については、下記の記事を書いています。

https://qiita.com/torifukukaiou/items/9d42a8635397896dae7b

# はじめに
- @u2dayo さんの[【AtCoder解説】PythonでABC178のA,B,C問題を制する！](https://qiita.com/u2dayo/items/98917c94c89c77b9b3a1)を拝見しまして、私は[Elixir](https://elixir-lang.org/)でやってみようとおもいました

# 問題
- [AtCoder Beginner Contest 178](https://atcoder.jp/contests/abc178)
- A〜Cまで解いてみます

# [問題A - Not](https://atcoder.jp/contests/abc178/tasks/abc178_a)
- 問題文はリンク先をご参照くださいませ :bow:
- 自力で行けました :lgtm:

```elixir
defmodule Main do
  def main do
    IO.read(:line)
    |> String.trim()
    |> solve()
    |> IO.puts()
  end

  defp solve("1"), do: "0"

  defp solve("0"), do: "1"
end
```

- [提出](https://atcoder.jp/contests/abc178/submissions/17012080)

# [問題B - Product Max](https://atcoder.jp/contests/abc178/tasks/abc178_b)
- 問題文はリンク先をご参照くださいませ :bow:
- 自力で行けました :lgtm:

```elixir
defmodule Main do
  def main do
    IO.read(:line)
    |> String.trim()
    |> String.split(" ")
    |> Enum.map(&String.to_integer/1)
    |> solve()
    |> IO.puts()
  end

  defp solve([a, b, c, d]), do: Enum.max([a * c, a * d, b * c, b * d])
end
```

- [提出](https://atcoder.jp/contests/abc178/submissions/17012131)

# [問題C - Ubiquity](https://atcoder.jp/contests/abc178/tasks/abc178_c)
- 解き方は、[元の記事のベン図](https://qiita.com/u2dayo/items/98917c94c89c77b9b3a1#%E8%80%83%E5%AF%9F-1)で理解しました
    - ありがとうございます！
    - $10^N - 2 × 9^N + 8^N$ を計算すればよいわけです
- べき乗計算ですね、イヤな予感がしてきました
- [Elixir](https://elixir-lang.org/)には`**`演算子がありません
- [Erlang](https://www.erlang.org/)の[:math.pow/2](https://erlang.org/doc/man/math.html#pow-2)が使えますが、結果がfloatですし、[round](https://hexdocs.pm/elixir/Kernel.html#round/1)で整数にしても誤差がでてしまうし、計算できる上限があります

```elixir
iex> :math.pow(2, 3)
8.0

iex> :math.pow(10, 100) |> round
10000000000000000159028911097599180468360808563945281389781327557747838772170381060813469985856815104

iex> :math.pow(10, 1000000)
** (ArithmeticError) bad argument in arithmetic expression
    (stdlib 3.13) :math.pow(10, 1000000)
```

- [How do I raise a number to a power in Elixir?](https://stackoverflow.com/questions/32024156/how-do-i-raise-a-number-to-a-power-in-elixir/32030190) で紹介されていた、べき乗計算を末尾再帰で行う解法[^1]で提出してみました
- が、しかし`TLE (Time Limit Exceeded)`で**不合格**となっています😥
    - [元の記事](https://qiita.com/u2dayo/items/98917c94c89c77b9b3a1#%E5%AE%9F%E8%A3%85)にありました「余りを取りながら計算すると高速に計算できます」もやってみたのですが、その工夫の効果よりもべき乗の計算に時間がかかってしまっているようで**不合格**のままでした

[^1]: 私は末尾再帰になっているものだと思っているのですが間違っていたらご指摘ください :bow: 

```elixir
defmodule Main do
  @divisor 1_000_000_007

  def main do
    IO.read(:line)
    |> String.trim()
    |> String.to_integer()
    |> solve()
    |> IO.puts()
  end

  def solve(n) do
    pow(10, n)
    |> Kernel.-(2 * pow(9, n))
    |> Kernel.+(pow(8, n))
    |> rem(@divisor)
  end

  def pow(m, n), do: _pow(m, n, 1)

  defp _pow(_, 0, acc), do: acc

  defp _pow(m, n, acc), do: _pow(m, n - 1, m * acc)
end
```

- [提出](https://atcoder.jp/contests/abc178/submissions/17049260)

### 【追記】 `AC (Accepted)`が１ケース増えました！
- [べき乗の高速化(log n)](https://ttrsq.exblog.jp/24414256/) を参考にさせていただいて、`pow/2`関数を書き直してみましたところ`AC (Accepted)`が１ケース増えました

```elixir
defmodule Awesome do
  use Bitwise
 
  def pow(m, n) do
    pow(m, n, 1)
  end

  def pow(_m, n, acc) when n <= 0, do: acc

  def pow(m, n, acc) do
    if (n &&& 1) == 1 do
      pow(m * m, n >>> 1, m * acc)
    else
      pow(m * m, n >>> 1, acc)
    end
  end
end
```
- [:timer.tc/3](https://erlang.org/doc/man/timer.html#tc-3)で計測したところ確かに速くなっています

```elixir
iex> :timer.tc(Awesome, :pow, [10, 100000]) |> elem(0)     
60575

iex> :timer.tc(Main, :pow, [10, 100000]) |> elem(0)
1274525
```

- [提出](https://atcoder.jp/contests/abc178/submissions/17052123)
    - まだまだ**不合格** `TLE (Time Limit Exceeded)`が多い

## 【追記】 @suzuki-navi さんが解いてくださいました！ :lgtm::lgtm::lgtm: 
- [ElixirでABC178のC Ubiquityを解いてみる](https://qiita.com/suzuki-navi/items/d29175b2baed42bbca7a)
- :tada::tada::tada: 

## Ruby
- とりあえず、[Elixir](https://elixir-lang.org/)の言語仕様に強い影響を与えたと言われていて、[Elixir](https://elixir-lang.org/)の母だと言われることもある[Ruby](https://www.ruby-lang.org/ja/)で提出したところ、あっさり**合格**しました
    - ありがとう、おっかさん！ :woman:

```ruby
n = gets.to_i
 
puts ((10 ** n - 2 * (9 ** n) + (8 ** n)) % 1000000007)
```

- [提出](https://atcoder.jp/contests/abc178/submissions/17048026)


# Wrapping Up
- [Elixir](https://elixir-lang.org/)のべき乗計算はどうやると速くできるのでしょうか :thinking::thinking::thinking: 
    - 自分で分かったら更新したいと思いますし、ご存知の方はぜひ教えてくださいませ :bow::bow::bow: 
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket: 
