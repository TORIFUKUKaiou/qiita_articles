---
title: 闘魂Elixir ── paizaのC問題をElixirで闘魂注入しながら解くことを楽しむ
tags:
  - Elixir
  - paiza
  - 闘魂
  - AdventCalendar2024
  - paiza×Qiitaコラボキャンペーン
private: false
updated_at: '2024-09-27T13:40:48+09:00'
id: 966b71497f04c7fb5882
organization_url_name: haw
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>

:::note info
この記事は入賞（Amazonギフトカード500円分）した記事です。
Qiitaさん、paizaさんありがとうございます！
[paiza×Qiita記事投稿キャンペーン「プログラミング問題をやってみて書いたコードを投稿しよう！」受賞者発表！](https://zine.qiita.com/event/202409-paiza/)
:::

https://zine.qiita.com/event/202409-paiza/



https://qiita.com/official-events/9ab96aa95d62fe3cbdd7

# はじめに

本記事は、「[paiza×Qiita記事投稿キャンペーン「プログラミング問題をやってみて書いたコードを投稿しよう！」](https://qiita.com/official-events/9ab96aa95d62fe3cbdd7)」イベント記事です。

私は[Elixir](https://elixir-lang.org/)で楽しんでみます。

C問題をやってみます。

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

# [残り物の量](https://paiza.jp/works/mondai/c_rank_skillcheck_archive/leftover)

https://paiza.jp/works/mondai/c_rank_skillcheck_archive/leftover

問題はリンク先をご参照ください。

<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

単位を揃えたり、パーセントに注意したり、最後に割り算しているのが地味に誤差が小さくなっていいのかもしれません。
そこまでしなくてもいいのかもしれません。

```elixir
defmodule Main do
  def main("闘魂") do
    [m, p, q] =
        IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    r = m * 1000 * (100 - p) * (100 - q) / (1000 * 100 * 100)
    IO.puts(r)
  end
end

Main.main("闘魂")
```

</details>

# [Fizz Buzz](https://paiza.jp/works/mondai/c_rank_skillcheck_sample/fizz-buzz)

https://paiza.jp/works/mondai/c_rank_skillcheck_sample/fizz-buzz

問題はリンク先をご参照ください。

<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

入力の数値を3で割った余りと5で割った余りを求めます。`if`などで条件分岐せずに、関数のパターンマッチで解決してしまうのが[Elixir](https://elixir-lang.org/)らしいコードです。


```elixir
defmodule Main do
  def main("闘魂") do
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    1..n
    |> Enum.map(&FizzBuzz.say/1)
    |> Enum.join("\n")
    |> IO.puts()
  end
end

defmodule FizzBuzz do
  def say(n), do: do_say(rem(n, 3), rem(n, 5), n)

  defp do_say(0, 0, _n), do: "Fizz Buzz"
  defp do_say(0, _, _n), do: "Fizz"
  defp do_say(_, 0, _n), do: "Buzz"
  defp do_say(_, _, n), do: n
end


Main.main("闘魂")
```

</details>

# [みかんの仕分け](https://paiza.jp/works/mondai/c_rank_skillcheck_archive/mikan)

https://paiza.jp/works/mondai/c_rank_skillcheck_archive/mikan

問題はリンク先をご参照ください。

<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

さきほどの[Fizz Buzz](https://paiza.jp/works/mondai/c_rank_skillcheck_sample/fizz-buzz)の解き方と似ています。正解となったコードを貼り付けておきます。ローカルではインプット例から期待通りの結果を得るまでに、いろいろと試行錯誤していました。途中、勘違いすることも多かったです。インプット例から期待通りの結果は得られるようになったものの、考慮漏れしているケースがあるのではないかとビクビクしました。通ってよかったです。


```elixir
defmodule Main do
  def main("闘魂") do
    [n, m] =
        IO.read(:line) |> String.trim() |> String.split(" ") |> Enum.map(&String.to_integer/1)

    ws = for _ <- 1..m do
      IO.read(:line) |> String.trim() |> String.to_integer()
    end

    ws
    |> Enum.map(fn w -> Worker.work(w, n) end)
    |> Enum.join("\n")
    |> IO.puts()
  end
end

defmodule Worker do
  def work(w, n), do: do_work(div(w, n), rem(w, n), w, n)

  defp do_work(0, _r, _w, n), do: n
  defp do_work(d, 0, _w, n), do: d * n
  defp do_work(d, r, w, n) when w - d * n < d * n + n - w, do: d * n
  defp do_work(d, _r, _w, n), do: d * n + n
end


Main.main("闘魂")
```

</details>

# [野球の審判](https://paiza.jp/works/mondai/c_rank_skillcheck_archive/umpire)

https://paiza.jp/works/mondai/c_rank_skillcheck_archive/umpire

問題はリンク先をご参照ください。

<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

再帰で解いてみました。あとで気づきましたが、ストライクとボールのカウントを数える必要はありませんでした。問題の制約で最後の判定で、`out!`か`fourball!`かを決められるからです。カウントをまじめに数えることを想定してモジュールを作ってカウントしようとした名残があるコードです。


```elixir
defmodule Main do
  def main("闘魂") do
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    counts = for _ <- 1..n do
      IO.read(:line) |> String.trim()
    end

    Umpire.call(counts)
    |> Enum.join("\n")
    |> IO.puts()
  end
end

defmodule Umpire do
  def call(counts), do: do_call(counts, [])

  def do_call(["strike" | []], acc), do: acc ++ ["out!"]
  def do_call(["ball" | []], acc), do: acc ++ ["fourball!"]
  def do_call(["strike" | tail], acc), do: do_call(tail, acc ++ ["strike!"])
  def do_call(["ball" | tail], acc), do: do_call(tail, acc ++ ["ball!"])
end


Main.main("闘魂")
```

</details>

# [宝くじ](https://paiza.jp/works/mondai/c_rank_skillcheck_archive/lottery)

https://paiza.jp/works/mondai/c_rank_skillcheck_archive/lottery

問題はリンク先をご参照ください。

<details><summary>私の解答</summary>

_問題文を読んでいることを前提にひとこと解説をしておきます。_

関数のパターンマッチで解きました。[Elixir](https://elixir-lang.org/)のパターンマッチは上から順に評価されるので、より制約がきつい条件を上に書いておく必要があります。この問題の場合は、1等、前後賞、2等、3等、ハズレの順に書いていけば :ok: です。


```elixir
defmodule Main do
  def main("闘魂") do
    b = IO.read(:line) |> String.trim() |> String.to_integer()
    n = IO.read(:line) |> String.trim() |> String.to_integer()

    as = for _ <- 1..n do
      IO.read(:line) |> String.trim() |> String.to_integer()
    end

    as
    |> Enum.map(& Lottery.inquire(b, &1))
    |> Enum.join("\n")
    |> IO.puts()
  end
end

defmodule Lottery do
  def inquire(b, a) when b == a, do: "first"
  def inquire(b, a) when b - 1 == a or b + 1 == a, do: "adjacent"
  def inquire(b, a) when rem(b, 10000) == rem(a, 10000), do: "second"
  def inquire(b, a) when rem(b, 1000) == rem(a, 1000), do: "third"
  def inquire(_b, _a), do: "blank"
end

Main.main("闘魂")
```

</details>



# さいごに

[paiza](https://paiza.jp/)のC問題を解いてみました。
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

https://qiita.com/haw_ohnuma/items/dd329bc9c5da78967e7c

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
