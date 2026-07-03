---
title: Elixirで文字列を数値に変換 ── Integer.parse/2とFloat.parse/1を楽しむ
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-04-03T00:42:46+09:00'
id: b8dfa91f7fa7a37d45d9
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**たれをかも知る人にせむ高砂の松も昔の友ならなくに**


---

Advent Calendar 2022 84日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

今日は、[Integer.parse/2](https://hexdocs.pm/elixir/Integer.html#parse/2)と[Float.parse/1](https://hexdocs.pm/elixir/Float.html#parse/1)を楽しんでみます。

# 動機

[Integer.parse/2](https://hexdocs.pm/elixir/Integer.html#parse/2)と[Float.parse/1](https://hexdocs.pm/elixir/Float.html#parse/1)を紹介しようとおもった動機です。

- [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slackの`#beginners`チャンネルの質問投稿で見かけました
- 改めて興味深い関数だとおもいました
- Advent Calendar 2022 goes behind 8 days. :sweat_smile:

# [Integer.parse/2](https://hexdocs.pm/elixir/Integer.html#parse/2)

公式の説明をそのまま掲載します。

![スクリーンショット 2022-04-02 23.33.32.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/064e0747-6f15-5f8f-4a35-22ddb25758ab.png)



## Specs

`parse(binary(), 2..36) :: {integer(), remainder_of_binary :: binary()} | :error`

引数を2つ取ります。


- 第1引数は、文字列です
- 第2引数は、何進数なのかを指定します
    - 第2引数を指定しない場合はデフォルトで10進数として評価されます
    - 2進数から36進数までを指定できます

戻り値は、2種類あります。

- 変換に成功した場合は2要素のタプルです
    - 最初の要素は変換した整数です
    - 2番目の要素は変換できなかった文字列です
- 変換に失敗した場合は `:error`アトムです

## [Examples](https://hexdocs.pm/elixir/Integer.html#parse/2-examples)

公式に書いてある[Examples](https://hexdocs.pm/elixir/Integer.html#parse/2-examples)をそのまま掲載しておきます。

```elixir
iex> Integer.parse("34")
{34, ""}

iex> Integer.parse("34.5")
{34, ".5"}

iex> Integer.parse("three")
:error

iex> Integer.parse("34", 10)
{34, ""}

iex> Integer.parse("f4", 16)
{244, ""}

iex> Integer.parse("Awww++", 36)
{509216, "++"}

iex> Integer.parse("fab", 10)
:error

iex> Integer.parse("a2", 38)
** (ArgumentError) invalid base 38
```

使い方はこれでばっちりですね :thumbsup::thumbsup_tone1::thumbsup_tone2::thumbsup_tone3::thumbsup_tone4::thumbsup_tone5: 

## [実装](https://github.com/elixir-lang/elixir/blob/v1.13.3/lib/elixir/lib/integer.ex#L273-L313)

https://github.com/elixir-lang/elixir/blob/v1.13.3/lib/elixir/lib/integer.ex#L273-L313

このあたりです。
ドキュメント中の`</>`が押せますので気になる方は迷わず押してみましょう。

![スクリーンショット 2022-04-02 23.38.35.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ce582d48-2019-8d38-d78d-dd2d4cd8904a.png)

リンク先のソースコードの解説はいたしますまい。

以下の箇所には高い芸術性を感じます。

```elixir
  digits = [{?0..?9, -?0}, {?A..?Z, 10 - ?A}, {?a..?z, 10 - ?a}]

  for {chars, diff} <- digits,
      char <- chars do
    digit = char + diff

    defp count_digits_nosign(<<unquote(char), rest::bits>>, base, count)
         when base > unquote(digit) do
      count_digits_nosign(rest, base, count + 1)
    end
  end
```



---



# [Float.parse/1](https://hexdocs.pm/elixir/Float.html#parse/1)

公式の説明をそのまま掲載します。

![スクリーンショット 2022-04-02 23.56.16.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ffd72e05-c0b9-d434-16e4-04c7efc54146.png)



## Specs

`https://hexdocs.pm/elixir/Float.html#parse/1`

引数を1つ取ります。

戻り値は、2種類あります。

- 変換に成功した場合は2要素のタプルです
    - 最初の要素は変換したfloatです
    - 2番目の要素は変換できなかった文字列です
- 変換に失敗した場合は `:error`アトムです

## [Examples](https://hexdocs.pm/elixir/Float.html#parse/1-examples)

公式に書いてある[Examples](https://hexdocs.pm/elixir/Float.html#parse/1-examples)をそのまま掲載しておきます。

```elixir
iex> Float.parse("34")
{34.0, ""}

iex> Float.parse("34.25")
{34.25, ""}

iex> Float.parse("56.5xyz")
{56.5, "xyz"}

iex> Float.parse("pi")
:error
```

使い方はこれでばっちりですね :thumbsup::thumbsup_tone1::thumbsup_tone2::thumbsup_tone3::thumbsup_tone4::thumbsup_tone5: 

## [実装](https://github.com/elixir-lang/elixir/blob/v1.13.3/lib/elixir/lib/float.ex#L115-L151)

https://github.com/elixir-lang/elixir/blob/v1.13.3/lib/elixir/lib/float.ex#L115-L151

このあたりです。
ドキュメント中の`</>`が押せますので気になる方は迷わず押してみましょう。

![スクリーンショット 2022-04-02 23.46.32.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d61ef253-0e04-5b63-a4cd-5f4eab2c69b2.png)


リンク先のソースコードの解説はいたしますまい。


---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

本日は、以下をご紹介しました。


- [Integer.parse/2](https://hexdocs.pm/elixir/Integer.html#parse/2)
- [Float.parse/1](https://hexdocs.pm/elixir/Float.html#parse/1)

私はドキュメント中の **Specs** （例: `parse(binary(), 2..36) :: {integer(), remainder_of_binary :: binary()} | :error`） を見てみぬふりをしてきました。
`Examples`と照らし合わせながらみることでうっすら見えるようになった気がしてきました。

**観の目強く、見の目弱く**

https://www.nhk.or.jp/meicho/famousbook/54_gorinnosyo/motto.html

以上です。

