---
title: Zigで、B - FizzBuzz Sum問題を解いてみる
tags:
  - ZIG
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-01-05T23:31:32+09:00'
id: 47637b3f95ca843881a0
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**信長之代、五年、三年は持たるべく候。明年辺は公家などに成さるべく候かと見及び申候。左候て後、高ころびに、あおのけに転ばれ候ずると見え申候。藤吉郎さりとてはの者にて候**

Advent Calendar 2022 5日目[^1]です。
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[AtCoder](https://atcoder.jp/home)の[B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)を[Zig](https://ziglang.org/)で解いてみます。

[Zig](https://ziglang.org/)の`Hello, world!`的なことは下記の記事をご参照ください。

https://qiita.com/torifukukaiou/private/8dd486a2d12dd44e371e

この記事では、[Elixir](https://elixir-lang.org/)のことは取り扱っていません。

# [B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)

> AtCoderは、オンラインで参加できるプログラミングコンテスト(競技プログラミング)のサイトです。リアルタイムのコンテストで競い合ったり、約3000問のコンテストの過去問にいつでも挑戦することが出来ます。

[AtCoder](https://atcoder.jp/home)の[B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)問題とは次のような問題です。

例: 入力が5の場合、FizzBuzzの列は、`1,2,Fizz,4,Buzz`となり、数字だけを足し算して、7が答え

問題文は[リンク先]((https://atcoder.jp/contests/abc162/tasks/abc162_b))をご参照ください。

プログラミングの基本である

- 順次
- 分岐
- 繰り返し

が含まれている良問だとおもっています。




```zig:src/main.zig
//const builtin = @import("builtin");
const std = @import("std");
const io = std.io;
const fmt = std.fmt;

pub fn main() !void {
    const stdout = io.getStdOut().writer();
    const stdin = io.getStdIn();

    var line_buf: [20]u8 = undefined;

    const amt = try stdin.read(&line_buf);
    if (amt == line_buf.len) {
        try stdout.print("Input too long.\n", .{});
    }
    const line = std.mem.trimRight(u8, line_buf[0..amt], "\r\n");
    const n = try fmt.parseInt(u128, line, 10);

    var i: u128 = 1;
    var sum: u128 = 0;

    while (i <= n) {
        if (i % 3 == 0) {
        } else if (i % 5 == 0) {
        } else {
            sum += i;
        }

        i += 1;
    }

    try stdout.print("{d}\n", .{sum});
    return;
}
```

残念ながら、[AtCoder](https://atcoder.jp/home)では2022/01/03現在、まだ[Zig](https://ziglang.org/)を選べませんでしたので、手元で`zig build run`して自分で標準入力して結果を確かめました。

作成にあたって、以下のプログラム例を参考にしました。

https://github.com/ziglang/zig/blob/0.9.x/test/standalone/guess_number/main.zig

- 入力を受け取って整数に変換するところはもっとすっきり書けるのかもしれません
- `const n = try fmt.parseInt(u128, line, 10);`は、カンで`try`をつけています
    - `try`がないと、`i <= n`のところで、下記のエラーがでます
        - error: expected type 'u128', found 'std.fmt.ParseIntError!u128'

どうでもいい話ですが、ググるとRustの記事がよくでてきます。
Rustに似ているところがあるのでしょうか。



# Wrapping up :lgtm::lgtm::lgtm::lgtm:

Enjoy [Zig](https://ziglang.org/):bangbang::bangbang::bangbang:

2022年に流行る技術予想 ーー それは、[Zig](https://ziglang.org/)です:rocket::rocket::rocket:
