---
title: defdelegateを使ってみました (Elixir)
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
private: false
updated_at: '2022-08-14T12:11:24+09:00'
id: 1ba0f3ae5117a48f936b
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
https://qiita.com/official-events/5cb794f7cb9ac194ed70

**継続は力なり**

Advent Calendar 2022 17日目[^1]の記事です。
I'm ready for 12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I'm looking forward to  12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
I can't wait for 12/25,**2022** :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

# はじめに

[Elixir](https://elixir-lang.org/)を楽しんでいますか:bangbang::bangbang::bangbang:

君は
<font color="purple">$\huge{defdelegate🚀🚀🚀}$</font>
を感じたことがあるか[^2]:interrobang:

[^2]: 元ネタは、聖闘士星矢の「君は小宇宙[^3]を感じたことがあるか!?」です。

[^3]: 若い方はご存知ないかもしれませんが、小宇宙は**コスモ**と読みます。

[defdelegate/2](https://hexdocs.pm/elixir/1.13.2/Kernel.html#defdelegate/2)の話を書きます。

# [defdelegate/2](https://hexdocs.pm/elixir/1.13.2/Kernel.html#defdelegate/2)

```elixir
defmodule MyList do
  defdelegate reverse(list), to: Enum
  defdelegate other_reverse(list), to: Enum, as: :reverse
end

MyList.reverse([1, 2, 3])
#=> [3, 2, 1]

MyList.other_reverse([1, 2, 3])
#=> [3, 2, 1]
```

なるほどね、`delegate`するわけね。

> a person who is chosen or elected to represent the views of a group of people and vote and make decisions for them

https://www.oxfordlearnersdictionaries.com/definition/english/delegate_1?q=delegate

---

> 〔権限・任務などを人に〕委任する、委譲する、委託する、委嘱する

https://eow.alc.co.jp/search?q=delegate

---

iOS開発で聞いたことがあります。
ほとんど覚えていません。

https://developer.apple.com/documentation/uikit/uiapplication/1622936-delegate


# へえ〜　こんなのあったのだあ!!!

https://hexdocs.pm/elixir/1.0/Kernel.html#defdelegate/2

けっこう昔のバージョンからその存在を確認できます。


# [defdelegate/2](https://hexdocs.pm/elixir/1.13.2/Kernel.html#defdelegate/2)を知ったきっかけ

@sotashiro さんの「[[Elixir]RubyやRailsのメソッドは便利なものが多いので、それらをElixirでも使えるようにしたライブラリをリリースしました。](https://qiita.com/sotashiro/items/3a3a24c978bc2a55d52b)」で紹介されている[REnum](https://github.com/tashirosota/ex-r_enum)で知りました:rocket:

> Many useful functions implemented. REnum is Enum extended with convenient functions inspired by Ruby and Rails ActiveSupport. It also provides full support for native functions through metaprogramming.

(恩着せがましい言い方です:pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:が)
<font color="purple">$\huge{貢献しておきました🚀🚀🚀}$</font>


[defdelegate/2](https://hexdocs.pm/elixir/1.13.2/Kernel.html#defdelegate/2)を私の人生においてはじめて使うと当時に[コミット](https://github.com/tashirosota/ex-r_enum/pull/2/commits/10a46391d5949b853cd84e21947cba67c47c5568)し、プルリクを出したらマージしてもらえました:tada::tada::tada:

@sotashiro さん江
私が古いバージョンをベースにしていたため、コンフリクトが発生してしまい、その解消ありがとうございました！


https://github.com/tashirosota/ex-r_enum/pull/2/commits/10a46391d5949b853cd84e21947cba67c47c5568

```elixir
  defdelegate tally(enumerable), to: Enum, as: :frequencies
```

@mnishiguchi さんも貢献しています!!!
私が主宰している[autoracex](https://autoracex.connpass.com/)揃い踏みです。

**記念撮影** :camera_with_flash: 
![スクリーンショット 2022-01-17 19.55.28.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/cee13565-f0ca-c064-40a5-e7c1cbdff3f7.png)


それにしても、@sotashiro さんが
<font color="purple">$\huge{すごい勢い🚀🚀🚀}$</font>
で開発されています!!!
ただただ驚くばかりです。

# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀🚀🚀}$</font>

**他人のふんどしで堂々と記事を書いています。**

<font color="purple">$\huge{I\ like\ Nerves\ Livebook👍}$</font>
 


2022年に流行る技術予想 ーー それは、[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook)です:rocket::rocket::rocket:



---

最後に、[Elixir](https://elixir-lang.org/)のご紹介をします。

## オススメの書籍 :books: 
- [プログラミングElixir（第2版）](https://www.ohmsha.co.jp/book/9784274226373/) -- オーム社
- [Elixir実践ガイド](https://book.impress.co.jp/books/1120101021) -- インプレス

## Webアプリケーションを楽しむなら
- [Phoenix](https://www.phoenixframework.org/)

## IoTを楽しむなら
- [Nerves](https://www.nerves-project.org/)

## AIを楽しむなら
- [Nx](https://github.com/elixir-nx/nx) + [Livebook](https://github.com/livebook-dev/livebook)

## コミュニティ
-  [elixir.jp](https://join.slack.com/t/elixirjp/shared_invite/zt-ae8m5bad-WW69GH1w4iuafm1tKNgd~w) Slack workspaceに参加してみてください
    - マヂ、やさしい人ばっかりのコミュニティ
    - あなたの**困った**をきっと解決してくれるでしょう
- [NervesJP](https://join.slack.com/t/nerves-jp/shared_invite/zt-9vteokip-iVAqi8TkT0ID_uK9dSqVHA) Slack workspaceでは、[Nerves](https://www.nerves-project.org/)やIoTが好きな愉快なfolksたちがあなたの訪れを歓迎します :tada:
- たくさんのコミュニティがあります
    - @nako_sleep_9h さん作の素敵な資料をご紹介します
    - [Elixirコミュニティ の歩き方〜国内オンライン編〜](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian) :clap::clap_tone1::clap_tone2::clap_tone3::clap_tone4::clap_tone5:

![FCOvBkAUYAE6mL8.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a277d0ea-2780-d9a3-4062-66d38b175125.jpeg)
@piacerex さん作 :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

## <u><b>Elixirコミュニティに初めて接する方は下記がオススメです</b></u>

**Elixirコミュニティ の歩き方〜国内オンライン編〜**<br>
https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian

[![image.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/155423/f891b7ad-d2c4-3303-915b-f831069e28a4.png)](https://speakerdeck.com/elijo/elixirkomiyunitei-falsebu-kifang-guo-nei-onrainbian)

---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)
