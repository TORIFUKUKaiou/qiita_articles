---
title: GitHubでプルリクを出したあとに、ブランチ名をGitHub上で変更したらプルリクがCloseになります
tags:
  - ポエム
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-01-19T23:36:24+09:00'
id: b182326f75d892d89f0e
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**見ればただなんの苦もなき水鳥の足に暇なきわが思いかな**

Advent Calendar 2022 14日目[^1]の記事です。
I'm ready for 12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I'm looking forward to  12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

<font color="purple">$\huge{Enjoy\ Elixir🚀🚀🚀}$</font>

今回は**GitHubでプルリクを出したあとに、ブランチ名をGitHub上で変更したらプルリクがCloseになっちゃった**という話です。
以上です。
内容としては本当に以上なのですがもう少し書いておきます。

# GitHubでプルリクを出したあとに、ブランチ名をGitHub上で変更したらプルリクがCloseになる

対象(事件?)はこのプルリクです。

https://github.com/livebook-dev/nerves_livebook/pull/148

マージされるか<font color="purple">$\huge{マヂ}$</font>ドキドキ :heartbeat: です。
[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)の歴史(コミット)に**名乗るほどのものでもない[^2]名**を残せるか否か。

ブランチ名が、`including_HTTPoison_in_the_default_dependency_list_in_mix_exs`です。
問題となるのはブランチ名中の**HTTPoison**です。
プルリクをだしたあと、「HTTPoisonより、[Req](https://hexdocs.pm/req/Req.html)のほうがいいんじゃないの？」とコメントをもらいました。
それで私は :bow::bow_tone1::bow_tone2::bow_tone3::bow_tone4::bow_tone5:
「ははあー、仰せのままに。御意:rocket:」となるわけです。
さっそく [Req](https://hexdocs.pm/req/Req.html)に変えて変更をPushです。
**[I force push](https://github.com/livebook-dev/nerves_livebook/pull/148#issuecomment-1012200097)**です。
通じました。
なんと<font color="purple">$\huge{Approved}$</font>されました。
まあ、このあともレビュー(審査)は続くでしょうからマージされるかどうかは現時点ではわかりません。
<font color="purple">$\huge{マヂ}$</font>
<font color="purple">$\huge{マ〜〜〜ジ}$</font>
されてほしいです。
名を残せる意味とそれで、アドベントカレンダー 2022を書けるからです。
アドベントカレンダー 2022は「マージされませんでした :sob::sob::sob:」でも書けるか :rocket::rocket::rocket:
お願いマージして :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:  

話を戻します。
HTTPoisonの追加を[Req](https://hexdocs.pm/req/Req.html)に変えたわけですから、実に日本人らしいというかプルリクしたブランチ名が気になります。
しかしながらプルリク自体はAlchemistにレビューしてもらって、しかもApprovedされているので、ブランチ名を変えて別のプルリクにはしたくないです。

そうだ！　GitHub上でブランチ名をリネームしたらうまいこといくんじぇねえ:interrobang:
とおもって気軽にやってみました。
果たして、GitHub上でブランチ名をリネームしたらプルリクがCloseされました。

![スクリーンショット 2022-01-14 12.26.11.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/01ad251e-3b86-ae3c-b9ae-ebcedc666421.png)



その後は、GitHub上でブランチ名を再度もとに戻して、プルリク自体をRe-Openしました。
そんな話でした。




[^2]: そうやって枕詞のように「名乗るほどのものではありませんが」と言って、いつもしっかり名乗っています。いきなり「山内です」と言うより一瞬「あれ？」って注意を引くので、マヂで心理学的にはこちらの支配下に置くだなんだの効果があるとかないとか。私はそんなことは一切考えていません。素でやっています。あえて原点を求めるとすると、「あしたのジョー」でジョーが少年院の先輩方に「聞かれて名乗るのはおこがましいが」なんとかかんとかと発言するシーンと、古くからの友人がふざけて30年近く前に言っていたのを私ひとりが記憶していてずっと言っているわけです。私のしつこさを物語るエピソードです。

**GitHubでプルリクを出したあとに、ブランチ名をGitHub上で変更したらプルリクがCloseになります**

これだけのことです。
けれどこれだけ言われてもピンとこないとおもいましたので、私に実際に起こった出来事を物語にしたためました。
楽しんでいただけましたら幸いです。

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:

<font color="purple">$\huge{I\ like\ Req\ 👍}$</font>
 

- ブランチ名は、あんまり細かいことまで書かないようにしようとおもいました
- **I force push**や**Req is the usefullest http client I've ever seen.**でも通じたからと、あんまり適当すぎる英語をいつも使うのはよくないけど、細かい英文法よりも :hearts: が大事だと私はおもいました
    - **I force push** は通じるだろうという予感はありました
    - 実は高度な能力なのだと自画自賛しています
        - 考えてもわからんものはとりあえず発信しちゃう図々しさ
        - ギリギリ通じるだろうという見きわめ


2022年に流行る技術予想 ーー それは、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)です:rocket::rocket::rocket:



---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)
