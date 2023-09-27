---
title: >-
  闘魂Elixir ーー
  取り込みたいHex(パッケージ／ライブラリ)がponchoプロジェクトでGitリポジトリにある場合に特定のディレクトリのみを取り込みたい
tags:
  - Elixir
  - Nerves
  - 猪木
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-07-29T09:54:16+09:00'
id: cebf4729fb4368a68d8a
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

[Elixir](https://elixir-lang.org/)という素敵な関数型言語の話です。
[Elixir](https://elixir-lang.org/)のパッケージ（ライブラリ）は[Hex](https://hex.pm/)と呼ばれています。
パッケージ（ライブラリ）の取り込み方のオプションは、`mix help deps`で確認できます。

取り込みたい[Hex](https://hex.pm/)がponchoプロジェクトでGitリポジトリにある場合に特定のディレクトリ（つまりは[Hex](https://hex.pm/))のみを取り込みたいということが私にはありました。
他の人もそういうことがあるかもしれないので紹介しておきます。
そんなことをしたくなるのは、ほぼほぼ[Nerves](https://nerves-project.org/)界隈の人だろうと想像されます。
だってponchoプロジェクトなのですもの。

追記: 取り込みたい対象のHexが[Umbrella Projects](https://elixirschool.com/ja/lessons/advanced/umbrella_projects)に含まれている場合でも同じことをしたくなることがあるかもしれません。


# 取り込み例

こんな感じです。
TSL2561という光測定ができる部品の[Hex](https://hex.pm/)を取り込んでいます。

```elixir:mix.exs
  def deps do
    ...
    {:tsl2561,
       git: "https://github.com/NervesJP/sensor_hub_poncho.git",
       subdir: "tsl2561",
       targets: @all_targets},
  end
```

ポイントは`:subdir`オプションです。これでディレクトリを特定します。
`:subdir`オプションは[Elixir](https://elixir-lang.org/)のv1.13以上で使えます。
フルチェックアウトします。

v1.13未満でも使えるオプションは、`:sparse`オプションです。
こちらは[git-sparse-checkout](https://git-scm.com/docs/git-sparse-checkout)というGitのEXPERIMENTAL機能を使っているそうです。
[git-sparse-checkout](https://git-scm.com/docs/git-sparse-checkout)とは、


![スクリーンショット 2023-06-29 23.35.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/75abe2ac-63ed-210c-1ad7-68d24a36dd9f.png)


なのだそうです。


---

# さいごに

取り込みたい[Hex](https://hex.pm/)がGitHubにあり、しかもponchoプロジェクトであるため、特定のディレクトリ（つまりは[Hex](https://hex.pm/))のみを取り込む方法を紹介しました。
`:subdir`オプションか`:sparse`オプションを使います。

あー、最後に気づきましたが[Umbrella Projects](https://elixirschool.com/ja/lessons/advanced/umbrella_projects)でも同じことをしたくなることがあるかもしれません。

---


**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
