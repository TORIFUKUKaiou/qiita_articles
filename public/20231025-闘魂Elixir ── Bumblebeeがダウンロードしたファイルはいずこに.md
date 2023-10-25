---
title: 闘魂Elixir ── Bumblebeeがダウンロードしたファイルはいずこに
tags:
  - Elixir
  - bumblebee
  - Livebook
  - AdventCalendar2023
  - 闘魂
private: false
updated_at: '2023-10-25T23:46:52+09:00'
id: beea66ad4c9629fa826e
organization_url_name: null
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>



# はじめに

[Bumblebee](https://github.com/elixir-nx/bumblebee/)という素敵なライブラリが[Elixir](https://elixir-lang.org/)にはあります。

> Bumblebee provides pre-trained Neural Network models on top of Axon. It includes integration with 🤗 Models, allowing anyone to download and perform Machine Learning tasks with few lines of code.

[Elixir](https://elixir-lang.org/)は素敵なプログラミング言語です。
これを使ってAIのいろいろを楽しめるようになってきています。
[Bumblebee](https://github.com/elixir-nx/bumblebee/)は大きく関係しています。


# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があってがですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

# [Bumblebee](https://github.com/elixir-nx/bumblebee/)がダウンロードしたファイルはいずこに

たぶん本質はここじゃないと思います。

2023/10/24(火)に開かれた「[LiveViewJP#22：画像識別AIや音声識別AI、お絵描きAIをハンズオンで作成](https://liveviewjp.connpass.com/event/296643/)」というイベントに参加しました。

[Livebook](https://livebook.dev/)という[Elixir](https://elixir-lang.org/)製のノートブックツールをつかって、グラフィカルユーザーインターフェースでぽちぽちでAIを楽しめます。

![kino_bumblebee_token_classification.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/6ce867a5-b3e6-9906-aaf7-8c94bd61aeaf.png)

内部的にはこういうコードが実行されているようです。

```elixir
{:ok, model_info} = Bumblebee.load_model({:hf, "bert-base-uncased"})
{:ok, tokenizer} = Bumblebee.load_tokenizer({:hf, "bert-base-uncased"})
```

ダウンロードが始まります。何かファイルをどこかに保存しているログが流れます。

冒頭述べた通り、たぶん本質はここじゃないと思います。
だけれども気になったものは仕方ありません。好奇心は止められません。ロマンティックは止まりません。
探す旅にでかけました。それはワクワク、ドキドキのアドベンチャーでした。

# きっとここ

きっとここだと思います。
どうやってたどりついたのか思い出せません。
たしか動物的カン（実は**理詰めのカンピュータ**）で探し当てました。（うまく言葉にはできませんがベテランならできる技みたいなものがあるのです。まだまだ若いものには負けません）

```elixir:https://github.com/elixir-nx/bumblebee/blob/v0.4.2/lib/bumblebee.ex#L1144-L1154
  @doc """
  Returns the directory where downloaded files are stored.
  """
  @spec cache_dir() :: String.t()
  def cache_dir() do
    if dir = System.get_env("BUMBLEBEE_CACHE_DIR") do
      Path.expand(dir)
    else
      :filename.basedir(:user_cache, "bumblebee")
    end
  end
```

`BUMBLEBEE_CACHE_DIR`なんて環境変数は設定しないでしょうから、`:filename.basedir(:user_cache, "bumblebee")`が実行されるわけです。

私のMacでは以下を指していました。

```elixir
iex> :filename.basedir(:user_cache, "bumblebee")
"/Users/awesome/Library/Caches/bumblebee"
```

いろいろイベント中に試したのでたくさんのファイルがダウンロードされていました。

```
tree /Users/awesome/Library/Caches/bumblebee
/Users/awesome/Library/Caches/bumblebee
└── huggingface
    ├── 45ak3kopsrlcvrs4ghpxsoooa4.eizggmjzmy3dmnrwmuygkmjwgnrtoojvgrsgmnrwmnrdsmbrgm2tgztdmfsdaobymura
    ├── 45ak3kopsrlcvrs4ghpxsoooa4.json
    ├── 45jmafnchxcbm43dsoretzry4i.eiztamryhfrtsnzzgjstmnrymq3tgyzzheytqmrzmm4dqnbshe3tozjsmi4tanjthera
    ├── 45jmafnchxcbm43dsoretzry4i.json
    ├── 4oyaiviw4gtpsnfvzcjwelasoq.json
    ├── 4oyaiviw4gtpsnfvzcjwelasoq.k4xsenbtmmwwcqjrn52fmnzlmjawq3segnkwyscgjjzgg5ktozeegyzc
    ├── 4rzuvfd7uqgwxqphdacp6avq7u.ei3dqobyhazgcnzzmy2dinbugjsgiyzrmy3dazbxgaztgndbg5tgmnlemyygmyrug4ra
    ├── 4rzuvfd7uqgwxqphdacp6avq7u.json
    ├── 4tbnly7rbf52so232jfgxonbgm.ei3dknztmqydsmzumm3wgnbxgyytgm3ggy4dqnlfhe3wezjzmy3wkmzwmqytiytfmqra
    ├── 4tbnly7rbf52so232jfgxonbgm.json
    ├── 5ret6rvancrakuueiqha45gy6u.ei3timbzmy2gkyryhbrtazbqgyztqojrmvswmmbymy4gmnbtmqygiylggq3wmojyhara
    ├── 5ret6rvancrakuueiqha45gy6u.json
    ├── 6iosqsd3di2r5kjnx2jpszqq4i.json
    ├── 6iosqsd3di2r5kjnx2jpszqq4i.k4xseobrfv2tqwdzom3fsubljvwfgv2kjevusq3bojkgmncjjbgxgiq
    ├── 6scgvbvxgc6kagvthh26fzl53a.ejtgmobrgyzwcmjtgiztgmztgezdmnzqgzsdmnbzmnstom3fmnsdontfgq2wimrugfrdimtegyzdgzdfme3ggnzsgm3dsmddmftgkmbxei
    ├── 6scgvbvxgc6kagvthh26fzl53a.json
    ├── 7p34k3zbgum6n3sspclx3dv3aq.json
    ├── 7p34k3zbgum6n3sspclx3dv3aq.k4xsenbtguwtmuclmfdgum3enjuwosljkrbuc42govrhcudqlbde6ujc
    ├── bnlgkvnpwj52hykyqh7ooxmlqq.eiytsmzuheygenjymvtdmmrxgm4tanzxgi3dezjygmzwezrqheywgnrwmmzdsnbyhaydkobwhaywcyzsgvrwmn3emyzwiobrheydsnzuei
    ├── bnlgkvnpwj52hykyqh7ooxmlqq.json
    ├── bogumoiciig45rqy2g57e6tpiy.ei4toytfmqzgeyjqgnstcyjxg5tgknjuhbtgcyrygaytinrumm3tgndcgbqtcnbsmira
    ├── bogumoiciig45rqy2g57e6tpiy.json
    ├── c33jqncm4wa4tcko5dpxf53m4a.json
    ├── c33jqncm4wa4tcko5dpxf53m4a.k4xseobvmqwvgtdmjzjeurlxjzxg4y2vorwfoyzwhb4w4n3mivjum3zc
    ├── dh2w67quldl2vmsmwdtzufqwf4.ei3tomdbgq3wcolgmzsggztemeygembvguydmyjxha4dqzleg4ytizbqgyytgmlegyydenrxmu3ggzrvgi3tmnlegyywgzrvhftginrxei
    ├── dh2w67quldl2vmsmwdtzufqwf4.json
    ├── g7j3pdbldewprfr6xcwld5b5ae.ejsdmyrymu2tgndeg5rtgzrtgbtgkzrygu3gcmtfgzqtezbsmi2geobwgyytmolehera
    ├── g7j3pdbldewprfr6xcwld5b5ae.json
    ├── hyf4yh32gfopwaspy4p5jgp35u.ejqtqyrtgiydqyzsha4diyzumvtgeobwmu2dsmzqgbtgizbtmrrtqnzxgizday3emyra
    ├── hyf4yh32gfopwaspy4p5jgp35u.json
    ├── if44k45fkbzgexit6zts5w6kiu.json
    ├── if44k45fkbzgexit6zts5w6kiu.k4xsendggmwwqokhhbkhawseor2gkm2tjbbfu2ctg5ug6u3rf5rekzzc
    ├── ifendrejod5wpsd6di3ylnw6eq.ei2teojuhe2tkztgg44damjqhazwmnzsgbrdgndcgu2wimdggftdkmjtgezwgnldgura
    ├── ifendrejod5wpsd6di3ylnw6eq.json
    ├── j3wvmkhwaquasphdeazohr2ehq.eiywemjtgrrwizlehbswenzymiytqndbmvtgeobyga2wentcgu3tezrtgztgcnzxmizdknldgq4dgnrwgvsgiyjzgmywmyjqgeztayzvei
    ├── j3wvmkhwaquasphdeazohr2ehq.json
    ├── joyelungrfqvqwv6mjjivtlj4a.eiydsn3dmy4dmzrygqytoojvgi4toyzrha2dgndegu3tkm3bhazwezbqmvswgzdcgera
    ├── joyelungrfqvqwv6mjjivtlj4a.json
    ├── k5b4gjtq4lpoaa3m6yuu6halkm.ejsgmnbtgbqtqntdmvtgknbrge2tiojvmu3diyzug44tgnryguygczdbmvqwgmdfhera
    ├── k5b4gjtq4lpoaa3m6yuu6halkm.json
    ├── k5rzwmdxtm2tvh7twpc2jhrt6y.ei4weztcgqzgcyjzg5sggzbwgfstqolggi3tsy3dmfswkojyhbrggy3cgrtgcytbmura
    ├── k5rzwmdxtm2tvh7twpc2jhrt6y.json
    ├── lb6l6khgwx2qwtr7adesyfcqgi.json
    ├── lb6l6khgwx2qwtr7adesyfcqgi.k4xsenzsgmwuo6lgnfeeoz2uirdu6k2skrmge5stgmzgmudhijzdi3zc
    ├── nmceqxcilyj2mbhjf2uwewrnfy.ei4toyrrhfrgkobugaztayrrmvtgiyjzg5tgcnjvmu3dontdgiytknjrmy4wczjvgqra
    ├── nmceqxcilyj2mbhjf2uwewrnfy.json
    ├── nmlxgldo3whwquych7eqcl24qa.eiygmojzhbrwimjvmu2tezrwgu3dkntdmq4damjuhe3wimjxgfrtkyrzgq3toy3dg4ra
    ├── nmlxgldo3whwquych7eqcl24qa.json
    ├── oociky5xkaqmdih564kjr7pzpi.json
    ├── oociky5xkaqmdih564kjr7pzpi.k4xsenbugawueqzygjwvazltpbugu4ktoq3fqrzyhfsdgnk2kvndqmbc
    ├── pg2bwgezsijahdtef5nq7zy4cm.json
    ├── pg2bwgezsijahdtef5nq7zy4cm.k4xsezlcfvieisdfkjbxcqkgnbdfaocumrevimlmki4eytlmn5lu2iq
    ├── prhukhu5obtz4fbwx6pydmffem.eizwemzzgezdszrqhe3dgnzvhezgimtfmy4tsmtemmytimzzgu2wgn3fgaywindbgira
    ├── prhukhu5obtz4fbwx6pydmffem.json
    ├── q2dnqvgyajrkey5wuyhfzbdqq4.ejsdmnrtha3dkmlbgu2tentdmmzgkzdfgu3gmmtcguytandegy4dkmlcga3tknjyge3gimrsgbstkzjqgq3dqnzqgqztamjygbrtonrxei
    ├── q2dnqvgyajrkey5wuyhfzbdqq4.json
    ├── qrzpq2uix65n3fekhh4nzdfmtm.ejrtembuhbsgmyjzmzsdsndbga2tezjwgjstsmbymqzggndemzrdcobvgm2gendegira
    ├── qrzpq2uix65n3fekhh4nzdfmtm.json
    ├── slom3tqv7g2abjxc3faiacowe4.json
    ├── slom3tqv7g2abjxc3faiacowe4.k4xsenruguwwg2tbknywswkniz3gszskozgde22kpb3gkolvnrbdesjc
    ├── supm7iy3wltj2uka6ubnnc4qbi.eiywcm3fgzsdcyjrg5sgintfg4zdeyrumq2deojxgazdgzrzg44tcnzqgiytsnrygara
    ├── supm7iy3wltj2uka6ubnnc4qbi.json
    ├── sw75gnfcnl7bhl6e5urvb65r6i.ei4wcnbwmnrwcobrgeztqy3fgq4tanrzmq3dgzrwha4gczjvg42taobygjsgmmbxmura
    ├── sw75gnfcnl7bhl6e5urvb65r6i.json
    ├── ut5yli5kyi33uudwcutnlcbqtu.ei3dezbuhbrdizbygqywcmzrg44dkmjrmzqtinjtmrtdazdbmu2tsyrsgiydqolbmnstmnbwga4wgyzzmq2tgnjtmqygcn3ggm3wgmrwei
    ├── ut5yli5kyi33uudwcutnlcbqtu.json
    ├── x7lmcabhkqquxmzy72r7yjn7ie.ei2tqmddg44wgnrygyzgmmzrmqywmolcmqydqzdegfqtimjvmjqtazbqguydey3ehera
    ├── x7lmcabhkqquxmzy72r7yjn7ie.json
    ├── zhcuk6sxek7kedrkux62zw3lky.ei2dcn3bme4wizjuhfqtcmzsmrsdgzlcgzqtkntegnrgkmrxge4gemjvmyydqojrg4ra
    ├── zhcuk6sxek7kedrkux62zw3lky.json
    ├── zjlcqpshxx4rulsajgxnlhzyay.ei4tmmbxmy4tqyjsmizdezbzmuzdeolbmu2dgyzvgjswgzlbg44wiy3fmrstszjqmm2wgztbmu3dozjymrqtmzleme4dmzbymfqwgmleei
    ├── zjlcqpshxx4rulsajgxnlhzyay.json
    ├── zwnrxccaq4htvugyw772d2awua.json
    └── zwnrxccaq4htvugyw772d2awua.k4xsenbtgewus3kgizveevd2ojswovkcizresr2nm5kva53pmnztqujc

2 directories, 74 files
```

あー、[huggingface](https://huggingface.co/)ね、と。ちっともわかっていないのにわかったフリをしてしまっている自分がいます。


# さいごに

[Bumblebee](https://github.com/elixir-nx/bumblebee/)でなにかダウンロードがはじまったら、それはきっと `:filename.basedir(:user_cache, "bumblebee")` の場所に格納されています。

人類は不老不死の霊薬を意味する素敵なプログラミング言語[Elixir](https://elixir-lang.org/)を手に入れました。並行処理を他のプログラミング言語よりも比較的容易に書くことができます。それはきっとコンピュータ資源を有効活用できることにつながるでしょう。巡り巡って世界平和に貢献できることでしょう。

さあ、そこのあなたも[Elixir](https://elixir-lang.org/)の世界へようこそ。
_手始めに[エリクサーチ](https://elixir-lang.info/)なんていかがでしょうか。私のオススメです。_

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
