---
title: is_number/1 の実装を追いかけてみることを楽しむ（Elixir）
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-04-10T17:52:16+09:00'
id: e392052f4339d5f795e5
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
**白露に風の吹きしく秋の野はつらぬきとめぬ玉ぞ散りける**


---

Advent Calendar 2022 88日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[My Advent Calendar 2022](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955) goes behind 8 days.
NP.

[is_number/1](https://hexdocs.pm/elixir/Kernel.html#is_number/1)を読んでみます。

# is_xxx [Guards](https://hexdocs.pm/elixir/Kernel.html#module-guards)

ある`term`があったときにそれが何であるのかを判定する[Guards](https://hexdocs.pm/elixir/Kernel.html#module-guards)と呼ばれるものがあります。

`is_`という接頭辞で始まります。
以下のものがあります。
たとえば、[is_atom/1](https://hexdocs.pm/elixir/Kernel.html#is_atom/1)は、`term`が[Atom](https://elixir-lang.org/getting-started/basic-types.html#atoms)である場合に`true`、それ以外の場合には`false`が返ります。

- [is_atom/1](https://hexdocs.pm/elixir/Kernel.html#is_atom/1)
- [is_binary/1](https://hexdocs.pm/elixir/Kernel.html#is_binary/1)
- [is_bitstring/1](https://hexdocs.pm/elixir/Kernel.html#is_bitstring/1)
- [is_boolean/1](https://hexdocs.pm/elixir/Kernel.html#is_boolean/1)
- [is_exception/1](https://hexdocs.pm/elixir/Kernel.html#is_exception/1)
- [is_exception/2](https://hexdocs.pm/elixir/Kernel.html#is_exception/2)
- [is_float/1](https://hexdocs.pm/elixir/Kernel.html#is_float/1)
- [is_function/1](https://hexdocs.pm/elixir/Kernel.html#is_function/1)
- [is_function/2](https://hexdocs.pm/elixir/Kernel.html#is_function/2)
- [is_integer/1](https://hexdocs.pm/elixir/Kernel.html#is_integer/1)
- [is_list/1](https://hexdocs.pm/elixir/Kernel.html#is_list/1)
- [is_map/1](https://hexdocs.pm/elixir/Kernel.html#is_map/1)
- [is_map_key/2](https://hexdocs.pm/elixir/Kernel.html#is_map_key/2)
- [is_nil/1](https://hexdocs.pm/elixir/Kernel.html#is_binary/1)
- [is_number/1](https://hexdocs.pm/elixir/Kernel.html#is_number/1)
- [is_pid/1](https://hexdocs.pm/elixir/Kernel.html#is_pid/1)
- [is_port/1](https://hexdocs.pm/elixir/Kernel.html#is_port/1)
- [is_reference/1](https://hexdocs.pm/elixir/Kernel.html#is_reference/1)
- [is_struct/1](https://hexdocs.pm/elixir/Kernel.html#is_struct/1)
- [is_struct/2](https://hexdocs.pm/elixir/Kernel.html#is_struct/2)
- [is_tuple/1](https://hexdocs.pm/elixir/Kernel.html#is_tuple/1)


# [is_number/1](https://hexdocs.pm/elixir/Kernel.html#is_number/1)

上記の中で、[is_number/1](https://hexdocs.pm/elixir/Kernel.html#is_number/1)は、`term`が整数やFloatである場合に`true`、それ以外の場合には`false`が返ります。

どういうふうに実装されているのだろうと気になりました。
気になったものは仕方ありません。
人間の好奇心は誰にも止められません。

もう少し言葉にしてみると、ある変数を宣言するときに[Elixir](https://elixir-lang.org/)では型とともに宣言しないので、型がなにであるかを確かめるのは結構複雑なことをしないとわからないのではないかとおもいました。
複雑な[Elixir](https://elixir-lang.org/)の実装に出会えるのではないかとワクワクドキドキしました。
はたしていかに:interrobang:

調べたことは、Qiitaに書いておきます。

# `[</>]` を押してみます

[is_number/1](https://hexdocs.pm/elixir/Kernel.html#is_number/1)のドキュメントに行きます。

https://hexdocs.pm/elixir/Kernel.html#is_number/1

`[</>]`のリンクを押してみましょう。

https://github.com/elixir-lang/elixir/blob/v1.13.3/lib/elixir/lib/kernel.ex#L726

迷わず押せよ！
押せばわかるさ！
ありがとう！

```elixir:lib/elixir/lib/kernel.ex
  def is_number(term) do
    :erlang.is_number(term)
  end
```

ほうほう、たったのこれだけでした。
Erlangの`is_number`を呼び出していました。


# Erlangの`is_number`

Erlangに深入りしてみます。

https://github.com/erlang/otp/blob/55a65f83e8f6b3c8301ea57ee91aeaff3b984a9d/erts/preloaded/src/erlang.erl#L2262-L2266

```erlang:erts/preloaded/src/erlang.erl#L2262-L2266
%% Shadowed by erl_bif_types: erlang:is_number/1
-spec is_number(Term) -> boolean() when
      Term :: term().
is_number(_Term) ->
    erlang:nif_error(undefined).
```

最後はCで実装されているようです。
断片だけ示しておきます。
ちゃんと追えているのかあんまり自信はありません。

https://github.com/erlang/otp/blob/2b6df21c480b730159e8849af7facca9f6bdcfe9/erts/emulator/beam/erl_term.h#L1301

```c:erts/emulator/beam/erl_term.h
#define is_number(x)		(is_integer(x) || is_float(x))
```

ここからは、`is_integer`のほうに進んでみます。

https://github.com/erlang/otp/blob/2b6df21c480b730159e8849af7facca9f6bdcfe9/erts/emulator/beam/erl_term.h#L1299

```c:erts/emulator/beam/erl_term.h
#define is_integer(x)		(is_small(x) || is_big(x))
```

また `||`になっています。
ここからは、`is_small`のほうに進んでみます。 

https://github.com/erlang/otp/blob/2b6df21c480b730159e8849af7facca9f6bdcfe9/erts/emulator/beam/erl_term.h#L263

```c:erts/emulator/beam/erl_term.h#L263
#define is_small(x)	(((x) & _TAG_IMMED1_MASK) == _TAG_IMMED1_SMALL)
```

https://github.com/erlang/otp/blob/2b6df21c480b730159e8849af7facca9f6bdcfe9/erts/emulator/beam/erl_term.h#L80

```c:erts/emulator/beam/erl_term.h
#define _TAG_IMMED1_MASK	0xF
```

https://github.com/erlang/otp/blob/2b6df21c480b730159e8849af7facca9f6bdcfe9/erts/emulator/beam/erl_term.h#L84

```c:erts/emulator/beam/erl_term.h
#define _TAG_IMMED1_SMALL	((0x3 << _TAG_PRIMARY_SIZE) | TAG_PRIMARY_IMMED1)
```

![スクリーンショット 2022-04-06 23.10.05.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8c611eed-b8d0-ba08-142b-5bfd9a9eacaf.png)

調べ方は、[Erlangのリポジトリ](https://github.com/erlang/otp)で、左上の`Search or jump to...`にキーワードを打ち込んで、でてきた結果を眺めました。
並べました。






---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

[is_number/1](https://hexdocs.pm/elixir/Kernel.html#is_number/1)の実装を追いかけてみました。
Erlangの`is_number`を呼び出しているだけでした。

Erlangに入ってからは、ちゃんと追いかけられているかどうかはあんまり自信はありません。



以上です。





