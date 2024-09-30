---
title: 闘魂Elixir ── 三目並べ(Tic tac toe)をPhoenix.LiveViewの上で動かすことを楽しむ
tags:
  - Elixir
  - Phoenix
  - LiveView
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-09-21T12:33:14+09:00'
id: a8a4924734be174715f0
organization_url_name: haw
slide: false
ignorePublish: false
---
# はじめに

[三目並べ(Tic tac toe)](https://ja.wikipedia.org/wiki/%E4%B8%89%E7%9B%AE%E4%B8%A6%E3%81%B9) （◯☓ゲーム）を[Phoenix.LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)の上で作ってみます。

# 動機

動機を述べます。

ふと、そろそろ、たいがいで[Reactチュートリアル](https://ja.react.dev/learn/tutorial-tic-tac-toe)の[三目並べ(Tic tac toe)](https://ja.wikipedia.org/wiki/%E4%B8%89%E7%9B%AE%E4%B8%A6%E3%81%B9)を理解したいと思いました。
通算で何度も（年に1回ずつ5年くらい？）チュートリアルに取り組みましたが、私にはどうも馴染めずすぐ忘れてしまう始末でした。

馴染めなかったのは言葉にすると、以下のことが挙げられます。

- `function`の中に、また`function`がでてくるのが気持ち悪い (=> 中の`function`は、名前付き関数のエントリポイントを定義しているものと見えるようになりました。そういうものだと思うようにしました)
- 関数のカッコ付きが呼び出し、カッコが無いと関数ポインタみたいなものであることを理解できていませんでした
- `const [currentMove, setCurrentMove] = useState(0)`がなかなか理解できなかった（いまは`currentMove`が現在値で、`setCurrentMove`が更新用の関数ポインタみたいなものだとみえるようになりました)

言葉にするとこんなところです。どうやって克服したかというと、とにかく「そういうものだ」と思うことにして、深く考えないで、とにかく写経を繰り返しました。読書百遍自ずからその意通ず、みたいな感じです。上の「こう思うようになりました」という理解もJavaScript界隈の専門家の方に言わせると若干間違っている解釈があるのかもしれません。それについては、よくはありませんが、三目並べのチュートリアルの100行程度のコードはソラで書けるようにはなったという事実はあります。

私が写経をどのくらい繰り返したかというと、一週間毎日時間をとって取り組んでみました。一週間のうち最初の３日くらいはタイムトラベルの前までであえて止めていました。タイムトラベルの前までを完璧に理解してその後にタイムトラベルを取り組みました。そうしたところ何も見ずにソラで書けるようになりました :tada::tada::tada:

そんなこんなで**完全に理解しました**。（もちろん！　例の意味です）

それでここからは私のクセです。趣味です。同じことを[Elixir](https://elixir-lang.org/)という素敵な関数型言語を使ってやってみたい衝動を抑えきれなくなりました。

それでこの記事をしたためているわけです。

# 特に参考にしたドキュメントなど

特に参考にしたドキュメントなどを示します。

- [Phoenix.Component](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html)
- [The Pragmatic Studio提供のPhoenix LiveView Course](https://pragmaticstudio.com/phoenix-liveview) ※ビデオ教材

# できあがり品

できあがり品（ソースコード）を以下に置いておきます。

https://github.com/TORIFUKUKaiou/tic_tac_toe

# 使用したソフトウェアとそのバージョン

使用したソフトウェアとそのバージョンを示します。

- Elixir 1.17.2 (compiled with Erlang/OTP 27)

私はmacOSを使っています。
以下の記事を参考にしてインストールしました。いつも参照しています。ありがとうーーーーッ！！！　ございます。

https://qiita.com/zacky1972/items/c94baef2ee9379c21fa1

# プロジェクトの作成とセットアップ

```
mix phx.new tic_tac_toe --no-ecto
cd tic_tac_toe
mix setup
```

# ソースコードを作る

ソースコードを作っていきます。楽しんでいきます。
[Reactチュートリアル](https://ja.react.dev/learn/tutorial-tic-tac-toe)のご経験があれば、なんとなく似ているところがたくさんあると思います。懐かしい思いにきっとかられることと思います。


## lib/tic_tac_toe/tic_tac_toes.ex

ゲームの勝者を判定する`TicTacToe.TicTacToes.calculate_winner/1`関数です。

```elixir:lib/tic_tac_toe/tic_tac_toes.ex
defmodule TicTacToe.TicTacToes do
  def calculate_winner(squares) do
    lines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]

    lines
    |> Enum.reduce_while(nil, fn [a, b, c], nil ->
      if Enum.at(squares, a) && Enum.at(squares, a) == Enum.at(squares, b) &&
           Enum.at(squares, a) == Enum.at(squares, c) do
        {:halt, Enum.at(squares, a)}
      else
        {:cont, nil}
      end
    end)
  end
end
```

## lib/tic_tac_toe_web.ex

プロジェクトを作ったときにはじめから存在するファイルに、後述するFunction Componentsを`.`はじまりでどこからでも使えるようにimportしておきます。

```elixir:lib/tic_tac_toe_web.ex
  defp html_helpers do
    quote do
      # HTML escaping functionality
      import Phoenix.HTML
      # Core UI components and translation
      import TicTacToeWeb.CoreComponents
      import TicTacToeWeb.GameComponents # 追加
      import TicTacToeWeb.Gettext
```

## lib/tic_tac_toe_web/components/game_components.ex

Function Componentsです。今回は、`lib/tic_tac_toe_web/components/core_components.ex`形式で作ってみました。`Square`モジュールや`Board`モジュールにわける作り方もあります。

```elixir:lib/tic_tac_toe_web/components/game_components.ex
defmodule TicTacToeWeb.GameComponents do
  use Phoenix.Component

  attr :status, :string, required: true
  attr :squares, :list, required: true

  def board(assigns) do
    ~H"""
    <div>
      <div class="status"><%= @status %></div>
      <div class="board-row">
        <.square :for={index <- 0..2} index={index} content={Enum.at(@squares, index)} />
      </div>
      <div class="board-row">
        <.square :for={index <- 3..5} index={index} content={Enum.at(@squares, index)} />
      </div>
      <div class="board-row">
        <.square :for={index <- 6..8} index={index} content={Enum.at(@squares, index)} />
      </div>
    </div>
    """
  end

  attr :index, :integer, required: true
  attr :content, :string, default: nil

  def square(assigns) do
    ~H"""
    <button class="square" phx-click="square_click" phx-value-ref={@index}><%= @content %></button>
    """
  end

  slot :inner_block, required: true
  attr :entries, :list, required: true

  def ordered_list(assigns) do
    ~H"""
    <ol>
      <%= for index <- @entries do %>
        <li key={index}><%= render_slot(@inner_block, index) %></li>
      <% end %>
    </ol>
    """
  end
end
```

`TicTacToeWeb.GameComponents.board/1`では、`:for`を使って、3個ずつSquareを配置するように書いています。このオプションの説明は「[Heex extension: special attributes](https://hexdocs.pm/phoenix_live_view/Phoenix.Component.html#sigil_H/2-heex-extension-special-attributes)」に書いてあります。

## lib/tic_tac_toe_web/live/tic_tac_toe_live/index.ex

状態を管理しているところといいましょうか、ゲームのエントリーポイントとでもいいましょうか、司令塔みたいな役割をしているLiveViewモジュールです。

```elixir:lib/tic_tac_toe_web/live/tic_tac_toe_live/index.ex
defmodule TicTacToeWeb.TicTacToeLive.Index do
  use TicTacToeWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    history = [List.duplicate(nil, 9)]
    squares = Enum.at(history, 0)

    {:ok,
     socket
     |> assign(
       history: history,
       squares: squares,
       current_move: 0,
       winner: nil,
       status: status(nil, 0)
     )}
  end

  @impl true
  def handle_event("square_click", %{"ref" => index}, socket) do
    index = String.to_integer(index)
    square_click(socket, index, Enum.at(socket.assigns.squares, index))
  end

  @impl true
  def handle_event("move", %{"ref" => move}, socket) do
    move = String.to_integer(move)
    squares = Enum.at(socket.assigns.history, move)
    winner = TicTacToe.TicTacToes.calculate_winner(squares)

    {:noreply,
     assign(socket,
       squares: squares,
       current_move: move,
       winner: winner,
       status:
         status(
           winner,
           move
         )
     )}
  end

  defp square_click(socket, _index, value_of_index) when value_of_index != nil,
    do: {:noreply, socket}

  defp square_click(socket, _index, _value_of_index) when socket.assigns.winner != nil,
    do: {:noreply, socket}

  defp square_click(socket, index, _value_of_index) do
    current_move = socket.assigns.current_move

    next_squares = List.replace_at(socket.assigns.squares, index, mark(current_move))

    next_current_move = current_move + 1
    next_history = Enum.slice(socket.assigns.history, 0, next_current_move) ++ [next_squares]
    new_winner = TicTacToe.TicTacToes.calculate_winner(next_squares)
    status = status(new_winner, next_current_move)

    {:noreply,
     assign(socket,
       history: next_history,
       squares: next_squares,
       current_move: next_current_move,
       winner: new_winner,
       status: status
     )}
  end

  defp mark(current_move) when rem(current_move, 2) == 0, do: "X"
  defp mark(_current_move), do: "O"

  defp status(winner, _current_move) when winner != nil, do: "Winner: " <> winner
  defp status(_winner, current_move), do: "Next Player: " <> mark(current_move)
end

```

# lib/tic_tac_toe_web/live/tic_tac_toe_live/index.html.heex

ゲーム全体のレイアウトファイルです。

```html:lib/tic_tac_toe_web/live/tic_tac_toe_live/index.html.heex
<div class="game">
  <div>
    <.board squares={@squares} status={@status} />
  </div>
  <div class="game-info">
    <.ordered_list
      :let={index}
      entries={Enum.with_index(@history) |> Enum.map(fn {_, index} -> index end)}
    >
      <.button phx-click="move" phx-value-ref={index}>
        <%= if index > 0, do: "Go to move ##{index}", else: "Go to game start" %>
      </.button>
    </.ordered_list>
  </div>
</div>
```

# lib/tic_tac_toe_web/router.ex

パスの指定です。プロジェクトを作ったときにはじめから存在するファイルに追加します。

```elixir:lib/tic_tac_toe_web/router.ex
  scope "/", TicTacToeWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/tictactoes", TicTacToeLive.Index, :index # 追加
  end
```

# assets/css/app.css

CSSは、[Reactチュートリアル](https://ja.react.dev/learn/tutorial-tic-tac-toe)から~~意味もわからず~~丸パクリです。

```css:assets/css/app.css
* {
  box-sizing: border-box;
}

body {
  font-family: sans-serif;
  margin: 20px;
  padding: 0;
}

h1 {
  margin-top: 0;
  font-size: 22px;
}

h2 {
  margin-top: 0;
  font-size: 20px;
}

h3 {
  margin-top: 0;
  font-size: 18px;
}

h4 {
  margin-top: 0;
  font-size: 16px;
}

h5 {
  margin-top: 0;
  font-size: 14px;
}

h6 {
  margin-top: 0;
  font-size: 12px;
}

code {
  font-size: 1.2em;
}

ul {
  padding-inline-start: 20px;
}

* {
  box-sizing: border-box;
}

body {
  font-family: sans-serif;
  margin: 20px;
  padding: 0;
}

.square {
  background: #fff;
  border: 1px solid #999;
  float: left;
  font-size: 24px;
  font-weight: bold;
  line-height: 34px;
  height: 34px;
  margin-right: -1px;
  margin-top: -1px;
  padding: 0;
  text-align: center;
  width: 34px;
}

.board-row:after {
  clear: both;
  content: '';
  display: table;
}

.status {
  margin-bottom: 10px;
}
.game {
  display: flex;
  flex-direction: row;
}

.game-info {
  margin-left: 20px;
}

.game-info ol li {
  margin-bottom: 10px;
}
```

タイムトラベル機能のボタンの間隔が詰まっているようにみえたので、最後のこの部分だけは、~~カンで~~追加しました。

```css
.game-info ol li {
  margin-bottom: 10px;
}
```

# 動かし方

迷わず動かしてみましょう。

```
mix phx.server
```

visit: http://localhost:4000/tictactoes


![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/17d39c23-7fa9-6de4-0c2a-5b7a21e257b9.gif)


# 実際に動かせます（お試しいただけます）

https://tic-tac-toe-icy-paper-4088.fly.dev/tictactoes

[https://tic-tac-toe-icy-paper-4088.fly.dev/tictactoes](https://tic-tac-toe-icy-paper-4088.fly.dev/tictactoes)
にアクセスしてみてください。


[Fly.io](https://fly.io/)にデプロイしています。

そのうち止めると思いますので、アクセスできないときはそういうことだと思ってください。

[Phoenix](https://www.phoenixframework.org/)のプロジェクトは、[Deploying on Fly.io](https://hexdocs.pm/phoenix/fly.html) の通りにやると簡単にデプロイできます。デプロイするために必要なファイルをコマンドで自動的に作ってくれます。めちゃくちゃ便利です！　感動します！　以下の記事が詳しいです！

https://qiita.com/t-yamanashi/items/88b695dec3d8fc295d93

# さいごに

[三目並べ(Tic tac toe)](https://ja.wikipedia.org/wiki/%E4%B8%89%E7%9B%AE%E4%B8%A6%E3%81%B9) （◯☓ゲーム）を[Phoenix.LiveView](https://hexdocs.pm/phoenix_live_view/Phoenix.LiveView.html)の上で作ってみました。

[Elixir](https://elixir-lang.org/)で書くことのメリットは、値がすべてイミュータブルであることです。イミュータブルかそうでないかを意識したり、コードを書き分けたりする必要は一切ありません。

React、Phoenix LiveViewともに理解が深まったことを感じます。
同じことを異なる言語、異なるフレームワークで試してみるのも理解を深める手段のひとつなのかもしれません。

あなたも[三目並べ(Tic tac toe)](https://ja.wikipedia.org/wiki/%E4%B8%89%E7%9B%AE%E4%B8%A6%E3%81%B9)をお好きなプログラミング言語、フレームワークで作ってみてはいかがでしょうか。
