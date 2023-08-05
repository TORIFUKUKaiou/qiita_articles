---
title: NervesMOTD.print/1の使い方 (Elixir)
tags:
  - Elixir
  - Nerves
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-01-19T23:33:29+09:00'
id: 0bb73660f8601bd77e7d
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**夢なき者に理想なし、理想なき者に計画なし、計画なき者に実行なし、実行なき者に成功なし。故に、夢なき者に成功なし。**

Advent Calendar **2022** 10日目[^1]の記事です。
I'm ready for 12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I'm looking forward to  12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:

私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:
[Nerves](https://www.nerves-project.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

[nerves_motd](https://github.com/nerves-project/nerves_motd)の話をします。

# この記事で伝えたいこと

[Nerves](https://www.nerves-project.org/)に`ssh`したときに格好いいロゴと各種情報が表示されますよね。
<font color="purple">$\huge{アレです。}$</font>

![132778791-7968786b-7d35-4e50-969d-a13c32cdfb01.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0e6bcd04-e4cf-d2fa-6afc-5ef19c7761a4.png)

<font color="purple">$\huge{コレです。}$</font>
**この表示をカスタマイズできるの知っていましたか？**

ちなみに、[nerves_motd](https://github.com/nerves-project/nerves_motd)の最初のコミッターは、[autoracex](https://autoracex.connpass.com/)の共同オーガナイザー @mnishiguchi さんです!!!

https://github.com/nerves-project/nerves_motd/commit/7602cb6855399fdd8151e68e46f142bb496e3bc8


# [NervesMOTD.print/1](https://hexdocs.pm/nerves_motd/NervesMOTD.html#print/1)の使い方

```elixir
logo = "\e[38;5;24m   ██     ██   ██  ██████    █████   ██████     ██       ████   ███████  ██  ██\n\e[38;5;24m  ████    ██   ██  █ ██ █   ██   ██   ██  ██   ████     ██  ██   ██   █  ██  ██\n\e[38;5;24m ██  ██   ██   ██    ██     ██   ██   ██  ██  ██  ██   ██        ██ █     ████\n\e[38;5;24m ██  ██   ██   ██    ██     ██   ██   █████   ██  ██   ██        ████      ██\n\e[38;5;24m ██████   ██   ██    ██     ██   ██   ██ ██   ██████   ██        ██ █     ████\n\e[38;5;24m ██  ██   ██   ██    ██     ██   ██   ██  ██  ██  ██    ██  ██   ██   █  ██  ██\n\e[38;5;24m ██  ██    █████    ████     █████   ████ ██  ██  ██     ████   ███████  ██  ██\n"

NervesMOTD.print(logo: logo, extra_rows: [
  [{"url", "https://autoracex.connpass.com/"}],
  [{"motto", "We Are The Alchemists, my friends!"}]
])
```

上記を実行すると、こんな感じになります。

![autoracex.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/205f8d60-ebc0-f8f5-4193-ca8096893972.png)
<font color="purple">$\huge{🎉🎉🎉🎉🎉}$</font>

少し説明します。

- [NervesMOTD.print/1](https://hexdocs.pm/nerves_motd/NervesMOTD.html#print/1)のドキュメントに、`:logo`と`:extra_rows`オプションを指定できることが書いてあります
- `:logo`には文字列を渡します
- `:extra_rows`への渡し方は、 https://github.com/nerves-project/nerves_motd/blob/main/lib/nerves_motd.ex を読んで雰囲気で掴みました
- `"\e[38;5;24m"`で色が付きます
    - そのままググるといろいろ記事が見つかるのでそちらをご参照ください
    - 私はなんとなく、 https://github.com/nerves-project/nerves_motd/blob/d2de4419212c6451e899ae690f44a6ba79dba709/lib/nerves_motd.ex#L9-L15 を参考にしました


`rootfs_overlay/etc/iex.exs`に書いておくと、`ssh nerves.local`して接続したときに表示されるよ

# [autoracex](https://autoracex.connpass.com/)の新ロゴ誕生 :tada::tada::tada:

<blockquote class="twitter-tweet"><p lang="en" dir="ltr">New <a href="https://twitter.com/hashtag/autoracex?src=hash&amp;ref_src=twsrc%5Etfw">#autoracex</a> logo 🎉🎉🎉<br><br>Thanks for nerves_motd.<br>The nerves_motd&#39;s first committer is <a href="https://twitter.com/MNishiguchiDC?ref_src=twsrc%5Etfw">@MNishiguchiDC</a> -san.<br>He belongs to autoracex.<br>Thanks a lot!!!<a href="https://twitter.com/hashtag/NervesJP?src=hash&amp;ref_src=twsrc%5Etfw">#NervesJP</a> <a href="https://t.co/OQ1H4aFMMn">pic.twitter.com/OQ1H4aFMMn</a></p>&mdash; TORIFUKU Kaiou (@torifukukaiou) <a href="https://twitter.com/torifukukaiou/status/1479828531291246594?ref_src=twsrc%5Etfw">January 8, 2022</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

![スクリーンショット 2022-01-10 13.09.20.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/97415ab7-82f3-84d3-f598-ed611436b55e.png)


[@NervesProject](https://twitter.com/NervesProject) 公式ツイッターアカウントが**Like**してくれています :tada::tada::tada:
[coner](https://twitter.com/pressy4pie) さんも**Like**してくれています :tada::tada::tada:







# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

- [NervesMOTD.print/1](https://hexdocs.pm/nerves_motd/NervesMOTD.html#print/1)の使用例を示しました
- [autoracex](https://autoracex.connpass.com/)の新ロゴが誕生しました :tada::tada::tada:
- [nerves_motd](https://github.com/nerves-project/nerves_motd)の最初のコミッターは、[autoracex](https://autoracex.connpass.com/)の共同オーガナイザー @mnishiguchi さんです!!!

Enjoy [Nerves](https://www.nerves-project.org/):bangbang::bangbang::bangbang:


<font color="purple">$\huge{Enjoy\ Nerves🚀}$</font>


2022年に流行る技術予想 ーー それは、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)です:rocket::rocket::rocket:



---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)
