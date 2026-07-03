---
title: 'サイコロをつくる(Elixir, Nerves)'
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2020-02-02T19:08:22+09:00'
id: 5577f7c79c0723f514d8
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
# はじめに
- サイコロをつくってみます
- もちろん[Nerves](https://nerves-project.org/)を使います
    - [Elixir](https://elixir-lang.org/)でIoTができます
    - [NervesはElixirのIoTでナウでヤングなcoolなすごいヤツです🚀](https://twitter.com/torifukukaiou/status/1201266889990623233)

![VID_20200127_210610.gif](https://firebase.torifuku-kaiou.tokyo/VID_20200127_210610.gif)

- ボタンを押している間はガチャガチャ表示して、離したら適当な数字を１つ表示します

![IMG_20200127_210641_copy.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/bf1f08d7-5933-caf5-b5f9-6b4ef0a822b9.jpeg)

- 配線が、ガチャガチャしています:man_tone3:

## 前提記事
- [Nervesを使ってタクトスイッチを押したらLEDを光らせる(Elixir)](https://qiita.com/torifukukaiou/items/ad3eee31dea0dc1cbcbd)
- [@MzRyuKa](https://twitter.com/MzRyuKa)さんの[はてなブログに投稿しました
RaspberryPiのピンの役割を確認するのに便利なサイト「http://pinout.xyz」 - みずりゅの自由帳 https://mzryuka.hatenablog.jp/entry/2020/01/28/073204 #はてなブログ](https://twitter.com/MzRyuKa/status/1221923905369063424)
    - こちらで紹介されている[pinout.xy](https://pinout.xyz/)をみてGPIOを選びました(特定の役割が割り当てられていないものを選び直しました)
    - ありがとうございます！


# ソースコード
- [hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)

# ソースコード抜粋
- 関連コミット
    - [6da3307336c53f3427364723719ae921157d9216](https://github.com/TORIFUKUKaiou/hello_nerves/commit/6da3307336c53f3427364723719ae921157d9216)
    - [1f0ebc1ac85ba53c62e227f9a585fd4eacb80ebc](https://github.com/TORIFUKUKaiou/hello_nerves/commit/1f0ebc1ac85ba53c62e227f9a585fd4eacb80ebc)
    - [b9f1dcba85164f261936b021cb411294f7720289](https://github.com/TORIFUKUKaiou/hello_nerves/commit/b9f1dcba85164f261936b021cb411294f7720289)

```Elixir:lib/hello_nerves/led/seven_seg.ex
defmodule HelloNerves.Led.SevenSeg do
  @a_led_pin Application.get_env(:hello_nerves, :a_led_pin, 26)
  @b_led_pin Application.get_env(:hello_nerves, :b_led_pin, 6)
  @c_led_pin Application.get_env(:hello_nerves, :c_led_pin, 5)
  @d_led_pin Application.get_env(:hello_nerves, :d_led_pin, 16)
  @e_led_pin Application.get_env(:hello_nerves, :e_led_pin, 23)
  @f_led_pin Application.get_env(:hello_nerves, :f_led_pin, 25)
  @g_led_pin Application.get_env(:hello_nerves, :g_led_pin, 22)

  alias Circuits.GPIO

  require Logger

  def clear do
    [@a_led_pin, @b_led_pin, @c_led_pin, @d_led_pin, @e_led_pin, @f_led_pin, @g_led_pin]
    |> Enum.map(&gpio(&1))
    |> Enum.map(&turn_off(&1))
  end

  def show do
    fun = random_fun()

    1..3
    |> Enum.each(fn _ ->
      fun.()
      Process.sleep(50)
      clear()
      Process.sleep(25)
    end)

    fun.()
  end

  def random do
    fun = random_fun()
    fun.()
  end

  def random_forever do
    random()

    50..75
    |> Enum.random()
    |> Process.sleep()

    random_forever()
  end

  def one do
    clear()
    [@b_led_pin, @c_led_pin] |> flush()
  end

  def two do
    clear()
    [@a_led_pin, @b_led_pin, @g_led_pin, @e_led_pin, @d_led_pin] |> flush()
  end

  def three do
    clear()
    [@a_led_pin, @b_led_pin, @g_led_pin, @c_led_pin, @d_led_pin] |> flush()
  end

  def four do
    clear()
    [@f_led_pin, @g_led_pin, @b_led_pin, @c_led_pin] |> flush()
  end

  def five do
    clear()
    [@f_led_pin, @g_led_pin, @c_led_pin, @d_led_pin, @a_led_pin] |> flush()
  end

  def six do
    clear()
    [@f_led_pin, @e_led_pin, @d_led_pin, @c_led_pin, @g_led_pin] |> flush()
  end

  defp flush(pins) do
    pins
    |> Enum.map(&gpio(&1))
    |> Enum.map(&turn_on(&1))
  end

  defp turn_on(gpio) do
    GPIO.write(gpio, 1)
  end

  defp turn_off(gpio) do
    GPIO.write(gpio, 0)
  end

  defp gpio(pin) do
    {:ok, output_gpio} = GPIO.open(pin, :output)
    output_gpio
  end

  defp random_fun do
    [&one/0, &two/0, &three/0, &four/0, &five/0, &six/0]
    |> Enum.random()
  end
end
```

- 一画ずつGPIOがひもづいていて、それらをONやOFFすることで数字を表しています
- 特に`random_fun/0`がうまくかけたんじゃないかとおもっています :rocket:
    - [&関数捕捉演算子](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#&/1)
    - [Function capturing](https://elixir-lang.org/getting-started/modules-and-functions.html#function-capturing)

```Elixir:
  defp random_fun do
    [&one/0, &two/0, &three/0, &four/0, &five/0, &six/0]
    |> Enum.random()
  end
```





