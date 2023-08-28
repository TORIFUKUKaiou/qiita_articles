---
title: 'とあるサイトでのみ%HTTPoison.Error{id: nil, reason: :closed}が発生 (Elixir)'
tags:
  - Elixir
private: false
updated_at: '2021-09-04T10:02:24+09:00'
id: 100afafe1920eb72b339
organization_url_name: fukuokaex
slide: false
---
[Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2) 4日目です。
前日は、[Surfaceをつかってみる(Elixir/Phoenix)](https://qiita.com/torifukukaiou/items/b5ae9eac42bd304b7aa3)でした。

# 2021-09-04追記
- ようやく会話が成立しました :tada::tada::tada: 
- 下記の記事をご参照ください
- [とあるサイトでのみ%HTTPoison.Error{id: nil, reason: :closed}が発生 解決編 (Elixir)](https://qiita.com/torifukukaiou/items/fd7971bb5dd7788c55d5)

# はじめに
- そういうことがあるのですねえ
- この記事で使用したバージョンは以下の通りです

|  | バージョン | 
|:-----------|------------:|
|[Elixir](https://elixir-lang.org/)|1.10.4-otp-23|
|[Erlang](https://www.erlang.org/)|23.0.1|
|[httpoison](https://hex.pm/packages/httpoison)|1.7.0|
|[hackney](https://hex.pm/packages/hackney)|1.16.0|

- 大丈夫なサイトもあります
- たいてい大丈夫です

```elixir
iex> HTTPoison.get "https://www.google.com" 
{:ok,
 %HTTPoison.Response{
   body: "<!doctype html><html...
}
```

- エラーがでるサイトの例
    - 少数派です

```elixir
iex> HTTPoison.get "https://xxx.jp/"    
{:error, %HTTPoison.Error{id: nil, reason: :closed}}
```

- なにがなんだかわからず焦った :sweat: ので、調べたことを書いておきます 

----

# 結論
- **[hackney](https://hex.pm/packages/hackney)のアップデートを待ちましょう**

----

# [{:error, %HTTPoison.Error{id: nil, reason: "closed"}} #326](https://github.com/edgurgel/httpoison/issues/326)
- [hackney](https://hex.pm/packages/hackney)を更新したら直ったという人もいれば、駄目だという人もいろいろいます
- どうも[httpoison](https://hex.pm/packages/httpoison)が依存している[hackney](https://hex.pm/packages/hackney)になにかがありそうです

# 回避策(非推奨)
- 必ずしも解決できるとは限りません
- [hackney](https://hex.pm/packages/hackney)のバージョンを落としてみました
- 私がアクセスしたかったサイトは以下の方法でアクセスできましたよ! ということのご紹介です

```elixir:mix.exs
  defp deps do
    [
      {:httpoison, "~> 1.6"},
      {:jason, "~> 1.2"},
      {:hackney, "1.15.2", override: true}
    ]
  end
```

```
$ mix deps.update --all
```

```elixir
$ iex -S mix

iex> HTTPoison.get "https://xxx.jp", [], ssl: [{:versions, [:'tlsv1.2']}]
{:ok,
 %HTTPoison.Response{
   body: "<!doctype html><html...
}
```

- こんなことをしなくてもアクセスできていた気がするので、[httpoison](https://hex.pm/packages/httpoison)と[hackney](https://hex.pm/packages/hackney)の組み合わせでなにかありそうです
    - さらにほると、[hackney](https://hex.pm/packages/hackney)が依存している[certifi](https://hex.pm/packages/certifi)というHexのバージョンを落とせば第3引数の指定で動くことを確認しました
    - `{:certifi, "2.5.1"},`


# Wrapping Up :lgtm: :qiita-fabicon: :lgtm: 
- すっきりしませんが、日本語の記事は見つからなかったので書き留めておきます
- Enjoy [Elixir](https://elixir-lang.org/)!!! :rocket::rocket::rocket: 
