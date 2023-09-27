---
title: AtCoderのB - FizzBuzz Sum問題をC#で解くことを楽しむ
tags:
  - C#
  - AtCoder
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-04-17T21:21:38+09:00'
id: 4c4d6f9a295fa2121eab
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
**み垣もり衛士のたく火の夜はもえ昼は消えつつものをこそ思へ**

Advent Calendar 2022 101日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

この記事は、[AtCoder](https://atcoder.jp/)の[B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)問題をC#で解いてみます。

私はC#初心者です。
なにかのタイミングで「C#やってみます！」と元気よく書いた気がするので、おもむろに[AtCoder](https://atcoder.jp/)をC#で解いてみます。
[B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)問題は良い問題だとおもっています。


# [AtCoder](https://atcoder.jp/)とは?

> AtCoderは、世界最高峰の競技プログラミングサイトです。
> リアルタイムのオンラインコンテストで競い合うことや、
> 3,000以上の過去問にいつでもチャレンジすることができます。

https://atcoder.jp/

# プログラム


```cs
using System;
 
class Program
{
    static void Main()
    {
        long n = long.Parse(Console.ReadLine());
        long sum = 0;
        for (long i = 1; i <= n; i++)
        {
            if (i % 3 == 0 || i % 5 == 0) {
                continue;
            } else {
                sum += i;
            }
         }
         Console.WriteLine($"{sum}");
    }
}
```

`C#(.NET Core 3.1.201)` でパスしました。

---

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:


この記事は、[AtCoder](https://atcoder.jp/)の[B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)問題をC#で解いてみました




以上です。





---

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>

I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)

---

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">We appreciate this shoutout, Torifuku! <a href="https://t.co/dThmJg4CYN">pic.twitter.com/dThmJg4CYN</a></p>&mdash; ClickUp (@clickup) <a href="https://twitter.com/clickup/status/1513541411634913284?ref_src=twsrc%5Etfw">April 11, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script> 






