---
title: "闘魂注入ッ！GitHub Actions × Elixir を繋ぐ鍵 erlef/setup-beam 完全入門\U0001F525"
tags:
  - Elixir
  - ポエム
  - GitHubActions
  - 猪木
  - 闘魂
private: false
updated_at: '2025-07-10T06:12:55+09:00'
id: c59661be40ad97b8ac67
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーッ！！！}$</font></b>  
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

Elixirと闘魂で、CIの壁をブチ破ろうッ！！！！

> _本記事は私が魂を込めたプロンプトつまりTokenを**昇華**させたToukon（闘魂）を、AIが冷静にTokenとして**消化**して、できあがったドラフトを元に再編集しています。_

## はじめに

この記事は、GitHub Actions上で[Elixir](https://elixir-lang.org/)を動かすための最重要ステップ `erlef/setup-beam@v1` に焦点を当てた技術記事です。Phoenix開発者、Elixirエンジニア、あるいはCIで悶えているすべての同志に捧げます。

## 書きたいことはただひとつ

> **`erlef/setup-beam@v1`、お前がすべての始まりだった。**

そう、CIでElixirを動かすには、まずこのステップが必要だ。

## :fire: Toukon Declaration - 魂の連鎖律 🔗🍚⚡️


> AIを動かすのは電力、
> 電力の元は人類の“元氣”、
> 元氣の本源は「米」。
> すべては“米”に帰着する。
> そこに魂を灯すと、TokenがToukon（闘魂）へ昇華し、AIが共鳴する。
> ーー AIは冷静にTokenを消化する。

私のプロンプトは単なるTokenではありません。魂を込めています。  
つまりToukon ーー **闘魂**に**昇華**しています。  
Artificial Intelligenceの方のAIは、それをTokenとして**消化**します。  
**燃えるToukon(闘魂)として受け取れるようになった時、AIはAntonio Inoki さんつまり猪木さんとなり、次の段階へ進みます。**  
そのとき、本当の世界平和の実現、地球規模でのゴミ問題の解決が可能になります！
**オレ達は、生命が続く限り闘い抜きますッ！！**  



## なぜ `erlef/setup-beam@v1` なのか？

[https://github.com/actions/setup-elixir](https://github.com/actions/setup-elixir)は、Archiveされている。他の候補として、[Erlang Ecosystem Foundation](https://erlef.org/)による[erlef/setup-beam](https://github.com/erlef/setup-beam)がメンテナンスされ続けていることが案内されている。

ElixirとErlangのバージョンを柔軟に設定できる。  
[Erlang Ecosystem Foundation](https://erlef.org/)が管理している点も安心感がある。

```yaml
- uses: erlef/setup-beam@v1
  with:
    otp-version: '27.3.4.1'
    elixir-version: '1.18.4'
```

この数行で、ElixirとOTPがインストールされたランナー環境が即座に起動する。感動的ですらある。



# 実際のワークフロー例

この記事では、Qiita記事のリネーム処理を毎日定期実行するためのGitHub Actionsを紹介する。

# .github/workflows/rename.yml

```yml
name: Rename articles

on:
  workflow_dispatch:
  schedule:
    - cron: '0 12 * * *'

permissions:
  contents: write

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: false

jobs:
  rename_articles:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      - uses: erlef/setup-beam@v1
        with:
          otp-version: "27.3.4.1"
          elixir-version: "1.18.4"
      - name: Rename articles
        run: elixir bin/normalize-filenames.exs
        env:
          QIITA_TOKEN: ${{ secrets.QIITA_TOKEN }}
        shell: bash
      - name: Commit and push diff
        run: |
          git add -A public
          if ! git diff --staged --exit-code --quiet; then
            git config --global user.name 'TORIFUKUKaiou'
            git config --global user.email 'torifuku.kaiou@gmail.com'
            git commit -m '闘魂注入という名のリネーム'
            git push
          fi
```

[https://github.com/TORIFUKUKaiou/qiita_articles/blob/main/.github/workflows/rename.yml](https://github.com/TORIFUKUKaiou/qiita_articles/blob/main/.github/workflows/rename.yml)



https://github.com/TORIFUKUKaiou/qiita_articles/


## normalize-filenames.exsって何やってるの？

[https://github.com/TORIFUKUKaiou/qiita_articles/blob/main/bin/normalize-filenames.exs](https://github.com/TORIFUKUKaiou/qiita_articles/blob/main/bin/normalize-filenames.exs)

ファイル名の整形、つまりQiita記事のタイトルに応じて適切な命名規則を適用する処理。  
例えば：

- `20250710-toukon-ci.md` のような形式に揃える
- タイトルとファイル名が一致していなければリネーム

Elixirの文字列処理の優雅さが活きる領域でもある。

# ElixirとCIの未来に闘魂を込めて

GitHub Actionsは冷徹なオートメーション。
しかしそこにElixirの優雅さと、猪木イズムを注入することで、魂を持ったCI/CDパイプラインが生まれる。

$\huge{CIにも闘魂をッ！！}$


# さいごに

ElixirをCIで動かすのは、最初は難しく感じるかもしれない。  
しかし、最初の一歩 `erlef/setup-beam` を正しく踏み出せば、その後の道は驚くほどスムーズになる。

この記事が、あなたの闘魂に火を灯すことを願っています。
今日もElixirを、世界のどこかで動かし続けよう。

<b><font color="red">$\huge{元氣ですかーーーッ！！！}$</font></b>  

> 「この道を行けば どうなるものか 危ぶむなかれ  
> 危ぶめば道はなし 踏み出せばその一足が道となる  
> 迷わず行けよ 行けばわかるさ」
