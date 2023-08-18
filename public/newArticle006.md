---
title: 闘魂Elixir ── OptionParserを楽しむ
tags:
  - Elixir
  - AdventCalendar2023
  - optionparser
  - 闘魂
private: false
updated_at: '2023-08-18T22:17:51+09:00'
id: 2409383eb86ac062842a
organization_url_name: fukuokaex
slide: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>
# はじめに

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があります。  
[OptionParser](https://hexdocs.pm/elixir/OptionParser.html)について書きます。  

# [OptionParser](https://hexdocs.pm/elixir/OptionParser.html) とは?

> Functions for parsing command line arguments.
です。

たとえば、  
`/broadcast --channel autoracex --channel general --channel awesome We are the Alchemists, my firends!!!`
というコマンドを作るとします。
Slackの[Slash Command](https://api.slack.com/interactivity/slash-commands)をイメージしていただくとよいでしょう。  
仕様は以下の通りとします。

- チャンネル「#autoracex」、「#general」、「#awesome」という3つのチャンネルに同じ内容のメッセージを送る（同報する）
- 投稿するメッセージの内容は上記のコマンド例では「We are the Alchemists, my firends!!!」

「--channel autoracex --channel general --channel awesome We are the Alchemists, my firends!!!」を上の仕様に合うようにparseする必要があります。  
そんなときに使うのが[OptionParser](https://hexdocs.pm/elixir/OptionParser.html)です。  

[Elixir](https://elixir-lang.org/)以外の他のプログラミング言語でもこういうものは、たいてい _OptionParser_ と呼ぶようです。  

使い方については次の記事が詳しいです。  

https://qiita.com/mnishiguchi/items/6c43ace25d04ab2d5e84

ここで記事を終えてもよいところです。  
上記の内容を理解できていることを前提にもう少し話を続けます。  

# [:keep](https://hexdocs.pm/elixir/OptionParser.html#parse/2-modifiers)

https://hexdocs.pm/elixir/OptionParser.html#parse/2-modifiers

`--channel`は複数受け取るようにしたいです。そんなときに使うのが`:keep`です。  

使い方と動作例を示します。  
この記事ではDockerを使います。  

まずはHost(開発マシン)でElixirのコンテナを立ち上げます。  

```bash
❯ docker pull elixir:1.15.4-otp-25-alpine
❯ docker run --rm -it elixir:1.15.4-otp-25-alpine sh
```

Dockerコンテナの中での作業です。  

```bash
❯ cat <<-EOF > ./broadcast.exs
  System.argv()
  |> OptionParser.parse(
    strict: [
      channel: :keep
    ]
  )
  |> IO.inspect()
EOF

❯ elixir broadcast.exs --channel autoracex --channel general --channel awesome We are the Alchemists, my firends!!!
{[channel: "autoracex", channel: "general", channel: "awesome"],
 ["We", "are", "the", "Alchemists,", "my", "firends!!!"], []}
```

ただしくparseできています。  
キーワードリスト`[channel: "autoracex", channel: "general", channel: "awesome"]`から`:channel`の値(values)を取り出すには、[Keyword.get_values/2](https://hexdocs.pm/elixir/Keyword.html#get_values/2)を使います。  
この例のように、キーワードリストは同じキーで複数の値を持つことができます。  

```elixir
Keyword.get_values([channel: "autoracex", channel: "general", channel: "awesome"], :channel)
# => ["autoracex", "general", "awesome"]
```



# [:aliases](https://hexdocs.pm/elixir/OptionParser.html#parse/2-aliases)

https://hexdocs.pm/elixir/OptionParser.html#parse/2-aliases

`--channel`は長くてコマンドを打つのが嫌になりそうです。せっかく作ったコマンドですからたくさん使ってもらいたいです。  
省略形の`-c`もサポートすることにします。  
簡単です。`:aliases`を使えばよいです。

こんな感じです。猪木寛至です。猪木さんです。  

```bash
❯ cat <<-EOF > ./broadcast.exs
  System.argv()
  |> OptionParser.parse(
    strict: [
      channel: :keep
    ],
    aliases: [c: :channel]
  )
  |> IO.inspect()
EOF

❯ elixir broadcast.exs -c autoracex -c general -c awesome We are the Alchemists, my firends!!!
{[channel: "autoracex", channel: "general", channel: "awesome"],
 ["We", "are", "the", "Alchemists,", "my", "firends!!!"], []}
```

# さいごに

この記事は、[Elixir](https://elixir-lang.org/)の[OptionParser](https://hexdocs.pm/elixir/OptionParser.html)について書きました。特に`:keep`と`:alias`の使用例にフォーカスしています。  

[OptionParser](https://hexdocs.pm/elixir/OptionParser.html)を基礎から知りたい人には次の記事をおすすめしておきます。  

https://qiita.com/mnishiguchi/items/6c43ace25d04ab2d5e84

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>

