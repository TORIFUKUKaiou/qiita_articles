---
title: >-
  TRICK2022(超絶技巧Ruby意味不明コンテスト for RubyKaigi)で金賞を獲得されたプログラム(Quine)を動かしてみました ーー
  高校生向けプログラミング講座「福岡県Rubyキャンプ」にて
tags:
  - Ruby
  - Elixir
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-12-17T21:09:44+09:00'
id: 84c03b8d31c19ca20711
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/advent-calendar/2022/ruby

# はじめに

TRICK2022(超絶技巧Ruby意味不明コンテスト for RubyKaigi)で金賞を獲得されたプログラム(Quine)を動かしてみます。

動かしてみたきっかけとなったのは、福岡県Ruby・コンテンツビジネス振興会議さんと福岡県さんが主催された「[高校生向けプログラミング講座「福岡県Rubyキャンプ」](https://www.pref.fukuoka.lg.jp/press-release/ruby-camp2022.html)」にて、コーチとして参加したことです。詳しくは後述します。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">先月、TRICK2022(超絶技巧Ruby意味不明コンテスト for RubyKaigi)で金賞をとってきたプログラム(Quine)です。<br>全てのフレームが、魚達がその場所から泳ぎを再開する実行可能なRubyのコードになっています。<br>魚・水草・泡でコードの一部が欠落していますが、誤り訂正により復元しています。 <a href="https://t.co/vQsGG5o7Of">pic.twitter.com/vQsGG5o7Of</a></p>&mdash; ぺん！ (@tompng) <a href="https://twitter.com/tompng/status/1582322388678549504?ref_src=twsrc%5Etfw">October 18, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

# TRICK2022(超絶技巧Ruby意味不明コンテスト for RubyKaigi)で金賞を獲得されたプログラム(Quine)を動かす

さっそく動かしてみます。
Dockerを使ってみます。

```bash:CMD
git clone https://github.com/tric/trick2022.git
cd trick2022/01-tompng
docker pull ruby:3.1.0-alpine3.15
docker run --rm -v $PWD:/app ruby:3.1.0-alpine3.15 sh -c "cd /app && bundle install && bundle exec ruby entry.rb"
```

動きましたよ :tada::tada::tada::tada::tada: 

![スクリーンショット 2022-11-14 8.16.30.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8f4733f2-863d-3154-7837-6f18e4eab7b3.png)

:qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan::qiitan:

# [高校生向けプログラミング講座「福岡県Rubyキャンプ」](https://www.pref.fukuoka.lg.jp/press-release/ruby-camp2022.html)

私は、コーチとして参加しました。
このキャンプを主導するような立場ではなく、協力者の一人としてコーチに、名乗るほどのものでもないのですが、名乗りを挙げてキャンプの一部分に参加しました。
私の主な役割は、**高校生といっしょに[Ruby](https://www.ruby-lang.org/ja/)のプログラミングを楽しむこと**です。
今回がはじめての取り組みで、第一回開催とのことです。

日程は、2022年の１１月５日（土）、６日（日）と１１月１２日（土）、１３日（日）の四日間で行われました。
約３０名の高校生が自らの意思で参加を決めたそうです。

豪華なカリキュラムでした。
なんと[まつもとゆきひろ](https://twitter.com/yukihiro_matz)さんと九州工業大学の[田中和明](https://www.ccr.kyutech.ac.jp/professors/iizuka/i3/i3-2/entry-714.html)先生の講演付きです。
私は１１月１２日（土）と１３日（日）に参加して高校生2人とともに[Ruby](https://www.ruby-lang.org/ja/)でプログラミングすることを楽しみました。

![スクリーンショット 2022-11-14 9.30.58.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/280f3467-4a03-03f4-19f0-3b888336f80c.png)


[まつもとゆきひろ](https://twitter.com/yukihiro_matz)さんの講演のときに、TRICK2022(超絶技巧Ruby意味不明コンテスト for RubyKaigi)で金賞を獲得されたプログラム(Quine)の話が少しでてきたそうです。高校生から自分たちでも動かしてみたい！、ソースコードをみてみたい！　とのことでしたので動かすことを楽しみました。

[ソースコード](https://github.com/tric/trick2022/blob/master/01-tompng/entry.rb)にも技巧が含まれていました！

```ruby:entry.rb 
                               eval((s=%~c=(0..35
                         ).map{s[2*_1+1]}*'';class$Inte
                     ger;def$quXinclude(Math ;spXo(a)=self*
                 a.pow(87X=h=32.chr;g=PI/480;ls=(sp*31X,89)%89;
               def$abX+'eval((s=%'+(n=? .next)+s*88.chr+[nXs()=[a
            =self%X+'.split(',sp*25+'?'+88.chr+');(0..36).mapX89,89-
          a].miX{s[2*_1].split}',sp*31+".join.tr('$',$/)))"]*$/)Xn;end
         ;reqX.split$/;trap(:INT){puts;exit};q=->t,i{a,y=((t+i*99)Xuire
       'matrX%960). ivmod(80);[(a*(7+i)+i*23)%79+(y+a)/(5+i%4)%2,39Xix';1
      5.tiX-y/2]};p=->t,u{a=->b,c{(0..5).sum{(u%2-1)*E**(t*(b+c*_1)*gXmes{
     |i,*X.i+ i*u+=5+sin(u*u))}};x,z=a[5,3].           5,3].rect;x+=y.Xv|z=
    *?!Xi a[19,4];z+=w;r=(4+(x.abs+z.i).ab                };t=(0..959).fX..?
   W,?Xind{|t|(0..29).all?{x,y=q[t,_1];(x                   2||h=ls[y][x]X[,*
  ?]..X[/[^!-}]/]}};h=($**h+h).chr;eval(                     []}   ->(x,yX?};a
  =(0X,a,b){x=x*36+39.5;y=19.5-y*18;b*=1                            |i|((yX..1
 34)X-b).ceil..y+b).map{|j|((x-i)/a+(y j)/                          .times{X.ma
 p{zXx,z=p[t,_1];l=u```=0;while``````(l<1)``;          u+```=0      ;d=x-y;X.in
dex(Xl+=(d.abs+(z-w``)``.i).ab``s*1.``1 ;x``,z=y``,w;o[v``=``x.r    d.imag/Xc[i+
15*Xd.abs*l*sin(2*``l-t``*g*80``-_1)         l*(``1-l)/``6,a``=l*( -l)**2*0.X_1]
)};X7,a*2]&&o[v,z,``0.0``3,l**``                ``times``{|i``|(8+i).times{|Xw=*
MatXj|o[sin(i)/2+````` ```sin(                   `/2.0`````````)*j/200,j*0.0Xrix
[*(X5-1,0.02,0.1]``}}   ``.                       q[t,``_1];m``[y][x]= };i=-X0..
44).X1;$><<(['%%','[H                            .map{|j|(0..79).map{|k|x=(Xmap{
 |i,X -39.5)/35.8;y=(                            i+=1;m[j][k]?h:c[i]):ls[j]X*b|
 v<<X[k];}*''}*$/<<0)      1)%9                     te"`")#qv.jSaL{=;q(Q}4fXa.z
  ip(Xjs(:#tK`Jm))FKO   /A9(2'%iorvf7 eEa0uV          xv+Q@qUU](L@&Py .1v'X0..
  ).suXydSEH{-GI|-5(,z   G5evpq,[b50  D[   t          {on,I?VStS`?G@LoqFCXm{|j
   ,k|Xj1.QnxKz!mH%o#    )b2Seut,]!   48              lBieJGi 5jeNPD#b}H3X-(p
    =(iXaVz#8*+US,hgF     5#6]y-`    4hy               HN hF75WjD!0IxJ$sX+k)
     .powX+UP"cNUE9-  G<  tHvV;Ib    <-s           U  T ?  vlE xylg=x#X(i+k
      ,88)XV9u$9lKb9  @C   do7+-w   >l {     v9   {   P l  ga%]AK<e&'X+1)*
       (j||(X4ifK/6S+  k}   @@*a}  6rS      xn"Q[M   8    `|g>$#BrjXb<<p;
         0))}XtbDp'Kc   t2  Dat9C  s C  rL+ g,j]Tf  B<    eMI+zzkWX;b}]
          .lup.XtVP<ak  IM  E/+)B  jwv  uB  (Twqed  D*   dyf_dT7Xsolve
            (v);13Xn:8  #_  RiSTO,  [Fk  m  O]O#"+  a_   cT_.X5.time
               s{c[i+X  e5  T`FBEC  q*f  2 o@{a<eUG aW   PX15*_1]
                 =z[a[_1]X z_@`nll  7F1  2 [=^uS0z^  6X||w.shif
                     t]}};eval(Xfg  K#R  N bp-E_Xc)~.split(
                         ?X);(0..36).map{s[2*_1].split}
                               .join.tr('$',$/)))
```

# 感心したこと

[高校生向けプログラミング講座「福岡県Rubyキャンプ」](https://www.pref.fukuoka.lg.jp/press-release/ruby-camp2022.html)の最後に、参加した高校生一人ひとりから感想を述べてもらうコーナーがありました。
おおよそ 2/3の高校生が、家で引き続き[Ruby](https://www.ruby-lang.org/ja/)をやってみよう！　とおっしゃっていました。
将来が楽しみです。


# パラシュート部隊の[斉藤優](https://twitter.com/nisijinboy)さんが取材にいらっしゃる！

[高校生向けプログラミング講座「福岡県Rubyキャンプ」](https://www.pref.fukuoka.lg.jp/press-release/ruby-camp2022.html)の様子は、TV局の取材がありました。

<blockquote class="twitter-tweet"><p lang="ja" dir="ltr">合同庁舎で知っトクふくおかロケ <a href="https://t.co/fPYcGiWcFs">pic.twitter.com/fPYcGiWcFs</a></p>&mdash; パラシュート部隊斉藤優 (@nisijinboy) <a href="https://twitter.com/nisijinboy/status/1591620111634661376?ref_src=twsrc%5Etfw">November 13, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

パラシュート部隊の[斉藤優](https://twitter.com/nisijinboy)さんが取材にいらっしゃいました。
「いつもTVで見ています」とおそれ多くも声をかけさせていただきました。
芸能人の方、特有のアレ ーー やはりオーラがでていました。

<iframe width="963" height="542" src="https://www.youtube.com/embed/2Do-Jsg6g38" title="未来のITエンジニアを育成！Rubyキャンプ 【優＆舞の知っトク！ふくおか】" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

# [Ruby](https://www.ruby-lang.org/ja/)と[Elixir](https://elixir-lang.org/)

私の記事では、[Elixir](https://elixir-lang.org/)のことを必ず触れることにしています。

```elixir
iex> "Elixir" |> String.graphemes() |> Enum.frequencies()
%{"E" => 1, "i" => 2, "l" => 1, "r" => 1, "x" => 1}

iex> "A PROGRAMMER'S BEST FRIEND" |> String.graphemes() |> Enum.frequencies()
%{
  " " => 3,
  "'" => 1,
  "A" => 2,
  "B" => 1,
  "D" => 1,
  "E" => 3,
  "F" => 1,
  "G" => 1,
  "I" => 1,
  "M" => 2,
  "N" => 1,
  "O" => 1,
  "P" => 1,
  "R" => 4,
  "S" => 2,
  "T" => 1
}
```

[Elixir](https://elixir-lang.org/)の作者[José Valim](https://twitter.com/josevalim)さんは、[Elixir](https://elixir-lang.org/)を作る上で影響を受けた言語に[Ruby](https://www.ruby-lang.org/ja/)を挙げられています。

[José Valim - Cognicast Episode 120](https://cognitect.com/cognicast/120)

> The main, the top three influences are Erlang, Ruby, and Clojure.

完全に私見です。
[Elixir](https://elixir-lang.org/)が[Ruby](https://www.ruby-lang.org/ja/)から一番色濃く影響を受けているのは、 **A PROGRAMMER'S BEST FRIEND** だとおもっています。**A PROGRAMMER'S BEST FRIEND** は、[Ruby](https://www.ruby-lang.org/ja/)の公式ページの先頭のところに書いてあります。
[Elixir](https://elixir-lang.org/)にのめり込むと自然と海外の方との交流が増えます。出会う人がみな親切でジェントルマンです。国内のコミュニティもそうです。みなマヂでいい人ばっかりです。

![スクリーンショット 2022-11-14 11.53.20.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f7736594-6606-1475-1d9b-d856fbb8664a.png)





# おわりに

TRICK2022(超絶技巧Ruby意味不明コンテスト for RubyKaigi)で金賞を獲得されたプログラム(Quine)を動かしてみました。

きっかけとなりましたのは、「[高校生向けプログラミング講座「福岡県Rubyキャンプ」](https://www.pref.fukuoka.lg.jp/press-release/ruby-camp2022.html)」に一コーチとして参加したことです。
高校生たちのますますの活躍が楽しみです。
