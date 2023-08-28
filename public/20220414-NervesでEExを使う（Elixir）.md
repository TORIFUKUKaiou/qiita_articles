---
title: NervesでEExを使う（Elixir）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-04-14T23:22:56+09:00'
id: 644bb17cf51955b0847f
organization_url_name: fukuokaex
slide: false
---
**ゆらのとを渡る舟人かぢを絶え行くへも知らぬ恋の道かな**

Advent Calendar 2022 98日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

この記事は、[Elixir](https://elixir-lang.org/)でIoTを楽しめる[ナウでヤングでcool](https://speakerdeck.com/takasehideki/nerveshanaudeyangunacoolnasugoiyatu-for-soracom-ug)なフレームワークである[Nerves](https://www.nerves-project.org/)で[EEx](https://hexdocs.pm/eex/EEx.html)を使う方法をお知らせします。

https://speakerdeck.com/takasehideki/nerveshanaudeyangunacoolnasugoiyatu-for-soracom-ug

# [Nerves](https://www.nerves-project.org/)では標準では[EEx](https://hexdocs.pm/eex/EEx.html)は使えません

余計なものは極力省く[Nerves](https://www.nerves-project.org/)の思想でしょう。
[Nerves](https://www.nerves-project.org/)では標準では[EEx](https://hexdocs.pm/eex/EEx.html)は使えません。

```elixir
** (UndefinedFunctionError) function EEx.eval_file/2 is undefined (module EEx is not available)
```

# もちろんちょっとした設定で使えます

もちろんちょっとした設定をすることで使えます。

## 設定

`mix.exs`をちょっと書き換えるだけです。

```elixir:mix.exs
  def application do
    [
      mod: {HelloNerves.Application, []},
      extra_applications: [:logger, :runtime_tools, :eex] # :eexを追加
    ]
  end
```

## 使い方

たとえば、`priv/hoge/template.md`と配置しましょう。

```elixir:priv/hoge/template.md
<%= item_count %>
```

ソースコードは以下のように作ります。
`:code.priv_dir`を使うことで、ホスト(ローカルマシン)での開発、[Nerves](https://www.nerves-project.org/)上での実行ともにいい感じにパスを解決してくれます。

```elixir
template_path = "#{:code.priv_dir(:hello_nerves)}/hoge/template.md" # :hello_nerves はNervesアプリ名に置き換えてください
bindings = [item_count: 100]
EEx.eval_file(template_path, bindings)
```




# 動機

私は[Nerves](https://www.nerves-project.org/)アプリで、Qiitaの記事を自動で更新しています。
テンプレートに[EEx](https://hexdocs.pm/eex/EEx.html)を使いたいわけです。




---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:


この記事は、[Nerves](https://www.nerves-project.org/)で[EEx](https://hexdocs.pm/eex/EEx.html)を使う方法をお知らせしました。

[Nerves](https://www.nerves-project.org/)にデフォルトで入っている[nerves_motd](https://github.com/nerves-project/nerves_motd)の1st コミッターである @mnishiguchi さんのスペシャルサンクスでこの記事を書けました。
ありがとうございます！
この場をお借りして感謝を申し上げます。
<font color="purple">$\huge{Thank\ you\ very\ much.}$</font>


Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>


以上です。





---

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)

---

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">We appreciate this shoutout, Torifuku! <a href="https://t.co/dThmJg4CYN">pic.twitter.com/dThmJg4CYN</a></p>&mdash; ClickUp (@clickup) <a href="https://twitter.com/clickup/status/1513541411634913284?ref_src=twsrc%5Etfw">April 11, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 






