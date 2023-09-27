---
title: 闘魂Elixir ── ANSIエスケープコードをElixirの出力で使う（コンソールの出力を上書きする）
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-02-12T12:10:44+09:00'
id: e3af576e8a1b20ab7110
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

**闘魂**と[Elixir](https://elixir-lang.org/)が出会いました。
**闘魂** meets [Elixir](https://elixir-lang.org/).です。
[Elixir](https://elixir-lang.org/) meets **闘魂**.でもよいです。

https://qiita.com/torifukukaiou/items/4f7f5aaafa0de517b1bd

この記事を書くにあたって使ったテクニックを特出しして記事にしておきます。


```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

この記事は、もくもく会イベント **[autoracex #177](https://autoracex.connpass.com/event/271822/)** の成果です。

# 対象とする読者

プログラミングを楽しんでいるそこの**あなた**。
特に、「**[闘魂プログラミング（ストロングスタイル）](https://qiita.com/torifukukaiou/items/c414310cde9b7099df55)**」を楽しんでいるそこの**あなた**。
「**わたしが長年夢であった本当の Elixirを通じて プログラミングを通じて 世界平和(を)必ず実現します！**」に共感していただけるそこの**あなた**。

つまりは
<b><font color="blue">$\huge{全人類}$</font></b>
です。

<b><font color="green">$\huge{For　You　All}$</font></b>
です。

# ANSIエスケープコードとは

こちらの記事を参照してください。

https://www.mm2d.net/main/prog/c/console-02.html

ありがとうございます！
ありがとうございます！
ありがとうございます！

いろいろと使いみちはあるのだとおもいます。
私はコンソールの出力を上書きすることで使ってみたいとおもっています。

# コンソールの出力を上書きする

「コンソールの出力を上書きする」とはこういうことです。

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/43b2a4f4-d5d4-0c8f-40ed-709f04460ecd.gif)


他には進捗プログレスの表示などに使えそうです。

# コード例

さきほどのアニメーションGIFのコードを示します。

```elixir
words = ~w(闘 魂 猪 木 燃 🔥)

f = fn ->
  for _i <- 1..5 do
    for _j <- 1..5 do
      Enum.random(words)
    end
    |> Enum.join()
  end
  |> Kernel.++(["\e[5A"])
  |> Enum.join("\n")
end

print = fn
  lines, 100 -> lines |> String.slice(0..28) |> IO.puts()
  lines, _ -> IO.write(lines)
end

1..100
|> Enum.each(fn i ->
  Process.sleep(50)

  f.()
  |> print.(i)
end)
```

`ESC[nA`（カーソルを上にn移動させる。(nには整数が入る、省略すると1)）を使っています。
[Elixir](https://elixir-lang.org/)のプログラムでは、`"\e[5A"`のところです。
今回は5行出力しているので上に5行移動させることにしています。


---

# おまけ

```elixir
words = ~w(闘 魂 猪 木 燃 🔥)

f = fn ->
  for _i <- 1..5 do
    for _j <- 1..5 do
      Enum.random(words)
    end
  end
end

print = fn
  lines, :halt -> lines |> String.slice(0..28) |> IO.puts()
  lines, :cont -> IO.write(lines)
end

Stream.iterate(0, &(&1 + 1))
|> Enum.reduce_while(0, fn i, _acc ->
  Process.sleep(1)

  lines = f.()
  Enum.at(lines, 2)

  halt_or_cont =
    if Enum.at(lines, 2) == ~w(燃 闘 魂 猪 木) do
      :halt
    else
      :cont
    end

  lines
  |> Enum.map(&Enum.join/1)
  |> Kernel.++(["\e[5A"])
  |> Enum.join("\n")
  |> print.(halt_or_cont)

  {halt_or_cont, i}
end)
|> IO.puts()
```

3行目に「燃える闘魂アントニオ猪木」 = **燃闘魂猪木** が並ぶまで繰り返してみました。

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c33f6a59-c466-6634-b06f-64fdfc655ed1.gif)

上のアニメーションGifでは`6541`と表示されたときに、 **燃闘魂猪木** が3行目に並んでいます。

---

# さいごに

この記事では、「コンソールの出力を上書きする」ことを[Elixir](https://elixir-lang.org/)で行う例を示しました。


**闘魂**とは、 **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

<font color="red">$\huge{１、２、３ ぁっダァー！}$</font>


<iframe width="910" height="512" src="https://www.youtube.com/embed/AWxwmqzbOaw" title="燃える闘魂 アントニオ猪木  追悼VTR" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



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
