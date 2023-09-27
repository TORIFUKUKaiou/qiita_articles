---
title: NimbleCSVのご紹介(Elixir)
tags:
  - Elixir
private: false
updated_at: '2020-12-11T07:02:57+09:00'
id: 9e9e28411d6a7d134a11
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
この記事は [Elixir その2 Advent Calendar 2020](https://qiita.com/advent-calendar/2020/elixir2) 11日目です。
前回は [1 = a (プログラミングElixir 第2版)](https://qiita.com/torifukukaiou/items/14ad8b9673bd47ce8b8f) でした。

----

# はじめに
- [Elixir](https://elixir-lang.org/)楽しんでいますか！
- CSVを扱いたいことありますよね
- [dashbitco/nimble_csv](https://github.com/dashbitco/nimble_csv)をご紹介します
    - Contributorsの先頭には[Elixir](https://elixir-lang.org/)作者の[José Valim](https://twitter.com/josevalim)さんがいらっしゃいます
- `nimble` means that [able to move quickly and easily](https://www.oxfordlearnersdictionaries.com/definition/english/nimble?q=nimble)
    - 早く簡単に動作する、みたいなニュアンスでしょうか


![スクリーンショット 2020-12-10 23.00.38.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/053d404e-5399-700d-9bf6-5c4d7c44b3db.png)


![EoohLj8VgAAvhTJ.jpeg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/42f1247e-496f-47d8-94b7-e26e2471a9ba.jpeg)
**[プログラミングElixir 第2版](https://www.ohmsha.co.jp/book/9784274226373/)発売中**

- 書評: [1 = a (プログラミングElixir 第2版)](https://qiita.com/torifukukaiou/items/14ad8b9673bd47ce8b8f) 

# 導入

```
$ mix new csv_sample
$ cd csv_sample
```

```elixir:mix.exs
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:elixir_mbcs, github: "woxtu/elixir-mbcs", tag: "0.1.3"},
      {:nimble_csv, "~> 1.0"}
    ]
  end
```

```
$ mix deps.get
```

# 読み込み

```elixir:lib/csv_sample.ex
NimbleCSV.define(MyParser, [])

defmodule CsvSample do
  def read do
    File.read!("c01.csv")
    |> Mbcs.decode!(:cp932)
    |> MyParser.parse_string()
  end
...
```

- `NimbleCSV.define(MyParser, [])`というものを呼び出して置きます
    - [NimbleCSV.define/2](https://hexdocs.pm/nimble_csv/NimbleCSV.html#define/2)
- `c01.csv`は、[政府統計の総合窓口（ｅ－Ｓｔａｔ）](https://www.e-stat.go.jp/)というページ内の [https://www.e-stat.go.jp/stat-search/files?page=1&layout=datalist&toukei=00200521&tstat=000001011777&cycle=0&tclass1=000001094741](https://www.e-stat.go.jp/stat-search/files?page=1&layout=datalist&toukei=00200521&tstat=000001011777&cycle=0&tclass1=000001094741) にて**男女別人口－全国，都道府県（大正９年～平成27年）**のCSVをダウンロードしたものです
- [File.read!](https://hexdocs.pm/elixir/File.html#read!/1)して、
- `Mbcs.decode!(:cp932)`は文字コードを`UTF-8`へ変換し
- `MyParser. parse_string/1`でパースしているわけです
- :point_down::point_down_tone1::point_down_tone2::point_down_tone3::point_down_tone4::point_down_tone5:というふうに結果が返ります  

```elixir
$ iex

iex> CsvSample.read                                                       
[
  ["00", "全国", "大正", "9", "1920", "", "55963053", "28044185",
   "27918868"],
  ["01", "北海道", "大正", "9", "1920", "", "2359183", "1244322",
   "1114861"],
  ["02", "青森県", "大正", "9", "1920", "", "756454", "381293", "375161"],
  ["03", "岩手県", "大正", "9", "1920", "", "845540", "421069", "424471"],
  ["04", "宮城県", "大正", "9", "1920", "", "961768", "485309", "476459"],
  ["05", "秋田県", "大正", "9", "1920", "", "898537", "453682", "444855"],
  ["06", "山形県", "大正", "9", "1920", "", "968925", "478328", "490597"],
  ["07", "福島県", "大正", "9", "1920", "", "1362750", "673525", "689225"],
  ["08", "茨城県", "大正", "9", "1920", "", "1350400", "662128", "688272"],
  ["09", "栃木県", "大正", "9", "1920", "", "1046479", "514255", "532224"],
  ["10", "群馬県", "大正", "9", "1920", "", "1052610", "514106", "538504"],
  ["11", "埼玉県", "大正", "9", "1920", "", "1319533", "641161", "678372"],
  ["12", "千葉県", "大正", "9", "1920", "", "1336155", "656968", "679187"],
  ["13", "東京都", "大正", "9", "1920", "", "3699428", "1952989",
   "1746439"],
  ["14", "神奈川県", "大正", "9", "1920", "", "1323390", "689751",
   "633639"],
  ["15", "新潟県", "大正", "9", "1920", "", "1776474", "871532", "904942"],
  ["16", "富山県", "大正", "9", "1920", "", "724276", "354775", "369501"],
  ["17", "石川県", "大正", "9", "1920", "", "747360", "364375", "382985"],
  ["18", "福井県", "大正", "9", "1920", "", "599155", "293181", "305974"],
  ["19", "山梨県", "大正", "9", "1920", "", "583453", "290817", "292636"],
  ["20", "長野県", "大正", "9", "1920", "", "1562722", "758639", "804083"],
  ["21", "岐阜県", "大正", "9", "1920", "", "1070407", "536334", "534073"],
  ["22", "静岡県", "大正", "9", "1920", "", "1550387", "774169", "776218"],
  ["23", "愛知県", "大正", "9", "1920", "", "2089762", "1033860",
   "1055902"],
  ["24", "三重県", "大正", "9", "1920", "", "1069270", "525957", "543313"],
  ["25", "滋賀県", "大正", "9", "1920", "", "651050", "313737", "337313"],
  ["26", "京都府", "大正", "9", "1920", "", "1287147", "650780", "636367"],
  ["27", "大阪府", "大正", "9", "1920", "", "2587847", "1344846",
   "1243001"],
  ["28", "兵庫県", "大正", "9", "1920", "", "2301799", "1175426",
   "1126373"],
  ["29", "奈良県", "大正", "9", "1920", "", "564607", "280383", "284224"],
  ["30", "和歌山県", "大正", "9", "1920", "", "750411", "372058",
   "378353"],
  ["31", "鳥取県", "大正", "9", "1920", "", "454675", "222802", "231873"],
  ["32", "島根県", "大正", "9", "1920", "", "714712", "354959", "359753"],
  ["33", "岡山県", "大正", "9", "1920", "", "1217698", "605316", "612382"],
  ["34", "広島県", "大正", "9", "1920", "", "1541905", "775080", "766825"],
  ["35", "山口県", "大正", "9", "1920", "", "1041013", "521041", "519972"],
  ["36", "徳島県", "大正", "9", "1920", "", "670212", "331768", "338444"],
  ["37", "香川県", "大正", "9", "1920", "", "677852", "336195", "341657"],
  ["38", "愛媛県", "大正", "9", "1920", "", "1046720", "515389", "531331"],
  ["39", "高知県", "大正", "9", "1920", "", "670895", "332087", "338808"],
  ["40", "福岡県", "大正", "9", "1920", "", "2188249", "1116818",
   "1071431"],
  ["41", "佐賀県", "大正", "9", "1920", "", "673895", "329962", ...],
  ["42", "長崎県", "大正", "9", "1920", "", "1136182", ...],
  ["43", "熊本県", "大正", "9", "1920", "", ...],
  ["44", "大分県", "大正", "9", "1920", ...],
  ["45", "宮崎県", "大正", "9", ...],
  ["46", "鹿児島県", "大正", ...],
  ["47", "沖縄県", ...],
  ["00", ...],
  [...],
  ...
]
```

# 書き込み

```elixir
iex>[~w(name age), ~w(mary 28), ~w(awesome 85), ~w(hog,e 19), ~w(f,uga 17), ~w(不老不死の霊薬 999)]
[
  ["name", "age"],
  ["mary", "28"],
  ["awesome", "85"],
  ["hog,e", "19"],
  ["f,uga", "17"],
  ["不老不死の霊薬", "999"]
]
```

こういうデータがあったとしてCSVファイルへ書き出してみます

```elixir::lib/csv_sample.ex
NimbleCSV.define(MyParser, [])

NimbleCSV.define(MyParser, [])

defmodule CsvSample do
  ...

  def write do
    [~w(name age), ~w(mary 28), ~w(awesome 85), ~w(hog,e 19), ~w(f,uga 17), ~w(不老不死の霊薬 999)]
    |> MyParser.dump_to_iodata()
    |> IO.iodata_to_binary()
    |> (&File.write!("output.csv", &1)).()
  end
end
```

```elixir
$ iex

iex> CsvSample.write
:ok
```

- `output.csv`という名前でCSV(文字コードUTF-8)でファイルができていることでしょう

# Wrapping Up :christmas_tree::santa::santa_tone1::santa_tone2::santa_tone3::santa_tone4::santa_tone5::christmas_tree: 
- Enjoy CSV !!!
- :lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm::lgtm: 
- Enjoy [Elixir](https://elixir-lang.org/) !!! :rocket::rocket::rocket: 

