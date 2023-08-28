---
title: Rails on Tiles（どう書く） (Elixir)
tags:
  - Elixir
private: false
updated_at: '2021-01-09T21:52:57+09:00'
id: 8c684fec556a132efe3f
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Elixir](https://elixir-lang.org/) 楽しんでいますか :bangbang::bangbang::bangbang:
- @Nabetaniさんの「[オフラインリアルタイムどう書く第5回の参考問題](https://qiita.com/Nabetani/items/0ddde0164a745cd09c34)」を[Elixir](https://elixir-lang.org/)でやってみました
    - @obelisk68 さんの「[Rails on Tiles（どう書く）](https://qiita.com/obelisk68/items/94971d9aacbc1c8725a2)」で問題の存在を知りました

# 準備
- [Elixir](https://elixir-lang.org/) をインストールしましょう
- 手前味噌ですが、[インストール](https://qiita.com/torifukukaiou/items/d04d0273749c41eb50af#0-%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)などをご参照ください

## うまくいかなかったら
- 何事にも準備が肝心です
- ここが一番つまらないし、謎にハマってしまうことが多いのですが、がんばってください！
- うまくいかなかったら、**思い切って僕の胸に飛び込んで来てほしい** (by 長嶋茂雄 読売ジャイアンツ終身名誉監督)
    - [elixirjp.slack.com slack workspace](https://elixirjp.slack.com/join/shared_invite/enQtODE0NjM3NTIyNTMzLTU5NmViZDE4N2Q3MGUyMmI5YTdlNmQ2ZDI4ZDgxZGZiYTVlYmJjOTMzYzk2NGUyMjBhMTBiNDdjYTg3ZjhmYWI)か[NervesJP workspace](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)に入ってきていただいて、`@torifukukaiou`へご質問ください
    - たとえ私が答えられなくても、マジみんな親切で優しい人が多いので、きっと解決できるでしょう:bangbang:

# mix new

```
$ mix new rails_on_tiles
$ cd rails_on_tiles
```

# ソースコードを書く

```elixir:lib/rails_on_tiles.ex
defmodule RailsOnTiles do
  @moduledoc """
  Documentation for `RailsOnTiles`.
  """

  @tiles [[2, 3, 0, 1], [1, 0, 3, 2], [3, 2, 1, 0]]
  @dirs [[0, -1], [1, 0], [0, 1], [-1, 0]]
  @alphabets ?A..?I

  @doc """
  Rails on Tiles（どう書く）

  ## Examples
  iex> RailsOnTiles.go("101221102")
  "BEDGHIFEH"

  iex> RailsOnTiles.go("000000000")
  "BEH"

  iex> RailsOnTiles.go("111111111")
  "BCF"

  iex> RailsOnTiles.go("222222222")
  "BAD"

  iex> RailsOnTiles.go("000211112")
  "BEFIHEDGH"

  iex> RailsOnTiles.go("221011102")
  "BADGHIFEBCF"

  iex> RailsOnTiles.go("201100112")
  "BEHIFCBADEF"

  iex> RailsOnTiles.go("000111222")
  "BEFIH"

  iex> RailsOnTiles.go("012012012")
  "BC"

  iex> RailsOnTiles.go("201120111")
  "BEDABCFI"

  iex> RailsOnTiles.go("220111122")
  "BADEHGD"

  iex> RailsOnTiles.go("221011022")
  "BADG"

  iex> RailsOnTiles.go("111000112")
  "BCFIHEBA"

  iex> RailsOnTiles.go("001211001")
  "BEFI"

  iex> RailsOnTiles.go("111222012")
  "BCFEHIF"

  iex> RailsOnTiles.go("220111211")
  "BADEHI"

  iex> RailsOnTiles.go("211212212")
  "BCFEBAD"

  iex> RailsOnTiles.go("002112210")
  "BEFC"

  iex> RailsOnTiles.go("001010221")
  "BEF"

  iex> RailsOnTiles.go("100211002")
  "BEFIHG"

  iex> RailsOnTiles.go("201212121")
  "BEFCBAD"
  """
  def go(input) do
    String.codepoints(input)
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(3)
    |> solve()
    |> Enum.map(&Enum.at(@alphabets, &1))
    |> Enum.map(&<<&1>>)
    |> Enum.join()
  end

  defp solve(field) do
    {x, y} = new_xy(1, -1, 2)
    do_solve(field, x, y, 2, [])
  end

  defp do_solve(_field, x, y, _dir, route) when x < 0 or x > 2 or y < 0 or y > 2, do: route

  defp do_solve(field, x, y, dir, route) do
    rev = get_in(@tiles, [Access.at(0), Access.at(dir)])

    nxt =
      get_in(@tiles, [
        get_in(field, [Access.at(y), Access.at(x)]) |> Access.at(),
        Access.at(rev)
      ])

    tile_num = y * 3 + x

    {x, y} = new_xy(x, y, nxt)
    do_solve(field, x, y, nxt, route ++ [tile_num])
  end

  defp new_xy(x, y, dir) do
    [dx, dy] = Enum.at(@dirs, dir)
    x = x + dx
    y = y + dy

    {x, y}
  end
end
```

# [Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)

- `## Examples`の下にあるものは、[Doctests](https://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)と呼ばれるものでテストできるんです :bangbang::bangbang::bangbang:

```elixir
$ mix test
......................

Finished in 0.08 seconds
21 doctests, 1 test, 0 failures
```

# Wrapping Up 🎍🎍🎍🎍🎍
- 問題の解き方は全然わかりませんでした:sweat_smile:がお手本のRubyを[Elixir](https://elixir-lang.org/)で置き換えてみました :bangbang:
- みんなちがって　みんないい(金子みすゞ)
    - みなさんもお好きなプログラミング言語で書いてみてください！
- Enjoy [Elixir](https://elixir-lang.org/) :rocket::rocket::rocket:
