---
title: Nervesで書き込める場所 (Elixir)
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2020-12-24T08:01:21+09:00'
id: 9dd5cfa81109a2e0a5eb
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
~~いつでも[#NervesJP Advent Calendar 2020](https://qiita.com/advent-calendar/2020/nervesjp)に代打できます~~ :smile_cat:
12月も終わりそうなので、[NervesJP Slack](https://join.slack.com/t/nerves-jp/shared_invite/enQtNzc0NTM1OTA5MzQ1LTg5NTAyYThiYzRlNDRmNDIwM2ZlZTJiZDc1MmE5NTFjYzA5OTE4ZTM5OWQxODFhZjY1NWJmZTc4NThkMjQ1Yjk)で相談のうえ、代打しました。 
@MickeyOoh さん、アレでしたら枠をお譲りしますのでご連絡くださいね〜
この記事は[#NervesJP Advent Calendar 2020](https://qiita.com/advent-calendar/2020/nervesjp) **9日目** です。
前日は、@kikuyuta 先生の[BeagleBone Green 上の Elixir / Nerves で電力制御をする](https://qiita.com/kikuyuta/items/5f8671c3164c16069ab5) でした。


# はじめに
- @ringo156 さんの[Nervesで画像処理がしたい](https://qiita.com/ringo156/items/688a52cf7c062f428094)を読みました
- その記事の中にコメントでこんなことを私が書きました
    - https://qiita.com/ringo156/items/688a52cf7c062f428094#comment-b9b71b7812e9b9c27f27

```elixir
File.write!("/root/sample.jpg", Picam.next_frame)
で書き込めるかも？(他のファイルなら書き込んだことあります)
Nervesが1.7とか新しいやつなら、File.write!("/data/sample.jpg", Picam.next_frame)
```

- 根拠を示さんとなー　ということで根拠を探す旅をしてきました
- ドキュメントのここです！　ソースコードのここです！　を示したかったのですが、結論から先に申しますと、近いところまで行った気はするのですがやや手前で失速しました
- 余談ですがRaspberry Pi にカメラをつないであんなことやこんなことをしてみたいとおもっていたのですが、どれを買えばいいのか迷っていたのでたいへん参考になりました

# ドキュメント
- [Advanced Configuration -- Partitions](https://hexdocs.pm/nerves/advanced-configuration.html#partitions)
  - Because the root filesystem is read-only, we also add a read/**write** partition by default, called app_data and mounted at **/root** (the root user's home directory).
  - このへんの記述ですよね:bangbang:
- @pojiro さんの質問ではじまった[elixir forum](https://elixirforum.com/)
    - [How to save data persistently on Nerves?](https://elixirforum.com/t/how-to-save-data-persistently-on-nerves/33319)
- https://github.com/nerves-project/nerves_system_br/blob/main/CHANGELOG.md#v1124
    - コメントにて、@pojiro さんに教えていただきました！
    - <font color="purple">$\huge{Thanks!!!}$</font>

私は、`/root`配下にファイルを書き込んだ経験があります。
[Nerves](https://nerves-project.org/)の1.7からは`/data`だと(たぶん@pojiroさんから)聞きました。
依然として`/root`は使えるそうでシンボリックリンクになっているとのことです。

# `/data`の旅
- いろいろ探しまわったつもりですけど私にはわかりませんでした
- わかりませんでしたでは淋しいので、たしかにそうなっているよをお示ししておきます
- [Nerves](https://nerves-project.org/)の1.7を使った`Hello, World`的なファームウェアを焼き込んで以下を実施しました

```elixir
$ ssh nerves.local

iex> File.read_link("/data")
{:ok, "root"}
```

- [File.read_link/1](https://hexdocs.pm/elixir/File.html#read_link/1) 関数に聞いてみたですよ :tada::tada::tada:

# 旅をしている途中でみつけたおもしろそうなもの

- https://github.com/nerves-project/nerves_runtime/blob/2e88d55edb680de596c1405678556133adb4f9a9/lib/nerves_runtime/kv.ex#L25-L56

```elixir
iex> Nerves.Runtime.KV.get_all()
%{
  "a.nerves_fw_application_part0_devpath" => "/dev/mmcblk0p3",
  "a.nerves_fw_application_part0_fstype" => "ext4",
  "a.nerves_fw_application_part0_target" => "/root",
  "a.nerves_fw_architecture" => "arm",
  "a.nerves_fw_author" => "The Nerves Team",
  "a.nerves_fw_description" => "",
  "a.nerves_fw_misc" => "",
  "a.nerves_fw_platform" => "rpi0",
  "a.nerves_fw_product" => "test_app",
  "a.nerves_fw_uuid" => "d9492bdb-94de-5288-425e-2de6928ef99c",
  "a.nerves_fw_vcs_identifier" => "",
  "a.nerves_fw_version" => "0.1.0",
  "b.nerves_fw_application_part0_devpath" => "/dev/mmcblk0p3",
  "b.nerves_fw_application_part0_fstype" => "ext4",
  "b.nerves_fw_application_part0_target" => "/root",
  "b.nerves_fw_architecture" => "arm",
  "b.nerves_fw_author" => "The Nerves Team",
  "b.nerves_fw_description" => "",
  "b.nerves_fw_misc" => "",
  "b.nerves_fw_platform" => "rpi0",
  "b.nerves_fw_product" => "test_app",
  "b.nerves_fw_uuid" => "4e08ad59-fa3c-5498-4a58-179b43cc1a25",
  "b.nerves_fw_vcs_identifier" => "",
  "b.nerves_fw_version" => "0.1.1",
  "nerves_fw_active" => "b",
  "nerves_fw_devpath" => "/dev/mmcblk0",
  "nerves_serial_number" => ""
}
``` 

- `mix upload`したらAに焼くだ、Bに焼くだ英語で言っているとおもいますが、いまアクティブな方はBだよみたいなのがわかるようです
    - `"nerves_fw_active" => "b"`

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree:
- 中途半端な感じですが、どなたかが完全版にしてくれるでしょう
- うん、これは完全に[Nerves](https://nerves-project.org/)な記事ですね
- Enjoy [Elixir](https://elixir-lang.org/) !!!
- ありがとう！ [Qiita Advent Calendar 2020](https://qiita.com/advent-calendar/2020)
- <font color="purple">$\huge{毎日が12月だったらいいのに！}$</font>

**明日は、@zacky1972先生の[Apple M1チップ搭載MacでNervesを動かす方法(2020.12.8暫定版)](https://qiita.com/zacky1972/items/753d2ef5d6bac48af14a)です。**
**引き続きお楽しみください。**
