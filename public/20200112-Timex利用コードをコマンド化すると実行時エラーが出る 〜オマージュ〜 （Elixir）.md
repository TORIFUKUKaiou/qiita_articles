---
title: Timex利用コードをコマンド化すると実行時エラーが出る 〜オマージュ〜 （Elixir）
tags:
  - Elixir
private: false
updated_at: '2020-01-12T17:17:52+09:00'
id: 422116d6617892ab7050
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
（この記事は @piacerex さんの[Timex利用コードをコマンド化すると実行時エラーが出る](https://qiita.com/piacerex/items/7ebaa107ad7a7f6cec46)のオマージュです）

今回は、[Timex](https://hex.pm/packages/timex)を使うコードを、escriptでコマンド化した際、実行時エラーが出るのを回避する方法を解説 :alarm_clock:

escriptでのコマンド化についても、軽く解説します

私の記事ですが、[Slack Workflowの申請内容を一覧(CSV)にする(with Elixir)](https://qiita.com/torifukukaiou/items/9db04591477de8c4cc11) を書いているときに同じエラーが発生しましたので回避策を個別にまとめておきます

```
> elixir -v
Erlang/OTP 22 [erts-10.5.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Elixir 1.9.4 (compiled with Erlang/OTP 22)
```

# escriptでElixirコードをコマンド化
まず、メインモジュールにmain()関数を追加します

コンソールから呼び出したときは、この関数が呼ばれます

```Elixir:lib/sample.ex
defmodule Sample do
  def main(_args \\ []), do: IO.puts("Hello, world!")
end
```

mix.exsの「def project」配下にescript利用を追記し、「defp escript」にメインモジュールのモジュール名を追加します（ここではElixirプロジェクト名を「sample」としています(`> mix new sample` で作成)）

```Elixir:mix.exs
defmodule Sample.MixProject do
  use Mix.Project

  def project do
    [
    …
      escript: escript(), 
      deps: deps()
    ]
  end

  defp escript() do
    [main_module: Sample]
  end
…
```

escriptでコマンド化します

```
> mix escript.build
```

コンソールでの実行は、以下の通りです

```
> escript sample
```

Windows以外だと、以下でも実行できます

```
% chmod 755 ./sample
% ./sample
```

# Timex利用コードのコマンド化で実行時エラーが出る

[Timex](https://hex.pm/packages/timex)モジュールを導入します

```Elixir:mix.exs
defmodule Sample.Mixfile do
　…
  defp deps do
　…
    {:timex, "~> 3.6"}, 
　…
```

```
> mix deps.get
```

せっかくなので[Timex](https://hex.pm/packages/timex)を使ってみましょう

```Elixir:lib/sample.ex
defmodule Sample do
  def main(_args \\ []),
    do:
      Timex.now()
      |> Timex.local()
      |> Timex.format!("{YYYY}-{0M}-{0D} {h24}:{0m}:{0s}")
      |> IO.puts()
end
```




コマンド化して実行すると、以下エラーが出ます

```
> mix escript.build
> escript sample

13:41:51.198 [info]  Application tzdata exited: exited in: Tzdata.App.start(:normal, [])
    ** (EXIT) an exception was raised:
        ** (MatchError) no match of right hand side value: {:error, {:shutdown, {:failed_to_start_child, Tzdata.EtsHolder, {%ArgumentError{message: "unknown application: :tzdata"}, [{Application, :app_dir, 1, [file: 'lib/application.ex', line: 699]}, {Application, :app_dir, 2, [file: 'lib/application.ex', line: 726]}, {Tzdata.EtsHolder, :release_dir, 0, [file: 'lib/tzdata/ets_holder.ex', line: 123]}, {Tzdata.EtsHolder, :make_sure_a_release_dir_exists, 0, [file: 'lib/tzdata/ets_holder.ex', line: 101]}, {Tzdata.EtsHolder, :make_sure_a_release_is_on_file, 0, [file: 'lib/tzdata/ets_holder.ex', line: 77]}, {Tzdata.EtsHolder, :init, 1, [file: 'lib/tzdata/ets_holder.ex', line: 16]}, {:gen_server, :init_it, 2, [file: 'gen_server.erl', line: 374]}, {:gen_server, :init_it, 6, [file: 'gen_server.erl', line: 342]}]}}}}
            (tzdata) lib/tzdata/tzdata_app.ex:17: Tzdata.App.start/2
            (kernel) application_master.erl:277: :application_master.start_it_old/4
```

これを回避するには、[tzdata](https://hex.pm/packages/tzdata)モジュールに.etsファイルの場所をお知らせしておきます（元ネタは[こちら](https://github.com/lau/tzdata/issues/48)）

（[Timex](https://hex.pm/packages/timex)が[tzdata](https://hex.pm/packages/tzdata)に依存しています）

```Elixir
> iex -S mix
Erlang/OTP 22 [erts-10.5.3] [source] [64-bit] [smp:4:4] [ds:4:4:10] [async-threads:1] [hipe]

Interactive Elixir (1.9.4) - press Ctrl+C to exit (type h() ENTER for help)
iex> Tzdata.Util.data_dir
"c:/Users/torifuku/elixirProjects/sample/_build/dev/lib/tzdata/priv"
```

`Tzdata.Util.data_dir`で出力された内容を`config/config.exs`(このファイルがなければ作ります)に設定します

```config/config.exs
use Mix.Config

config :tzdata,
       :data_dir,
       "c:/Users/torifuku/elixirProjects/sample/_build/dev/lib/tzdata/priv"

```

ビルドし直して、実行すると、エラーが出なくなります :grinning:

```
> mix escript.build
> escript sample
2020-01-12 15:58:19
```

一応これで解決はしますが、スマートじゃないのでもっとよい方法がありましたらコメントいただけますとうれしいです:bow:

# 補足
- `{:tzdata, "== 0.1.8", override: true}`でバージョン固定するやり方は、Elixirが1.9.4だとコンパイルエラーがでていました

```
== Compilation error in file lib/tzdata/period_builder.ex ==
** (CompileError) lib/tzdata/period_builder.ex:60: undefined function from_standard_time_year/0
    (elixir) src/elixir_locals.erl:108: :elixir_locals."-ensure_no_undefined_local/3-lc$^0/1-0-"/2
    (elixir) src/elixir_locals.erl:109: anonymous fn/3 in :elixir_locals.ensure_no_undefined_local/3
    (stdlib) erl_eval.erl:680: :erl_eval.do_apply/6
could not compile dependency :tzdata, "mix compile" failed. You can recompile this dependency with "mix deps.compile tzdata", update it with "mix deps.update tzdata" or clean it with "mix deps.clean tzdata"
```

- 参考にさせていただいた @piacerex さんの記事は2016年のアドベントカレンダーですものね
- そんな前からElixirに注目されていたということに改めて敬意を表します
