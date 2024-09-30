---
title: pandasのDataFrameに複数行の値をインプットにして新しい列の値を作ることをPythonで楽しんでなおかつ、Elixirでも同じことを楽しむ
tags:
  - Python
  - Elixir
  - pandas
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-03-13T22:58:09+09:00'
id: 764cea61d3f724688a04
organization_url_name: haw
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>




# はじめに

[pandas](https://pandas.pydata.org/)の[DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html#pandas.DataFrame)に複数行の値をインプットにして新しい列の値を作ることをPythonで楽しみます。

なおかつ[Elixir](https://elixir-lang.org/)でも同じことを楽しんでみます。

# 例題

![スクリーンショット 2024-02-23 19.19.47.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/54392c5e-44e2-ca4b-a3da-f23172f121ef.png)

こういうデータがあったとします。
mark列を追加します。

- math、japanese、englishの得点が60点以上の場合の値は、`pass`とします
- そうではない場合の値は、`fail`とします

つまりこんな感じの[DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html#pandas.DataFrame)を得たいわけです。

![スクリーンショット 2024-02-23 19.22.59.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/47d0cfde-4460-3819-fda9-7f0a49b4bdbc.png)

# 実行環境

[Jupyter Docker Stacks](https://github.com/jupyter/docker-stacks)を使います。

こんな感じで使います。[README](https://github.com/jupyter/docker-stacks/blob/main/README.md)の通りです。

```bash
docker run -it --rm -p 10000:8888 -v "${PWD}":/home/jovyan/work quay.io/jupyter/datascience-notebook:2024-02-13
```

[pandas](https://pandas.pydata.org/)が同梱されているイメージです。
[pandas](https://pandas.pydata.org/)のバージョンは、`2.2.0`を使いました。

# 結論

[apply](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.apply.html#pandas.DataFrame.apply)を使うとよさそうですね。

```python
import pandas as pd

df = pd.DataFrame({
    'class': [1, 1, 1, 2, 2, 2, 3, 3, 3],
    'math': [10, 80, 90, 70, 80, 90, 50, 80, 60],
    'japanese': [80, 80, 70, 70, 80, 90, 70, 80, 90],
    'english': [100, 80, 60, 70, 80, 90, 70, 80, 90],
})
```

```python
def new_column(row):
    if row.math >= 60 and row.japanese >= 60 and row.english >= 60:
        return 'pass'
    else:
        return 'fail'

df['mark'] = df.apply(new_column, axis = 1)
```

簡単ですね。

# [apply](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.apply.html#pandas.DataFrame.apply)を知らずに困ったこと

この手前でこの記事は終わってもよいわけですが、[pandas](https://pandas.pydata.org/)初心者の私が困ってしまった話を書きます。

`class`を3クラスだけに絞ることします。

![スクリーンショット 2024-02-23 19.44.31.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/400dbd38-c8fe-48b3-fa60-4aa88378dcc1.png)

こんな感じの[DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html#pandas.DataFrame)が得られればOKです。

まずは[apply](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.apply.html#pandas.DataFrame.apply)を使った例です。

```python
df_class3 = df[df['class'] == 3]
df_class3.loc[:, ['mark']] = df_class3.apply(new_column, axis = 1)
```

## [apply](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.apply.html#pandas.DataFrame.apply)を知らずに……

[apply](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.apply.html#pandas.DataFrame.apply)を知らずに書いたコードがこんな感じです。

```python
l = []
for row in df_class3.itertuples():
    print(row)
    l.append('pass' if row.math >= 60 and row.japanese >= 60 and row.english >= 60 else 'fail')

df_marks_dummy = pd.DataFrame([l], index = ['mark']).T
```

`T`（転置）を使ってがんばって書いています。

```python
df_class3.shape
# => (3, 4)
```

```python
df_marks_dummy.shape
# => (3, 1)
```

ともに3行の[DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html#pandas.DataFrame)どうしだからぴったりくっつけられるだろう！

```python
pd.concat([df_class3, df_marks_dummy], axis = 1)
```

おっと……、へんてこりんなデータが得られました。[pandas.concat](https://pandas.pydata.org/docs/reference/api/pandas.concat.html)を`axis = 1`で使ったら、行が増えたあー、ぎゃー:sob:

![スクリーンショット 2024-02-23 19.56.14.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/4629c5de-0454-0fea-e794-095338427217.png)

知っている方からするとこの結果が得られるのは当たり前のことなのでしょうね。

Indexがずれているわけですね。
[apply](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.apply.html#pandas.DataFrame.apply)を使えば悩まずに済んだのでしょうが、こういう思った通りにならないときに、アレコレ試してみることで理解が深まることもあります。

ちなみに`df_marks_dummy = pd.DataFrame([l], index = ['mark'], columns = df_class3.index).T`と無理やり、Indexを指定しておけば辻褄はあいます。`T`で転置しているので、`columns`に与えています。
とにかく[apply](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.apply.html#pandas.DataFrame.apply)を使えば悩むことはありません。

## ちなみに初見で`df[df['class'] == 3]`が理解できなかった

ちなみにはじめて`df[df['class'] == 3]`を見たとき私は、なんだかちっともわかりませんでした。
ちょっとずつ分割してみると理解しやすいです。一番内側の`df['class'] == 3`だけ実行してみます。

```python
df['class'] == 3
```

```python
0    False
1    False
2    False
3    False
4    False
5    False
6     True
7     True
8     True
Name: class, dtype: bool
```

IndexとBool値の`pandas.core.series.Series`です。


```python
df[df['class'] == 3]
```

こう書くと、`True`のところの行が取り出せるわけですね。

![スクリーンショット 2024-02-23 20.03.39.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/05e33380-c956-5385-0872-f5f5662f42b8.png)




---

# [Elixir](https://elixir-lang.org/)では

[Elixir](https://elixir-lang.org/)で同じことをやってみます。

[Livebook](https://github.com/livebook-dev/livebook)を使います。
こちらも[README](https://github.com/livebook-dev/livebook/blob/main/README.md)に書いてあるDockerコンテナで動かす方法で試します。
[README](https://github.com/livebook-dev/livebook/blob/main/README.md)の通りです。

```bash
docker run -p 8080:8080 -p 8081:8081 --pull always ghcr.io/livebook-dev/livebook
```

![スクリーンショット 2024-02-23 20.08.49.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8d593ce2-581f-2081-6a88-14d70452f5e9.png)

[Elixir](https://elixir-lang.org/)では、[explorer](https://github.com/elixir-explorer/explorer)が[pandas](https://pandas.pydata.org/)に相当します。

```elixir
Mix.install([
  :explorer
])
```

```elixir
require Explorer.DataFrame, as: DF

df = DF.new(%{
  class: [1, 1, 1, 2, 2, 2, 3, 3, 3],
  math: [10, 80, 90, 70, 80, 90, 50, 80, 60],
  japanese: [80, 80, 70, 70, 80, 90, 70, 80, 90],
  english: [100, 80, 60, 70, 80, 90, 70, 80, 90]
})

df_class3 = DF.filter(df, class == 3)

df_class3_with_mark = DF.mutate(df_class3, mark:
  cond do
    math >= 60 and japanese >= 60 and english >= 60 -> "pass"
    true -> "fail"
  end
)

DF.print(df_class3_with_mark)
```

実行結果です。

```elixir
+-----------------------------------------------+
|   Explorer DataFrame: [rows: 3, columns: 5]   |
+-------+-------+----------+---------+----------+
| math  | class | japanese | english |   mark   |
| <s64> | <s64> |  <s64>   |  <s64>  | <string> |
+=======+=======+==========+=========+==========+
| 50    | 3     | 70       | 70      | fail     |
+-------+-------+----------+---------+----------+
| 80    | 3     | 80       | 80      | pass     |
+-------+-------+----------+---------+----------+
| 60    | 3     | 90       | 90      | pass     |
+-------+-------+----------+---------+----------+
```

やったね:tada::tada::tada:
[pandas](https://pandas.pydata.org/)の[DataFrame](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html#pandas.DataFrame)で理解を深めたあとでしたのですんなり書けました。

慣れの問題かもしれませんが、私は[Elixir](https://elixir-lang.org/)のほうが書きやすい、読みやすい、止まらないです。
人それぞれ、人生いろいろでしょう。

---

# さいごに

ChatGPTに聞いてみたら、[apply](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.apply.html#pandas.DataFrame.apply)を勧めてくれました。

![スクリーンショット 2024-02-23 20.15.42.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1b6c182a-178c-ccb0-3d2e-606f02d62e42.png)

まわり道かもしれませんが、あれこれ試行錯誤したほうが私は理解が深まるので無駄ではなかったとおもいます。
「[pandas.concat](https://pandas.pydata.org/docs/reference/api/pandas.concat.html)したら、行数が増えた。困った」みたいな方は私と同じようにいらっしゃるとおもうので、その方のお役にきっと立つだろうということで記録を残しておきます。




---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
