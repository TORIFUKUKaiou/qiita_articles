---
title: 'All your codebase are belong to us. ーー ZigのHello, world!'
tags:
  - ZIG
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-01-19T23:11:23+09:00'
id: 8dd486a2d12dd44e371e
organization_url_name: fukuokaex
slide: false
---
**山中の賊を破るは易く心中の賊を破るは難し**

Advent Calendar 2022 4日目[^1]の記事です。
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

昨日「[Fortranをはじめる(Nervesにてはじめる前の準備運動を開始)](https://qiita.com/torifukukaiou/items/9494767af2816d1b607c)」という記事を書きました。

@mnishiguchi さんから[Zig](https://ziglang.org/)なるものを教えてもらいました。
とりあえず[Zig](https://ziglang.org/)単体で、`Hello, World`してみます。
近いうちに[Nerves](https://www.nerves-project.org/)と組み合わせて、アレした〜　コレした〜 を書いてみたいとおもっています。


<blockquote class="twitter-tweet"><p lang="en" dir="ltr">This is huge news. Zig can now create Erlang/Elixir NIFs and cross compile them to all major OSes. But eg Rust can cross compile too, right? Right, it can do that for Rust code. But Zig can cross compile both Zig *and* C/C++ code. Let that sink in for a minute. <a href="https://twitter.com/hashtag/MyElixirStatus?src=hash&amp;ref_src=twsrc%5Etfw">#MyElixirStatus</a> <a href="https://t.co/sxW4d4pqid">https://t.co/sxW4d4pqid</a></p>&mdash; Wojtek Mach (@wojtekmach) <a href="https://twitter.com/wojtekmach/status/1477196958179680256?ref_src=twsrc%5Etfw">January 1, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

この記事では、[Elixir](https://elixir-lang.org/)には触れません。

# [Zig](https://ziglang.org/)の公式ページ

[Zig](https://ziglang.org/)

> Zig is a general-purpose programming language and toolchain for maintaining **robust**, **optimal**, and **reusable** software.

2015年に誕生したプログラミング言語とのことで、**Young**です。

Qiita内では2022/01/03 18:41現在、[ZIG](https://qiita.com/tags/zig)のTagが付いた記事は私の記事を入れて6本です。

公式のトップには以下のプログラムが書いてあります。

```zig
const std = @import("std");
const json = std.json;
const payload =
    \\{
    \\    "vals": {
    \\        "testing": 1,
    \\        "production": 42
    \\    },
    \\    "uptime": 9999
    \\}
;
const Config = struct {
    vals: struct { testing: u8, production: u8 },
    uptime: u64,
};
const config = x: {
    var stream = json.TokenStream.init(payload);
    const res = json.parse(Config, &stream, .{});
    // Assert no error can occur since we are
    // parsing this JSON at comptime!
    break :x res catch unreachable;
};
pub fn main() !void {
    if (config.vals.production > 50) {
        @compileError("only up to 50 supported");
    }
    std.log.info("up={d}", .{config.uptime});
}
```

おそらくは、`up=9999`が出力されるものとおもいます。
本当にそうなのか、インストールから取り組んでみます。


# インストール

[Getting Started](https://ziglang.org/learn/getting-started/)をご参照ください。

私は、macOSを使っています。
[Homebrew](https://brew.sh/index_ja)にてインストールしました。

```bash
$ brew install zig
```

## (任意)VS Codeのプラグイン

https://marketplace.visualstudio.com/items?itemName=tiehuis.zig

[Tools](https://ziglang.org/learn/tools/)というドキュメントでススメられていました。

# Run Hello World

```
$ mkdir hello-world
$ cd hello-world
$ zig init-exe
```

こんなふうにファイルが作られます。

```tree
.
├── build.zig
└── src
    └── main.zig
```

とりあえず、`build.zig`はそっと閉じます。
`src/main.zig`を見てみます。

```zig:src/main.zig
const std = @import("std");

pub fn main() anyerror!void {
    std.log.info("All your codebase are belong to us.", .{});
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
```


## テスト

ほうほう、テストコードもあります。
テストからやってみます。
ファイル名を指定する必要があります。

```
$ zig test src/main.zig
```

当然パスします。
これまた当然、期待結果の`10`を`11`などに書き換えるとテストはコケます。


## Run

```bash
$ zig build run
```

<font color="purple">$\huge{All\ your\ codebase\ are\ belong\ to\ us.}$</font>

:tada::tada::tada:

`Hello, world!`ではなく、`All your codebase are belong to us.`と`zig init-exe`コマンドで作られたファイルに書いてあるので、その通りに出力されています。

一瞬、コンピュータが乗っ取られたのかと思いましたが、そんなことはありません[^2]。
安心してください。
そう書いてあるから、書いてある通りに出力されただけです。

[^2]: 「All your codebase are belong to us.」の話が好きで、私は[Zig](https://ziglang.org/)の虜になりそうです。そういう意味では私のパソコンはすっかり乗っ取られてしまったのかもしれません。

---

# All your codebase are belong to us.

ところでこの`All your codebase are belong to us.`という英文、
<font color="purple">$\huge{なんだか変}$</font>
です[^3]。

[^3]: ブームを起こしたことはすごいことです。私は「[ゼロウィング](https://ja.wikipedia.org/wiki/%E3%82%BC%E3%83%AD%E3%82%A6%E3%82%A3%E3%83%B3%E3%82%B0)」をプレイしたことはないし、何も関わってはいませんし、私だけの感じ方だとはおもいますが、これからももっともっと日本から英語で堂々と発信して行けばいいとおもっています。何か私も世界を驚かせるsomethingを残したいとおもっています。

Google翻訳や[DeepL](https://www.deepl.com/translator)に聞いてみましたが、どうもピンときません。

結論から言うと、日本発の**[ゼロウィング](https://ja.wikipedia.org/wiki/%E3%82%BC%E3%83%AD%E3%82%A6%E3%82%A3%E3%83%B3%E3%82%B0)**というゲームのヨーロッパ版の英訳を起源とするもので、一種のネタのようなものでした。

以下、リンクを示しておきます。

https://ja.wikipedia.org/wiki/All_your_base_are_belong_to_us

https://en.wikipedia.org/wiki/All_your_base_are_belong_to_us

https://www.gamespark.jp/article/2021/02/17/106148.html

https://h2g2.com/edited_entry/A19147205


さらに、**[ゼロウィング](https://ja.wikipedia.org/wiki/%E3%82%BC%E3%83%AD%E3%82%A6%E3%82%A3%E3%83%B3%E3%82%B0)**のゲームの内容は、

> 宇宙海賊「CATS」を倒すために、自機「ZIG-01」が8つの防衛基地に向けて発進するという内容となっている。[^1]

[^1]: https://ja.wikipedia.org/wiki/%E3%82%BC%E3%83%AD%E3%82%A6%E3%82%A3%E3%83%B3%E3%82%B0

とのことです。

[Zig](https://ziglang.org/)というプログラミング言語の由来は、**[ゼロウィング](https://ja.wikipedia.org/wiki/%E3%82%BC%E3%83%AD%E3%82%A6%E3%82%A3%E3%83%B3%E3%82%B0)**というゲームにありそうですが、正確なことは**わかりません。**

---

# 公式ページトップに載っているプログラムの実行結果

話をプログラミング言語[Zig](https://ziglang.org/)に戻します。

`src/main.zig`を[公式ページトップ](https://ziglang.org/)に載っているプログラムに書き換えます。

```zig:src/main.zig
const std = @import("std");
const json = std.json;
const payload =
    \\{
    \\    "vals": {
    \\        "testing": 1,
    \\        "production": 42
    \\    },
    \\    "uptime": 9999
    \\}
;
const Config = struct {
    vals: struct { testing: u8, production: u8 },
    uptime: u64,
};
const config = x: {
    var stream = json.TokenStream.init(payload);
    const res = json.parse(Config, &stream, .{});
    // Assert no error can occur since we are
    // parsing this JSON at comptime!
    break :x res catch unreachable;
};
pub fn main() !void {
    if (config.vals.production > 50) {
        @compileError("only up to 50 supported");
    }
    std.log.info("up={d}", .{config.uptime});
}
```

```
$ zig build run
```

<font color="purple">$\huge{info: up=9999}$</font>


# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Zig](https://ziglang.org/):bangbang::bangbang::bangbang:


<font color="purple">$\huge{All\ your\ codebase\ are\ belong\ to\ us.}$</font>

---

[Zig](https://ziglang.org/)の公式ページの下のほうにも書いてあります。

![スクリーンショット 2022-01-03 19.22.48.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/afe96dd2-b5b8-3cd8-47fb-6286f79c6a4d.png)


---

# "Zig" in Japanese 

When Japanese folks hear "zig", they think of the below songs.
We hope you enjoy them.

[近藤真彦　スニーカーぶる～す](https://www.youtube.com/watch?v=1tm8GV6T_ZU) :video_camera: 
[シブがき隊　ZIG ZAG セブンティーン](https://www.youtube.com/watch?v=GCYrZQ70wxA) :video_camera: 


https://ja.wikipedia.org/wiki/%E6%B2%BB%E5%85%B7





