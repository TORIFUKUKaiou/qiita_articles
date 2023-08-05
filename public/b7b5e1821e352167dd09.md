---
title: Fortranで、B - FizzBuzz Sum問題を解いてみる
tags:
  - Fortran
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-01-19T23:32:55+09:00'
id: b7b5e1821e352167dd09
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**海道一の弓取り**

Advent Calendar 2022 9日目[^1]です。
**:santa:2022/12/25が来るのが待ち遠しいです。**
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[AtCoder](https://atcoder.jp/home)の[B - FizzBuzz Sum](https://atcoder.jp/contests/abc162/tasks/abc162_b)を[Fortran](https://fortran-lang.org/)で解いてみます。

[Fortran](https://fortran-lang.org/)に興味をもったきっかけは、[Nerves](https://www.nerves-project.org/)で、Fortranが使えるようになるらしいからです。

https://qiita.com/torifukukaiou/items/9494767af2816d1b607c


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


```fortran:hello.f
      PROGRAM HELLO
      INTEGER(8) :: J
      READ (*, *) N
      I = 1
      J = 0
      DO WHILE (I .LE. N)
        IF ((MOD(I, 3) .NE. 0) .AND. (MOD(I, 5) .NE. 0)) THEN
          J = J + I
        ENDIF
        I = I + 1
      END DO
      PRINT '(i0)', J
      END PROGRAM HELLO
```

たったこれだけのことを書くのに、いろいろ詰まりました。
なにせ私は、[Fortran](https://fortran-lang.org/)初心者なので。

実行環境はDockerで用意しました。

```docker:Dockerfile
FROM alpine

WORKDIR /home/fortran
RUN set -x && \
    apk update && \
    apk add --no-cache gfortran musl-dev

CMD ["/bin/sh"]
```

```yml:docker-compose.yml
version: '3'
services:

  fortran:
    build: .
    container_name: fortran
    volumes:
      - .:/home/fortran
    tty: true
```

# Run

ローカルでの実行は以下の感じです。

```bash
$ docker-compose run --rm fortran gfortran hello.f -o hello 
$ docker-compose run --rm fortran ./hello
```

[AtCoder](https://atcoder.jp/home)はもちろんパスします。

https://atcoder.jp/contests/abc162/submissions/28338552

![スクリーンショット 2022-01-05 22.04.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c3c89d43-f103-30e0-03b4-692b98e1bcc5.png)



# Wrapping up :lgtm::lgtm::lgtm::lgtm:

Enjoy [Fortran](https://fortran-lang.org/):bangbang::bangbang::bangbang:

2022年に流行る技術予想 ーー それは、[Fortran](https://fortran-lang.org/) on [Nerves](https://www.nerves-project.org/)です:rocket::rocket::rocket:
