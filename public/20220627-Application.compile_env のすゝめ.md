---
title: Application.compile_env のすゝめ
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - autoracex
  - AdventCalendar2022
  - QiitaEngineerFesta2022
private: false
updated_at: '2022-06-27T11:08:20+09:00'
id: 34426e3b1140c02cca67
organization_url_name: fukuokaex
slide: false
---

**志士は溝壑（こうがく）に在るを忘れず、勇士は其の元（かうべ）を喪うことを忘れず**

Advent Calendar 2022 131日目[^1]の記事です。
I'm looking forward to 12/25,2022 :santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5:
私の[Advent Calendar 2022 一覧](https://docs.google.com/spreadsheets/d/1HQvFjagQLRPjOYAjDVzWp9S4b8dKixxvvaz_TtbZWto/edit#gid=1723448955)。

[^1]: @kaizen_nagoya さんの「[「@e99h2121 アドベントカレンダーではありますまいか Advent Calendar 2020」の改訂版ではありますまいか Advent Calendar 2022 １日目　Most Breakthrough Generator](https://qiita.com/kaizen_nagoya/items/49ebebee3a0377f3b59b)」から着想を得て、模倣いたしました。 

---



# はじめに

[Elixir](https://elixir-lang.org/) を楽しんでいますか:bangbang::bangbang::bangbang:

この記事は、[Application.compile_env/3](https://hexdocs.pm/elixir/Application.html#compile_env/3)をオススメします。

# [Compile-time environment](https://hexdocs.pm/elixir/Application.html#module-compile-time-environment)

もし

```elixir:lib/foo.ex
defmodule Foo do
  @moduledoc """
  Documentation for `Foo`.
  """
  @world Application.get_env(:foo, :world, "awesome")

  def hello do
    @world
  end
end
```

と書いてあるところがありましたら、

```elixir:lib/foo.ex
defmodule Foo do
  @moduledoc """
  Documentation for `Foo`.
  """
  @world Application.compile_env(:foo, :world, "awesome")

  def hello do
    @world
  end
end
```

と書くようにしましょう。
違いは、`@world`の中身の定義の仕方です。
前者は`Application.get_env/3`を、後者は`Application.compile_env/3`を使っています。

ということが、[Compile-time environment](https://hexdocs.pm/elixir/Application.html#module-compile-time-environment) に書いてあります。
@mnishiguchi さんに教えてもらいました :pray::pray_tone1::pray_tone2::pray_tone3::pray_tone4::pray_tone5:

説明が前後しますが、こういう`config/config.exs`もセットで置いてあることが多いとおもいます。

```elixir:config/config.exs
import Config

config :foo, :world, "awesome123"
```





# 注意事項

注意事項をいくつか書きます。

## 1.10 or later

[Elixir](https://elixir-lang.org/)のバージョンは1.10以上から、[Application.compile_env/3](https://hexdocs.pm/elixir/Application.html#compile_env/3)は使えます。

## (RuntimeError) Application.compile_env/3 cannot be called inside functions, only in the module body

```elixir:lib/foo.ex
defmodule Foo do
  def foo do
    Application.compile_env(:foo, :world, "awesome")
  end
end
```

上記はコンパイルできません。

この場合は、以下のように[Application.get_env/3](https://hexdocs.pm/elixir/Application.html#get_env/3)を使います。

```elixir:lib/foo.ex
defmodule Foo do
  def foo do
    Application.get_env(:foo, :world, "awesome")
  end
end
```

## By using compile_env/3, tools like Mix will store the values used during compilation and compare the compilation values with the runtime values whenever your system starts, raising an error in case they differ.

なにもしていないのに壊れた :sob: に近いことが起こるかもしれません。
いや何かしているのです。なにかしているので`ERROR!`が発生しているのです。

```
ERROR! the application :foo has a different value set for key :world during runtime compared to compile time. Since this application environment entry was marked as compile time, this difference can lead to different behaviour than expected:

  * Compile time value was set to: "awesome1234"
  * Runtime value was set to: "awesome123"

To fix this error, you might:

  * Make the runtime value match the compile time one

  * Recompile your project. If the misconfigured application is a dependency, you may need to run "mix deps.compile foo --force"

  * Alternatively, you can disable this check. If you are using releases, you can set :validate_compile_env to false in your release configuration. If you are using Mix to start your system, you can pass the --no-validate-compile-env flag


** (ErlangError) Erlang error: "aborting boot"
    (elixir 1.13.1) Config.Provider.boot/2
```

上記の`:foo`や`:world`は適宜読み替えてください。


解決方法は、`mix compile --force`とでもすればいいでしょう。
`foo`が依存しているHexなら`mix deps.compile foo --force`です。

発生方法は以下の通りです。
もっと実践的な発生方法がわかりましたら追記します。

```elixir:lib/foo.ex
defmodule Foo do
  @moduledoc """
  Documentation for `Foo`.
  """
  @world Application.compile_env(:foo, :world, "awesome")

  def hello do
    @world
  end
end
```

```elixir:config/config.exs
import Config

config :foo, :world, "awesome1234"
```


```elixir:config/runtime.exs
```

`config/runtime.exs`はとりあえず空のファイルで大丈夫です。
上記の3ファイルがあるプロジェクトにて

```
iex -S mix
```

を一旦します。
実行してみます。

```elixir
iex> Foo.hello
"awesome1234"
```

という結果が得られました。
`config/config.exs`を書き換えます。
たとえば

```elixir:config/config.exs
import Config

config :foo, :world, "awesome123"
```

そして`recompile`します。

```
iex> recompile
```

一旦、Ctl+Cを2回押しでもしてIExを終了させます。
そして再度`iex -S mix`とすると冒頭のエラーに遭遇できます。

`config/runtime.exs`が存在しない場合は、同じことをしても`ERROR!`とはならないです。
もっと実践的なところで遭遇する例をみつけたら追記したいとおもいます。


# まとめ


この記事は、[Module attributes](https://elixir-lang.org/getting-started/module-attributes.html)で、[Application.get_env/3](https://hexdocs.pm/elixir/Application.html#get_env/3)を使っている箇所があったら、[Application.compile_env/3](https://hexdocs.pm/elixir/Application.html#compile_env/3)のほうを使うことがススメられていますよということをご紹介した記事です。

[Application.compile_env/3](https://hexdocs.pm/elixir/Application.html#compile_env/3)に置き換えたときに遭遇するかもしれない注意事項を3点書きました。

- 1.10 or later
- (RuntimeError) Application.compile_env/3 cannot be called inside functions, only in the module body
- By using compile_env/3, tools like Mix will store the values used during compilation and compare the compilation values with the runtime values whenever your system starts, raising an error in case they differ.

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
<font color="purple">$\huge{Enjoy\ Elixir🚀}$</font>



**We are the Alchemists, my friends!!!**



---



I organize [autoracex](https://autoracex.connpass.com/).
And I take part in [NervesJP](https://nerves-jp.connpass.com/), [fukuoka.ex](https://fukuokaex.connpass.com/), [EDI](https://fukuokaex.connpass.com/), [tokyo.ex](https://beam-lang.connpass.com/), [Pelemay](https://pelemay.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)



https://qiita.com/official-campaigns/engineer-festa/2022
