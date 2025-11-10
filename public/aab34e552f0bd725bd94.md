---
title: Qiitaで動く詰将棋──Kifu for JSで盤上をプログラムする
tags:
  - JavaScript
  - 将棋
  - 闘魂
  - AdventCalendar2025
  - AIではなく人間が書いてます
private: false
updated_at: '2025-11-10T09:02:12+09:00'
id: aab34e552f0bd725bd94
organization_url_name: null
slide: false
ignorePublish: false
---
## はじめに

Qiitaで将棋をします。

## 詰将棋をどうぞ

<p class="codepen" data-height="600" data-default-tab="html,result" data-slug-hash="JoXPdaY" data-pen-title="Untitled" data-user="TORIFUKUKaiou" style="height: 300px; box-sizing: border-box; display: flex; align-items: center; justify-content: center; border: 2px solid; margin: 1em 0; padding: 1em;">
      <span>See the Pen <a href="https://codepen.io/TORIFUKUKaiou/pen/JoXPdaY">
  Untitled</a> by Awesome YAMAUCHI (<a href="https://codepen.io/TORIFUKUKaiou">@TORIFUKUKaiou</a>)
  on <a href="https://codepen.io">CodePen</a>.</span>
      </p>
      <script async src="https://public.codepenassets.com/embed/index.js"></script>

出典: https://kifu-for-js.81.la/docs/getting-started/

## 動機

私は将棋が好きです。何の自慢にもなりませんが、超絶センスがありません。noteにいくつかエントリーを書いています。

https://note.com/awesomey/n/n3523082881bf

https://note.com/awesomey/n/nd381a26b74c2

https://note.com/awesomey/n/n4118bc944c27

https://note.com/awesomey/n/n39596ec899b0

9年前にはじめてやっと将棋ウォーズ10分切れ負け初段になりました。いい大人になってからはじめたので気になる棋書は片っ端から買いました。品揃えだけで言うと、アマ四段はないとおかしいくらい本格的なものを揃えています。
棋神頼りなところはありますが、初段になれたいまだからこそ、その自信と自負があるからこそ、ようやく棋書が言っている意味がわかってきたような気がします。「わかるようになりました」と明言を避けているのは、結局のところ、初段レベルでの理解しかできていないからです。真に理解したとはまだまだ言い難いです。ただ、級位者であったころよりはずいぶん書いてある意味が読み解けるようになったことは事実です。

さらに強くなりたいと思っています。センスのいい人は詰将棋だけやっていれば強くなるようです。しかし私のようにセンスが全くない人は強い人に教えてもらうのが一番の近道のようです。次の動画で紹介されているように、無意識の筋悪将棋をずっと繰り返しているだけでは強くなれないですし、駒の損得が局面によって異なることがちっとも理解できていないわけです。

<iframe width="1287" height="724" src="https://www.youtube.com/embed/qVPVxhf8Ic0" title="【将棋】棋力の壁に苦しむ人を救う動画【講座】" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>


強い人に習うと言っても、ド田舎に住んでおり、都会の将棋教室に通おうにも、時間も費用もかかります。そんなとき身近に師匠がいることに気づきました。[ぴよ将棋](https://www.studiok-i.net/piyo_shogi/)です。

ぴよ七段、めちゃくちゃ強いです。将棋ウォーズの段級位ともだいたい合っているように思います。つまり七段の人に教えてもらうわけです。平手つまりふつうの対局では全く相手にならないので、駒落ちというハンデをつけた対局をしてもらっています。師匠は厳しいです。言葉では教えてくれません。負けを重ねて、感想戦をして自分で問題点をみつけ、それを課題にして克服していくことを繰り返すしかありません。時間もかかると思うし、だいぶ遠回りだと思います。近くに教室があったり、経済的に余裕のある方は教室に通うことをオススメします。通っていないのに、いい加減なことをいいますが、やはり将棋というゲームは人から刺激を受けて強くなるという面があるように思います。

これもなんの自慢にもなりませんが、四枚落ちの勝率は現在のところ４割以下です。本当に初段の実力があるのか疑問です:sob:

## 駒落ち

駒落ちとは、強い人（上手うわて）がいくつかの駒をはずした状態からはじめます。飛車、角行を落とす二枚落ち、それに加え香車を落とす四枚落ち、さらに桂馬も落として六枚落ち、さらにさらに銀も落として八枚落ちとなります。

一局の流れを理解するには、駒落ちで序盤、中盤、終盤を学ぶのが一番よいのではないかと思いました。『将棋大観（木村義雄先生）』や『ひっかけ将棋入門（花村元司先生）』、『棒銀と中飛車で駒落ちを勝て！（高橋道雄先生）』などいい本を揃えています。さらに一冊加わりました。『【新装版】駒落ち定跡（所司和晴先生）』です。

著者の所司和晴先生が冒頭に「一家に一冊備え」たい書籍です。羽生善治永世七冠もおっしゃられています。「内容が上達に必要な栄養になっている」と。
帯には藤井聡太六冠の帯もついています。「私も将棋を覚えたての頃には、この本を読んで勉強しました」と。
そしてもしかすると、以下の大山康晴永世名人vs新宿の殺し屋小池重明の角落ちを並べていらっしゃったのかもしれません。

羽生善治永世七冠は、小学生のころに小池重明先生を見たことがあるようです。「生き様と同じで型破り将棋をする人でした。でも、とにかく強かった」

https://shogidb2.com/games/145711545493a4c8a4113ea1dc5fa66e30a12b27

<iframe width="965" height="724" src="https://www.youtube.com/embed/0KnQFFkv-ts" title="神業   真剣師 小池重明1" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

この本は、終盤の勝ち切るところまで書いてあるのがよいです。「終盤は駒の損得より速度」の格言のような手が最終盤にでてきて爽快です。私も実戦でそういう手をさせるようになりたいです。

## 【新装版】駒落ち定跡（所司和晴先生）

『【新装版】駒落ち定跡（所司和晴先生）』の書籍の内容が、出版社からウェブ上でもそのエッセンスが紹介されています。これはありがたいです。

https://book.mynavi.jp/shogi/detail/id=143647

## 再びの動機

そしてウェブ版ですので、JavaScriptで駒が動く解説付きです。これもありがたいです。ウェブ版でぽちぽち駒を動かして勉強していました。それでふと歯車（⚙️）アイコンのほうに目がうつりました。押してみると、次の画面が表示されました。もしかしてこれはGitHubに公開されていたりするのではないか。果たしてそうでした。ビンゴでした。

![スクリーンショット 2025-11-10 8.52.10.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e8075b7f-d106-495f-8cdb-1d2acc4de915.png)


https://kifu-for-js.81.la/

https://github.com/na2hiro/Kifu-for-JS

将棋の勉強もさることながら、一応、闘魂プログラマーの端くれですから、このライブラリにも興味を覚えました。そしてそれをQiitaアドベントカレンダーに書いてみようと思った次第です。ライブラリの使い方だけ書いてもおもしろくはないと思ったので、冒頭の詰将棋の掲載となるわけです。Qiita上で将棋がさせて面白いかなあと思いました。以下は知っているだけで使ったことがなかったので、記憶のそこからひっぱりだせてよかったです。

https://qiita.com/Qiita/items/edae7417214c8e957f54

これがこの記事を書いた動機です。

## さいごに

「[Qiitaで記事にCodePenが埋め込めるようになりました](https://qiita.com/Qiita/items/edae7417214c8e957f54)」の実例を示しました。
好きなこと書ける x 技術でいくらでも記事を書けそうです。今年は「闘魂 x 将棋 x Elixir x AWS」で書き続けられそうです。
