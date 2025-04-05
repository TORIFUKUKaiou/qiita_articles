---
title: 闘魂プログラミング： Rubyで楽しむAtCoder Beginners Selection
tags:
  - Ruby
  - ポエム
  - 闘魂
private: false
updated_at: '2025-04-04T12:05:51+09:00'
id: 4d8d87ec18ddf2e89af4
organization_url_name: haw
slide: false
ignorePublish: false
---
![2025-02-10_07-46-21_436.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/898583e8-1ac4-fd37-3c05-f66dbc2e15a2.jpeg)

（これまでいただいたQiitanたちと他のお人形さんたちもいっしょに記念撮影）


# はじめに

プログラミングのスキルを向上させるために、私は現在、[AtCoder](https://atcoder.jp/)のABC問題に挑戦しています。AtCoderは、アルゴリズムやデータ構造を中心にした問題解決能力を磨く場であり、自分との闘いでもあります。挑戦を通じてアントニオ猪木さんがおっしゃった「闘魂とは己に打ち克つこと、そして闘いを通じて己の魂を磨いていくこと」を体現する一つの活動と捉えています。


## AtCoderとは

AtCoderは、日本発のオンラインプログラミングコンテストプラットフォームで、競技プログラミングの学習や実力を試す場として多くのエンジニアや学生に利用されています。プラットフォーム上では、さまざまなレベルの問題が提供されており、初心者から上級者まで幅広く挑戦することができます。

AtCoderの主な特徴として、以下の点が挙げられます：
- **定期的なコンテスト**: 毎週開催される「AtCoder Beginner Contest (ABC)」や「AtCoder Regular Contest (ARC)」を通じて、問題解決能力を継続的に向上させることができます
- **多彩な問題**: アルゴリズム、データ構造、数学、最適化など、幅広い分野の問題が揃っています
- **ランキングとレーティング**: 参加者の成績に応じてレーティングが変動し、自分の成長を数値として確認することが可能です

特にABCは、初心者向けの問題が中心でありながら、後半の問題はやりごたえのあるものも多く、プログラミングスキルを基礎から応用まで段階的に磨けるのが魅力です。AtCoderは単なる練習の場ではなく、自己成長や目標達成のための重要なステップとして、国内外のエンジニアから高く評価されています。

## AtCoder Beginner Contest (ABC)

AtCoder Beginner Contest (ABC)についての個人の見解です。
順にレベルが上がります。

どのプログラミング言語でも共通にある「順次、分岐、繰り返し」で問題のレベルを解説してみます。

### A問題

順次、分岐で解けます。

### B問題

順次、分岐に加えて繰り返しを使います。

### C問題

順次、分岐、三重程度の多重繰り返しを使います。

---

コンテストによりその傾向は異なります。
D問題以降は競技プログラミングの訓練が必要です。訓練無しに解ける人は才能があります。うらやましい限りです。

何を「一般的」と定義するのかは諸説あると思いますが、数学的センスを必要とはしない「一般的な」プログラミングはC問題くらいまでできればなんとかなります。何の自慢にもなりませんが、私はそれで20年以上飯を喰ってきました。そして自分でも気づいている通り、それは何の自慢にもなりませんし、`html`のタグを手打ちするのが当たり前だった牧歌的な時代をだらっとすごしてきた人間の感傷かもしれません。若い人には高みを目指して欲しいと思っています。そしてそんな私を生温かい目で**鑑賞**していただければ幸いです。ポエムです。



**ここで述べたのはあくまでも個人の見解です。**

---

# [AtCoder Beginners Selection](https://atcoder.jp/contests/abs)

今回は、[AtCoder Beginners Selection](https://atcoder.jp/contests/abs)に挑戦します。

以前、Elixirで解いた記事があります。

https://qiita.com/torifukukaiou/items/2a17b1cb850cde75f664

## [PracticeA - Welcome to AtCoder](https://atcoder.jp/contests/abs/tasks/practice_1)

問題文はリンク先をご参照ください。
それでは解答です。

<details><summary>私の解答</summary>

### Ruby

```ruby
# 整数の入力
a = gets.chomp.to_i
# スペース区切りの整数の入力
b,c = gets.chomp.split(" ").map(&:to_i)
# 文字列の入力
s = gets.chomp
# 出力
puts("#{a+b+c} #{s}")
```


</details>


## [ABC086A - Product](https://atcoder.jp/contests/abs/tasks/abc086_a)

問題文はリンク先をご参照ください。
それでは解答です。

<details><summary>私の解答</summary>

### Ruby

```ruby
a, b = gets.chomp.split(" ").map(&:to_i)
x = a * b

if x.odd?
  puts 'Odd'
else
  puts 'Even'
end
```




</details>



## [ABC081A - Placing Marbles](https://atcoder.jp/contests/abs/tasks/abc081_a)

問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
s = gets.chomp
a = s.split("")
filtered = a.filter { |item| item == '1' }
puts filtered.size
```

</details>

## [ABC081B - Shift only](https://atcoder.jp/contests/abs/tasks/abc081_b)

問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
gets
a = gets.chomp.split(" ").map(&:to_i)

count = (10**9).times do |i|
  if a.all? { |item| item.even? }
    a = a.map { |item| item / 2 }
  else
    break i
  end
end

puts count
```

</details>


## [ABC087B - Coins](https://atcoder.jp/contests/abs/tasks/abc087_b)

問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
a = gets.chomp.to_i
b = gets.chomp.to_i
c = gets.chomp.to_i
x = gets.chomp.to_i

count = 0

(0..a).each do |i|
  (0..b).each do |j|
    (0..c).each do |k|
      if (i * 500 + j * 100 + k * 50) == x
        count = count + 1
      end
    end
  end
end

puts count
```

</details>

## [ABC083B - Some Sums](https://atcoder.jp/contests/abs/tasks/abc083_b)

問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
n, a, b = gets.chomp.split(" ").map(&:to_i)

array = (1..n).map do |i|
  s = i.to_s.split('').map(&:to_i).sum()
  if a <= s and s <= b
    i
  else
    0
  end
end

sum = array.sum()
puts sum
```

</details>

## [ABC088B - Card Game for Two](https://atcoder.jp/contests/abs/tasks/abc088_b)

問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
gets
a = gets.chomp.split(" ").map(&:to_i)
a = a.sort().reverse()

alice = 0
bob = 0

a.each_with_index do |a, i|
  if i.even?
    alice = alice + a
  else
    bob = bob + a
  end
end

puts alice - bob
```

</details>

## [ABC085B - Kagami Mochi](https://atcoder.jp/contests/abs/tasks/abc088_b)

問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
n = gets.chomp.to_i
array = []

(1..n).each do |i|
  array << gets.chomp.to_i
end

puts array.uniq.size
```

</details>

## [ABC085C - Otoshidama](https://atcoder.jp/contests/abs/tasks/abc085_c)

問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
n, y = gets.chomp.split(" ").map(&:to_i)

found = false

(0..n).each do |i|
  (0..(n - i)).each do |j|
    k = n - i - j
    #next if [i, j, k].any? { |item| item < 0 }
    sum = 10000 * i + 5000 * j + 1000 * k
    if sum == y
      puts "#{i} #{j} #{k}"
      found = true
      break
    end
  end

  break if found
end

if !found
  puts "-1 -1 -1"
end

```

</details>

## [ABC049C - 白昼夢](https://atcoder.jp/contests/abs/tasks/arc065_a)

問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
s = gets.chomp.reverse
words =  ['dream', 'dreamer', 'erase', 'eraser'].map(&:reverse)
found = false

(10**5).times do |i|
  break if s.length == 0
  found = false

  words.each do |word|
    if s.start_with?(word)
      s = s[(word.length)..-1]
      found = true
      break
    end
  end

  break if !found
end

if found
  puts 'YES'
else
  puts 'NO'
end
```

</details>

## [ABC086C - Traveling](https://atcoder.jp/contests/abs/tasks/arc089_a)

問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
def main
  n = gets.chomp.to_i
  array_of_arrays = []

  n.times do |i|
    array_of_arrays << gets.chomp.split(" ").map(&:to_i)
  end

  before_t = 0
  before_x = 0
  before_y = 0

  result = false

  array_of_arrays.each do |t, x, y|
    result = false
    d = (x - before_x).abs + (y - before_y).abs
    dt = (t - before_t).abs
    break if d > dt
    break if ((dt - d) % 2) == 1

    before_t = t
    before_x = x
    before_y = y
    result = true
  end

  if result
    puts 'Yes'
  else
    puts 'No'
  end
end

main()
```

</details>

ここまでが、 [AtCoder Beginners Selection](https://atcoder.jp/contests/abs) の問題です。

以下、適当に選んで解いた問題の解答をついでに載せておきます。

## [A - Doors in the Center](https://atcoder.jp/contests/abc398/tasks/abc398_a)

問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
n = gets().chomp().to_i()

if n.even?
  left = (n - 2) / 2
  right = left
  puts "#{'-' * left}==#{'-' * right}"
else
  left = (n - 1) / 2
  right = left
  puts "#{'-' * left}=#{'-' * right}"
end
```

</details>

## [A - Thermometer](https://atcoder.jp/contests/abc397/tasks/abc397_a)


問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
f = gets().chomp().to_f()

if f >= 38.0
  puts 1
elsif f >= 37.5
  puts 2
else
  puts 3
end
```

</details>

## [B - Full House 3](https://atcoder.jp/contests/abc398/tasks/abc398_b)


問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
def main
  a = gets.chomp.split(' ').map(&:to_i)

  values = a.tally().values().sort().reverse()

  if values == [5, 2]
    puts 'Yes'
  elsif values == [4, 3]
    puts 'Yes'
  elsif values == [4, 2, 1]
    puts 'Yes'
  elsif values == [3, 3, 1]
    puts 'Yes'
  elsif values == [3, 2, 2]
    puts 'Yes'
  elsif values == [3, 2, 1, 1]
    puts 'Yes'
  else
    puts 'No'
  end
end

main()
```

</details>

## [B - Ticket Gate Log](https://atcoder.jp/contests/abc397/tasks/abc397_b)


問題文はリンク先をご参照ください。
それでは解答です。


<details><summary>私の解答</summary>

### Ruby

```ruby
def main
  a = gets.chomp.split('')
  count = 0


  1000.times do |i|
    if i > 1 && a[i - 1] == 'o' && a[i].nil?
      break
    end

    if i.even? && a[i] != 'i'
      count = count + 1
      a.insert(i, 'i')
    elsif i.odd? && a[i] != 'o'
      count = count + 1
      a.insert(i, 'o')
    end
  end

  puts count
end

main()
```

</details>

---

# まとめ

本記事を書くことを通して得られた経験は、『闘魂とは己に打ち克つこと』という言葉の重みを再認識させてくれました。今後も未知の領域へ果敢に挑戦していきます。

**あなたもお好きなプログラミング言語で、プログラミングという藝術活動を楽しんでください！**
