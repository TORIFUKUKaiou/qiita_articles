---
title: 闘魂Elixir ── Slack上でタイピングしている風の演出をElixirでやってみる
tags:
  - Elixir
  - Slack
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-11-15T22:03:36+09:00'
id: 0ba7c908599efdd7aec8
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>



# はじめに

ChatGPT流行っていますね。AIブームです。つまりアントニオ猪木ブームです。**闘魂**のブームがきているのです。
これに乗るしかありません。

プログラマーのチャットツールといえば[Slack](https://slack.com/intl/ja-jp)ですよね。

ChatGPTが流行った理由の背景にはタイピングしている風の演出が一役買っているのだと私は思っています。
私が思っているのです。そう思っているのです。合っているのかどうかはわかりません。私はそう思っていると言っているだけです。私はそう思っているのです。

[Slack](https://slack.com/intl/ja-jp)上でタイピングしている風の演出をやってみたくなりました。
[chat.update](https://api.slack.com/methods/chat.update) APIを使えばいけるんじゃないかと思いました。
[Elixir](https://elixir-lang.org/)でやってみます。

# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があってがですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

# サンプルプログラム

デモです。

![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/7ca34345-94cb-396e-c3e1-fc53ff53a9ed.gif)



サンプルプログラムです。

```elixir
chat_update = (fn json -> 

    url = "https://slack.com/api/chat.update"

    headers = [
      "Content-type": "application/json; charset=UTF-8",
      Authorization: "Bearer #{System.get_env("SLACK_BOT_TOKEN")}"
    ]

    {:ok, _response} = HTTPoison.post(url, json, headers)
end
)

%{ts: "1692320035.004929", channel: "C02LWMFD3KK", text: "　　　　"} |> Jason.encode! |> chat_update.()
# 1692320035.004929 はメッセージのタイムスタンプ

"We are the Alchemists, my friends!!!"
|> String.codepoints
|> Enum.reduce("", fn char, acc ->
    Process.sleep(33)
    new_acc = acc <> char
    %{ts: "1692320035.004929", channel: "C02XXXXXX", text: new_acc} |> Jason.encode! |> chat_update.()
    IO.inspect new_acc
end)
# C02XXXXXXはチャンネルIDのサンプル値
```

一直線のタイピングなので演出としてはまだまだイマイチですが、それっぽいものはできそうです。

ただ[Rate Limits](https://api.slack.com/docs/rate-limits)の[Web API Tier 3](https://api.slack.com/docs/rate-limits#tier_t3)ですので1分間に50回くらいの制限がありそうです。_APIコールは計画的に。_





# さいごに

[Slack](https://slack.com/intl/ja-jp)上でタイピングしている風の演出の試作を[Elixir](https://elixir-lang.org/)でやってみました。

人類は不老不死の霊薬を意味する素敵なプログラミング言語[Elixir](https://elixir-lang.org/)を手に入れました。並行処理を他のプログラミング言語よりも比較的容易に書くことができます。それはきっとコンピュータ資源を有効活用できることにつながるでしょう。巡り巡って本当の世界平和を必ず実現します。世界文化の進展に寄与できます。

さあ、そこのあなたも[Elixir](https://elixir-lang.org/)の世界へようこそ。
_手始めに[エリクサーチ](https://elixir-lang.info/)なんていかがでしょうか。私のオススメです。_

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
