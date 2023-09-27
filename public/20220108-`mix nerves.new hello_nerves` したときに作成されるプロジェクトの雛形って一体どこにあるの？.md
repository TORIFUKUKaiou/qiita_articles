---
title: '`mix nerves.new hello_nerves` したときに作成されるプロジェクトの雛形って一体どこにあるの？'
tags:
  - Elixir
  - Nerves
  - autoracex
private: false
updated_at: '2022-01-11T01:15:39+09:00'
id: 1fcf2458dc8fb23404cf
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**one for all, all for one**

Advent Calendar 2022 11日目[^1]の記事です。
I'm ready for 12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I'm looking forward to  12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Nerves](https://www.nerves-project.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)の話をします。

# `mix nerves.new hello_nerves` したときに作成されるプロジェクトの雛形って一体どこにあるの？

気になったことがある方はいらっしゃいませんか？

2022/01/08 22:57現在、[ココ](https://github.com/nerves-project/nerves_bootstrap/tree/main/templates/new)にあります。

https://github.com/nerves-project/nerves_bootstrap/tree/main/templates/new

@mnishiguchi さん、即答でした :rocket::rocket::rocket:
すばらしい :tada::tada::tada:
感謝、感激です！！！

# [Nerves](https://www.nerves-project.org/)のバージョン追従はどうやるのがいいの？

**ナウでヤングでcool**でおなじみの[Nerves](https://www.nerves-project.org/)のバージョンがあがると、`mix nerves.new hello_nerves` をしたときに作成されるプロジェクトの雛形が変更されます。

どうやって自身のプロジェクトに取り込んで行くのがよいでしょうか。
私は、プロジェクトのルートにて

```bash
$ mix archive.install hex nerves_bootstrap
$ mix nerves.new .
```

としております。
細かいことは気にせずにこれが手っ取り早いかなあとおもっています。
とりあえず、Overrideに`Y`と元気よく答えて、`git diff`で差分をみながらどうするか決めるというやり方です。

`mix hex.outdated`というコマンドで一旦どんな状態なのか確認することができます。
@pojiroさんに教えてもらいました。

そももそも、`mix nerves.new hello_nerves` したときの雛形はどこにあるのでしょうか？　という疑問が生じまして、「[NervesJP #22 新年LT回](https://nerves-jp.connpass.com/event/234191/)」にて聞いた(|> きいた |> Qiita)内容をまとめた。

Qiitaは私の外部記憶装置です。いつもありがとうございます。

「[NervesJP #22 新年LT回](https://nerves-jp.connpass.com/event/234191/)」の模様は以下にまとめています。

https://qiita.com/torifukukaiou/items/d9f2a675c76c4962541c


# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
Enjoy [Nerves](https://www.nerves-project.org/):bangbang::bangbang::bangbang:
 
`mix nerves.new hello_nerves` したときに作成されるプロジェクトの雛形は、[ココ](https://github.com/nerves-project/nerves_bootstrap/tree/main/templates/new)にあります。

2022年に流行る技術予想 ーー それは、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)です:rocket::rocket::rocket:

---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)
