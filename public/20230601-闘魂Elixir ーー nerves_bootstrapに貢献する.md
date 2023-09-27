---
title: 闘魂Elixir ーー nerves_bootstrapに貢献する
tags:
  - Elixir
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-06-03T22:23:25+09:00'
id: e903ed0e70846417f19c
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

[nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)に貢献する方法を書きます。

ポイントは、[Local development](https://github.com/nerves-project/nerves_bootstrap/tree/690a03038d1866d7babea2a85c3ced3c7fb7f49d#local-development)です。
つまり、`mix do deps.get, archive.build, archive.install`です。

# What's [nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)?

さて、「はじめに」はなんだかさっぱりわからないですよね。

[nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)の前提知識として[Nerves](https://nerves-project.org/)を説明します。

[Nerves](https://nerves-project.org/)とは、[Elixir](https://elixir-lang.org/)でIoTを楽しめる開発フレームワーク兼[Elixir](https://elixir-lang.org/)専用OSと言って過言でもないものがあります。
[Nerves](https://nerves-project.org/)の[インストール](https://hexdocs.pm/nerves/installation.html)を済ませると、`mix nerves.new`という[Nerves](https://nerves-project.org/)のアプリケーションを初期化してくれるMixタスクが手に入ります。
Mixタスク`mix nerves.new`は、[nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)にあらかじめ用意されているテンプレートファイルをもとにプロジェクトの雛形を作ります。

# 動機

[nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)のテンプレートを変更したくなるときがあります。
たとえば顕著なものとしては、`mix nerves.new`で作った直後のプロジェクトで`mix format`をしたときに整形されるファイルがあるときです。
最初っから`mix format`されていればうれしいなあという次第です。

# 変更

そういうこときは、[nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)プロジェクト内の`templates/new/`配下のファイルをさわればよいです。

# 動作確認

変更したら動作確認せずにはいられません。動作確認せずにプルリクエストを出せるのはよっぽどの自信家です。
手元で変更した[nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)をインストールするにはどうしたらよいでしょうか。

そのときに参考にするのが、[Local development](https://github.com/nerves-project/nerves_bootstrap/tree/690a03038d1866d7babea2a85c3ced3c7fb7f49d#local-development)です。

```
mix do deps.get, archive.build, archive.install
```

手元で変更した[nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)をインストールしておいて、`mix nerves.new`で新規プロジェクトを作って確かめるという寸法です。

# 私の実績

私の[nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)の実績を披瀝しておきます。
過去3回プルリクエストを送ってすべてマージしてもらえました :tada::tada::tada:

- https://github.com/nerves-project/nerves_bootstrap/pull/163
- https://github.com/nerves-project/nerves_bootstrap/pull/266
- https://github.com/nerves-project/nerves_bootstrap/pull/267

あなたもなにか見つけたらぜひプルリクエストをしたためて送ってみてはいかがでしょうか。

---

# さいごに

[nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)に貢献する方法を書きました。
動作確認方法を書きました。

# おまけ

もしかしたらこの手の初期プロジェクトにおける`mix format`の微修正は、プルリクエスト「[do mix format in doing mix nerves.new](https://github.com/nerves-project/nerves_bootstrap/pull/270)」が採用されたらもう不要となるかもしれません。

**追記**

プルリクは採用されました。
アイデアとしては、`mix nerves.new`の最後で新しく作ったプロジェクトに対して`mix format`しちゃうというアイデアです。


---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
