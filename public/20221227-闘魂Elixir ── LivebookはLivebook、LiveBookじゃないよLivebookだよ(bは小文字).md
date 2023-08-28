---
title: 闘魂Elixir ── LivebookはLivebook、LiveBookじゃないよLivebookだよ(bは小文字)
tags:
  - Elixir
  - 猪木
  - Livebook
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2022-12-27T09:01:15+09:00'
id: e9632a68b3207b7f85ba
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

# はじめに

闘魂と[Elixir](https://elixir-lang.org/)が出会いました。
闘魂 meets [Elixir](https://elixir-lang.org/).です。
[Elixir](https://elixir-lang.org/) meets 闘魂.でもよいです。

私は @kaizen_nagoya さんに感化されて2022-12-26から、[AdventCalendar2023](https://qiita.com/tags/adventcalendar2023)を書いています。

https://qiita.com/kaizen_nagoya/items/fbadf32881d48c6c6537

[私のアドベントカレンダー](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)一覧は、[コチラ](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=156122552)です。

**だれよりも2023/12/25を楽しみにしています。**

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}
```

---

# [Livebook](https://livebook.dev/)は[Livebook](https://livebook.dev/)

[Livebook](https://livebook.dev/)は[Livebook](https://livebook.dev/)です。
何を言っているかわかりますかね。
表記の話です。

https://livebook.dev/

誤: LiveBook
正: [Livebook](https://livebook.dev/)

たいていの場合[Elixir](https://elixir-lang.org/)界では、モジュール名は公式ドキュメントの[Casing](https://hexdocs.pm/elixir/naming-conventions.html#casing)によるとCamelCaseでして、`LiveBook`と書きたくなる氣持ちはわかります。私も当初勘違いしていました。まだ自分の記事の中にも修正しきれていない記事が残っているかもしれません。
他の方が`LiveBook`と書いていらっしゃるのに気づいたら、できるだけ編集リクエストを送ることにしています。たいていのみなさんは快く採用してくださっています。ありがとうございます。この場をお借りして、御礼申し上げます。

# [Livebook](https://livebook.dev/)とは

イメージ的には、Pythonの[Jupyter](https://jupyter.org/)に相当するものです。

[Jupyter](https://jupyter.org/)をご存知ではない、うーんそうですね、下記から簡単に[Livebook](https://livebook.dev/)を動かせますので触ってみてください。

https://livebook.dev/

# @RyoWakabayashiさんに注目

@RyoWakabayashiさんが、[Livebook](https://livebook.dev/)を使った有益なサンプルコラムをたくさん掲げられています。
ご本人も「[Livebook](https://livebook.dev/)が楽しい」と発言されていました。

特に代表作はこちらの記事です。

https://qiita.com/RyoWakabayashi/items/7d9eff9df1041c705713#%E7%94%BB%E5%83%8F%E5%87%A6%E7%90%86

[Livebook](https://livebook.dev/)公式の動画で取り上げられています。

<iframe width="1566" height="605" src="https://www.youtube.com/embed/lyiqw3O8d_A" title="What's new in Livebook 0.7" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

@RyoWakabayashiさんの記事、@RyoWakabayashiさんご本人にも注目です。


---

# さいごに

[Livebook](https://livebook.dev/)の表記に関する注意喚起でした。
大文字は最初の`L`だけです。

---

プロレスを通じて、スポーツを通じて、真の世界平和の実現を訴え続けられた、アントニオ猪木さんのご冥福をお祈りします。

闘魂の意味は、 **「己に打ち克つこと、そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

<font color="red">$\huge{１、２、３ ぁっダー！}$</font>


<iframe width="910" height="512" src="https://www.youtube.com/embed/AWxwmqzbOaw" title="燃える闘魂 アントニオ猪木  追悼VTR" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

https://www.youtube.com/watch?v=FSz7N5hCltw

---

https://qiita.com/torifukukaiou/items/5e96f4e9f12ec3c4b3f4

https://qiita.com/torifukukaiou/items/b6361f98194f3687a13c

https://qiita.com/torifukukaiou/items/4c35ace6db3f02ac3897

https://qiita.com/torifukukaiou/items/17d55cf896c24b13350e



---



---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダー！}$</font></b>
