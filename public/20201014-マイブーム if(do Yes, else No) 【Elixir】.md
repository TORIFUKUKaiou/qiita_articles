---
title: 'マイブーム |> if(do: "Yes", else: "No")  [Elixir]'
tags:
  - Elixir
private: false
updated_at: '2021-01-11T21:44:45+09:00'
id: 937a0e5ba7f393e00793
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- ある条件に合致するときは"Yes"、そうではない場合は"No"を返しなさいという関数をつくりたいとします
- [AtCoder](https://atcoder.jp/)の問題にあったりします
    - [A - Fourtune Cookies](https://atcoder.jp/contests/arc105/tasks/arc105_a)
- いろいろな書き方があるおもいますが、マイブームはpipe operator[|>](https://hexdocs.pm/elixir/Kernel.html#%7C%3E/2)を使った`|> if(do: "Yes", else: "No")`です
- 以降、この記事ではリストの中身が100より小さいときは"Yes"、そうではないときには"No"とします

# マイブーム

```elixir
iex> [1, 2, 3] |> Enum.all?(& &1 < 100) |> if(do: "Yes", else: "No")
"Yes"

iex> [1, 2, 101] |> Enum.all?(& &1 < 100) |> if(do: "Yes", else: "No")
"No"
```

# パターンマッチ
```elixir
defmodule Awesome do
  def solve(list), do: Enum.all?(list, & &1 < 100) |> do_solve()

  defp do_solve(true), do: "Yes"

  defp do_solve(false), do: "No"
end
```

# if文っぽく
```elixir
defmodule Awesome do
  def solve(list) do
    if Enum.all?(list, & &1 < 100) do
      "Yes"
    else
      "No"
    end
  end
end
```

# 無名関数を作ってpipe operatorでつなぐ
```elixir
defmodule Awesome do
  def solve(list) do
    Enum.all?(list, & &1 < 100)
    |> (fn b -> if b, do: "Yes", else: "No" end).()
  end
end
```
- 私は長らくこの書き方をしていたのですが、なにか変だぞとおもって`|> if(do: "Yes", else: "No") `に気づいたわけです
- 余談ですが、このテクニックはどなたかの記事で知りまして、前の計算結果を次の関数の第一引数ではない箇所に渡して呼び出したいときに重宝しています

```elixir
Awesome.get_content() # .wavデータが取得できるすんごい関数
|> (fn content -> File.write("alarm.wav", content) end).()
```


# [if](https://hexdocs.pm/elixir/Kernel.html#if/2)って何ですか？
- マクロです
- リンク先の公式ドキュメントのサンプルをみていただけると感じるものがあるとおもいます
- もっと[if](https://hexdocs.pm/elixir/Kernel.html#if/2)のことを知りたい方は、@piacerex さんの記事をご参照ください
    - [Elixirのifはタダの関数](https://qiita.com/piacerex/items/c7c31499a6bde7f1fe0e)
    - [ifをパイプの中で使用する](https://qiita.com/piacerex/items/b39eab7d92e91b366c51)
    - いつもありがとうございます！
- [Elixir](https://elixir-lang.org/)の[ソースコード](https://github.com/elixir-lang/elixir/blob/v1.11.0/lib/elixir/lib/kernel.ex#L3280-L3340)

```elixir
  defmacro if(condition, clauses) do
    build_if(condition, clauses)
  end

  defp build_if(condition, do: do_clause) do
    build_if(condition, do: do_clause, else: nil)
  end

  defp build_if(condition, do: do_clause, else: else_clause) do
    optimize_boolean(
      quote do
        case unquote(condition) do
          x when :"Elixir.Kernel".in(x, [false, nil]) -> unquote(else_clause)
          _ -> unquote(do_clause)
        end
      end
    )
  end

  defp build_if(_condition, _arguments) do
    raise ArgumentError,
          "invalid or duplicate keys for if, only \"do\" and an optional \"else\" are permitted"
  end
```

# 2021/01/11(月) 追記
- @pojiro さんの書き込みにて[case/2](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#case/2)も同じようにいけます :rocket::rocket::rocket: 
- [パイプラインでcaseを使えることを知りました。（phx.gen.authのコードから抜粋](https://twitter.com/pojiro3/status/1348239155222908929)

![ErXn_sDVgAEZ8K5.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8840fa07-0c06-f292-b119-88bc86391f6d.png)

- https://twitter.com/akoutmos/status/1332383690131816448



# Wrapping Up :qiita-fabicon: 
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::lgtm::lgtm::lgtm::rocket: 



