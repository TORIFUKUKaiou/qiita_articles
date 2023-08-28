---
title: '&>=/2, &<=/2, &</2などなどはFunction capturingです（Elixir）'
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-03-22T22:45:53+09:00'
id: 140e0e90ba080f3be0ad
organization_url_name: fukuokaex
slide: false
---
**山里は冬ぞ寂しさまさりける人目も草もかれぬと思へば**

Advent Calendar 2022 78日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

`&>=/2`, `&<=/2`, `&</2`などは、[Function capturing](https://elixir-lang.org/getting-started/modules-and-functions.html#function-capturing)です。
という話を書きます。

# `&>=/2`, `&<=/2`, `&</2`

`&>=/2`, `&<=/2`, `&</2`はそれぞれ、enumerableなものから最大値、最小値を取得する関数の第3引数`sorter`のデフォルト値に指定されています。

| 第3引数`sorter`のデフォルト | 関数 |
|:-:|:-:|
| `&>=/2`  | [Enum.max/3](https://hexdocs.pm/elixir/Enum.html#max/3)  |
| `&>=/2`  |  [Enum.max_by/4](https://hexdocs.pm/elixir/Enum.html#max_by/4) |
| `&<=/2`  |  [Enum.min/3](https://hexdocs.pm/elixir/Enum.html#min/3) |
| `&<=/2`  |  [Enum.min_by/4](https://hexdocs.pm/elixir/Enum.html#min_by/4) |
| `&</2`  |  [Enum.min_max_by/4](https://hexdocs.pm/elixir/Enum.html#min_max_by/4) |

たとえば、[Enum.max/3](https://hexdocs.pm/elixir/Enum.html#max/3)をみてみましょう。

![スクリーンショット 2022-03-21 2.00.59.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/82b8cb0e-0464-47bc-aca7-44bbb54ce771.png)

一見するとわかりにくいかもしれません。
引数をそれぞれ詳しくみていきます。

- 第1引数 `enumerable`
- 第2引数 `sorter`: デフォルト値は、`&>=/2` ※意味は後述
- 第3引数 `empty_fallback`: デフォルト値は、`fn -> raise Enum.EmptyError end`という引数0個の無名関数

とみます。
な〜んてことない人は、相当な**Alchemist**です。
つまり、この説明を読んでな〜んてことない人になったあなたは**Alchemist**です。


# What's `/2` ?

`/2`というのは引数が2つという意味です。
`/0`だと引数が0。
`/1`だと引数が1。

専門家の間では、arity（アリティ）と呼ばれます。

https://elixir-lang.org/getting-started/modules-and-functions.html#function-capturing

# [>=/2](https://hexdocs.pm/elixir/Kernel.html#%3E=/2)

[>=/2](https://hexdocs.pm/elixir/Kernel.html#%3E=/2)を深掘りしてみます。
[>=/2](https://hexdocs.pm/elixir/Kernel.html#%3E=/2)の内部実装は以下の通りです。

```elixir
  @doc guard: true
  @spec term >= term :: boolean
  def left >= right do
    :erlang.>=(left, right)
  end
```

2つの引数を`:erlang.>=/2`に渡して呼び出しています。

こんな書き方（呼び出し方）はしなくてよいのですが、紹介だけしておくと`Kernel.>=(4, 3)`と書けます。

他も気になる方は、[ドキュメント](https://hexdocs.pm/elixir/Kernel.html)の`</>`を迷わず押してみてください。
ソースコードにジャンプできます。

# `&>=/2`, `&<=/2`, `&</2`などは、[Function capturing](https://elixir-lang.org/getting-started/modules-and-functions.html#function-capturing)


`&>=/2`, `&<=/2`, `&</2`などは、[Function capturing](https://elixir-lang.org/getting-started/modules-and-functions.html#function-capturing)です。

`&>=/2`を実行した結果と、`fn a, b -> a >= b end`を実行した結果は同じです。

```elixir
iex> fc = (&>=/2) 
&:erlang.>=/2

iex> f = fn a, b -> a >= b end
#Function<43.65746770/2 in :erl_eval.expr/5>

iex> fc.(3, 1)
true

iex> f.(3, 1)
true

iex> fc.(3, 4)
false

iex> f.(3, 4)
false
```

`fn a, b -> a >= b end`を&記法で書くと、`& &1 >= &2`となります。
もうここまで来ちゃうと

```elixir
iex> (&>=/2) == (& &1 >= &2)
true
```

と、`(&>=/2) == (& &1 >= &2)`が`true`として成立します。

公式ドキュメントは、以下をご参照ください。

https://hexdocs.pm/elixir/Kernel.SpecialForms.html#&/1

https://elixir-lang.org/getting-started/modules-and-functions.html#function-capturing


# その他

何に使うかはこの際、考えません。
以下のようなものを作ることができます。
ソースコード中ではじめてみると、なんだこれ？　となること請け合いです。

```elixir
iex> &+/2
&:erlang.+/2

iex> &-/2
&:erlang.-/2

iex> &++/2
&:erlang.++/2

iex> &<>/2
#Function<43.65746770/2 in :erl_eval.expr/5>

iex> &../2
#Function<43.65746770/2 in :erl_eval.expr/5>

iex> &**/2
&Kernel.**/2

iex> &=/2 
#Function<43.65746770/2 in :erl_eval.expr/5>

iex> &==/2
&:erlang.==/2

iex> & &&/2
#Function<43.65746770/2 in :erl_eval.expr/5>

iex> &!/1
#Function<44.65746770/1 in :erl_eval.expr/5>

iex> &in/2 
#Function<43.65746770/2 in :erl_eval.expr/5>

iex> &**/2 
&Kernel.**/2
```





---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

`&>=/2`, `&<=/2`, `&</2`などは、[Function capturing](https://elixir-lang.org/getting-started/modules-and-functions.html#function-capturing)です。

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>


以上です。

## 尚々書

先日書いた「[Enum.max_by/4 を説明します（Elixir）](https://qiita.com/torifukukaiou/items/ee38aea95111b505798a)」の中でもこの記事の内容は一部触れています。
[Enum.max_by/4](https://hexdocs.pm/elixir/Enum.html#max_by/4)は案外奥が深く、内容が盛り沢山になりました。
`&>=/2`, `&<=/2`, `&</2`は初見殺し感が満載なので、これらに絞って記事を書き起こしました。





---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)





