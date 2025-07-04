---
title: 並びが違うだけ？ 実質同じファイルかをPythonとElixirでスマートに検証する方法
tags:
  - Python
  - Elixir
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-01T19:40:29+09:00'
id: fb42f8d6dc98d7d56760
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# 並びが違うだけで“diff”に出るファイル、本当に違う？

日々の開発やデータ処理の中で、こんなことはないだろうか。

> 「diffを取ったら違うって言われたけど、並び以外は全部同じな気がする…」
> 「行数も内容も同じはず。でも順番が違うだけなんだよな」

そんなときに役立つ、“**実質同一かどうか**”を**一発で判定する方法**を、PythonとElixirで紹介する。

---

# 🐍 Python編：セット比較で即答！

```bash
python3 -c "print(set(open('file1.txt')) == set(open('file2.txt')))"
```

## ✔️ ポイント

* `set()` にすることで、**重複と順序を無視**して比較
* 改行単位で処理されるため、**1行1レコードのファイル**に特に適している

---

# 💧 Elixir編：MapSetで同様の比較を

```bash
elixir -e "IO.puts MapSet.new(File.stream!(\"file1.txt\")) == MapSet.new(File.stream!(\"file2.txt\"))"
```

## ✔️ 解説

* `File.stream!` でファイルを1行ずつ読み込む
* `MapSet.new()` により、**順不同＋重複なし**の集合として比較
* `IO.puts` で `true/false` を表示

---

# 🧠 結論

* `diff` は**並びまで厳密に見る**
* `set` や `MapSet` を使えば、**並び順が違うだけのファイルを“実質同じ”とみなせる**
* 比較ロジックに「何を同一とみなすか」の哲学が必要

---

# ✅ こういうときに使える

* 並びが毎回変わるログファイルやエクスポートCSVの検証
* 自動テストで「内容は同じなのに順番が違う」問題の切り分け
* チーム内レビューで「これは差分ではない」と伝える説得材料に

---

**「違いがあるのは並びだけ。ならば、もう“違い”ではない。」**
PythonでもElixirでも、**真の“実質一致”を証明できる一行がある。**

