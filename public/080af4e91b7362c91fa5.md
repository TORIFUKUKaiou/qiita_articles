---
title: Memory usageを楽しむ（Elixir）
tags:
  - Elixir
  - Docker
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-10-29T08:08:26+09:00'
id: 080af4e91b7362c91fa5
organization_url_name: fukuokaex
slide: false
---
# はじめに

[Nerves](https://www.nerves-project.org/)にsshするとこんな表示がでます。

![スクリーンショット 2022-10-28 22.10.33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0e4a43d1-11c8-d8f5-6c29-8aee170bddd8.png)


この記事は`Memory usage`を深掘してみます。

# こたえ

早速答えです。

https://github.com/nerves-project/nerves_motd/blob/cd97c1773082d41a91856e17299390a37c87bae9/lib/nerves_motd/runtime.ex#L66-L82

```elixir
  def memory_stats() do
    # Use free to determine memory statistics. free's output looks like:
    #
    #                   total        used        free      shared  buff/cache   available
    #     Mem:         316664       65184      196736          16       54744      253472
    #     Swap:             0           0           0

    {free_output, 0} = System.cmd("free", [])
    [_title_row, memory_row | _] = String.split(free_output, "\n")
    [_title_column | memory_columns] = String.split(memory_row)
    [size_kb, used_kb, _, _, _, _] = Enum.map(memory_columns, &String.to_integer/1)
    size_mb = round(size_kb / 1000)
    used_mb = round(used_kb / 1000)
    used_percent = round(used_mb / size_mb * 100)

    {:ok, %{size_mb: size_mb, used_mb: used_mb, used_percent: used_percent}}
  rescue
    # In case the `free` command is not available or any of the out parses incorrectly
    _error -> :error
  end
```

要するに、`free`コマンドの結果で、`Mem`の`total`と`used`の値で計算しています。
文字列を改行（`\n`）でsplitしてあとは巧みにパターンマッチをして値を取り出しています。
coolです。何かの折にきっとこの技を使いたいと切におもいました。

# 試してみる

[Nerves](https://www.nerves-project.org/)をお使いの方は、sshしてお楽しみください。

macOSで試してみようとしました。しかし、macOSには、`free`コマンドはありません。
そこでDockerで動かしてみます。

```bash:CMD
docker pull hexpm/elixir:1.14.1-erlang-25.1.2-ubuntu-xenial-20210804
docker run --rm -it hexpm/elixir:1.14.1-erlang-25.1.2-ubuntu-focal-20211006 iex
```

IExが立ち上がります。
あとは、「こたえ」のところで示したコードを実行してください。
再掲しておきます。

```elixir
{free_output, 0} = System.cmd("free", [])
[_title_row, memory_row | _] = String.split(free_output, "\n")
[_title_column | memory_columns] = String.split(memory_row)
[size_kb, used_kb, _, _, _, _] = Enum.map(memory_columns, &String.to_integer/1)
size_mb = round(size_kb / 1000)
used_mb = round(used_kb / 1000)
used_percent = round(used_mb / size_mb * 100)
```

コピペして貼り付けて、迷わず実行してみてください。

# おわりに

この記事は、[Nerves](https://www.nerves-project.org/)にsshしたときに表示される`Memory usage`を深掘してみました。
Dockerで試してみる方法もご紹介しました。

Enjoy [Elixir](https://elixir-lang.org/)!!!
