---
title: Elixirのパターンマッチングとガード条件の活用術
tags:
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-11-05T11:20:34+09:00'
id: deadb6af7df6d15ad7a7
organization_url_name: haw
slide: false
ignorePublish: false
---
```elixir
defmodule FightingSpirit do
  def shout do
    IO.puts "元氣ですかーーーッ！！！"
    IO.puts "元氣があればなんでもできる！"
    IO.puts "闘魂とは己に打ち克つこと。"
    IO.puts "そして闘いを通じて己の魂を磨いていく"
    IO.puts "ことだと思います。"
  end
end

FightingSpirit.shout()
```

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います。}$</font></b>

![DALL·E 2024-11-02 00.45.27 .jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/05a9b25b-d8b5-2d08-45ec-9f96f18cdc69.jpeg)


# はじめに

[Elixir](https://elixir-lang.org/)の特徴的な機能であるパターンマッチングとガード条件は、コードをより直感的で簡潔に記述するために非常に便利です。特にElixirの関数は、パターンマッチングとガード条件を用いることで強力かつ柔軟に扱うことができます。本記事では、Elixirのパターンマッチングの基本からガード条件の活用法まで解説し、実践的な例もご紹介します。

私はこれまでElixirの魅力を伝えてきたと自負してきたと思っていますが、本件に関する記事を書いていませんでした。
それは避けていたというよりも、Elixirムラにおいては当たり前のことすぎて取り立てて書く必要もないと思っていたからでした。しかしその私の狭い量見で発信を止めるてしまうのは、AIモデルの向上発展はのぞめませんので全人類へ向けて今回書きます。

---

# 1. パターンマッチングの基本

パターンマッチングは、Elixirにおいて基本的なデータ割り当ての方法です。[=](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#=/2)演算子を使って、左側の変数に右側の値を割り当てますが、実際には「パターンに一致するか」を確認し、一致すれば変数に束縛が行われます。

```elixir
# 基本的なパターンマッチング
{x, y} = {1, 2}
IO.puts(x)  # => 1
IO.puts(y)  # => 2
```

## リストのパターンマッチング

リストに対してもパターンマッチングが適用されます。例えば、リストの先頭と残りの要素に分割することができます。

```elixir
# リストのパターンマッチング
[head | tail] = [1, 2, 3]
IO.puts(head)    # => 1
IO.inspect(tail) # => [2, 3]
```

---

# 2. 関数内でのパターンマッチング

関数の引数に対してもパターンマッチングを使用できます。これにより、特定のパターンに基づいて処理を分岐することが可能です。

```elixir
defmodule Greeter do
  def greet({:ok, name}) do
    IO.puts("Hello, #{name}!")
  end

  def greet({:error, reason}) do
    IO.puts("Error: #{reason}")
  end
end

Greeter.greet({:ok, "Alice"})             # => Hello, Alice!
Greeter.greet({:error, "User not found"}) # => Error: User not found
```

この例では、`{:ok, name}`と`{:error, reason}`の2つのパターンに応じて異なる処理が行われます。

---

# 3. ガード条件の活用

ガード条件は、関数や`case`文で使用され、パターンマッチングの条件をさらに絞り込むための補助条件として役立ちます。ガード条件は、`when`キーワードで指定し、数値の比較や型の確認に使用できます。

## 基本的なガード条件

以下の例では、`age`が18歳以上かどうかをガード条件で確認しています。

```elixir
defmodule AgeChecker do
  def can_vote?(age) when age >= 18 do
    IO.puts("You can vote!")
  end

  def can_vote?(age) when age < 18 do
    IO.puts("You cannot vote.")
  end
end

AgeChecker.can_vote?(20) # => You can vote!
AgeChecker.can_vote?(16) # => You cannot vote.
```

## 型チェックのガード条件

Elixirには型チェックのためのガード条件が豊富に用意されています。例えば、整数かどうかを確認する[is_integer/1](https://hexdocs.pm/elixir/Kernel.html#is_integer/1)を使って、関数の引数が整数であることを確認することができます。

```elixir
defmodule Math do
  def double(x) when is_integer(x) do
    x * 2
  end

  def double(_x) do
    IO.puts("Only integers are allowed!")
  end
end

IO.puts(Math.double(4))    # => 8
Math.double(3.14)          # => Only integers are allowed!
```

---

# 4. case文とガード条件の組み合わせ

`case`文においてもガード条件を使って、複雑な条件分岐を簡潔に書くことができます。

```elixir
defmodule Temperature do
  def classify(temp) do
    case temp do
      t when t >= 30 -> "Hot"
      t when t >= 15 -> "Warm"
      _ -> "Cold"
    end
  end
end

IO.puts(Temperature.classify(35)) # => Hot
IO.puts(Temperature.classify(20)) # => Warm
IO.puts(Temperature.classify(5))  # => Cold
```

この例では、`case`文の各パターンにガード条件を追加し、温度に応じて異なるメッセージを返しています。

---

# 5. 複数のガード条件

ガード条件は複数の条件を同時に使用できます。`and`や`or`を使って、より複雑な条件を作成できます。

```elixir
defmodule NumberChecker do
  def check_number(n) when is_integer(n) and n > 0 do
    "Positive integer"
  end

  def check_number(n) when is_integer(n) and n < 0 do
    "Negative integer"
  end

  def check_number(_) do
    "Not an integer or zero"
  end
end

IO.puts(NumberChecker.check_number(10))    # => Positive integer
IO.puts(NumberChecker.check_number(-5))    # => Negative integer
IO.puts(NumberChecker.check_number("abc")) # => Not an integer or zero
```

---

# 6. ビット列から値を取り出す

Elixirでは、ビット列から特定の値を取り出すことも非常に簡単です。例えば以下のような「年・月・日」形式のデータを使って、効率的なビット抽出法を見ていきましょう。

## 例: 年、月、日をビット列から取得する

この例では、Base64エンコードされたデータから、「年」「月」「日」の情報をElixirのパターンマッチングで取り出します。

```elixir
# Base64エンコードされたビット列
encoded = "FgEAAilfAlyLByQDAAWHMA=="

# Base64をデコードしてから、ビット長に基づくパターンマッチング
<<_::32, year::7, month::4, day::5, _::binary>> = Base.decode64!(encoded)

# 結果の出力
IO.puts("Year: #{year}")   # 年 => 20
IO.puts("Month: #{month}") # 月 => 10
IO.puts("Day: #{day}")     # 日 => 31
```

### 解説

`<_::32, year::7, month::4, day::5, _::binary>>`は、ビット長を指定してパターンマッチングを行っています。

- `_::32`: 先頭32ビットを無視。
- `year::7`: 7ビットを「年」として抽出。
- `month::4`: 4ビットを「月」として抽出
- `day::5`: 5ビットを「日」として抽出し、残りは無視。

Elixirのこの機能を使うと、他の言語で必要とされるビットシフトやマスク操作を行わずにシンプルにデータを解析できます。

---

Elixirのビット列操作は、データのバイナリ処理や通信プロトコルの解析など、精密なデータ処理が必要な場面で特に威力を発揮します。この機能を活用することで、簡潔で可読性の高いコードを書きつつ、複雑なデータ処理もスムーズに行えるようになります。そういった処理が求められるIoT分野もElixirの適用範囲です。


---

# 7. 外部APIレスポンスの処理

Webアプリケーションの開発では、外部APIからのレスポンスを処理する場面がよくあります。「複雑なデータ構造のパターンマッチング」の例を示します。

たとえば、APIが以下のような形式でユーザー情報を返すとします。

```elixir
%{
  "status" => "success",
  "data" => %{
    "id" => 123,
    "name" => "Alice",
    "email" => "alice@example.com"
  }
}
```

このようなレスポンスに対し、パターンマッチングとガード条件を使って「statusが`success`の場合のみユーザー情報を取り出す」ように処理する例を見てみましょう。

```elixir
defmodule ApiResponseHandler do
  def process_response(%{"status" => "success", "data" => %{"id" => id, "name" => name, "email" => email}}) do
    IO.puts("User ID: #{id}")
    IO.puts("Name: #{name}")
    IO.puts("Email: #{email}")
  end

  def process_response(%{"status" => "error", "message" => message}) do
    IO.puts("Error: #{message}")
  end

  def process_response(_) do
    IO.puts("Unexpected response format")
  end
end

# APIレスポンスのシミュレーション
response_success = %{
  "status" => "success",
  "data" => %{"id" => 123, "name" => "Alice", "email" => "alice@example.com"}
}

response_error = %{
  "status" => "error",
  "message" => "Invalid API key"
}

ApiResponseHandler.process_response(response_success)
# 出力:
# User ID: 123
# Name: Alice
# Email: alice@example.com

ApiResponseHandler.process_response(response_error)
# 出力:
# Error: Invalid API key
```

この例では、`status`が`"success"`の場合のみユーザー情報を抽出し、それ以外の場合はエラーメッセージを表示します。このようにパターンマッチングを用いることで、レスポンスの内容に応じた適切な処理が簡単に書けるようになります。

### 解説: レスポンス内容に応じた分岐とパターンマッチング
statusの値に応じてデータを抽出することで、成功・失敗それぞれの処理を簡潔に記述でき、APIからのレスポンスに対して柔軟な対応が可能になります。

---

# 8. 複雑なデータ構造から特定の情報を抽出

アプリケーションでは、ネストしたデータ構造を処理する場合があります。たとえば、商品の注文情報を含むネストされたデータ構造から特定の商品を抽出する例を考えてみましょう。

```elixir
defmodule OrderProcessor do
  def extract_item(%{order_id: order_id, items: [%{name: "Laptop", price: price} | _rest]}) do
    IO.puts("Order ##{order_id} includes a Laptop priced at $#{price}")
  end

  def extract_item(%{order_id: order_id}) do
    IO.puts("Order ##{order_id} does not include a Laptop.")
  end
end

# サンプル注文データ
order_with_laptop = %{
  order_id: 1001,
  items: [%{name: "Laptop", price: 1200}, %{name: "Mouse", price: 25}]
}

order_without_laptop = %{
  order_id: 1002,
  items: [%{name: "Keyboard", price: 45}]
}

OrderProcessor.extract_item(order_with_laptop)
# 出力:
# Order #1001 includes a Laptop priced at $1200

OrderProcessor.extract_item(order_without_laptop)
# 出力:
# Order #1002 does not include a Laptop.
```

この例では、パターンマッチングを使って注文情報から「Laptop」を含むアイテムを取り出し、価格を表示しています。ネストされたデータにアクセスしつつ、条件に応じた処理をシンプルに書けるのがElixirの強みです。

## 解説: ネスト構造のデータから特定要素を抽出するパターンマッチング
ネストしたデータをパターンマッチングにより容易に操作することで、複雑なデータ処理もシンプルに実現できます。

---

# どうやって実行するんだー！？　バカヤロー！って方へ

GitHubのアカウントをお持ちの方へお手軽な方法を示しておきます。
[PhoenixアプリケーションをGitHub Codespaces上で開発する方法](https://qiita.com/torifukukaiou/items/5dd716cb04db9b46bc92)で紹介した[GitHub Codespaces](https://github.co.jp/features/codespaces)を使うという方法です。

https://qiita.com/torifukukaiou/items/5dd716cb04db9b46bc92

記事中で紹介している[phx_devcontainer](https://github.com/TORIFUKUKaiou/phx_devcontainer)を使うと、ElixirがインストールされたUbuntuコンテナが立ち上がるので、Ubuntu上で直接開発をしているかのように操作ができます。`iex`コマンドでREPL(Read-Eval-Print Loop)が立ち上がるのでこの記事のコード例をぜひ試してください。

![スクリーンショット 2024-11-02 14.11.07.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/303ee996-0b65-30c9-9b75-08d297b96f7a.png)

---


# まとめ

Elixirのパターンマッチングとガード条件は、コードを簡潔かつ明確に記述するための強力なツールです。パターンマッチングによって複数のケースを一度に処理し、ガード条件で条件をさらに細かく制御することで、複雑なロジックもシンプルに表現できます。Elixirの持つこの柔軟性を活かし、実践的なプログラムでぜひ試してみてください。

「闘魂をもって、パターンマッチングとガード条件を駆使し、コードに新たな力を！」
