---
title: mix nerves.new hogeのちょっとした改善プルリクがマージされた話(Elixir)
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2020-10-07T14:13:29+09:00'
id: 26fed9d7193dc674e8fb
organization_url_name: fukuokaex
slide: false
---
# はじめに
- [Nerves](https://www.nerves-project.org/)とは、[ElixirのIoTでナウでヤングなcoolなすごいヤツです:rocket:](https://twitter.com/torifukukaiou/status/1201266889990623233)
- `mix nerves.new hoge`して、`hoge/mix.exs already exists, overwrite? [Yn]`に`n`で答えるとちょっとだけあれれ？　なことがおきます
- [Nerves](https://www.nerves-project.org/)の準備のところでやる`$ mix archive.install hex nerves_bootstrap`の[nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)に（本当に）ちょっとしたあれれ？　がありました
    - [Nerves](https://www.nerves-project.org/)の環境構築は、@takasehideki 先生の[ElixirでIoT#4.1：Nerves開発環境の準備（2020年9月版）](https://qiita.com/takasehideki/items/88dda57758051d45fcf9)が詳しいです

# （本当に）ちょっとだけあれれ？　なこと

```
$ mix nerves.new hoge
* creating hoge/config/config.exs
* creating hoge/config/target.exs
* creating hoge/lib/hoge.ex
* creating hoge/lib/hoge/application.ex
* creating hoge/test/test_helper.exs
* creating hoge/test/hoge_test.exs
* creating hoge/rel/vm.args.eex
* creating hoge/rootfs_overlay/etc/iex.exs
* creating hoge/.gitignore
* creating hoge/.formatter.exs
* creating hoge/mix.exs
* creating hoge/README.md

Fetch and install dependencies? [Yn] n
Your Nerves project was created successfully.

You should now pick a target. See https://hexdocs.pm/nerves/targets.html#content
for supported targets. If your target is on the list, set `MIX_TARGET`
to its tag name:

For example, for the Raspberry Pi 3 you can either
  $ export MIX_TARGET=rpi3
Or prefix `mix` commands like the following:
  $ MIX_TARGET=rpi3 mix firmware

If you will be using a custom system, update the `mix.exs`
dependencies to point to desired system's package.

Now download the dependencies and build a firmware archive:
  $ cd hoge
  $ mix deps.get
  $ mix deps.get
  $ mix firmware

If your target boots up using an SDCard (like the Raspberry Pi 3),
then insert an SDCard into a reader on your computer and run:
  $ mix firmware.burn

Plug the SDCard into the target and power it up. See target documentation
above for more information and other targets.
```

- わかりますか？
- `Now download the dependencies and build a firmware archive:`の下あたりで`$ mix deps.get`が２回でてきているのです :mask::mask:

# 気づいてしまったからには改善したほうがいいとおもって[プルリク](https://github.com/nerves-project/nerves_bootstrap/pull/163)を出しました

- [プルリク](https://github.com/nerves-project/nerves_bootstrap/pull/163)を出してからなんと**３０分くらい**でマージしてもらいました :tada::tada::tada: 

![スクリーンショット 2020-10-07 1.39.30.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/9c92f4a8-2529-d099-c6e6-a2263f1210f2.png)

- 私の黄色い猫のアイコンが左上と右下にいますよね！
- 今回は[Elixir](https://elixir-lang.org/)で書かれたコードを少し変えたコミットがマージしてもらえました
    - 以前、[Nerves](https://www.nerves-project.org/)関連でプルリクをマージしてもらったことがあるのですがそのときはドキュメントだけでした
    - ソースコードのちょっとした修正ではありますが、[Elixir](https://elixir-lang.org/)のプログラムを修正したプルリクがマージしてもらえたのはとてもうれしくおもっておりますし、自信にもなりました
    - 以前ドキュメント修正したというプルリク　→　[Update /CONTRIBUTING.md to /.github/CONTRIBUTING.md on README.md #501](https://github.com/nerves-project/nerves/pull/501)
- 全体をみないとなんのことやらわからないとはおもいますが、差分は以下の通りです

```diff
@@ -215,15 +215,11 @@ defmodule Mix.Tasks.Nerves.New do
     install? = Mix.shell().yes?("\nFetch and install dependencies?")
 
     File.cd!(path, fn ->
-      extra =
-        if install? && Code.ensure_loaded?(Hex) do
-          cmd("mix deps.get")
-          []
-        else
-          ["  $ mix deps.get"]
-        end
+      if install? && Code.ensure_loaded?(Hex) do
+        cmd("mix deps.get")
+      end
 
-      print_mix_info(path, extra)
+      print_mix_info(path)
     end)
   end
 
@@ -255,8 +251,8 @@ defmodule Mix.Tasks.Nerves.New do
     end
   end
 
-  defp print_mix_info(path, extra) do
-    command = ["$ cd #{path}"] ++ extra
+  defp print_mix_info(path) do
+    command = ["$ cd #{path}"]
 
     Mix.shell().info("""
     Your Nerves project was created successfully.
```
- いろいろ修正の方法があるとおもいました
- `print_mix_info`の第2引数の`extra`はそのまま残す修正の方法もあるとはおもいましたが、空のリストを渡すというような処理が増えることになりますし、プライベート関数で使われ方は限られていたので、思い切って第2引数の`extra`を消してしまうことにしました

# [nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)のプルリクを出すにあたってやったこと
- READMEを読んで手元でビルドしたオレオレ[nerves_bootstrap](https://github.com/nerves-project/nerves_bootstrap)をインストールした状態で、`$ mix nerves.new hoge`が正しく動作することを確認しました
- あとはちょっとドキドキしながらプルリクを送ったらすぐにマージしてもらえました :tada::tada::tada: 

```
$ cd nerves_bootstrap
$ mix test
$ mix do deps.get, archive.build, archive.install
$ cd ..
$ mix nerves.new hoge
```

# Wrapping Up
- なんかおかしいなとおもったら修正を検討してみよう! 
- 修正できたらプルリクしてみよう!
- Enjoy [Nerves](https://www.nerves-project.org/) !!!
- Enjoy [Elixir](https://elixir-lang.org/) !!!

