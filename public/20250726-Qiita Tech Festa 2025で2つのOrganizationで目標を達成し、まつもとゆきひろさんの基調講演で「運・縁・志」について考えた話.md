---
title: Qiita Tech Festa 2025で2つのOrganizationで目標を達成し、まつもとゆきひろさんの基調講演で「運・縁・志」について考えた話
tags:
  - Ruby
  - Elixir
  - ポエム
  - 闘魂
  - QiitaTechFesta2025
private: false
updated_at: '2025-07-27T13:49:09+09:00'
id: 576f5cf1bea4d42fe892
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに

こんにちは！先日、[Qiita Tech Festa 2025](https://qiita.com/tech-festa/2025)のOrganization Challengeで、私が所属している2つのコミュニティが目標を達成しました🎉

- **[株式会社ハウインターナショナル](https://qiita.com/organizations/haw)**: Legend Organization（最高級！）
- **[fukuoka.ex：福岡Elixirコミュ](https://qiita.com/organizations/fukuokaex)**: Advanced Organization

![スクリーンショット 2025-07-26 8.36.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9e00ad10-f3f7-4d6f-81c2-60e712b14679.png)

https://qiita.com/tech-festa/2025/award


今回は、そのときの体験談と、発表会での[まつもとゆきひろ](https://x.com/yukihiro_matz)さんの基調講演が素晴らしくて、書きたいことがあふれだしました。その一部を記事としてご披露します。

# 大量投稿作戦（ちょっと卑怯？）

正直に告白すると、今回の選出条件は：
- レジェンド: 40記事以上(かつ200いいね)
- アドバンスト: 20記事以上(かつ100いいね)

という、記事数勝負でした。そしてその8〜9割は...私が**埋めました**😅
投稿（闘魂）したというよりは、少し自虐も入っている通り、「**埋めた**」がぴったりきます。


**どうやって？**

[AtCoder](https://atcoder.jp/)（競技プログラミング）の、しかも初級者向けのABCコンテストの問題を毎日解いて、それを記事にしたんです。

- A問題を解く → 1記事
- B問題を解く → 1記事

これを繰り返して数を稼ぎました。オリジナル記事は10記事程度で、あとは「AtCoderを解きました！」記事です。

正直、「これって卑怯なんじゃないか？」という気持ちもありました。でも、効率的なアプローチを取り入れつつ、自分なりの工夫を重ねた結果...と前向きに解釈することにします😊

# まつもとゆきひろさんの基調講演でいろいろなことを思い出しました

発表会でのまつもとゆきひろさんの基調講演のテーマは：

**「第2のまつもとゆきひろ、第3のまつもとゆきひろの作り方」**

日本人の中からも、世界で使われるソフトウェアを開発する人がもっと出てきてもいいんじゃないか、というお話でした。

## 成功の3要素：「運・縁・志」

特に印象的だったのが、成功に必要な3つの要素として挙げられた：

1. **運**
2. **縁** 
3. **志**

肩書とか大企業に属しているとか、そういうことではないとのことでした。

### 運について

[Ruby](https://www.ruby-lang.org/ja/)が生まれた1995年頃は「プログラミング言語の当たり年」だったそうです。JavaやJavaScriptも同時期に誕生。ちょうどインターネットが流行り始めて、インターネット向けサービスを書くプログラミング言語が求められていた時期でした。

そのタイミングでリリースできたのが、すごく良い運だったと。

### 縁について

当時は「オープンソース」という言葉もなかったけれど、Rubyを公開したそうです。「ライセンス販売をしていれば、大金持ちになれたのに」と言われることもあるけれど、今の形で良かったとおっしゃっていました。
オープンソースにしたからいろんな開発者が参加してくれて、今のRubyがある。それによって全人類で享受できる豊かなエコシステムが生み出された。それを大変誇りに思っているということでした。

解説本を書いてあげるよ、とかカンファレンスを開いてあげるよ、といった方々が多く現れたそうです。英語で発信したことで、世界中の人の目に触れたことも大きく成長した要因であるとおっしゃっられていました。

### 志について

ビジョン、パッション、熱意。「炎上上等」くらいの、始めた人の強い思い。

それが批判されると「独裁者」になるけれど、支持されると **強いリーダーシップ** になる。それぐらいの情熱が非常に重要だということでした。吉田松陰先生の師匠の佐久間象山先生の先生である佐藤一斎先生は、言志録の中でこんなことを言われています。「**学は立志より要なるは莫（な）し**」さらに原典をさかのぼれば、論語や孟子を始めとする四書五経に同様の言葉が言い伝えられているはずです。とまれ。

Rubyの場合、同時期に誕生したJavaは博士号を取った優秀な人たちが大企業の後ろ盾で、論文向けの定量的な指標で測れる機能をどんどん追加していました。

まつもとゆきひろさんはその方面で勝負すると「勝ち目がない」と考え、**「プログラマーが使いやすい、書きやすいようにするにはどうしたらいいか(A PROGRAMMER'S BEST FRIEND」** という方向に舵を切ったそうです。自身で方向性を決められたわけです。選択されたわけです。選ばれたわけです。  

## 個人的なRuby体験

私がRubyを使い始めたのは15年くらい前、いまいるハウインターナショナルに入るときでした。それまでC、Java、C++を使っていましたが、**「プログラミングってこんなに楽しいものだったんだ」** と改めて感じさせてくれる言語、それが[Ruby](https://www.ruby-lang.org/ja/)でした。

# 脱線：まつもとゆきひろさんとの思い出

実は、まつもとゆきひろさんにサインをいただいたことがあります。家宝です✨

![2025-07-26_11-48-23_251.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/61455f00-5f74-4878-85fe-9818f82a64f7.jpeg)


ハウインターナショナルがスポンサーしている「 [e-ZUKA Tech Night](https://ezukatechnight.com/)」というイベントにゲストで来ていただいたときのことです。日付をみるとちょうど10年前です。まつもとゆきひろさんの目の前でオートレースのandroidアプリを動かしました。「浜松オートレース場で森且行さん（元SMAP）がデビューした頃の話」で盛り上がったりしました。Rubyを開発している当初、浜松に住まわれていらっしゃったそうです。


# Elixirへの言及で嬉しかった話

基調講演の中で、私が大好きな **[Elixir](https://elixir-lang.org/)** の話も出ました！

![名称未設定elixir.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f3a7c1d1-4286-40b9-92fc-1839b0848b61.jpeg)


ElixirはRubyの「弟分」と言われることがあります。最も有名なgemである「[Devise](https://github.com/heartcombo/devise)」を作った[José Valim](https://x.com/josevalim)さんが作った言語だからです。RubyとElixirは、文法も若干似ていると言われることもあります。

今回は「弟分」という文脈ではなく、「2020年代以降、新しいプログラミング言語は大きな組織がバックについて進めているけれど、Elixirは大きな後ろ盾がなくても成功している。これからますます伸びていくだろう」という期待を込めてご紹介いただきました（と思っています）。

今回のTech Festaで大量投稿したAtCoder記事は、ElixirとRustで解いていたので、何かしら縁を感じます。

そして好きが高じて、あのサインをもらった当時では考えられなかったことです。私も技術書の著者という末席を汚すまでになれました。

[Elixir実践入門](https://gihyo.jp/book/2024/978-4-297-14014-4)

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8c7a005f-39a0-427f-b600-19ea3b8e82e5.png)



また、Elixirの歴史にも確かな小さな一歩を刻んだことがあります。

https://github.com/elixir-lang/elixir/pull/11039

サインをいただいた日からちょうど10年。
あの日、サインをいただいたときから物語ははじまっていたのかもしれません。縁を感じます。田舎の片隅で勝手に縁を感じて盛り上がっている中年男性がおります。


# 不安だった気持ちと、認められた喜び

正直、似たような記事ばかりになってしまったので「もしかしたら対象外にされるかも...」と思っていました。Qiitaの運営さんの判断なので、それはそれで仕方ないかなと。レフェリーの裁定には従う、クリーンなファイトを心がけています。
でも、こうして正式に発表会で名前を呼び上げられたときは、本当に嬉しかったです🎉

まつもとゆきひろさんの「運・縁・志」を卑近の例で示してみます


## 運

期間中おおよそ1.5記事/日で投稿すれば40記事に到達するルールはラッキーでした。これまでのアドベントカレンダーなどの完走賞をそんな賞ができる前から勝手に完走していた私にとっては楽すぎるルールでした。これは私がルールを決められる要素はなく、運としか言いようがありません。

## 縁

一人ではコミュニティになりません。参加していただいている方が他にいてくださってこそ、私はコミュニティの一員となれるわけです。複数人いてはじめてコミュニティと言えるわけです。コミュニティに参加していただいている方をはじめ、ともに投稿（闘魂）してくださった方、いいね👍️という応援をいただいた方に感謝します。確かに縁はあります。

## 志

パッションだけはあります。最後までやり続ける、マムシのようなしつこさがあります。ただ書くだけです。山があるから登るの心境と同じかもしれません。Qiitaがあるから書く。特にイベントという祭りをやっているからいつもより多めに書く。ただそれだけです。

# おわりに

まつもとゆきひろさんの「**運・縁・志**」の話を聞いて、技術者として、コミュニティの一員として、改めて大切なことを思い出させてもらいました。

運は巡ってくるもの、縁は大切にするもの、志は持ち続けるもの。

AtCoderで数を稼ぐような「効率的なアプローチ」も、それはそれで一つの工夫だったのかもしれません😊

これからも、「fukuoka.ex：福岡Elixirコミュ」と「ハウインターナショナル」で、 **楽しく** プログラミングしていきたいと思います！

<!---
闘魂とは己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことだと思います。
-->


![ChatGPT Image 2025年7月12日 10_22_33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/eeeae009-3577-4a87-aeba-6f6adce8d4f9.png)

---

> _憤の一字は、是れ進学の機関なり。舜何人ぞや、予何人ぞやとは、方に是れ憤なり。（佐藤一斎）_

> _来てみれば さほどでもなし 富士の山 釈迦や孔子も かくやありなん（村田清風）_

> _出る前に負けること考えるバカいるかよ（アントニオ猪木）_

---

_Translation assistance by Claude_

# Introduction

Hello! Recently, at the [Qiita Tech Festa 2025](https://qiita.com/tech-festa/2025) Organization Challenge, two communities I belong to achieved their goals! 🎉

- **[HAW International Co., Ltd.](https://qiita.com/organizations/haw)**: Legend Organization (the highest level!)
- **[fukuoka.ex: Fukuoka Elixir Community](https://qiita.com/organizations/fukuokaex)**: Advanced Organization

![Screenshot 2025-07-26 8.36.52.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9e00ad10-f3f7-4d6f-81c2-60e712b14679.png)

https://qiita.com/tech-festa/2025/award

This time, I want to share my experience from that event, and I was deeply moved by [Yukihiro Matsumoto](https://x.com/yukihiro_matz)'s keynote speech at the presentation ceremony. So many thoughts came flooding out that I decided to write this article to share some of them.

# Mass Posting Strategy (A Bit Unfair?)

To be honest, the selection criteria this time were:
- Legend: 40+ articles (and 200+ likes)
- Advanced: 20+ articles (and 100+ likes)

It was a numbers game. And 80-90% of those articles... I **filled** them myself 😅
Rather than saying I "posted with fighting spirit," the word "filled" seems more appropriate, with a bit of self-deprecation.

**How did I do it?**

I solved [AtCoder](https://atcoder.jp/) (competitive programming) problems daily, specifically beginner-level ABC contest problems, and turned each solution into an article.

- Solve A problem → 1 article
- Solve B problem → 1 article

I repeated this to rack up the numbers. Only about 10 articles were original content; the rest were "I solved AtCoder problems!" articles.

Honestly, I felt a bit guilty thinking, "Isn't this kind of unfair?" But I've chosen to interpret it positively as taking an efficient approach while adding my own creative touches 😊

# Yukihiro Matsumoto's Keynote Reminded Me of Many Things

The theme of Yukihiro Matsumoto's keynote at the presentation ceremony was:

**"How to Create the Second and Third Yukihiro Matsumotos"**

He spoke about how more Japanese people should emerge to develop software that's used worldwide.

## The Three Elements of Success: "Luck, Connections, and Aspiration"

What was particularly impressive were the three elements he identified as necessary for success:

1. **Luck**
2. **Connections**
3. **Aspiration**

He emphasized that it's not about titles or belonging to big corporations.

### About Luck

Around 1995, when [Ruby](https://www.ruby-lang.org/en/) was born, was apparently a "golden year for programming languages." Java and JavaScript were also born around the same time. It was just when the internet was becoming popular, and there was demand for programming languages to write internet services.

Being able to release Ruby at that timing was incredibly good luck.

### About Connections

Even though the term "open source" didn't exist back then, he made Ruby publicly available. People sometimes say, "You could have become very rich if you had sold licenses," but he said he's glad it turned out this way.
Because he made it open source, many developers participated, creating today's Ruby. This generated a rich ecosystem that all humanity can enjoy, which he's very proud of.

Many people appeared saying they'd write explanation books or organize conferences. Publishing in English so people worldwide could see it was also a major factor in its growth.

### About Aspiration

Vision, passion, enthusiasm. The strong feelings of the person who started it, even to the point of "bring on the flames."

When criticized, this becomes "dictatorship," but when supported, it becomes **strong leadership**. That level of passion is extremely important. Sato Issai, who was the teacher of Sakuma Shozan (who was the teacher of Yoshida Shoin), said in his Shishiroku: "**There is nothing more important in learning than establishing aspiration**." Tracing back to the original sources, similar words are passed down in the Four Books and Five Classics, including the Analects and Mencius.

In Ruby's case, Java, which was born around the same time, was developed by PhD holders with backing from large corporations, rapidly adding features that could be measured by quantitative metrics suitable for academic papers.

Matsumoto thought he had "no chance of winning" competing in that direction, so he pivoted toward **"How can we make it easier and more enjoyable for programmers to use and write (A PROGRAMMER'S BEST FRIEND)"**. He was able to determine, choose, and select this direction himself.

## My Personal Ruby Experience

I started using Ruby about 15 years ago when I joined HAW International, where I am now. Until then, I had used C, Java, and C++, but Ruby was the language that made me feel again that **"programming could be this enjoyable"**.

# Digression: Memories with Yukihiro Matsumoto

Actually, I once got an autograph from Yukihiro Matsumoto. It's a family treasure ✨

![2025-07-26_11-48-23_251.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/61455f00-5f74-4878-85fe-9818f82a64f7.jpeg)

This was when he came as a guest to "[e-ZUKA Tech Night](https://ezukatechnight.com/)," an event sponsored by HAW International. Looking at the date, it was exactly 10 years ago. I demonstrated an Android app for auto racing right in front of Matsumoto. We had a great conversation about "when Mori Katsuyuki (former SMAP member) debuted at Hamamatsu Auto Race Track." Apparently, he was living in Hamamatsu when he was developing Ruby.

# Happy to Hear Elixir Mentioned

During the keynote, he also mentioned **[Elixir](https://elixir-lang.org/)**, which I absolutely love!

![Named elixir.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f3a7c1d1-4286-40b9-92fc-1839b0848b61.jpeg)

Elixir is sometimes called Ruby's "little brother." This is because it was created by [José Valim](https://x.com/josevalim), who made "[Devise](https://github.com/heartcombo/devise)," the most famous Ruby gem. Ruby and Elixir are also said to have somewhat similar syntax.

This time, rather than in the "little brother" context, he introduced Elixir with the expectation that "while new programming languages since 2020 have been backed by large organizations, Elixir has succeeded without major backing and will continue to grow" (I believe).

The AtCoder articles I mass-posted for this Tech Festa were solved using Elixir and Rust, so I feel some connection there.

And because of my passion, something I couldn't have imagined when I got that autograph has happened. I've even become an author of a technical book, albeit in a humble capacity.

[Elixir Practical Introduction](https://gihyo.jp/book/2024/978-4-297-14014-4)

![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8c7a005f-39a0-427f-b600-19ea3b8e82e5.png)

I've also made a small but certain step in Elixir's history.

https://github.com/elixir-lang/elixir/pull/11039

Exactly 10 years from the day I received that autograph.
Perhaps the story began from that day when I received the autograph. I feel a connection. There's a middle-aged man in a rural corner getting excited about connections he's imagining on his own.

# My Anxious Feelings and the Joy of Recognition

Honestly, since I ended up with so many similar articles, I thought "Maybe I'll be disqualified..." But since it's Qiita's management decision, I thought that would be fine too. I follow the referee's judgment and aim for clean fights.
But when my name was officially called at the presentation ceremony, I was truly happy 🎉

Let me illustrate Matsumoto's "luck, connections, and aspiration" with a personal example:

## Luck

The rule that posting roughly 1.5 articles per day during the period would reach 40 articles was lucky for me. For someone like me who had been completing advent calendars and similar challenges even before completion awards existed, this rule was too easy. Since I had no say in determining the rules, this can only be called luck.

## Connections

You can't have a community with just one person. It's only because there are others participating that I can be a member of the community. You need multiple people to call it a community. I'm grateful to everyone participating in the community, those who posted (fought) together with me, and those who gave encouragement with likes 👍️. There are definitely connections.

## Aspiration

I do have passion. I have the persistent tenacity of a viper to keep going until the end. I just write. It might be the same mindset as "climb mountains because they're there." Write on Qiita because it exists. Write more than usual especially when there's an event or festival. That's all.

# Conclusion

Listening to Yukihiro Matsumoto's talk about "**luck, connections, and aspiration**" reminded me again of what's truly important as a technologist and as a community member.

Luck comes around, connections should be treasured, and aspiration should be maintained.

Even the "efficient approach" of racking up numbers with AtCoder might have been one kind of innovation in its own way 😊

I want to continue **enjoying** programming in both "fukuoka.ex: Fukuoka Elixir Community" and "HAW International"!

<!---
Fighting spirit means overcoming oneself. And I think it's about polishing one's soul through struggle.
-->

![ChatGPT Image 2025年7月12日 10_22_33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/eeeae009-3577-4a87-aeba-6f6adce8d4f9.png)

---

> _The character "indignation" is the engine of advancing in learning. What kind of person was Shun? What kind of person am I? This is precisely indignation. (Sato Issai)_

> _When you actually come to see it, Mount Fuji is not so impressive after all. Perhaps even Shakyamuni and Confucius were like this. (Murata Seifu)_

> _What fool thinks about losing before even going out there? (Antonio Inoki)_
