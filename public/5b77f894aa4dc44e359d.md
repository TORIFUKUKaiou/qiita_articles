---
title: wren-livebook を動かすことを楽しむ
tags:
  - Elixir
  - wren
  - 40代駆け出しエンジニア
  - Livebook
  - AdventCalendar2022
private: false
updated_at: '2022-11-16T20:32:39+09:00'
id: 5b77f894aa4dc44e359d
organization_url_name: fukuokaex
slide: false
---
# はじめに

私は[Elixir](https://elixir-lang.org/)というプログラミング言語が好きです。
好きが高じて、[autoracex](https://autoracex.connpass.com/)というコミュニティを作りました。

海外からも参加してくださる方がいらっしゃいます。
そんな中のお一人、[Camilo](https://github.com/clsource)さんの[ElixirCL/wren-livebook](https://github.com/ElixirCL/wren-livebook)を動かすことを楽しみます。

[ElixirCL/wren-livebook](https://github.com/ElixirCL/wren-livebook)は、[wren](https://wren.io/)というプログラミング言語を[Livebook](https://livebook.dev/)の上でSmart cellを使って動かしちゃうというものです。


# What is [wren](https://wren.io/) ?

https://wren.io/

私ははじめて知りました。

> Wren is a small, fast, class-based concurrent scripting language
> Think Smalltalk in a Lua-sized package with a dash of Erlang and wrapped up in a familiar, modern syntax.

なんだかスゴそう！　速そうです:rocket::rocket::rocket:

```wren
System.print("Hello, world!")

class Wren {
  flyTo(city) {
    System.print("Flying to %(city)")
  }
}

var adjectives = Fiber.new {
  ["small", "clean", "fast"].each {|word| Fiber.yield(word) }
}

while (!adjectives.isDone) System.print(adjectives.call())
```

# 動かしてみます

https://github.com/ElixirCL/wren-livebook

リポジトリのポイントは次の２点です。

- Livebookで動かせる `wren.livemd` があります
- `bin/`以下に`wren`の実行コマンド（バイナリ）が入っています（電池付き :battery: )

[Docker](https://www.docker.com/)を使います。

```
git clone https://github.com/ElixirCL/wren-livebook.git

cd wren-livebook

docker run -p 8080:8080 -p 8081:8081 --pull always -u $(id -u):$(id -g) -v $(pwd):/data livebook/livebook
```

ブラウザで、迷わずアクセスしてください。
Visit: http://0.0.0.0:8080/?token=mymb5cototlctb5osmvxrybirqfqwkcd

※ `token`の値は都度変わりますので、ターミナルに表示された通りの値を使ってください。

あとは、[wren.livemd](https://github.com/ElixirCL/wren-livebook/blob/main/wren.livemd)をOpenしてポチポチです。
`@current @macos` を `@current @unix`に変更するのみで、[Docker](https://www.docker.com/)コンテナ上で動きます。

動画を撮っておきました。

<iframe width="1005" height="565" src="https://www.youtube.com/embed/scuaTzuX7wQ" title="wren livebook" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


# 気づいたこと

すべてを理解したわけではありません。
私の関心がおもむいたところを３点紹介しておきます。

- ①独自Smart Cell
- ②`#{Wren.path()} #{path}`
- ③`trap "rm -f #{path}" 0 2 3 15`

## ①独自Smart Cell

独自にSmart Cellが作れるようです。
詳しくはよくわかっていませんが、関係ありそうなところを https://raw.githubusercontent.com/ElixirCL/wren-livebook/main/wren.livemd から抜き出しておきます。

```elixir
defmodule KinoGuide.WrenCell do
  use Kino.JS
  use Kino.JS.Live
  use Kino.SmartCell, name: "Wren script"

  @impl true
  def init(_attrs, ctx) do
    {:ok, ctx, editor: [attribute: "source", language: "javascript"]}
  end

  @impl true
  def handle_connect(ctx) do
    {:ok, %{}, ctx}
  end

  @impl true
  def to_attrs(_ctx) do
    %{}
  end

  @impl true
  def to_source(attrs) do
    quote do
      path = Temp.path!()
      File.write!(path, unquote(attrs["source"]))

      System.shell(
        """
        trap "rm -f #{path}" 0 2 3 15
        #{Wren.path()} #{path}
        """,
        into: IO.stream(),
        stderr_to_stdout: true
      )
      |> elem(1)
    end
    |> Kino.SmartCell.quoted_to_string()
  end

  asset "main.js" do
    """
    export function init(ctx, payload) {
      ctx.importCSS("main.css");

      root.innerHTML = `
        <div class="app">
          Wren script
        </div>
      `;
    }
    """
  end

  asset "main.css" do
    """
    .app {
      padding: 8px 16px;
      border: solid 1px #cad5e0;
      border-radius: 0.5rem 0.5rem 0 0;
      border-bottom: none;
    }
    """
  end
end

Kino.SmartCell.register(KinoGuide.WrenCell)
```

```html
<!-- livebook:{"attrs":{"source":"System.print(\"Hello, world!\")\n\nclass Wren {\n  flyTo(city) {\n    System.print(\"Flying to %(city)\")\n  }\n}\n\nvar adjectives = Fiber.new {\n  [\"small\", \"clean\", \"fast\"].each {|word| Fiber.yield(word) }\n}\n\nwhile (!adjectives.isDone) System.print(adjectives.call())"},"kind":"Elixir.KinoGuide.WrenCell","livebook_object":"smart_cell"} -->
```

```html
<!-- livebook:{"attrs":{"source":"for (yPixel in 0...24) {\n  var y = yPixel / 12 - 1\n  for (xPixel in 0...80) {\n    var x = xPixel / 30 - 2\n    var x0 = x\n    var y0 = y\n    var iter = 0\n    while (iter < 11 && x0 * x0 + y0 * y0 <= 4) {\n      var x1 = (x0 * x0) - (y0 * y0) + x\n      var y1 = 2 * x0 * y0 + y\n      x0 = x1\n      y0 = y1\n      iter = iter + 1\n    }\n    System.write(\" .-:;+=xX$& \"[iter])\n  }\n  System.print(\"\")\n}"},"kind":"Elixir.KinoGuide.WrenCell","livebook_object":"smart_cell"} -->
```

## ②`#{Wren.path()} #{path}`

`#{Wren.path()} #{path}`で、[wren](https://wren.io/)というプログラミング言語を実行しています。
`path`変数には、[Temp.path/1](https://hexdocs.pm/temp/Temp.html#path!/1)で取得したテンポラリファイルのパスが入ります。
`#{Wren.path()}`には実行環境にあわせた[wren](https://wren.io/)の実行バイナリが入っています。

`wren <file_path>`
ということです。

[Elixir](https://elixir-lang.org/)に例えると、`elixir sample.exs`みたいなものです。


## ③`trap "rm -f #{path}" 0 2 3 15`

`#{Wren.path()} #{path}`の前にこれが書いてあります。
ファイルを消してそうだけど、実行する前に消しちゃうの？、`0 2 3 15`って何？　となりました。

`trap 0 2 3 15`でググって最初にでたページです。

https://shellscript.sunone.me/signal_and_trap.html

詳しくはこちらに譲るとして、要は[wren](https://wren.io/)というプログラミング言語を実行したあとに、テンポラリファイルを消すということをやっています。
お行儀良いです。
心配りが行き届いています。
Niceです！ [Camilo](https://github.com/clsource)さん！！！

# おわりに

[ElixirCL/wren-livebook](https://github.com/ElixirCL/wren-livebook)を動かすことを楽しみました。
[wren](https://wren.io/)というプログラミング言語を私ははじめて知りました。
Smart cellを独自に定義できることを知りました。

[Camilo](https://github.com/clsource)さん、ありがとうございます！


