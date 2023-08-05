---
title: ElixirでArray#productなことをしたい
tags:
  - Elixir
private: false
updated_at: '2019-09-15T15:15:59+09:00'
id: f916d8373418b1a41f68
organization_url_name: fukuokaex
slide: false
---
# 結論
- [内包表記](https://elixirschool.com/ja/lessons/basics/comprehensions/)を使う

## Elixir
```sample.exs
iex(2)> for x <- [1,2], y <- [3,4], z <-[5,6], do: [x, y, z]
[
  [1, 3, 5],
  [1, 3, 6],
  [1, 4, 5],
  [1, 4, 6],
  [2, 3, 5],
  [2, 3, 6],
  [2, 4, 5],
  [2, 4, 6]
]
```

## Ruby
```sample.rb
[1,2].product([3,4],[5,6]) # => [[1,3,5],[1,3,6],[1,4,5],[1,4,6],
                           #     [2,3,5],[2,3,6],[2,4,5],[2,4,6]]
```
- サンプルは[こちら](https://docs.ruby-lang.org/ja/latest/class/Array.html#I_PRODUCT)を転載させていただきました

# 記事を書いたきっかけ
- ひょんなことから知ることになった[Elixir](https://elixir-lang.org/)をいろいろあって勉強しています
- 近所の図書館に [プログラマ脳を鍛える数学パズル シンプルで高速なコードが書けるようになる70問](https://www.amazon.co.jp/dp/B016QEE30G/) という本がありましてこれを借りてきました
- [Elixir](https://elixir-lang.org/) で書いていってみることにします
- Q02で[Ruby](https://www.ruby-lang.org/)で言うところの [Array#product](https://docs.ruby-lang.org/ja/latest/class/Array.html#I_PRODUCT) 的なことをしたくなりました
    - 私にとっては、接する時間が最近の中では一番多い言語は[Ruby](https://www.ruby-lang.org/)です
    - [Elixir](https://elixir-lang.org/)は、父が[Erlang](https://www.erlang.org/)で母が[Ruby](https://www.ruby-lang.org/)と言われることがあるそうで、[Ruby](https://www.ruby-lang.org/)に精通されている方は親しみやすいとおもいます
- はじめは以下のような感じのものを自作しました
- もっと便利なものがきっとあるだろうとふて寝をしたあと、 [プログラミングElixir](https://www.amazon.co.jp/%E3%83%97%E3%83%AD%E3%82%B0%E3%83%A9%E3%83%9F%E3%83%B3%E3%82%B0Elixir-%EF%BC%A4%EF%BD%81%EF%BD%96%EF%BD%85%EF%BC%B4%EF%BD%88%EF%BD%8F%EF%BD%8D%EF%BD%81%EF%BD%93-ebook/dp/B01KFCXP04/) で勉強した内包表記のことが思い浮かびました
- さっそく [Elixir School](https://elixirschool.com/ja/) に通学して[確認](https://elixirschool.com/ja/lessons/basics/comprehensions/)させていただきました
    - ありがとうございます

```sample.exs
iex(8)> f = fn enum1, enum2 ->
...(8)>   enum1
...(8)>   |> Enum.reduce([], fn x, acc ->
...(8)>     acc ++ Enum.map(enum2, fn y -> [x, y] end)
...(8)>   end) 
...(8)> end

iex(9)> f.([1,2], [3,4]) |> f.([5,6]) |> Enum.map(&List.flatten/1)
[
  [1, 3, 5],
  [1, 3, 6],
  [1, 4, 5],
  [1, 4, 6],
  [2, 3, 5],
  [2, 3, 6],
  [2, 4, 5],
  [2, 4, 6]
]
```
- _[問題集](https://www.amazon.co.jp/dp/B016QEE30G/)に提示されている回答までの目標時間は大幅に過ぎていますが気にしないことにします_
- _自分との闘い_
- 日本語の記事が見当たらないとおもって書いたのですがすでに先輩がいらっしゃいました！
    - [Rubyのarray.product(other_array)をElixirでやる](https://qiita.com/junsumida/items/6d2bbea74d227711c447)
