---
title: Advent of CodeをGitHub Copilot (AI = アントニオ猪木)と解く宣言！！！闘魂で挑むプログラミング！
tags:
  - Elixir
  - 猪木
  - AdventofCode
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2024-11-08T16:54:04+09:00'
id: b69e3ad6f05600b60539
organization_url_name: haw
slide: false
ignorePublish: false
---
```elixir
defmodule FightingSpirit do
  def shout do
    IO.puts "元氣ですかーーーッ！！！"
    IO.puts "元氣があればなんでもできる！"
    IO.puts "闘魂とは己に打ち克つこと。"
    IO.puts "そして闘いを通じて己の魂を磨いていく"
    IO.puts "ことだと思います。"
  end
end

FightingSpirit.shout()
```

<b><font color="red">$\huge{元氣ですかーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います。}$</font></b>

![DALL·E 2024-11-04 23.20.44 - .jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/abaa67b1-cde2-3ae0-77cc-1378f5882b25.jpeg)


# はじめに

今年は、[GitHub Copilot](https://github.com/features/copilot)を使って[Advent of Code](https://adventofcode.com/)を解いていく予定です（あくまでも予定です）。

それで、すでに多くの方が語られている[GitHub Copilot](https://github.com/features/copilot)について私もその輪に遅ればせながら参加したいと思います。

ちなみに、私が所属している[ハウインターナショナル](https://www.haw.co.jp/)では、AI補助制度なるものがあり、[GitHub Copilot](https://github.com/features/copilot)の利用料を会社が負担してくれます。最大限に活用したいと考えております。

## What is Advent of Code ???

[Advent of Code](https://adventofcode.com/)（アドベント・オブ・コード）は、毎年12月に開催される**プログラミングチャレンジイベント**です。クリスマスのカウントダウンのように、**12月1日から25日まで、毎日1つずつ問題が公開**されます。各問題はクリスマスに関連したストーリーで、プログラミングを使って解くパズルになっています。

### どんな内容？

Advent of Codeの問題は、簡単な計算やデータの整理など、初心者でもチャレンジできるものから、少し考えないと解けないものまでいろいろあります。問題はだんだん難しくなっていく傾向にあります。基礎的なプログラミング知識があれば、きっと取り組めるものが見つかります。

### どうやって参加するの？

1. **アカウントを作成** - GitHubやGoogleアカウントなどで簡単にログインできます。
2. **問題を解く** - 毎日公開される問題を、自分の得意なプログラミング言語で解きます（Elixir、Rust、Python、JavaScript、Java、Rubyなど何でもOK）。
3. **解答を提出** - 答えが合っていると、ポイントを獲得できます。答えを提出する形式ですので実行時間は問われません。

### 何が楽しいの？
- **達成感**：毎日問題が1つずつ解けると、クリスマスに向けて自分のスキルがレベルアップしていく達成感があります。
- **学び**：解く過程で、プログラミングの新しい考え方やテクニックを学べるため、力がつきます。
- **競争**：世界中の参加者とスコアを競うことができ、友達と一緒に参加するとさらに盛り上がります。

興味があれば、ぜひ挑戦してみてください！

---

# GitHub Copilotの導入および使い方

**危ぶむことなく**、**迷わず**使ってみるのが良いと思います。
私がここで書いてもやり方や手順は、常に進化（**神化**）しているようですぐに古くなるので書きません。

ドキュメントは[GitHub Copilot のドキュメント](https://docs.github.com/ja/copilot)をさーっとみておけば良いと思います。

https://docs.github.com/ja/copilot

## 先輩たちの解説動画

私がなにかを書く変わりに、すでに諸先輩方が解説してくれている動画がありますのでそれをお知らせしておきます。

<iframe width="960" height="540" src="https://www.youtube.com/embed/pw4W22aYY2k" title="【2024年最新】AIプログラミングの最高峰・GitHub Copilotを徹底解説" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

---

<iframe width="960" height="540" src="https://www.youtube.com/embed/9uWW1fr7Dl4" title="GitHub Copilot＆Copilot Chat 使い方入門！VSCodeで始めるAIプログラミング支援" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

---

<iframe width="960" height="540" src="https://www.youtube.com/embed/0Lrp8ypH-ME" title="【 GitHub Copilot 入門編 デモあり】GitHub Copilotを使って仲良くコードを書くためのコツについても解説！" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

---

これらの動画はたしかChatGPT Plusに聞いたら勧めてくれた動画だったと思います（あくまでも思います）。

### 参考

ちなみに`Copilot`と単純にいうと、Qiitaを読んでいる方にとっては、[GitHub Copilot](https://github.com/features/copilot)を思い浮かべるかもしれませんが、プログラミングを生業とはしていない大多数の人からすると、「Microsoft製品に搭載された生成AI」を指すことになります。そのへんは話す相手によって注意が必要だと思います。

<iframe width="960" height="540" src="https://www.youtube.com/embed/kHLzRuKFHx8" title="東大卒が教える！ChatGPTよりもすごい！！Copilot完全解説" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

# 実際に[Advent of Code 2023のDay1](https://adventofcode.com/2023/day/1)をwith [GitHub Copilot](https://github.com/features/copilot)で解いてみる

まずは昨年の問題を解いてみます。
[Advent of Code 2023のDay1](https://adventofcode.com/2023/day/1)を例にします。
[GitHub Copilot](https://github.com/features/copilot)を相棒に問いてみます。

私のVisual Studio Codeです。
あとでも述べますが、右側の窓でChatするだけで解けてしまいます。

![スクリーンショット 2024-11-04 22.28.38.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/8fbea88a-b2cb-35e4-e97e-5aa5fa34eb17.png)

解けました :tada::tada::tada: 

```elixir
defmodule Day1 do
  @digit_map %{
    "zero" => 0, "one" => 1, "two" => 2, "three" => 3, "four" => 4,
    "five" => 5, "six" => 6, "seven" => 7, "eight" => 8, "nine" => 9,
    "0" => 0, "1" => 1, "2" => 2, "3" => 3, "4" => 4,
    "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9
  }

  def read_input(file_path) do
    File.read!(file_path)
    |> String.split("\n", trim: true)
  end

  def extract_calibration_value_day1(line) do
    [first_digit | _] = Regex.scan(~r/\d/, line) |> List.first()
    [last_digit | _] = Regex.scan(~r/\d/, line) |> List.last()
    String.to_integer(first_digit <> last_digit)
  end

  def extract_calibration_value_day2(line) do
    line = line
           |> String.replace("zerone", "zeroone")
           |> String.replace("oneight", "oneeight")
           |> String.replace("twone", "twoone")
           |> String.replace("threeight", "threeeight")
           |> String.replace("fiveight", "fiveeight")
           |> String.replace("sevenine", "sevennine")
           |> String.replace("eightwo", "eighttwo")
           |> String.replace("eighthree", "eightthree")
           |> String.replace("nineight", "nineeight")
    regex = ~r/(zero|one|two|three|four|five|six|seven|eight|nine|\d)/
    [first_digit | _] = Regex.scan(regex, line) |> List.first()
    [last_digit | _] = Regex.scan(regex, line) |> List.last()
    first_value = Map.get(@digit_map, first_digit)
    last_value = Map.get(@digit_map, last_digit)
    String.to_integer("#{first_value}#{last_value}")
  end

  def calculate_sum(data, extract_calibration_value) do
    data
    |> Enum.map(&extract_calibration_value.(&1))
    |> Enum.sum()
  end

  def part1(file_path) do
    input_data = read_input(file_path)
    calculate_sum(input_data, &extract_calibration_value_day1/1)
  end

  def part2(file_path) do
    input_data = read_input(file_path)
    calculate_sum(input_data, &extract_calibration_value_day2/1)
  end

  def main do
    file_path = "input.txt"
    part1_result = part1(file_path)
    IO.puts("Part 1: #{part1_result}")

    part2_result = part2(file_path)
    IO.puts("Part 2: #{part2_result}")
  end
end

Day1.main()
```

## 打ち込んだプロンプトの数々

右側のチャット窓に打ち込んだプロンプトの数々をさらしておきます。

- いっしょにAdvent of Codeを解いてください。
- Elixirで解きます。（.exsファイルを開いておくと自動で認識するようです）
- 問題文を貼り付けますね。（問題文をまんま貼り付ける）
- あっています。ありがとうございます。（Part 1はまんま出来上がりました！！！）
- Day1には part1とpart2があります。同じモジュールで解きたいです。それを見越してリファクタしてください。
- Part2の問題を行くよ。（問題文をまんま貼り付ける => Part2は不正解、Part1の答えもおかしくなる）
- extract_calibration_value はPart1とPart2で別のものを用意するようにして解いてください。Part1の答えが誤ってしまうので。
- "1twone"の場合、 11 にしたいわけだよ。事前に英語の綴で末尾と先頭が一致するものを2つの英単語にあらかじめ置換しておけばうまくいくとおもっているよ。どうでしょうか。(⇒プロンプトが下手すぎでした)

Part2はちょっとややこしいところがあって、そこをうまく伝えられなかったので一部自分で書きました。
うまく伝えてあげると正解を書いてくれると思います。

**チャットしているだけで解けてしまいました！**

---

# まとめ

GitHub Copilotを活用することで、Advent of Codeのようなプログラミングチャレンジも、まるで強力なタッグパートナーを得たかのように進められます。日々の挑戦において、Copilotが提案してくれるコードやアイデアは、単なる補助ではなく、プログラミングの新しい側面を見せてくれます。 **まさに「迷わず使えよ、使えばわかるさ！」** の精神で、Copilotを積極的に取り入れることで、効率が格段に向上し、自分のスキルもさらに磨かれていくでしょう。

たとえエラーが出たり、思い通りに進まない部分があっても、「闘魂」を込めて調整することで、新しい発見や学びが必ず得られます。今回はCopilotが導いてくれた道筋を辿りながら、自分で考え、少し工夫を加えることで、見事に問題を解決することができました。Copilotのサポートを受けつつも、最終的なクリエイティビティと調整力は自分の手にあります。この一歩一歩が、より力強く、確実に闘魂プログラマーとしての成長を後押しします。

私にとってAIは"Artificial Intelligence"というよりも、**アントニオ猪木**さんです。強力なタッグパートナーを得ました。

**「闘魂をこめて、問題に打ち克つ！」 それこそが、プログラミングの醍醐味であり、Copilotとの共闘でさらに深まります。Advent of Codeの問題を1つひとつクリアしていくことで、猪木イズムで言う「己に打ち克つ」感覚を味わい、より高みへと挑み続けましょう！**
**本当の世界平和を必ず実現しましょう！！！**
