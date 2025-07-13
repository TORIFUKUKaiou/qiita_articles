---
title: 389倍の差！ ElixirでO(n)の罠にハマった話 - MapとListの性能差が想像以上だった件
tags:
  - Elixir
  - ポエム
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-13T08:05:19+09:00'
id: 96bd52f314768cb16e89
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
![ChatGPT Image 2025年7月12日 23_43_30.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/e4e4ab5a-6109-4ba3-bb7c-29d8071f08ab.png)


# はじめに

「アルゴリズムの計算量なんて、実用レベルでは気にしなくていいでしょ」

そう思っていた時期が僕にはありました。

今回、ElixirでGenServerを使ったユーザー管理システムを作っている時に、まさにO(n)の罠にハマってしまい、想像以上の性能差を目の当たりにしたので、その経験を共有します。

:::note info
https://hexdocs.pm/elixir/1.18.4/Map.html

The functions in this module that need to find a specific key work in logarithmic time. This means that the time it takes to find keys grows as the map grows, but it's not directly proportional to the map size. In comparison to finding an element in a list, it performs better because lists have a linear time complexity. Some functions, such as keys/1 and values/1, run in linear time because they need to get to every element in the map.

このモジュール（註: マップモジュール）の関数で特定のキーを見つける必要があるものは、対数時間で動作します。これは、キーを見つけるのにかかる時間がマップの成長に伴って増加するものの、マップのサイズに直接比例するわけではないことを意味します。リスト内の要素を見つけることと比較すると、リストは線形時間計算量を持つため、より良いパフォーマンスを発揮します。keys/1やvalues/1などの一部の関数は、マップ内のすべての要素にアクセスする必要があるため、線形時間で実行されます。
:::

# 問題の発端

ユーザー管理システムを作っていて、「とりあえずListでユーザー情報を管理しよう」と軽い気持ちで実装しました。

```elixir
defmodule UserManager do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, [], opts)
  end

  def init(_) do
    {:ok, []}  # Listで管理
  end

  def add_user(pid, user_id, name) do
    GenServer.call(pid, {:add_user, user_id, name})
  end

  def find_user(pid, user_id) do
    GenServer.call(pid, {:find_user, user_id})
  end

  def handle_call({:add_user, user_id, name}, _from, users) do
    new_user = %{id: user_id, name: name}
    {:reply, :ok, [new_user | users]}
  end

  def handle_call({:find_user, user_id}, _from, users) do
    # ここがO(n)の罠！
    result = Enum.find(users, fn user -> user.id == user_id end)
    {:reply, result, users}
  end
end
```

最初は数百ユーザーでテストしていたので、特に問題を感じませんでした。しかし、ユーザー数が増えるにつれて、明らかにレスポンスが遅くなってきました。

# 改善策：MapによるO(log n)検索

問題の原因は明らかでした。`Enum.find/2`による線形検索です。

そこで、MapによるO(log n)検索に変更しました。

```elixir
defmodule UserManager2 do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, %{}, opts)
  end

  def init(_) do
    {:ok, %{}}  # Mapで管理
  end

  def add_user(pid, user_id, name) do
    GenServer.call(pid, {:add_user, user_id, name})
  end

  def find_user(pid, user_id) do
    GenServer.call(pid, {:find_user, user_id})
  end

  def handle_call({:add_user, user_id, name}, _from, users) do
    new_user = %{id: user_id, name: name}
    {:reply, :ok, Map.put(users, user_id, new_user)}
  end

  def handle_call({:find_user, user_id}, _from, users) do
    # O(log n)で高速検索！
    result = Map.get(users, user_id)
    {:reply, result, users}
  end
end
```

変更点は実にシンプル：
- 状態をListからMapに変更
- `Enum.find/2`を`Map.get/2`に変更

# 実際にベンチマークを取ってみた

「どれくらい違うんだろう？」と思い、しっかりベンチマークを取ってみました。

```elixir
defmodule UserBenchmark do
  def run_benchmark do
    # テストデータサイズ
    test_sizes = [1000, 5000, 10000, 50000, 100000]
    
    Enum.each(test_sizes, fn size ->
      IO.puts("\n=== テストサイズ: #{size}ユーザー ===")
      
      # 両方のマネージャーを起動
      {:ok, manager1} = UserManager.start_link()
      {:ok, manager2} = UserManager2.start_link()
      
      # テストデータを追加
      1..size
      |> Enum.each(fn i ->
        user_id = "user_#{i}"
        name = "User #{i}"
        UserManager.add_user(manager1, user_id, name)
        UserManager2.add_user(manager2, user_id, name)
      end)
      
      # 検索対象をランダムに選択（1000回検索）
      search_targets = 
        1..1000
        |> Enum.map(fn _ -> 
          "user_#{:rand.uniform(size)}"
        end)
      
      # O(n)版のベンチマーク
      {time1, _} = :timer.tc(fn ->
        Enum.each(search_targets, fn target ->
          UserManager.find_user(manager1, target)
        end)
      end)
      
      # O(log n)版のベンチマーク
      {time2, _} = :timer.tc(fn ->
        Enum.each(search_targets, fn target ->
          UserManager2.find_user(manager2, target)
        end)
      end)
      
      time1_ms = time1 / 1000
      time2_ms = time2 / 1000
      improvement = time1_ms / time2_ms
      
      IO.puts("O(n)版（List）: #{Float.round(time1_ms, 4)}ms")
      IO.puts("O(log n)版（Map）: #{Float.round(time2_ms, 4)}ms")
      IO.puts("改善倍率: #{Float.round(improvement, 1)}倍高速化")
      
      # プロセスを終了
      GenServer.stop(manager1)
      GenServer.stop(manager2)
    end)
  end
end

UserBenchmark.run_benchmark()
```

# 結果に愕然とした

実際の測定結果がこちらです：

```
=== テストサイズ: 1000ユーザー ===
O(n)版（List）: 16.939ms
O(log n)版（Map）: 1.777ms
改善倍率: 9.5倍高速化

=== テストサイズ: 5000ユーザー ===
O(n)版（List）: 41.449ms
O(log n)版（Map）: 1.064ms
改善倍率: 39.0倍高速化

=== テストサイズ: 10000ユーザー ===
O(n)版（List）: 74.261ms
O(log n)版（Map）: 1.014ms
改善倍率: 73.2倍高速化

=== テストサイズ: 50000ユーザー ===
O(n)版（List）: 366.682ms
O(log n)版（Map）: 1.108ms
改善倍率: 330.9倍高速化

=== テストサイズ: 100000ユーザー ===
O(n)版（List）: 743.424ms
O(log n)版（Map）: 1.908ms
改善倍率: 389.6倍高速化
```

| ユーザー数 | O(n)版（List） | O(log n)版（Map） | 高速化倍率 |
|------------|----------------|---------------|-------------|
| 1,000      | 16.9 ms        | 1.7 ms        | 9.5倍       |
| 5,000      | 41.4 ms        | 1.0 ms        | 39.0倍      |
| 10,000     | 74.2 ms        | 1.0 ms        | 73.2倍      |
| 50,000     | 366.6 ms       | 1.1 ms        | 330.9倍     |
| 100,000    | 743.4 ms       | 1.9 ms        | 389.6倍     |

![benchmark_list_vs_map_en.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/cbecdb36-e738-449b-bfac-50de9484fe3a.png)

※ 図中: O(1) は、 O(log n)の誤りです。  


**想像以上でした。**

特に注目すべきポイント：

## 1. 線形増加の恐怖

- 1000ユーザー: 約17ms → まあ許容範囲
- 10000ユーザー: 約74ms → ちょっと遅い
- 50000ユーザー: 約367ms → 体感できる遅さ
- 100000ユーザー: 約743ms → 完全にアウト

## 2. 改善倍率の驚異

- 1000ユーザーで9.5倍
- 50000ユーザーで330.9倍
- 100000ユーザーで389.6倍

## 3. Map版の安定性

データサイズが100倍になっても、Map版の処理時間はほぼ一定（約1-2ms）。これがO(log n)の威力です。

# 実用的な影響

この数値を実際のWebアプリケーションに置き換えて考えてみると：

**1000回の検索 = 1000人のユーザーが同時にログインしようとした場合**
- 50000ユーザー登録済みの場合：**367ms vs 1.1ms**
- 100000ユーザー登録済みの場合：**743ms vs 1.9ms**

O(n)版だと、ユーザー数が増えるほど全体のレスポンスが悪化し、最悪の場合タイムアウトも発生します。

# 学んだこと

## 1. データ構造選択の重要性

「とりあえずList」ではなく、用途に応じた適切なデータ構造を選ぶことの重要性を痛感しました。

## 2. 理論と実践の乖離

「O(n)とO(log n)の違い」を頭では理解していても、実際の数値を見ると改めて驚かされます。

## 3. スケーラビリティの考慮

最初は少数のデータでテストしがちですが、スケールした時の性能も考慮する必要があります。


# まとめ

今回の経験で改めて感じたのは：

1. **データ構造の選択は性能に直結する**
2. **O(n)の罠は身近に潜んでいる**
3. **実際の数値で検証することの大切さ**
4. **スケーラビリティを最初から考慮する重要性**

「たかがデータ構造の違い」と思っていましたが、実際には**389倍**もの性能差が生まれました。

Elixirを使っている皆さんも、特にGenServerで状態管理をする際は、ぜひデータ構造の選択を慎重に検討してみてください。

きっと、想像以上の性能改善が得られるはずです。

---

*この記事が誰かの「O(n)の罠」回避に役立てば幸いです！*

![ChatGPT Image 2025年7月12日 10_22_33.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/eeeae009-3577-4a87-aeba-6f6adce8d4f9.png)
