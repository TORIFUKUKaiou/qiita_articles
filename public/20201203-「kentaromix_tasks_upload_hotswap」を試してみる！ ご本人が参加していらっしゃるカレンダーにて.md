---
title: 「kentaro/mix_tasks_upload_hotswap」を試してみる！　ご本人が参加していらっしゃるカレンダーにて
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2020-12-25T00:47:21+09:00'
id: 6adf153ee3893fd1ad4d
organization_url_name: fukuokaex
slide: false
---
この記事は、[#NervesJP Advent Calendar 2020](https://qiita.com/advent-calendar/2020/nervesjp) 12日目です。
前日は、 @mnishiguchi さんの「[Elixir/Nervesでパルス幅変調 (PWM) Lチカ](https://qiita.com/mnishiguchi/items/4bdf88acf0ab0e8e2c7e)」でした。
こちらもお楽しみください。


---

# はじめに

- @kentaroさんの [kentaro/mix_tasks_upload_hotswap](https://github.com/kentaro/mix_tasks_upload_hotswap)を試してみます
    - この記事で試したリビジョン [5d0fc4ff0c0a4a8d66ad13b032391c393fdd3a05](https://github.com/kentaro/mix_tasks_upload_hotswap/tree/5d0fc4ff0c0a4a8d66ad13b032391c393fdd3a05)
    - あ、そうそう[Happy birthday!!! :tada::gift::tada::gift::tada::gift::tada:](https://twitter.com/kentaro/status/1333367449564004352)
- **[Nerves](https://www.nerves-project.org/)界に衝撃が走りました**
    - [Elixir/Nerves勢にはぜひ試していただいて、フィードバックをいただけると〜](https://twitter.com/kentaro/status/1333363087924097032)
    - [what an amazing command!! @NervesProject how do you think?](https://twitter.com/takasehideki/status/1332847404454875136)
- 試供品付き(`/example`)なのでそれをそのまま動かします
- Elixr: `1.11.2-otp-23`
- [Nerves](https://www.nerves-project.org/)アプリを作れる環境が必要です
    - @takasehideki  先生の[ElixirでIoT#4.1：Nerves開発環境の準備](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)
    - @kentaroさんの [ウェブチカでElixir/Nervesに入門する（2020年12月版）](https://qiita.com/kentaro/items/e8df79aa93b9fe9a567e)
    - :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: これらをご参照ください 

# では、さっそくためしていきます :rocket::rocket::rocket: 

```
$ git clone https://github.com/kentaro/mix_tasks_upload_hotswap.git
$ cd mix_tasks_upload_hotswap/example
$ export MIX_TARGET=rpi4
$ export MY_NETWORK_SSID=your_ssid
$ export MY_NETWORK_PSK=your_psk
$ mix deps.get
$ mix firmware
```

- `MIX_TARGET`はお使いのハードウェアにあわせてください
    - 他に使用できるものは、[Targets](https://hexdocs.pm/nerves/targets.html#content)をご参照ください
- `MY_NETWORK_SSID`と`MY_NETWORK_PSK`はWi-FiでRaspberry Piを接続する場合に指定してください
    - 2.4GHz(G)と5GHz(A)が使える場合は、2.4GHz(G)の方を使っておいたほうが無難という噂があります
    - LANケーブルでネットワークに接続する場合は必要ありません
- Firmwareがビルドできたら、開発用マシンにmicroSDカードを挿して

```
$ mix burn
```

- :point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5: このコマンドで焼き込みます
- こんがり焼き上がったmicroSDカードをRaspberry Pi 4にさして電源ON !!!

# シナリオ1
## REDAMEに書いてある通り、`Example.hello/0`のAtomをかえてみる(`:world` -> :"new world")

```
$ ssh nerves.local

iex(example@nerves.local)> Example.hello
:world
```

- `Example.hello/0`の結果は`:world`であることを確認したらソースコードを書き換えます

```diff:example/lib/example.ex
--- a/example/lib/example.ex
+++ b/example/lib/example.ex
@@ -13,7 +13,7 @@ defmodule Example do
 
   """
   def hello do
-    :world
+    :"new world"
   end
```

- ふつうはここで`mix firmware && mix upload`とやるわけですが、今回はそうではありません
- 開発マシンから以下のコマンドを打ち込みます

```
$ mix upload.hotswap
```

- `mix firmware && mix upload`をやるのと比較するとほぼ**<font color="Red">一瞬</font>**でおわります
- もう一度、`Example.hello/0`の結果を確認してみます

```elixir
iex(example@nerves.local)> Example.hello
:"new world"
```

- **`:world` -> `:"new world"`に変わっている！**
- **まじNervesアプリ書き換わっているよ！　→　成功**


# シナリオ2
## Awesomeモジュール追加(Awesome.hello/0)
- これはさすがに対応していないんじゃないかな？

```elixir:example/lib/awesome.ex
defmodule Awesome do
  def hello do
    "NervesはElixirのIoTでナウでヤングなcoolなすごいヤツです🚀 (https://twitter.com/torifukukaiou/status/1201266889990623233)"
  end
end
```

- モジュールを追加したらおもむろに、開発マシンから

```
$ mix upload.hotswap

Successfully connected to example@nerves.local
Successfully deployed Elixir.Awesome to example@nerves.local
Successfully deployed Elixir.Example to example@nerves.local
Successfully deployed Elixir.Example.Application to example@nerves.local
Successfully deployed Elixir.Example.Counter to example@nerves.local
```

- **`Elixir.Awesome`がdeployされた！？**
- [Nerves](https://www.nerves-project.org/)で動作を確認してみましょう

```elixir
iex(example@nerves.local)> Awesome.hello
"NervesはElixirのIoTでナウでヤングなcoolなすごいヤツです🚀 (https://twitter.com/torifukukaiou/status/1201266889990623233)"
```

- **これすげーよ、対応しちょるよ！**


## このHexどんな複雑なことをやっているのだろう？
- えっ、`lib/mix/tasks/mix/tasks/upload/hotswap.ex` １ファイルしかない
- [Mix.Tasks.Upload.Hotswap.run](https://github.com/kentaro/mix_tasks_upload_hotswap/blob/5d0fc4ff0c0a4a8d66ad13b032391c393fdd3a05/lib/mix/tasks/mix/tasks/upload/hotswap.ex#L9-L30) 関数もそれほど長くはない
- ふむふむ [Node.connect/1](https://hexdocs.pm/elixir/Node.html#connect/1)して、 (@kikuyuta 先生の記事を読めば理解できる(とおもう)！）
- `modules`をひっぱってきて [IEx.Helpers.nl/2](https://hexdocs.pm/iex/IEx.Helpers.html#nl/2) を呼ぶのだな

# シナリオ3
- 今度こそこれはどうだろう？

## [Timex](https://hexdocs.pm/timex/Timex.html)を`mix.exs`に追加して、[Timex.now/0](https://hexdocs.pm/timex/Timex.html#now/0)を呼び出してみる

```diff:example/mix.exs
--- a/example/mix.exs
+++ b/example/mix.exs
@@ -52,7 +52,8 @@ defmodule Example.MixProject do
       {:nerves_system_x86_64, "~> 1.13", runtime: false, targets: :x86_64},
 
       # Local dependencies
-      {:mix_tasks_upload_hotswap, path: "../", only: :dev}
+      {:mix_tasks_upload_hotswap, path: "../", only: :dev},
+      {:timex, "~> 3.5"}
     ]
   end
```

```diff:example/lib/example.ex
@@ -19,4 +19,8 @@ defmodule Example do
   def increment do
     GenServer.call(Example.Counter, :increment)
   end
+
+  def now do
+    Timex.now()
+  end
 end
```

- この状態で、`mix upload.hotswap`しても`Timex`は[Nerves](https://www.nerves-project.org/)アプリに入りません
    - この時点で`mix upload.hotswap`を実行してしまうと以下の変更をしても反映されないので**まだ待ってください**
    - **[Timex](https://hexdocs.pm/timex/Timex.html)なぞ知らぬといわれる** のです
    - これはさすがにだめか
    - けれど**[歌うアルケミスト](https://twitter.com/piacere_ex/status/1334656415357538304)**と呼ばれる、**自称**アルケミストのはしくれ、[名乗るほどのものでもない](https://interface.cqpub.co.jp/wp-content/uploads/if2101_152.pdf)が、解決しろと**血がさわぐ**
- 以下の変更をすると、(**本当に**)とりあえず**イゴきました** ザマス

```diff:lib/mix/tasks/mix/tasks/upload/hotswap.ex
-    {:ok, modules} = :application.get_key(app_name, :modules)
+    # {:ok, modules} = :application.get_key(app_name, :modules)
+    IO.puts :awesome
+    modules = :code.all_loaded() |> Enum.map(&elem(&1, 0))
 
     for module <- modules do
       for node <- nodes do
@@ -57,6 +59,10 @@ defmodule Mix.Tasks.Upload.Hotswap do
     IO.puts("Successfully deployed #{module} to #{node}")
   end
 
  defp handle_load_module({:ok, [{_, :loaded, _}]}, module, node) do
    IO.puts("Successfully deployed #{module} to #{node}")
  end

+  defp handle_load_module({:ok, [{_, hoge, fuga}]}, module, node) do
+    IO.puts("#{hoge} #{fuga} #{module} to #{node}")
+  end
```

- `:application.get_key(app_name, :modules)`だと自分が追加したモジュール情報しか取れないようなので全部とっちゃえばいいのじゃなかろうか(そんな発想です)
- `:code.all_loaded`なんて、なんのことだかさっぱりわからないけれど、天が教えてくれた(たぶん ↓↓↓)
    - [https://elixirforum.com/t/question-on-application-get-key-my-app-module/29391](https://elixirforum.com/t/question-on-application-get-key-my-app-module/29391
)

```
$ mix upload.hotswap
```

- すごくだーっと流れます
- ヒヤヒヤします
- **スピード・スリル・サスペンス 飯塚オートです**
- 変数名、とりあえず`hoge`とか`fuga`です
- **一応、(本当に一応)これ動きました！！！**
- mix firmware && mix burn よりは断然速いです！（体感）

```elixir
iex(example@nerves.local)2> Example.now  
~U[2020-12-09 12:55:24.790199Z]
```

## ただし
- [Timex](https://hexdocs.pm/timex/Timex.html)は上の手順で入りましたが、[HTTPoison](https://github.com/edgurgel/httpoison)はうまく動きませんでした(依存ライブラリが完全に入り切らず足りない)
- シナリオ3の私のホットフィックスはいろいろあやしいです
    - 気づいたことを披露しておきます
- 上記の通りを一気にやると`Timex.now/0`を呼び出せることは確認したのですが、なにか変更をさらに加えて`mix upload.hotswap`したときの[Nerves](https://www.nerves-project.org/)アプリの動作がさらにあやしさ満点です
    - `ssh nerves.local`の接続が切れている
    - `Example.now/0`を呼び出したときにまたふたたび`Timex`なぞ知らぬと言われる:sob:
- `mix deps.get`して、`mix upload.hotswap`をしたときに`Timex`およびその依存モジュールがビルドされるのですがその最初のときだけ私のホットフィックスで`Timex`が[Nerves](https://www.nerves-project.org/)アプリに入るようです

```elixir
iex(example@nerves.local)2> Example.now  
** (UndefinedFunctionError) function Timex.now/0 is undefined (module Timex is not available)
    Timex.now()
```


# シナリオ4
- パソコン側で`iex -S mix`

```
$ iex -S mix
Erlang/OTP 23 [erts-11.0.1] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]


iex> :application.get_key(:example, :modules)
{:ok, [Example, Example.Application, Example.Counter]}
```



# Wrapping Up :lgtm::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::lgtm: 
- [kentaro/mix_tasks_upload_hotswap](https://github.com/kentaro/mix_tasks_upload_hotswap)は、とにかくすごい！ :rocket::rocket::rocket:
- `mix deps.get`するようなときは一回`mix firmware && mix upload`をしてmicroSDカードを落ち着けてから、自分の追加モジュールをイジイジして`mix upload.hotswap`で効率よく開発して、コードが固まったらまたそこで`mix firmware && mix upload`するというような使い方でだいぶ開発効率はあがるようにおもいます
- さっそく私のごった煮プロジェクト[TORIFUKUKaiou/hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)には追加していきたいとおもいます
    - ついでに[Nerves](https://www.nerves-project.org/)のバージョンあげよう！ とおもぉう〜 :microphone: 
    - [Pelemay](https://github.com/zeam-vm/pelemay)
    - [CpuInfo](https://github.com/zeam-vm/cpu_info)
    - もいれておこう！
    - (まだできてはいない :relaxed:)
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket::rocket::rocket::rocket::rocket::rocket::rocket:

**明日は@kentaro さんご本人が[kentaro/mix_tasks_upload_hotswap](https://github.com/kentaro/mix_tasks_upload_hotswap)を語ってくださいます。「[`mix upload.hotswap` (kentaro/mix_tasks_upload_hotswap)の裏側](https://qiita.com/kentaro/items/3fbf6a0e603adf64b235)」もぜひお楽しみください。**
**I can’t wait until tomorrow.**


**[`mix upload.hotswap` (kentaro/mix_tasks_upload_hotswap)の裏側](https://qiita.com/kentaro/items/3fbf6a0e603adf64b235)**

:point_up::point_up_tone1::point_up_tone2::point_up_tone3::point_up_tone4::point_up_tone5:     
