---
title: RubyとElixirの兄弟船：闘魂で切り拓く技術の旅 〜素のRubyプロジェクトでrails cのようなことをしたい〜
tags:
  - Ruby
  - Elixir
  - 猪木
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-11-06T15:51:17+09:00'
id: 15bf1fd9c23f94b1d91d
organization_url_name: haw
slide: false
ignorePublish: false
---
```elixir
defmodule FightingSpirit do
  def shout do
    IO.puts "元氣ですかーーーッ！！！"
    IO.puts "元氣があればなんでもできる！"
    IO.puts "闘魂とは己に打ち克つこと。"
    IO.puts "そして闘いを通じて己の魂を磨いていく"
    IO.puts "ことだと思います。"
  end
end

FightingSpirit.shout()
```

<b><font color="red">$\huge{元氣ですかーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います。}$</font></b>

---

# はじめに

今日は兄貴の話を書きたいと思います。
兄貴というのは、[Elixir](https://elixir-lang.org/)の兄貴筋にあたる[Ruby](https://www.ruby-lang.org/ja/)兄さんの話を書きます。

# RailsじゃないRubyのプロジェクトでrails c的なことをしたい

RailsじゃないRubyのプロジェクトで`rails c`的なことをして、一部のクラスの機能をIRB上で動かしたいといことがついさっきありました。

Gemの依存関係を解決しつつ、自作のクラスを動かしたいわけです。単にディレクトリで`irb`とやってもうまくいきません。

Rubyのプロジェクトはこんなディレクトリで構成しています。

```
.
├── Gemfile
├── Gemfile.lock
├── lib
│   ├── awesome
│   │   ├── gmail.rb
│   │   └── slack.rb
│   └── main.rb
└── README.md
```

動かしたいのは、`lib/awesome/slack.rb`にある`Awesome::Slack`クラスにあるクラスメソッド`post`です。

```ruby:lib/awesome/slack.rb
require 'net/http'
require 'uri'
require 'json'

URL = ENV['GMAIL_TO_SLACK_WEB_HOOK_URL']
CHANNEL = ENV['GMAIL_TO_SLACK_CHANNEL']

module Awesome
  class Slack
    class << self
      def post(text)
        uri = URI.parse(URL)
        https = Net::HTTP.new(uri.host, uri.port)

        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.request_uri)

        req['Content-Type'] = 'application/json'
        payload = {
          text: text,
          channel: CHANNEL,
          username: 'awesome_bot',
          icon_emoji: ':telephone:',
          link_names: 1
        }.to_json
        req.body = payload
        res = https.request(req)

      end
    end
  end
end
```

以前も同じことをしたことがありましたが、ど忘れしました。


ChatGPT Plusに聞いたらけっこうごついやり方の提案をしてきました。それはそれでありな気がしましたが、前にやったときはそんな大掛かりなことをやったはずはないなあ、と。それでチャットしていたら思い出した次第です。

ちなみに私が所属している[ハウインターナショナル](https://www.haw.co.jp/)では、[ChatGPT Plus](https://openai.com/ja-JP/chatgpt/pricing/)の利用料を会社が支払ってくれます。



```
bundle exec irb -I. -Ilib
```

として、IRBを立ち上げまして

```ruby
irb> require 'lib/awesome/slack'

irb> text = 'We are the Alchemists, my friends!!!'

irb> Awesome::Slack.post(text)
=> #<Net::HTTPOK 200 OK readbody=true>
```

無事実行できました :tada::tada::tada:

---

# どうしてQiitaに書いたの？

こうしてQiitaに書くことで私の脳が覚えるわけです。重要な情報だと分類されるわけです。
逆にこれまで記事にしていないから覚えられないわけです。

自分の記事として公開しておけばQiitaで検索しやすいですし、同じことで困っている他の人の助けにもなります。Qiitaは外部記憶装置です。

さらには昨今ではQiitaに投稿（闘魂）した記事は、それを学習したAIモデルの改善にもきっと繋がります。それは、世界文化の向上発展に寄与し、人類全体の能力向上につながること間違いなしです。行き着く先は、アントニオ猪木さんが夢見た「本当の世界平和の実現」です。

---

# なぜRubyがElixirの兄貴筋にあたるのですか？

[Elixir](https://elixir-lang.org/)の作者[José Valim](https://twitter.com/josevalim)さんはかつてこう述べました。

> The main, the top three influences are Erlang, Ruby, and Clojure.

（Elixirが）主に影響を受けたトップ３は、ErlangとRubyそしてClojureです。

[José Valim - Cognicast Episode 120](https://cognitect.com/cognicast/120)

https://cognitect.com/cognicast/120

[José Valim](https://twitter.com/josevalim)さんは、[Ruby](https://www.ruby-lang.org/ja/)を使っている人なら一度は使ったことがあるでしょう[devise](https://github.com/heartcombo/devise)の第一コミッターです。

https://github.com/heartcombo/devise/commit/673fda9725b3a0b5522afdbe4fc9c0608243723c


[José Valim](https://twitter.com/josevalim)さんは[Elixir](https://elixir-lang.org/)を作る前は、[Ruby](https://www.ruby-lang.org/ja/)界で活躍されていました。
[Elixir](https://elixir-lang.org/)は[Ruby](https://www.ruby-lang.org/ja/)の影響を受けているとのさきほど引用したご自身の発言もあります。



ここからは私の持論です。[Elixir](https://elixir-lang.org/)が[Ruby](https://www.ruby-lang.org/ja/)から一番色濃く影響を受けているのは、**A PROGRAMMER'S BEST FRIEND**なところだと思います。
コミュニティはあたたかで、海外との距離も近いです。
それで、私は[Ruby](https://www.ruby-lang.org/ja/)を兄貴と呼んでいます。
語感がいいのでそう私が呼んだにすぎません。
兄弟船です。鳥羽一郎さんと山川豊さんです。


<iframe width="960" height="540" src="https://www.youtube.com/embed/VOrZpq6O4zU" title="兄弟船　鳥羽一郎" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>





父がErlangで母がRubyという説もあります。

# さいごに

私たちエンジニアの旅路は、日々の挑戦と学びの連続です。RubyとElixirのように、技術は互いに影響を与え合いながら進化し、私たちの創造力を広げてくれます。この記事で共有したRubyプロジェクトでのIRBの活用法も、その小さな一歩に過ぎません。

なにか困難にぶつかり、解決策を見つけ、そしてそれを世界と共有する。このサイクルが、私たちの知識を深め、コミュニティを豊かにします。Qiitaに記事を投稿（**闘魂**）することは、自分自身の理解を深めるだけでなく、誰かの「できた！」を助ける光ともなるのです。

これからも、闘魂を胸に新たな技術と向き合い続けましょう。一歩ずつ進むその先には、今は想像もつかないような成長と発見が待っています。そして、その積み重ねが、私たちエンジニアとしての真の力となり、やがて世界を少しでも良い方向へと導くことを信じています。

一緒に学び、一緒に成長し、一緒に「本当の世界平和の実現」に向けて歩んでいきましょう！


<b><font color="red">$\huge{迷わず行けよ、行けばわかるさ！}$</font></b>
<b><font color="red">$\huge{ありがとうーーーッ！！！}$</font></b>

