---
title: IEx上でコマンドを実行する（Elixir）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-03-03T21:30:49+09:00'
id: 4643f1c5d4a609c773c0
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**あまつ風雲のかよひ路吹きとぢよをとめの姿しばしとどめむ**

Advent Calendar 2022 61日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

**[IEx](https://hexdocs.pm/iex/1.13/IEx.html)立ち上げた〜 > コマンド使いたい > もう一丁ターミナル立ち上げるか**
となることありませんか。
私はしょっちゅうあります。

そんなときにそのまま`IEx`上でコマンドを実行する方法をご紹介します。
`macOS Catalina 10.15.7`と`macOS Monterey 12.2.1`で確かめました。

[Elixir](https://elixir-lang.org/)でコマンドを実行する関数を使うわけです。

# What's [IEx](https://hexdocs.pm/iex/1.13/IEx.html)?

[IEx](https://hexdocs.pm/iex/1.13/IEx.html)というのは、

> Elixir's interactive shell.

です。

[Elixir](https://elixir-lang.org/)のプロジェクトのルートで、`iex -S mix`という形でよく使います。


# `mix format`したい

```elixir
iex> :os.cmd('mix format')
```

もしくは

```elixir
iex> System.cmd("mix", ["format"])
```

です。
ちなみに、私は前者のほうをよく使っています。

ドキュメントはここです。

- [:os.cmd](https://www.erlang.org/doc/man/os.html#cmd-1)
- [System.cmd/3](https://hexdocs.pm/elixir/System.html#cmd/3)

あとは同じ要領です。
その他、例をいくつか紹介しておきます。

# Finderを開きたい

```elixir
iex> :os.cmd('open .')  
```

もしくは

```elixir
iex> System.cmd("open", ["."])
```

# VS Codeを開きたい

```elixir
iex> :os.cmd('code .')  
```

もしくは

```elixir
iex> System.cmd("code", ["."])
```

参考: https://code.visualstudio.com/docs/setup/mac#_launching-from-the-command-line

ここに書いてあることをやって、`code`コマンドが使えるようにしています。


---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

今回は[IEx](https://hexdocs.pm/iex/1.13/IEx.html)上で、コマンドを実行する方法をご紹介しました。
ただ、[:os.cmd](https://www.erlang.org/doc/man/os.html#cmd-1)や[System.cmd/3](https://hexdocs.pm/elixir/System.html#cmd/3)を使っているだけのことです。

以上です。



---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)

---
