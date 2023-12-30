---
title: 闘魂Elixir ── ドキュメントにMermaidの絵を埋め込んで楽しむ
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - 闘魂
  - AdventCalendar2024
private: false
updated_at: '2023-12-30T00:34:13+09:00'
id: 874d4f733bbb3ea59eea
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>

<b><font color="red">$\huge{闘魂とは己に打ち克つこと。}$</font></b>
<b><font color="red">$\huge{そして闘いを通じて己の魂を磨いていく}$</font></b>
<b><font color="red">$\huge{ことだと思います}$</font></b>




# はじめに

[Elixir](https://elixir-lang.org/) 1.16がリリースされました :tada::tada::tada:

[Elixir v1.16 released](https://elixir-lang.org/blog/2023/12/22/elixir-v1-16-0-released/)

https://elixir-lang.org/blog/2023/12/22/elixir-v1-16-0-released/

この文章の中に

![スクリーンショット 2023-12-29 23.59.13.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/d3950f7b-94ca-ed45-5906-3d67416b8fa5.png)

と書いてあります。

たしかに、[GenServer](https://hexdocs.pm/elixir/GenServer.html)や[Supervisor](https://hexdocs.pm/elixir/Supervisor.html)のドキュメントを見に行くと、[Mermaid](https://mermaid.js.org/)で書かれた図があります。

![スクリーンショット 2023-12-30 0.00.10.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/96ab9e81-fa66-f20c-876d-88cf09580e00.png)

![スクリーンショット 2023-12-30 0.01.45.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b9a241d6-bd1c-add8-ebc6-ed1e86d6cf04.png)

て、ことは自作のプロジェクトにも使えるということですよね！
はい、できます！！！

![スクリーンショット 2023-12-30 0.02.27.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a40179b6-9263-99bb-72b9-6a8ec56df2a4.png)

どんな風にすると[Mermaid](https://mermaid.js.org/)の絵を埋め込めるようになるかを解説します。
なお、[Mermaid](https://mermaid.js.org/)そのものの書き方については私はあまり詳しくないので、他の専門書をあたってください。
あくまでも[Elixir](https://elixir-lang.org/)で作ったプロジェクトのドキュメントに[Mermaid](https://mermaid.js.org/)の絵を埋め込むことに焦点をあてます。



# What is [Elixir](https://elixir-lang.org/) ?

[Elixir](https://elixir-lang.org/)という素敵なプログラミング言語があるのですね。
その素敵具合は「[Elixir Saves Pinterest $2 Million a Year In Server Costs](https://paraxial.io/blog/elixir-savings)」によく現れています。開発者も経営者もこの事実に瞠目することでしょう。 **$2 Million/年の節約ですってよ！、奥さん。**

https://paraxial.io/blog/elixir-savings

---

# 本題

それでは本題に入っていきます。
たったの7ステップです。

## 1. プロジェクトを作ります

```
mix new hello
cd hello
```

## 2. パッケージを追加します

`mix.exs`を編集してドキュメント作成に利用するパッケージを追加します。

```elixir:mix.exs
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:ex_doc, "~> 0.31", only: :dev, runtime: false},
      {:makeup_html, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
```

## 3. 依存関係を解決します

アルケミストの方にはおなじみのコマンドです。
依存関係を解決します。

```bash
mix deps.get
```

## 4. JavaScriptのInjectionを書く

`ex_doc`内の[Extensions](https://github.com/elixir-lang/ex_doc?tab=readme-ov-file#extensions)を参考にします。
`mix.exs`を編集します。

```diff:mix.exs
diff --git a/mix.exs b/mix.exs
index e2dd0f4..a5e3647 100644
--- a/mix.exs
+++ b/mix.exs
@@ -7,7 +7,10 @@ defmodule Hello.MixProject do
       version: "0.1.0",
       elixir: "~> 1.16",
       start_permanent: Mix.env() == :prod,
-      deps: deps()
+      deps: deps(),
+      docs: [
+        before_closing_body_tag: &before_closing_body_tag/1
+      ]
     ]
   end
 
@@ -27,4 +30,34 @@ defmodule Hello.MixProject do
       {:makeup_html, ">= 0.0.0", only: :dev, runtime: false}
     ]
   end
+
+  defp before_closing_body_tag(:html) do
+    """
+    <!-- HTML injected at the end of the <body> element -->
+    <script src="https://cdn.jsdelivr.net/npm/mermaid@10.2.3/dist/mermaid.min.js"></script>
+    <script>
+      document.addEventListener("DOMContentLoaded", function () {
+        mermaid.initialize({
+          startOnLoad: false,
+          theme: document.body.className.includes("dark") ? "dark" : "default"
+        });
+        let id = 0;
+        for (const codeEl of document.querySelectorAll("pre code.mermaid")) {
+          const preEl = codeEl.parentElement;
+          const graphDefinition = codeEl.textContent;
+          const graphEl = document.createElement("div");
+          const graphId = "mermaid-graph-" + id++;
+          mermaid.render(graphId, graphDefinition).then(({svg, bindFunctions}) => {
+            graphEl.innerHTML = svg;
+            bindFunctions?.(graphEl);
+            preEl.insertAdjacentElement("afterend", graphEl);
+            preEl.remove();
+          });
+        }
+      });
+    </script>
+    """
+  end
+
+  defp before_closing_body_tag(:epub), do: ""
 end
```

https://github.com/elixir-lang/elixir/blob/v1.16.0/lib/elixir/scripts/elixir_docs.exs

も参考にしています。


## 5. Mermaidの記法でなにかを書く

たとえば`lib/hello.ex`にMermaidの記法でなにかを書きます。
こんな感じで書きます。

![スクリーンショット 2023-12-30 0.24.14.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/31499433-d451-a62b-36ae-f0270fb6d183.png)

Mermaidの記述は、 https://mermaid.js.org/syntax/quadrantChart.html を拝借しました。

```mermaid
quadrantChart
    title Reach and engagement of campaigns
    x-axis Low Reach --> High Reach
    y-axis Low Engagement --> High Engagement
    quadrant-1 We should expand
    quadrant-2 Need to promote
    quadrant-3 Re-evaluate
    quadrant-4 May be improved
    Campaign A: [0.3, 0.6]
    Campaign B: [0.45, 0.23]
    Campaign C: [0.57, 0.69]
    Campaign D: [0.78, 0.34]
    Campaign E: [0.40, 0.34]
    Campaign F: [0.35, 0.78]
```

こんな感じの絵です。


## 6. ドキュメントを作成する

ドキュメントを作成するコマンドは

```
mix docs
```

です。

## 7. htmlファイルを開く

`open doc/index.html`

あとはMermaidの記法でなにかを追加した`Hello`モジュールを開いてください。
そうすると無事に、Mermaidによるレンダリングが行われます :tada::tada::tada: 

![スクリーンショット 2023-12-30 0.02.27.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/a40179b6-9263-99bb-72b9-6a8ec56df2a4.png)

ちなみに

`open doc/hello.epub`するとこんなふうに表示されました。単なるテキスト情報になっていました。

![スクリーンショット 2023-12-30 0.26.36.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/b632dd88-ca86-cd73-9820-bc9fd0a10736.png)



# さいごに

[Elixir](https://elixir-lang.org/)で作ったプロジェクトのドキュメントに[Mermaid](https://mermaid.js.org/)の絵を埋め込む方法を解説しました。
みなさまも[Elixir](https://elixir-lang.org/)のドキュメント作成ライフを楽しんでください。

これからは公式ドキュメントのほうにも[Mermaid](https://mermaid.js.org/)で書かれたわかりやすい絵が増えそうですね。

---

人類は不老不死の霊薬を意味する素敵なプログラミング言語[Elixir](https://elixir-lang.org/)を手に入れました。並行処理を他のプログラミング言語よりも比較的容易に書くことができます。それはきっとコンピュータ資源を有効活用できることにつながるでしょう。巡り巡って世界平和に貢献できることでしょう。

さあ、そこのあなたも[Elixir](https://elixir-lang.org/)の世界へようこそ。
_手始めに[エリクサーチ](https://elixir-lang.info/)なんていかがでしょうか。私のオススメです。_

---

**闘魂**とは、  **「己に打ち克つこと。そして闘いを通じて己の魂を磨いていくことである」** との猪木さんの言葉をそのまま胸に刻み込んでいます。
知っているだけで終わらせることなく、実行する、断行する、一歩を踏み出すことを自らの行動で示していきたいとおもいます。
**アントニオ猪木さんのメッセージから元氣をもらったものとして、それを次代に語り継ぎ、自分自身が「闘魂」を体現するものでありたいとおもいます。**

---

アドベントカレンダー2023は幕を閉じ、**アドベントカレンダー2024**が開幕です:rocket::rocket::rocket:

![スクリーンショット 2023-12-25 23.37.44.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ff7d8496-820a-e635-462c-c1a0563ce774.png)







---

<b><font color="red">$\huge{元氣ですかーーーーッ！！！}$</font></b>
<b><font color="red">$\huge{元氣があればなんでもできる！}$</font></b>
<b><font color="red">$\huge{１、２、３ ぁっダァー！}$</font></b>
