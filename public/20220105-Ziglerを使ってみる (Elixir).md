---
title: Ziglerを使ってみる (Elixir)
tags:
  - Elixir
  - ZIG
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-01-13T00:46:28+09:00'
id: 123a7f0d3c1373b2ad38
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**多勢は勢ひをたのみ、少数は一つの心に動く**

Advent Calendar 2022 6日目[^1]です。
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Zig](https://ziglang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[Elixir](https://elixir-lang.org/)から[Zig](https://ziglang.org/)を使ってみます。
[Zigler](https://github.com/ityonemo/zigler)という[Hex](https://hex.pm/)を利用することで簡単に使えます。

[Zig](https://ziglang.org/)の事始めは下記の記事をご参照ください。

https://qiita.com/torifukukaiou/items/8dd486a2d12dd44e371e

<font color="purple">$\huge{All\ your\ codebase\ are\ belong\ to\ us.}$</font>

# 前提
[Elixir](https://elixir-lang.org/)と[Zig](https://ziglang.org/)をインストールしておいてください。

[Zig](https://ziglang.org/)のインストールは下記をご参照ください。

https://ziglang.org/learn/getting-started/

macOS Catalinaでは動きました。

- Elixirは、1.13.1-otp-24
- Erlangは、24.2

macOS Montereyでは動かせていません :sob::sob::sob: 

:::note warn 
2台のmacのうち、1台のmacでは動きませんでしたというのが事実です。
何が原因なのかは、はっきりとはわかっていません。
macOS Montereyでは現状、動かないと言っているわけではなく、私の環境の方に問題があるような気がしています。
動かなかったmacのOSが、macOS Montereyでしたというだけの話です。
OSの違いのせいなのか、なにか環境構築に差異があるのか。
分かり次第、追って更新します。
:::


```
== Compilation error in file lib/example_zig2.ex ==
** (CompileError)  this zig compiler warning hasn't been incorporated into the parser.
Please file a report at:
https://github.com/ityonemo/zigler/issues 
warning(link): unexpected LD stderr: ld: dynamic main executables must link with libSystem.dylib for architecture x86_64

error(link): ld: dynamic main executables must link with libSystem.dylib for architecture x86_64

error: LDReportedFailure
Elixir.ExampleZig2...The following command exited with error code 1:
/Users/yamauchi/Documents/13_Elixir/hello_zigler/deps/zigler/zig/zig-macos-x86_64-0.8.1/zig build-lib /var/folders/q6/5rpg5x9n6rx6357m9vztp_w00000gp/T/.zigler_compiler/dev/Elixir.ExampleZig2/Elixir.ExampleZig2.zig -lc --cache-dir /private/var/folders/q6/5rpg5x9n6rx6357m9vztp_w00000gp/T/.zigler_compiler/dev/Elixir.ExampleZig2/zig-cache --global-cache-dir /Users/yamauchi/.cache/zig --name Elixir.ExampleZig2 --version 0.1 -dynamic -target x86_64-macos-gnu -isystem /Users/yamauchi/.asdf/installs/erlang/24.2/erts-12.2/include --enable-cache 
error: the following build command failed with exit code 1: 
/private/var/folders/q6/5rpg5x9n6rx6357m9vztp_w00000gp/T/.zigler_compiler/dev/Elixir.ExampleZig2/zig-cache/o/8c3e0f616e375fbbe7a75842e9d66c5a/build /Users/yamauchi/Documents/13_Elixir/hello_zigler/deps/zigler/zig/zig-macos-x86_64-0.8.1/zig /private/var/folders/q6/5rpg5x9n6rx6357m9vztp_w00000gp/T/.zigler_compiler/dev/Elixir.ExampleZig2 /private/var/folders/q6/5rpg5x9n6rx6357m9vztp_w00000gp/T/.zigler_compiler/dev/Elixir.ExampleZig2/zig-cache /Users/yamauchi/.cache/zig

    (zigler 0.8.1) lib/zig/parser/error.ex:54: Zig.Parser.Error.parse/2
    (zigler 0.8.1) lib/zig/command.ex:30: Zig.Command.compile/2
    (zigler 0.8.1) lib/zig/compiler.ex:99: Zig.Compiler.compilation/2
    (zigler 0.8.1) expanding macro: Zig.Compiler.__before_compile__/1
    lib/example_zig2.ex:1: ExampleZig2 (module)
```

役に立つかどうかは不明ですが、同じログのIssueをみつけたのでコメントを追記しておきました。

https://github.com/ityonemo/zigler/issues/285#issuecomment-1011095756



# サンプル

```bash
$ mix new hello_zigler
```

[Zigler](https://github.com/ityonemo/zigler)を使えるようにします。

```elixir:mix.exs
  defp deps do
    [
      {:zigler, "~> 0.8.1", runtime: false}
    ]
  end
```

```bash
$ mix deps.get
```

[Zig](https://ziglang.org/)で書いたプログラムを[Elixir](https://elixir-lang.org/)で使えるようにします。

```elixir:lib/example_zig.ex
defmodule ExampleZig do
  use Zig
  ~Z"""
  /// nif: example_fun/2
  fn example_fun(value1: f64, value2: f64) bool {
    return value1 > value2;
  }
  """
end
```

たったこれだけです :tada:


# Run

```bash
$ iex -S mix
```

```elixir
iex> ExampleZig.example_fun(0.8, -0.8)
true

iex> ExampleZig.example_fun(0.1, 0.4)
false
```



# Wrapping up :lgtm::lgtm::lgtm::lgtm:

この記事では[Zig](https://ziglang.org/)で作った大小比較をする関数を[Elixir](https://elixir-lang.org/)から呼び出しているだけです。

**千里の道も一歩から。**
[Zig](https://ziglang.org/)力の向上とともにあんなことやこんなことを楽しめる気がしています。

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:


2022年に流行る技術予想 ーー それは、[Zig](https://ziglang.org/)です:rocket::rocket::rocket:
