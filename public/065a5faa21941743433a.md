---
title: 闘魂Elixir ── 『そんな奥さんおらんやろ』からget_in関数の紹介
tags:
  - Elixir
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-12-01T20:16:24+09:00'
id: 065a5faa21941743433a
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

[Elixir](https://elixir-lang.org/)の[get_in/2](https://hexdocs.pm/elixir/1.15.7/Kernel.html#get_in/2)関数を紹介します。

<iframe width="1028" height="578" src="https://www.youtube.com/embed/d0fk1Uzdlcs" title="主婦の掃除大抵コレやろ？【夫婦】【アニメ】" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

[そんな奥さんおらんやろ【夫婦のアニメコント】](https://www.youtube.com/@kanappe)というおもしろい動画集があります。その中で「get in, get in」と主人公のかなっぺさんが歌う回があります。
私は[Elixir](https://elixir-lang.org/)の[get_in/2](https://hexdocs.pm/elixir/1.15.7/Kernel.html#get_in/2)関数を思い浮かべました。

# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があるのですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

# [get_in/2](https://hexdocs.pm/elixir/1.15.7/Kernel.html#get_in/2)関数

[get_in/2](https://hexdocs.pm/elixir/1.15.7/Kernel.html#get_in/2)関数のサンプルを示します。
ネストされたマップのキーをたどる例です。

```elixir
iex> users = %{"john" => %{age: 27}, "meg" => %{age: 23}}
iex> get_in(users, ["john", :age])
27
```

こんなこともできます。

```elixir
iex> users = [%{name: "john", age: 27}, %{name: "meg", age: 23}]
iex> get_in(users, [Access.all(), :age])
[27, 23]
```

[Access](https://hexdocs.pm/elixir/1.15.7/Access.html#content)との組み合わせはさらにさらにこんなこともできます。

```elixir
iex> list = [%{name: "john"}, %{name: "mary"}]
iex> get_in(list, [Access.at(1), :name])
"mary"

iex> map = %{user: {"john", 27}}
iex> get_in(map, [:user, Access.elem(0)])
"john"

iex> list = [%{name: "john", salary: 10}, %{name: "francine", salary: 30}]
iex> get_in(list, [Access.filter(&(&1.salary > 20)), :name])
["francine"]
```

[get_in/2](https://hexdocs.pm/elixir/1.15.7/Kernel.html#get_in/2)、[get_in/2](https://hexdocs.pm/elixir/1.15.7/Kernel.html#get_in/2)、[get_in/2](https://hexdocs.pm/elixir/1.15.7/Kernel.html#get_in/2)です！！！

# さいごに

[get_in/2](https://hexdocs.pm/elixir/1.15.7/Kernel.html#get_in/2)関数を紹介しました。

<iframe width="1028" height="578" src="https://www.youtube.com/embed/d0fk1Uzdlcs" title="主婦の掃除大抵コレやろ？【夫婦】【アニメ】" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

この動画をみて、「[get_in/2](https://hexdocs.pm/elixir/1.15.7/Kernel.html#get_in/2)、[get_in/2](https://hexdocs.pm/elixir/1.15.7/Kernel.html#get_in/2)、[get_in/2](https://hexdocs.pm/elixir/1.15.7/Kernel.html#get_in/2)」歌いたくなりました。


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
