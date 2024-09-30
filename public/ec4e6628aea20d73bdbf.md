---
title: 闘魂Elixir ── paizaのD問題をElixirで闘魂注入しながら解くことを楽しむ
tags:
  - Elixir
  - paiza
  - 闘魂
  - AdventCalendar2024
  - paiza×Qiitaコラボキャンペーン
private: false
updated_at: '2024-08-17T16:59:11+09:00'
id: ec4e6628aea20d73bdbf
organization_url_name: haw
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>



https://qiita.com/official-events/9ab96aa95d62fe3cbdd7

# はじめに

本記事は、「[paiza×Qiita記事投稿キャンペーン「プログラミング問題をやってみて書いたコードを投稿しよう！」](https://qiita.com/official-events/9ab96aa95d62fe3cbdd7)」イベント記事です。

私は[Elixir](https://elixir-lang.org/)で楽しんでみます。

まずは基本のD問題をやってみます。

# 参考にした記事

@RyoWakabayashi さんの記事を参考にしました。

https://qiita.com/RyoWakabayashi/items/7e65bd490677e069c54b

[AtCoder](https://atcoder.jp/)を[Elixir](https://elixir-lang.org/)で解く場合は、`Main.main/0`関数をエントリーポイントとして提出する必要があります。

[paiza](https://paiza.jp/)の場合はどうするのだろう？　と、そこを一番気にしました。

自由でした。モジュールなしでもよさげで、モジュールを作った場合はそのエントリーポイントを一番最後に書いておけばよいようです。

私は、**闘魂**を注入することにしたいと思います。
どういう意味なのかは、私の回答例をぜひ見てみてください。

また競技プログラミングですので入力の読み取り方は以下の記事を参考にしました。

https://zenn.dev/torifukukaiou/articles/ac84c87736ceebf4da01

# [N倍の文字列](https://paiza.jp/works/mondai/d_rank_skillcheck_archive/square)

https://paiza.jp/works/mondai/d_rank_skillcheck_archive/square

問題はリンク先をご参照ください。

<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

[String.duplicate/2](https://hexdocs.pm/elixir/String.html#duplicate/2)で文字列を複製しています。


```elixir
defmodule Main do
  def main("闘魂") do
    n = IO.read(:line) |> String.trim() |> String.to_integer()
    
    String.duplicate("*", n)
    |> IO.puts()
  end
end

Main.main("闘魂")
```

</details>

# [Eメールアドレス](https://paiza.jp/works/mondai/d_rank_skillcheck_archive/email_address)

https://paiza.jp/works/mondai/d_rank_skillcheck_archive/email_address

問題はリンク先をご参照ください。

<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

文字列の埋め込み（`#{}`）を利用しました。公式ドキュメントは以下です。

https://hexdocs.pm/elixir/1.17.2/String.html#module-interpolation


```elixir
defmodule Main do
  def main("闘魂") do
    s = IO.read(:line) |> String.trim()
    t = IO.read(:line) |> String.trim()
    
    "#{s}@#{t}"
    |> IO.puts()
  end
end

Main.main("闘魂")
```

</details>

# [足し算](https://paiza.jp/works/mondai/d_rank_skillcheck_sample/addition)

https://paiza.jp/works/mondai/d_rank_skillcheck_sample/addition

問題はリンク先をご参照ください。

<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

足し算の基本的な問題です。

```elixir
defmodule Main do
  def main("闘魂") do
    [a, b] =
      IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)
    
    (a + b)
    |> IO.puts()
  end
end

Main.main("闘魂")
```



</details>

# [一番小さい値](https://paiza.jp/works/mondai/d_rank_skillcheck_sample/min_num)

https://paiza.jp/works/mondai/d_rank_skillcheck_sample/min_num

問題はリンク先をご参照ください。

<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_


[Enum.min/3](https://hexdocs.pm/elixir/Enum.html#min/3)関数で一発ですね。


```elixir
defmodule Main do
  def main("闘魂") do
    list = for _ <- 1..5 do
      IO.read(:line) |> String.trim() |> String.to_integer()
    end

    list
    |> Enum.min()
    |> IO.puts()
  end
end

Main.main("闘魂")
```



</details>


# [文字の一致](https://paiza.jp/works/mondai/d_rank_skillcheck_sample/diff_str)

https://paiza.jp/works/mondai/d_rank_skillcheck_sample/diff_str

問題はリンク先をご参照ください。

<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

関数の引数のパターンマッチで解きました。


```elixir
defmodule Main do
  def main("闘魂") do
    a = IO.read(:line) |> String.trim()
    b = IO.read(:line) |> String.trim()

    do_solve(a, b, "闘魂")
    |> IO.puts()
  end

  def do_solve(a, a, "闘魂"), do: "OK"
  def do_solve(a, b, "闘魂"), do: "NG"
end

Main.main("闘魂")
```



</details>

# さいごに

[paiza](https://paiza.jp/)のD問題を解いてみました。
基礎的な問題でした。

コード提出後のチェック画面はかわいらしいアニメーションが表示されて、解いていて楽しいです。

![スクリーンショット 2024-08-09 19.27.48.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a8beb4fc-de99-6389-5e99-5db07adcbfb2.png)

他の問題もぜひ解いてみたいと思います。

ところで、**闘魂注入**の意味はわかりましたか！？

<details><summary>「闘魂注入」の意味</summary>

**闘魂** をエントリーポイントの第1引数に入れないと動かないようにしています。文字列は **闘魂** である必要があります。関数の引数でパターンマッチをしているので。
</details>

---

@haw_ohnuma さんのRustでの解答例です。こちらの記事もぜひご覧になってください。

https://qiita.com/haw_ohnuma/items/12baf9f9d2a640f043c9


---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
