---
title: Nervesを使ってRaspberry Pi 2でLEDをチカチカさせる 〜クリスマスの飾り付けをしよう〜
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2019-12-10T07:01:58+09:00'
id: bf0354db8cd0628f161e
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
（この記事は、「[#NervesJP Advent Calendar 2019](https://qiita.com/advent-calendar/2019/nervesjp)」の10日目です）
昨日は[nishiuchikazuma](https://qiita.com/nishiuchikazuma)さんの「[ElixirでラズパイのLEDをチカ〜RaspbianOSインストールから〜](https://qiita.com/nishiuchikazuma/items/cce6152430467cffba56)」です！
こちらもぜひぜひ！
**私もチカチカさせてみます！**

# はじめに :santa_tone1: 

- [Nervesを使ってRaspberry pi2からTwitterの投稿を行う](https://qiita.com/torifukukaiou/items/6096c201fbb013e65baa)
- ここで作ったプロジェクトで、LEDをチカチカさせる機能を追加します
- [Nerves](https://nerves-project.org/)は[Elixir](https://elixir-lang.org/)のIoTでナウでヤングなクールなすごいやつです

# 作品
- [hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)

![EKQP567UYAAomEh.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/61335f30-6b55-84c0-6a7f-d299509a49ce.jpeg)


# 変更ポイント
- [対応コミット](https://github.com/TORIFUKUKaiou/hello_nerves/commit/0fb7e1aa6467f069d0ccdb48d2021c3682501932)

```Elixir
diff --git a/mix.exs b/mix.exs
index 7eb5f71..1e02c45 100644
--- a/mix.exs
+++ b/mix.exs
@@ -61,7 +61,8 @@ defmodule HelloNerves.MixProject do
       {:poison, "~> 3.1"},
       {:oauther, "~> 1.1"},
       {:extwitter, "~> 0.8"},
-      {:cronex, github: "jbernardo95/cronex", ref: "345b57e14667a08280d790afdfbb359f467649df"}
+      {:cronex, github: "jbernardo95/cronex", ref: "345b57e14667a08280d790afdfbb359f467649df"},
+      {:circuits_gpio, "~> 0.4"}
     ]
   end
```
- [Elixir Circuits - GPIO](https://github.com/elixir-circuits/circuits_gpio) を追加しています

```Elixir:lib/hello_nerves/led.ex
defmodule HelloNerves.Led do
  def blink do
    turn_on()
    Process.sleep(500)
    turn_off()
    Process.sleep(500)

    spawn(HelloNerves.Led, :blink, [])
  end

  defp turn_on do
    Circuits.GPIO.write(gpio(), 1)
  end

  defp turn_off do
    Circuits.GPIO.write(gpio(), 0)
  end

  defp gpio do
    {:ok, gpio} = Circuits.GPIO.open(18, :output)
    gpio
  end
end
```
- 私は `GPIO 18` を使いましたがお好みのものをお使いください
- 回路は、[Raspberry Piで学ぶ電子工作 超小型コンピュータで電子回路を制御する (ブルーバックス) ](https://www.amazon.co.jp/dp/4062578913/) を参考にしてつくりました(エイっ！　と差し込みました)
    - こちらの本では[Python](https://www.python.org/)での実装例が書いてありまして、それを参考に[Elixir](https://elixir-lang.org/) で書いてみました
    - 昔、本の通りに[Python](https://www.python.org/)でやった経験があるのでトラブルはありませんでした
    - この本、[カラー版](https://www.amazon.co.jp/dp/4062579774/)もあるようです

```
$ export MIX_TARGET=rpi2
$ mix deps.get
$ mix firmware
$ mix firmware.burn
```
して、[Nerves](https://nerves-project.org/) on Raspberry Pi 2に`ssh`で接続して

```
iex(1)> HelloNerves.Led.blink
```
なんてやると、LEDがチカチカずっとします。

# 閑話休題

```Elixir:lib/hello_nerves/led.ex
defmodule HelloNerves.Led do
  def start do
    spawn(Led, :blink, [])
  end

  def blink do
    {:ok, gpio} = Circuits.GPIO.open(18, :output)

    Stream.iterate(0, &(&1 + 1))
    |> Enum.each(fn _ ->
      Circuits.GPIO.write(gpio, 1)
      Process.sleep(500)
      Circuits.GPIO.write(gpio, 0)
      Process.sleep(500)
    end)
  end
end
```
- ずっと無限にチカチカするものを作りたかっただけなのですが、最初に書いたのはこんな感じの(たぶん)無限ループでした
- なんだか美しくないようにみえたので[上](https://github.com/TORIFUKUKaiou/hello_nerves/commit/0fb7e1aa6467f069d0ccdb48d2021c3682501932)のように書き直しました
- どっちがいいのか、はたまたもっと良い書き方があるのかはわかっていません :sweat_smile:
- ご指導ご鞭撻のほどよろしくお願いします

# A very merry Christmas (war is over if you want it)
![IMG_20191209_083545.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f759db7e-d362-4a78-66d6-2ce73deb3fc4.jpeg)

![IMG_20191209_083549.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f20b7ff8-e6ec-e001-31dc-6025e6585763.jpeg)

![VID_20191209_200553.gif](https://firebase.torifuku-kaiou.tokyo/VID_20191209_200553.gif)



# 次回
- 明日も[私](https://qiita.com/torifukukaiou)が担当いたしまして[Nervesを使って毎朝天気予報をRaspberry Pi 2にしゃべらせる(できた！)](https://qiita.com/torifukukaiou/items/795ee5a112845dbf7730) です
- こちらもよろしくお願いします
