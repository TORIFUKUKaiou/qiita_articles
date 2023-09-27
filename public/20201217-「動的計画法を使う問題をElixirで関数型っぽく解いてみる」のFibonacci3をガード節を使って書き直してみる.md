---
title: 「動的計画法を使う問題をElixirで関数型っぽく解いてみる」のFibonacci3をガード節を使って書き直してみる
tags:
  - Elixir
private: false
updated_at: '2020-12-23T13:50:49+09:00'
id: 5cb11e04d3041b6ac3ca
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
この記事は [Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2) **23日目**です。

---

# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか :bangbang:
- @masatam81 さんの[動的計画法を使う問題をElixirで関数型っぽく解いてみる -- Mapも使ってみる(おまけ)](https://qiita.com/masatam81/items/0306163bb15d9cfbe092#map%E3%82%82%E4%BD%BF%E3%81%A3%E3%81%A6%E3%81%BF%E3%82%8B%E3%81%8A%E3%81%BE%E3%81%91)の`Fibonacci3`を書き直してみます
- 私は`動的計画法`とか言われてもよくわかっていません
- けれども[Elixir](https://elixir-lang.org/)は読めるので手本があればなんとかなります :bangbang:

# お手本

```elixir
defmodule Fibonacci3 do
  defp create(dp, n) when n < 2 do
    Map.put(dp, n, n)
  end
  defp create(dp, n) do
    if not Map.has_key?(dp, n) do
      dp =
        if not Map.has_key?(dp, n-1) do
          create(dp, n-1)
        else
          dp
        end
      dp =
        if not Map.has_key?(dp, n-2) do
          create(dp, n-2)
        else
          dp
        end
      Map.put(dp, n, Map.get(dp, n-1) + Map.get(dp, n-2))
    else
      dp
    end
  end
  def fib(n) do
    dp = create(Map.new, n)
    Map.get(dp, n)
  end
end
```


# Mapにキーがあるかどうかを[ガード節](https://hexdocs.pm/elixir/Kernel.html#in/2-guards)やパターンマッチで`create/2`関数をわければいいんじゃないだろうか
- なにかいいのないかなー
- これか:bangbang:
    - [Kernel.is_map_key/2](https://hexdocs.pm/elixir/Kernel.html#is_map_key/2)

## [ガード節](https://hexdocs.pm/elixir/Kernel.html#in/2-guards) 編

```elixir
defmodule Fibonacci4 do
  defp create(dp, n) when n < 2 do
    Map.put(dp, n, n)
  end

  defp create(dp, n) when is_map_key(dp, n), do: dp

  defp create(dp, n) when is_map_key(dp, n - 1) and is_map_key(dp, n - 2) do
    Map.put(dp, n, Map.get(dp, n - 1) + Map.get(dp, n - 2))
  end

  defp create(dp, n) when is_map_key(dp, n - 1) do
    dp = create(dp, n - 2)
    Map.put(dp, n, Map.get(dp, n - 1) + Map.get(dp, n - 2))
  end

  defp create(dp, n) when is_map_key(dp, n - 2) do
    dp = create(dp, n - 1)
    Map.put(dp, n, Map.get(dp, n - 1) + Map.get(dp, n - 2))
  end

  defp create(dp, n) do
    dp = create(dp, n - 1)
    dp = create(dp, n - 2)
    Map.put(dp, n, Map.get(dp, n - 1) + Map.get(dp, n - 2))
  end

  def fib(n) do
    dp = create(Map.new(), n)
    Map.get(dp, n)
  end
end
```

## パターンマッチ

```elixir
defmodule Fibonacci5 do
  defp create(dp, n) when n < 2 do
    Map.put(dp, n, n)
  end

  defp create(dp, n) do
    n_minus_one = n - 1
    n_minus_two = n - 2

    case dp do
      %{^n => _} ->
        dp

      %{^n_minus_one => v1, ^n_minus_two => v2} ->
        Map.put(dp, n, v1 + v2)

      %{^n_minus_one => v1} ->
        dp = create(dp, n_minus_two)
        Map.put(dp, n, v1 + Map.get(dp, n_minus_two))

      %{^n_minus_two => v2} ->
        dp = create(dp, n_minus_one)
        Map.put(dp, n, Map.get(dp, n_minus_one) + v2)

      _ ->
        dp = create(dp, n_minus_one) |> create(n_minus_two)
        Map.put(dp, n, Map.get(dp, n - 1) + Map.get(dp, n - 2))
    end
  end

  def fib(n) do
    dp = create(Map.new(), n)
    Map.get(dp, n)
  end
end
```

- [case/2](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#case/2)を使いました
- :point_down::point_down_tone1::point_down_tone2::point_down_tone3::point_down_tone4::point_down_tone5: のような書き方ができたら一番キレイ:diamond_shape_with_a_dot_inside:に書ける気がしましたがこれはコンパイルエラーになりました 

```elixir
  defp create(%{^n => _} = dp, n), do: dp
```

```elixir

iex> recompile

== Compilation error in file lib/fibonacci5.ex ==
** (CompileError) lib/fibonacci5.ex:6: undefined variable ^n. No variable "n" has been defined before the current pattern
    (stdlib 3.13) lists.erl:1354: :lists.mapfoldl/3
    (stdlib 3.13) lists.erl:1354: :lists.mapfoldl/3
** (exit) shutdown: 1
    (mix 1.11.2) lib/mix/tasks/compile.all.ex:76: Mix.Tasks.Compile.All.compile/4
    (mix 1.11.2) lib/mix/tasks/compile.all.ex:57: Mix.Tasks.Compile.All.with_logger_app/2
    (mix 1.11.2) lib/mix/tasks/compile.all.ex:35: Mix.Tasks.Compile.All.run/1
    (mix 1.11.2) lib/mix/task.ex:394: Mix.Task.run_task/3
    (mix 1.11.2) lib/mix/tasks/compile.ex:119: Mix.Tasks.Compile.run/1
    (mix 1.11.2) lib/mix/task.ex:394: Mix.Task.run_task/3
    (iex 1.11.2) lib/iex/helpers.ex:104: IEx.Helpers.recompile/1
```

- (いいやり方ありましたらぜひ教えてください :bangbang::pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:) 


## 答えあわせ
- あっていそう :rocket::rocket::rocket: 

```elixir
iex> Fibonacci3.fib(50)                                                  
12586269025

iex> Fibonacci4.fib(50)
12586269025

iex> Fibonacci5.fib(50)
1258626902

iex> Fibonacci3.fib(51)
20365011074

iex> Fibonacci4.fib(51)
20365011074

iex> Fibonacci5.fib(51)
20365011074


iex> Fibonacci3.fib(52)
32951280099

iex> Fibonacci4.fib(52)
32951280099

iex> Fibonacci5.fib(52)
32951280099

iex> Fibonacci3.fib(100)                                                 
354224848179261915075

iex> Fibonacci4.fib(100)
354224848179261915075

iex> Fibonacci5.fib(100)
354224848179261915075
```

## 比較

- **いい勝負**
- @masatam81 さんのオリジナルが一番速い :rocket: 
- 単位はマイクロ秒です

```elixir
iex> :timer.tc(Fibonacci3, :fib, [100]) |> elem(0)
61

iex> :timer.tc(Fibonacci4, :fib, [100]) |> elem(0)
71

iex> :timer.tc(Fibonacci5, :fib, [100]) |> elem(0)
65

iex> :timer.tc(Fibonacci3, :fib, [1000]) |> elem(0)
970

iex> :timer.tc(Fibonacci4, :fib, [1000]) |> elem(0)
1130

iex> :timer.tc(Fibonacci5, :fib, [1000]) |> elem(0)
979
```

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- [ガード節](https://hexdocs.pm/elixir/Kernel.html#in/2-guards)を使うと一つひとつの関数が短くなるので理解しやすくなります
- [パターンマッチ編](https://qiita.com/torifukukaiou/items/5cb11e04d3041b6ac3ca#%E3%83%91%E3%82%BF%E3%83%BC%E3%83%B3%E3%83%9E%E3%83%83%E3%83%81)はもっと美しく書く方法があるのかも:interrobang:
- 私は、お手本があるから書けました :man_tone1::man_tone2::man_tone3::man_tone4::man_tone5:
- @koyo-miyamura さんに教えてもらった [問題解決力を鍛える!アルゴリズムとデータ構造](https://www.amazon.co.jp/dp/4065128447/)は冬休みの宿題 :snowboarder: 
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket: 
