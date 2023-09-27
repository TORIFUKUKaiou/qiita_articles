---
title: Elixirで、RubyのArray#packなことをする
tags:
  - Elixir
  - Monacoin
  - Blockchain
  - fukuoka.ex
private: false
updated_at: '2019-12-31T16:30:18+09:00'
id: ec81a4e5a0e3464b00ca
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- [Monacoin](https://monacoin.org/)のtestnet4に、とある[コインベーストランザクション](https://testnet-blockbook.electrum-mona.org/tx/2d3dcae3531be76f8e1ad1ba15f1c4503b159329156ad3814b1904eab411a6dd)があります
- 以下、抜粋です
<img width="1177" alt="スクリーンショット 2019-12-23 22.56.54.png" src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/0c9af043-6381-a4b3-4fe9-4011297ec19b.png">

- `coinbase`のところの  `"coinbase": "03e9bc0a42656c6965766520696e20796f7572207370697269742e20476f20666f7274682e00000000"` これはなんと書いてあるのかなー？　と
    - 先頭のほうの`03e9bc0a`と`00000000`を外した`"42656c6965766520696e20796f7572207370697269742e20476f20666f7274682e"`を以下読んでみます
    - 先頭のほうはたしかブロック高(だった気がする)
    - うしろのほうのやつは0だからいいでしょう
    - 16進文字列(上位ニブルが先)の形式になっています
- [Monacoin testnet4 Faucet](https://monacoin-testnet-faucet.torifuku-kaiou.tokyo/) `|>` これ動かしているの[私](https://twitter.com/torifukukaiou)です
    - 2017/10月か11月くらいから動かしています


# [Ruby](https://www.ruby-lang.org/ja/)なら
```Ruby
irb(main):002:0> ['42656c6965766520696e20796f7572207370697269742e20476f20666f7274682e'].pack('H*')
=> "Believe in your spirit. Go forth."
```

- [pack テンプレート文字列](https://docs.ruby-lang.org/ja/latest/doc/pack_template.html)

# [Elixir](https://elixir-lang.org/)なら
- 最近は[Elixir](https://elixir-lang.org/)にハマっていまして、[Elixir](https://elixir-lang.org/)ならどうやるんやろうなあーとおもってiexと戯れてみました
- [Enum.chunk_every/2](https://hexdocs.pm/elixir/Enum.html#chunk_every/2) がステキです！

```Elixir
iex(8)> (
...(8)> "42656c6965766520696e20796f7572207370697269742e20476f20666f7274682e"
...(8)> |> String.codepoints
...(8)> |> Enum.chunk_every(2)
...(8)> |> Enum.map(fn [a,b] -> "#{a}#{b}" end)
...(8)> |> Enum.map(&String.to_integer(&1, 16))
...(8)> |> List.to_string
...(8)> )
"Believe in your spirit. Go forth."
```

- もっと短くできるかもしれませんが愚直にやってみました
- **Thanks Elixir!**
- できた、できた


