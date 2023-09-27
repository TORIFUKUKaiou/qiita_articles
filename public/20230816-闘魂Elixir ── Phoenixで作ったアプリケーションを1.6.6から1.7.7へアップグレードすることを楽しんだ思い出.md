---
title: 闘魂Elixir ── Phoenixで作ったアプリケーションを1.6.6から1.7.7へアップグレードすることを楽しんだ思い出
tags:
  - Elixir
  - Phoenix
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-09-15T08:28:53+09:00'
id: 9b31826be9788f1ce796
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
[Elixir](https://elixir-lang.org/)には、[Phoenix](https://www.phoenixframework.org/)というWebアプリケーションフレームワークがあります。  

その[Phoenix](https://www.phoenixframework.org/)を使って2年前に制作したアプリケーションがあります。  
2年前の制作当時、[Phoenix](https://www.phoenixframework.org/)の最新バージョンは1.6.2でした。  
それから幾星霜、月日が経つのは早いもので、[Phoenix](https://www.phoenixframework.org/)は1.7.7に上がっています。  

[Phoenix](https://www.phoenixframework.org/)のバージョンを1.6.2から1.7.7に上げたという語るも涙、聞くも涙の物語をお届けします。（前フリだけは、吾妻鏡なみに大げさに書いています）  

# 前提

[Elixir](https://elixir-lang.org/)、[Phoenix](https://www.phoenixframework.org/)のインストールは済ませておいてください。  
[Git](https://git-scm.com/)が使えるとスムーズに進みます。  
あとは[PostgreSQL](https://www.postgresql.org/)くらいです。たとえばDockerで以下のようにやると十分です。  

```bash
docker run -d --rm -p 5432:5432 -e POSTGRES_USER=postgres -e \
POSTGRES_PASSWORD=postgres postgres
```

# 参考プルリク

参考になるかもしれないし、ならないかもしれないプルリクを公開しておきます。  

https://github.com/TORIFUKUKaiou/slack_doorman/pull/7

---

# アップグレード

さてそろそろ本題に入ります。  
私流のアップグレード方法です。  

1. プロジェクトのルートで、`mix phx.new .`して同じファイルはとにかく上書きして進める
2. `git diff`や`git blame`を駆使して、手動マージする
3. `mix.lock`を消して、`mix deps.get`する
4. とにかく`mix phx.server`や`mix test`で動かしてみて、コンパイルエラーがでるところに対処する

こんな感じでやりました。  

## 1. プロジェクトのルートで、`mix phx.new .`して同じファイルはとにかく上書きして進める

[Phoenix](https://www.phoenixframework.org/)のバージョンがあがって最初に作られるファイルの内容が異なるからです。  
あとこれは今回の場合に特有の話ですが、最初に作ったときはデータベースを使う必要がなかったので`--no-ecto`オプションを付けて、`mix phx.new`していました。いまとなっては機能を追加したくその際にデータベースを使うようにしたかったので、初期設定を行ってくれる`mix phx.new`を実行しました。  

以下、愛と感動の物語は続きます。  
（筆者は一旦ここで筆をおきました。現実においてもまた改めて続きを書いています）  

## 2. `git diff`や`git blame`を駆使して、手動マージする

プロジェクト固有でいろいろあるとおもいます。自分で書き足した必要なものだけを厳選して手動でマージします。  
[Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code)の[Source Controll](https://code.visualstudio.com/docs/sourcecontrol/overview)ボタンを押して表示される画面が便利でした。

## 3. `mix.lock`を消して、`mix deps.get`する

`mix.exs`には必要なパッケージ（外部ライブラリ）を手動でマージしておきます。  
`mix deps.get`をする前に、念のため`mix.lock`を消してあたかもまっさらなところからはじめて`mix deps.get`することを現出させました。  

## 4. とにかく`mix phx.server`や`mix test`で動かしてみて、コンパイルエラーがでるところに対処する

いろいろありましたが、代表的なところを言うと`lib/<app_name>_web/views`ディレクトリと`test/<app_name>_web/views`ディレクトリの削除です。  
もともと1.6.2時代のプロジェクトで最初につくられたままの状態で触っていませんでした（`git blame`が便利です！）し、1.7.7で`mix phx.new`したときにはできないフォルダなので迷わず消して問題ないです。



---

# その他に得られた知見

その他に得られた知見を書いておきます。

## JSONのレンダリング

APIの応答でJSONを返すことにするときの実装です。  
1.7.7の公式ドキュメントはこのへんです。

https://hexdocs.pm/phoenix/json_and_apis.html

@piacerex さんからコメントをもらいました！
ありがとうーーーーッ!!! ございます。

https://qiita.com/torifukukaiou/items/9b31826be9788f1ce796#comment-63c31acc376a20469e3c

:point_up::point_up::point_up: **@piacerex さんからのコメントもあわせてご確認ください。** :point_up::point_up::point_up:


### 1.6.2

1.6.2時代は以下のように書いていました。

```elixir:lib/slack_doorman_web/controllers/event_controller.ex
defmodule SlackDoormanWeb.EventController do
  use SlackDoormanWeb, :controller

  def create(conn, params) do
    ...
    render(conn, "challenge.json", challenge: challenge)
  end
```

```elixir:lib/slack_doorman_web/views/event_view.ex
defmodule SlackDoormanWeb.EventView do
  use SlackDoormanWeb, :view

  def render("challenge.json", %{challenge: challenge}) do
    %{challenge: challenge}
  end
end
```

`lib/slack_doorman_web/views/event_view.ex`は先程申しました通り、1.7.7では作られないフォルダですので、1.7.7のプロジェクトにはありません。

### 1.7.7

1.7.7では以下のように変わります。

```elixir:lib/slack_doorman_web/controllers/event_controller.ex
defmodule SlackDoormanWeb.EventController do
  use SlackDoormanWeb, :controller

  def create(conn, params) do
    ...
    render(conn, :create, challenge: challenge)
  end
```

```elixir:lib/slack_doorman_web/controllers/event_json.ex
defmodule SlackDoormanWeb.EventJSON do
  def create(%{challenge: challenge}) do
    %{challenge: challenge}
  end
end
```

`EventController`モジュールに対応するように`EventJSON`モジュールという名前のモジュールを[Phoenix](https://www.phoenixframework.org/)は期待しています。  


## assets/vendor 配下に多くのファイル(.svg)が追加されています

記事を書くにあたり[プルリク](https://github.com/TORIFUKUKaiou/slack_doorman/pull/7)を見直していると、変更ファイル数が900を超えていることに気づきました。  
なぜそんなに多いのだとよくみると、`assets/vendor`配下に多くのファイル(.svg)が追加されていました。  
1.7.7はアイコンが最初から多く追加されます。  

## mix phx.release.gen --docker

https://qiita.com/torifukukaiou/items/1c006187440d50af89ca

別の記事を作りました。ご参照くださいませ。  


---

# さいごに

Phoenixで作ったアプリケーションを1.6.6から1.7.7へアップグレードすることを楽しみました。  
プロジェクトのルートで`mix phx.new .`して、あとは[Git](https://git-scm.com/)を駆使してがんばりますということを書いています。  
[app:update](https://railsguides.jp/upgrading_ruby_on_rails.html#%E3%82%A2%E3%83%83%E3%83%97%E3%83%87%E3%83%BC%E3%83%88%E3%82%BF%E3%82%B9%E3%82%AF)とかありませんので、もしあなたが提供してくださったらヒーローです。  
I need a heroです！

<iframe width="948" height="533" src="https://www.youtube.com/embed/a7EPybpQcS0" title="Holding Out For A Hero/ヒーロー [日本語訳・英詞付き]　ボニー・タイラー" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>

この記事がどなたかのお役に立てますことを切に願っております。  


---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
