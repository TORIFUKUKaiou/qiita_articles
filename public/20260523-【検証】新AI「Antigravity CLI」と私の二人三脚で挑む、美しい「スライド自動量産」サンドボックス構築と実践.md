---
title: 【検証】新AI「Antigravity CLI」と私の二人三脚で挑む、美しい「スライド自動量産」サンドボックス構築と実践
tags:
  - pptx
  - SKILLS
  - 闘魂
  - Antigravity
private: false
updated_at: '2026-05-24T09:13:20+09:00'
id: ca7baeea25eadca58a94
organization_url_name: null
slide: false
ignorePublish: false
---
米Googleは2026年5月19日、AI開発者向けおよび一般消費者向けにいくつかの重要な発表を行いました。

その中でも開発者にとってインパクトが大きいのが、従来の **Gemini CLI から「Antigravity CLI」への完全移行** です。

「2026年6月18日までに移行しなさい」という公式の移行勧告を受け、私は公式のインストールガイドである [Antigravity CLI Getting Started](https://antigravity.google/docs/cli-getting-started) を見ながら、さっそくこの新しいAIターミナルツール「Antigravity CLI」を導入（インストール）しました。そして、単なる移行作業にとどまらず、この新しい相棒の実力を検証するために、Anthropicが公開しているオープン規格の「pptx」スキルを組み合わせ、ローカル環境を一切汚さずにハイクオリティなプレゼン資料（`.pptx`）を自動量産するサンドボックスを一緒に構築しました。

この記事では、Googleの最新動向を整理しつつ、**「AI（Antigravity）と私」の対話から生まれた、スライド自動生成パイプラインのリアルな構築プロセス** を共有します。

---

## 1. Google AI 関連の最新動向と私たちの移行

GoogleはAIエコシステムの再編とマルチエージェント化への適応を急ピッチで進めています。その象徴となる2つの重要発表が同日に行われました。

### ① Gemini CLI から Antigravity CLI への移行
Google Developers Blogにて、従来の Gemini CLI を **Antigravity CLI** へと移行・統合することが正式発表されました。

* **公式ブログ**: [An important update: Transitioning Gemini CLI to Antigravity CLI - Google Developers Blog](https://developers.googleblog.com/an-important-update-transitioning-gemini-cli-to-antigravity-cli/)
* **移行のタイムライン**: **2026年6月18日** をもって、個人向け（Google AI Pro、Ultra、無料枠）の Gemini CLI および Gemini Code Assist IDE 拡張機能のサービスが停止します。期日までに Antigravity CLI への移行が推奨されています。
* **公式ブログが挙げる技術的メリット（Why we transition）**:
  * **高速な実行環境（Faster execution）**: Go言語で構築され、より機敏でレスポンシブに動作します（*“Built in Go, Antigravity CLI is snappier and more responsive”*）。
  * **非同期ワークフロー（Asynchronous workflows）**: バックグラウンドで複雑なタスクのために複数のエージェントを協調・調停（orchestrate）させることが可能です。これにより、ターミナルセッションをロックすることなく、大規模なコードベースのリファクタリングや複数トピックのリサーチを並行して実行できます。
  * **統一されたアーキテクチャ（Unified architecture）**: 新しいデスクトップアプリケーション「Antigravity 2.0」と同一のコアエージェント制御機構（agent harness）を共有しています。これにより、将来的なコアエージェントのすべての改善が、使用場所を問わず自動的に反映されることが保証されます。

### ② 「Google AI Pro」への YouTube Premium Lite 無料付与
また、個人向けAIサブスクリプションである「Google AI Pro」の契約者に対し、YouTubeの広告をほぼ非表示にできる「YouTube Premium Lite」が無料付与されることが発表されました。

* **公式サブスクリプション案内**: [Gemini Advanced / Google AI Pro サブスクリプション - Google](https://gemini.google/jp/subscriptions/?hl=ja)
* **ニュースソース**: [「Google AI Pro」ユーザーはYouTube広告ほぼ非表示　「Premium Lite」無料付与 - Yahoo!ニュース](https://news.yahoo.co.jp/articles/a9f4ab44bf743afcbb151bc3a1c779be5754a57b)
* AI開発に投資するユーザーへの強力な特典付与となっており、AIとコンテンツ閲覧体験のシームレスな統合が進んでいます。

### ③ 有料Antigravityプランの「weekly Gemini quotasを3倍」および「クォータリセット」の告知

Google AI Developersの公式Xアカウントにて、有料Antigravityプランの **weekly Gemini quotas** を3倍に拡張し、クォータをリセットしたとの告知がありました。

* **公式X（旧Twitter）アナウンス**: [Google AI Developers 公式X (@googleaidevs)](https://x.com/googleaidevs/status/2057680511217393899)

私の環境でも、`agy` を再起動して `/usage` を確認したところ、Gemini系モデルの残量は100%に戻っていました。一方で、Claude系モデルの残量は20%のままでした。したがって、少なくとも私の環境では、この緩和は **Gemini系モデルの週次クォータに対するもの** として見えました。

その後、Gemini系モデルを使い始めると、5時間枠と思われる残量表示は 100% → 60% → 40% と減っていきました。週次クォータは大きく緩和された一方で、短期枠の消費感については、引き続き実際に使いながら見ていく必要がありそうです。

---

## 2. 実践：Antigravity CLI × Anthropic Skills によるスライド自動生成

新しくなった Antigravity CLI の実力を試すため、私はローカルの作業用リポジトリ（`~/repos/slides`）の中に完結した「スライド量産サンドボックス（錬成場）」を構築し、Antigravityとペアを組んでスライドを作成しました。

### サンドボックスの設計とフォルダ構造
PCのグローバル環境をインストール等で汚さないよう、特定の作業ディレクトリ（`~/repos/slides`）の内部だけで完全に完結する構成としました。

```text
~/repos/slides/ (プロジェクトのGitリポジトリ)
├── .agents/
│   └── skills/
│       └── pptx ── (シンボリックリンク) ➔ ../../vendor/anthropics-skills/skills/pptx
├── vendor/
│   └── anthropics-skills/ (Git Submodule: pptxの公式コードが管理されている場所)
├── decks/ (スライド量産フォルダ)
│   └── 01_slide_deck/ 
│       ├── slide_source.md (スライドの骨子・インプット)
│       ├── generate.js     (AIが自動生成する PptxGenJS スクリプト)
│       └── output.pptx     (完成品パワーポイントファイル)
├── package.json
└── README.md
```

#### ポイント
* **クリーンなスキル管理**: `pptx` スキルをグローバルではなく、`git submodule` でプロジェクト配下に引き込み、エージェント用の `.agents/skills/pptx` にシンボリックリンクで接続しています。これにより、ポータビリティとクリーンさを両立しています。
* **再現性の担保**: AIが直接スライド（`.pptx`）を組み立てるのではない、PptxGenJS を叩く「決定論的な JavaScript コード（`generate.js`）」をエージェントに生成させます。これにより、あとからデザインを手動で微調整したり、ローカルで何度でも同一スライドを再出力（再ビルド）できるパイプラインが完成します。

### 🛠️ サンドボックスの具体的な構築手順（コマンド例）

このクリーンなサンドボックスを実際にローカルで構築した手順とコマンド例です。

#### 1. リポジトリの準備とサブモジュールの引き込み
まず、作業用ディレクトリを作成して Git リポジトリを初期化し、Anthropic公式の「pptx」スキルが含まれるリポジトリを `git submodule` としてプロジェクトローカルに追加します。

```bash
# 作業ディレクトリの作成と移動
mkdir -p ~/repos/slides
cd ~/repos/slides
git init

# Anthropic公式スキルを Submodule として追加
mkdir -p vendor
git submodule add https://github.com/anthropics/skills.git vendor/anthropics-skills
git submodule update --init --recursive
```

#### 2. エージェント用スキルディレクトリとシンボリックリンクの作成
Antigravity CLI がローカルの拡張スキルとして認識できるよう、エージェント用ディレクトリを掘り、サブモジュール内の `pptx` スキルへシンボリックリンクを貼ります。

```bash
# エージェント用スキルフォルダの作成
mkdir -p .agents/skills

# サブモジュール内の pptx スキルへ相対パスでシンボリックリンクを張る
ln -s ../../vendor/anthropics-skills/skills/pptx .agents/skills/pptx
```
これによって、グローバル環境を完全にクリーンに保ったまま、このリポジトリ配下だけで `pptx` スキルをフル稼働させることができます（※パッケージ依存関係や環境構築は、Antigravity CLIのpptxコマンド実行時にエージェントが背後で自律的に解決してくれます）。
なお、依存パッケージの導入は専用ディレクトリ内に閉じ込め、実行前に `package.json` や `lockfile` を確認する運用にしています。

### 二人三脚の自動量産フロー
私とAntigravityの連携は、スラッシュコマンドと承認ベースで驚くほどスマートに進行します。

1. **骨子の準備と対話（私の仕事 ＆ 共同作業）**:
   まず、作成したいスライドのテーマや大枠の構成を `slide_source.md` に記述します。この作成過程自体、**あらかじめ agy (Antigravity CLI) とチャットで「どんな構成がいいか」「何枚にするか」を壁打ち対話しながら磨き上げていく**ことが可能です。これが最初の二人三脚の瞬間です。
2. **生成指示（スラッシュコマンドと承認）**:
   構成が固まったら、ターミナルからスラッシュコマンドを用いて一撃で指示を投げます。
   ```bash
   /pptx decks/01_test/slide_source.md
   ```
   コマンドを実行すると、Antigravity が実装計画などの **`/artifact`（成果物計画書）** を瞬時に作成して提示してくれます。
   ユーザー（私）がこの計画内容をレビューし、問題がなければ `approve`（承認）して `submit`（送信）します。あとはエージェントが裏で自律的に動作し、最終的な `generate.js` の生成まで「自走」してくれます。
   
   > 💡 **コラム: artifactはどこにある？**
   > 生成された実装計画書やログなどの `/artifact` は、ローカルの `~/.gemini/antigravity-cli/brain/[CONVERSATION_ID]` の配下に自動管理・保存されます。

3. **実行（私の確認）**:
   エージェントの自走が完了したら、出力された `generate.js` をローカルで実行するだけです。
   ```bash
   node generate.js
   ```
これだけで、厳密にレイアウト制御された美麗なパワーポイントファイル（`output.pptx`）が一瞬で書き出されます。

---

## 3. 私たちの検証における注意点と気づき

### Python による QA 自動検証は「動かしていない（試していない）」
Anthropic の pptx スキルガイドには、`markitdown` を用いたテキスト抽出や、LibreOffice（`soffice` コマンド）を用いてスライドを画像化し、AIがビジュアル崩れを QA 検証する手順が記載されています。

しかし、今回の私たちの環境においては、**これらの Python 依存パッケージや LibreOffice を用いた検証フローは実行していません（試していません）**。

#### なぜそれでも問題ないのか？
スライドの自動生成自体は、Node.js のパッケージである `pptxgenjs` を使用する `node generate.js` コマンドだけで **100% 完結**して正常に出力されるためです。
生成された `.pptx` は直接パワーポイントや Keynote 等で開き、自分の目でビジュアルを確認して調整すれば十分実用的です。高度で重量級な Python/LibreOffice 実行環境の構築をスキップしても、スライド生成の恩恵は完全に受けられるという事実を確認できました。

---

## 4. まとめ

Gemini CLI から Antigravity CLI への移行は、単なる名称の変更にとどまらず、**「マルチエージェントを前提とした新しいペアプログラミング体験」**への大いなる進化です。

Anthropic の pptx スキルのような高度なツールも、Antigravity CLI の非同期並行処理を活かしてプロジェクトローカルでスマートに動作させることが可能です。

YouTube Premium Lite の無料付与などの特典もアナウンスされている今、ぜひこの新しい相棒（Antigravity CLI）を導入し、一緒に「自走する開発体験」を楽しんでみてください。

---

## 参考

実際に生成した `generate.js` をご披露します。

### 「絶対に挫折しない」コブラ会式・アトミック習慣術

```js:generate.js
const pptxgen = require("pptxgenjs");
const React = require("react");
const ReactDOMServer = require("react-dom/server");
const sharp = require("sharp");

// react-icons から必要なアイコンをインポート
const { 
  FaBolt, 
  FaFistRaised, 
  FaFire, 
  FaSkull, 
  FaTrophy, 
  FaExclamationTriangle
} = require("react-icons/fa");

// SVGアイコンをPNGのBase64データに変換するヘルパー関数
function renderIconSvg(IconComponent, color = "#000000", size = 256) {
  return ReactDOMServer.renderToStaticMarkup(
    React.createElement(IconComponent, { color, size: String(size) })
  );
}

async function iconToBase64Png(IconComponent, colorHex, size = 256) {
  // PptxGenJSのカラー指定は # なしだが、React/SVGでは # が必要なので補完する
  const color = colorHex.startsWith("#") ? colorHex : `#${colorHex}`;
  const svg = renderIconSvg(IconComponent, color, size);
  const pngBuffer = await sharp(Buffer.from(svg)).png().toBuffer();
  return "data:image/png;base64," + pngBuffer.toString("base64");
}

async function main() {
  console.log("🚀 コブラ会式スライドの生成を開始します...");

  const pres = new pptxgen();
  pres.layout = 'LAYOUT_16x9'; // 10" x 5.625" (25.4cm x 14.28cm)
  pres.author = 'Antigravity';
  pres.title = 'コブラ会式アトミック習慣術';

  // カラー定義 (PptxGenJS用に#は含めない)
  const COLOR_BG = "141B3C";        // 主要背景 (極暗ネイビー)
  const COLOR_CARD = "2F3C7E";      // コブラ会カード背景 (ネイビー)
  const COLOR_MUTED_CARD = "222A45"; // 普通の習慣化カード背景 (ダークグレー)
  const COLOR_CORAL = "F96167";     // コーラル (アクセント)
  const COLOR_GOLD = "F9E795";      // ゴールド (アクセント)
  const COLOR_WHITE = "FFFFFF";     // 白
  const COLOR_MUTED_WHITE = "A1A1AA"; // Muted 白 (zinc-400相当)

  // アイコン画像の生成 (非同期でBase64化)
  const iconBolt = await iconToBase64Png(FaBolt, COLOR_GOLD);
  const iconFist = await iconToBase64Png(FaFistRaised, COLOR_CORAL);
  const iconFire = await iconToBase64Png(FaFire, COLOR_CORAL);
  const iconSkull = await iconToBase64Png(FaSkull, COLOR_MUTED_WHITE);
  const iconTrophy = await iconToBase64Png(FaTrophy, COLOR_GOLD);
  const iconWarning = await iconToBase64Png(FaExclamationTriangle, COLOR_CORAL);

  // ----------------------------------------------------
  // Slide 1: タイトルスライド
  // ----------------------------------------------------
  {
    console.log("👉 Slide 1 を作成中...");
    const slide = pres.addSlide();
    slide.background = { color: COLOR_BG };

    // 斜めのライン装飾 (背景に溶け込むアクセント)
    slide.addShape(pres.shapes.LINE, {
      x: 0.5, y: 4.8, w: 9.0, h: 0,
      line: { color: COLOR_CARD, width: 3 }
    });

    // 縦のCoral色の太いライン (コブラ会のシャープなイメージ)
    slide.addShape(pres.shapes.RECTANGLE, {
      x: 0.8, y: 1.2, w: 0.12, h: 2.8,
      fill: { color: COLOR_CORAL }
    });

    // メインタイトル (Impact)
    slide.addText("「絶対に挫折しない」\nコブラ会式・アトミック習慣術", {
      x: 1.1, y: 1.2, w: 8.0, h: 1.6,
      fontSize: 38,
      fontFace: "Impact",
      color: COLOR_GOLD,
      bold: true,
      margin: 0
    });

    // サブタイトル
    slide.addText("アトミックな習慣化 ➔ 容赦なき（No Mercy）仕組みへの昇華", {
      x: 1.1, y: 3.0, w: 8.0, h: 0.6,
      fontSize: 18,
      fontFace: "Arial",
      color: COLOR_WHITE,
      margin: 0
    });

    // フッター補足
    slide.addText("COBRA KAI DOJO / NO MERCY PRESENTS", {
      x: 1.1, y: 4.9, w: 8.0, h: 0.3,
      fontSize: 10,
      fontFace: "Arial",
      color: COLOR_MUTED_WHITE,
      margin: 0,
      charSpacing: 2
    });
  }

  // ----------------------------------------------------
  // Slide 2: コブラ会の3つの掟
  // ----------------------------------------------------
  {
    console.log("👉 Slide 2 を作成中...");
    const slide = pres.addSlide();
    slide.background = { color: COLOR_BG };

    // スライドタイトル
    slide.addText("コブラ会に学ぶ「習慣化の3つの掟」", {
      x: 0.5, y: 0.4, w: 9.0, h: 0.6,
      fontSize: 26,
      fontFace: "Arial",
      color: COLOR_WHITE,
      bold: true,
      margin: 0
    });

    // 3カラムのカード配置パラメータ
    const cardY = 1.2;
    const cardW = 2.7;
    const cardH = 3.9;
    const cardsData = [
      {
        title: "STRIKE FIRST",
        subTitle: "先手必勝",
        action: "「2秒で始める」",
        desc: [
          { text: "・始めるまでの心理的ハードルを極限まで下げる", options: { breakLine: true } },
          { text: "・意志の力を一切信じるな。ただ最初の1歩を最速で踏み出せ", options: { breakLine: true } },
          { text: "・2秒で開始できる極小のトリガーを定義せよ" }
        ],
        icon: iconBolt,
        accentColor: COLOR_GOLD
      },
      {
        title: "STRIKE HARD",
        subTitle: "全力で叩く",
        action: "「環境を圧倒的に支配」",
        desc: [
          { text: "・誘惑や邪魔になるすべての要素を事前に破壊・排除せよ", options: { breakLine: true } },
          { text: "・スマートフォンのロック、デスクの整理は『攻撃』である", options: { breakLine: true } },
          { text: "・成功せざるを得ないクリーンな戦場を用意せよ" }
        ],
        icon: iconFist,
        accentColor: COLOR_CORAL
      },
      {
        title: "NO MERCY",
        subTitle: "容赦なし",
        action: "「言い訳をゼロに」",
        desc: [
          { text: "・例外や『今日だけは休み』という甘えを1ミリも許すな", options: { breakLine: true } },
          { text: "・挫折する余地を完全に潰す、無慈悲な自動化の仕組み", options: { breakLine: true } },
          { text: "・ドージョーの誓いのように習慣を厳格に執行せよ" }
        ],
        icon: iconFire,
        accentColor: COLOR_CORAL
      }
    ];

    const makeShadow = () => ({
      type: "outer",
      color: "000000",
      blur: 8,
      offset: 3,
      angle: 135,
      opacity: 0.3
    });

    cardsData.forEach((card, index) => {
      const cardX = 0.5 + index * (cardW + 0.45); // x: 0.5, 3.65, 6.8

      // カード本体背景 (立体感を出すシャドウ付き)
      slide.addShape(pres.shapes.RECTANGLE, {
        x: cardX, y: cardY, w: cardW, h: cardH,
        fill: { color: COLOR_CARD },
        shadow: makeShadow()
      });

      // カード上部のアクセントボーダー (Strike Firstはゴールド、その他はコーラル)
      slide.addShape(pres.shapes.RECTANGLE, {
        x: cardX, y: cardY, w: cardW, h: 0.08,
        fill: { color: card.accentColor }
      });

      // アイコン (中央上部)
      slide.addImage({
        data: card.icon,
        x: cardX + (cardW - 0.5) / 2, y: cardY + 0.3, w: 0.5, h: 0.5
      });

      // 掟タイトル (Impact)
      slide.addText(card.title, {
        x: cardX, y: cardY + 0.9, w: cardW, h: 0.4,
        fontSize: 20,
        fontFace: "Impact",
        color: card.accentColor,
        bold: true,
        align: "center",
        margin: 0
      });

      // サブタイトル (日本語)
      slide.addText(card.subTitle, {
        x: cardX, y: cardY + 1.25, w: cardW, h: 0.3,
        fontSize: 12,
        fontFace: "Arial",
        color: COLOR_MUTED_WHITE,
        align: "center",
        margin: 0
      });

      // 応用アクション (強調)
      slide.addText(card.action, {
        x: cardX + 0.2, y: cardY + 1.65, w: cardW - 0.4, h: 0.4,
        fontSize: 14,
        fontFace: "Arial",
        color: COLOR_WHITE,
        bold: true,
        align: "center",
        fill: { color: "141B3C" }, // 暗い背景を敷いてバッジ化
        margin: 4
      });

      // 詳細説明 (リスト形式)
      slide.addText(card.desc, {
        x: cardX + 0.15, y: cardY + 2.2, w: cardW - 0.3, h: 1.5,
        fontSize: 10,
        fontFace: "Arial",
        color: "E2E8F0",
        margin: 0
      });
    });
  }

  // ----------------------------------------------------
  // Slide 3: 対比図解（「普通の習慣化」 vs 「コブラ会式の習慣化」）
  // ----------------------------------------------------
  {
    console.log("👉 Slide 3 を作成中...");
    const slide = pres.addSlide();
    slide.background = { color: COLOR_BG };

    // スライドタイトル
    slide.addText("継続の真実：甘えか、仕組みか", {
      x: 0.5, y: 0.4, w: 9.0, h: 0.6,
      fontSize: 26,
      fontFace: "Arial",
      color: COLOR_WHITE,
      bold: true,
      margin: 0
    });

    const cardY = 1.2;
    const cardW = 4.25;
    const cardH = 3.9;

    const makeShadow = () => ({
      type: "outer",
      color: "000000",
      blur: 8,
      offset: 3,
      angle: 135,
      opacity: 0.3
    });

    // --- 左側: 普通の習慣化 (Muted Gray) ---
    const leftX = 0.5;
    slide.addShape(pres.shapes.RECTANGLE, {
      x: leftX, y: cardY, w: cardW, h: cardH,
      fill: { color: COLOR_MUTED_CARD },
      shadow: makeShadow()
    });

    // 左側ヘッダー
    slide.addText("意志の力に頼る習慣化 (敗者のループ)", {
      x: leftX + 0.3, y: cardY + 0.3, w: cardW - 0.6, h: 0.4,
      fontSize: 18,
      fontFace: "Arial",
      color: COLOR_MUTED_WHITE,
      bold: true,
      margin: 0
    });

    // どくろアイコン (敗者の象徴)
    slide.addImage({
      data: iconSkull,
      x: leftX + cardW - 0.8, y: cardY + 0.25, w: 0.4, h: 0.4
    });

    // 左側ステップリスト (PptxGenJSのリッチテキスト形式で段組み)
    slide.addText([
      { text: "1. モチベーション依存のスタート\n", options: { bold: true, color: COLOR_WHITE, fontSize: 13 } },
      { text: "やる気がある時だけ大きく始めるため、エネルギー消費が大きすぎる。\n\n", options: { color: "A1A1AA", fontSize: 11 } },
      
      { text: "2. 「今日だけは」という無慈悲な例外\n", options: { bold: true, color: COLOR_WHITE, fontSize: 13 } },
      { text: "気分が乗らない日に例外を作ってサボる。コブラ会に例外は存在しない。\n\n", options: { color: "A1A1AA", fontSize: 11 } },
      
      { text: "3. 意志力の限界と完全な挫折\n", options: { bold: true, color: COLOR_CORAL, fontSize: 13 } },
      { text: "脳の疲労と共に元の怠惰な習慣へ逆戻りし、自己嫌悪のループに陥る。", options: { color: "A1A1AA", fontSize: 11 } }
    ], {
      x: leftX + 0.3, y: cardY + 0.9, w: cardW - 0.6, h: 2.8,
      fontFace: "Arial",
      margin: 0
    });

    // --- 右側: コブラ会式の習慣化 (Solid Navy + Coral Border) ---
    const rightX = 5.25;
    slide.addShape(pres.shapes.RECTANGLE, {
      x: rightX, y: cardY, w: cardW, h: cardH,
      fill: { color: COLOR_CARD },
      line: { color: COLOR_CORAL, width: 2 }, // コーラルの外枠で視線を惹きつける
      shadow: makeShadow()
    });

    // 右側ヘッダー
    slide.addText("容赦なき仕組み化 (勝者のループ)", {
      x: rightX + 0.3, y: cardY + 0.3, w: cardW - 0.6, h: 0.4,
      fontSize: 18,
      fontFace: "Arial",
      color: COLOR_GOLD,
      bold: true,
      margin: 0
    });

    // トロフィーアイコン (勝者の象徴)
    slide.addImage({
      data: iconTrophy,
      x: rightX + cardW - 0.8, y: cardY + 0.25, w: 0.4, h: 0.4
    });

    // 右側ステップリスト
    slide.addText([
      { text: "1. 2秒で起動するトリガーの設定\n", options: { bold: true, color: COLOR_WHITE, fontSize: 13 } },
      { text: "意志が介入する余地のない極小行動（例：ノートを開く、靴を履く）を固定。\n\n", options: { color: "E2E8F0", fontSize: 11 } },
      
      { text: "2. 例外を排除する環境の強制構築\n", options: { bold: true, color: COLOR_WHITE, fontSize: 13 } },
      { text: "スマホを別室に置く、事前に全てをセットするなど物理的にサボりを不可能にする。\n\n", options: { color: "E2E8F0", fontSize: 11 } },
      
      { text: "3. 無意識レベルでの自動継続（勝利）\n", options: { bold: true, color: COLOR_GOLD, fontSize: 13 } },
      { text: "『やる・やらない』を脳に相談させず、淡々と執行し続ける。それがコブラ会式だ。", options: { color: "E2E8F0", fontSize: 11 } }
    ], {
      x: rightX + 0.3, y: cardY + 0.9, w: cardW - 0.6, h: 2.8,
      fontFace: "Arial",
      margin: 0
    });
  }

  // ----------------------------------------------------
  // Slide 4: まとめ/結論
  // ----------------------------------------------------
  {
    console.log("👉 Slide 4 を作成中...");
    const slide = pres.addSlide();
    slide.background = { color: COLOR_BG };

    // スライドタイトル
    slide.addText("意志を信じるな。「無慈悲な仕組み」を信じよ。", {
      x: 0.5, y: 0.4, w: 9.0, h: 0.6,
      fontSize: 26,
      fontFace: "Arial",
      color: COLOR_CORAL,
      bold: true,
      margin: 0
    });

    // メインの結論メッセージ
    slide.addText([
      { text: "「明日やろう」は敗者の言葉である。\n\n", options: { bold: true, color: COLOR_WHITE, fontSize: 20 } },
      { text: "コブラ会式アトミック習慣術は、あなたに強固なモチベーションを求めない。\n", options: { color: "E2E8F0", fontSize: 14 } },
      { text: "ただ、あなたが一度「例外を排除した仕組み」を設計するだけで、習慣は自動的に執行される。\n\n", options: { color: "E2E8F0", fontSize: 14 } },
      { text: "やる気が出ない時こそ、仕組まれた最初の2秒のトリガーを淡々と引き金にせよ。", options: { color: COLOR_MUTED_WHITE, fontSize: 13 } }
    ], {
      x: 1.0, y: 1.2, w: 8.0, h: 1.7,
      fontFace: "Arial",
      margin: 0
    });

    // アクションプラン強調ブロック
    const boxX = 1.0;
    const boxY = 3.1;
    const boxW = 8.0;
    const boxH = 1.6;

    slide.addShape(pres.shapes.RECTANGLE, {
      x: boxX, y: boxY, w: boxW, h: boxH,
      fill: { color: COLOR_CARD },
      line: { color: COLOR_GOLD, width: 2 }
    });

    // 警告アイコン (アクションの緊急性をアピール)
    slide.addImage({
      data: iconWarning,
      x: boxX + 0.4, y: boxY + 0.4, w: 0.8, h: 0.8
    });

    // アクションプランの指示テキスト
    slide.addText("今すぐ、最初の「2秒アクション」を定義せよ。", {
      x: boxX + 1.4, y: boxY + 0.3, w: boxW - 1.8, h: 0.5,
      fontSize: 18,
      fontFace: "Arial",
      color: COLOR_GOLD,
      bold: true,
      margin: 0
    });

    slide.addText("モチベーションに相談する前に、靴を履くか、本を開くか、PCの電源を入れろ。例外は無用だ。", {
      x: boxX + 1.4, y: boxY + 0.8, w: boxW - 1.8, h: 0.5,
      fontSize: 11,
      fontFace: "Arial",
      color: COLOR_WHITE,
      margin: 0
    });
  }

  // PPTXファイルの保存
  const outputFileName = "output.pptx";
  console.log(`💾 スライドを ${outputFileName} に保存します...`);
  pres.writeFile({ fileName: outputFileName });
  console.log("✨ 完了しました！");
}

main().catch(err => {
  console.error("❌ エラーが発生しました:", err);
  process.exit(1);
});
```

### 「パワポ禁止令」をあえてパワポで語る

```js:generate.js
const pptxgen = require("pptxgenjs");

async function main() {
  console.log("📝 Amazon Bezos流「アンチ・パワポ」ミニマリズムスライドの生成を開始します...");

  const pres = new pptxgen();
  pres.layout = 'LAYOUT_16x9'; // 10" x 5.625" (25.4cm x 14.28cm)
  pres.author = 'Antigravity / Jeff Bezos';
  pres.title = 'アンチ・パワポ：Amazonがプレゼン資料を捨てた真実';

  // --- 紙とインク（白と漆黒）極限のミニマリズム カラー定義 ---
  const COLOR_BG = "FFFFFF";        // 主要背景: 完璧な純白 (紙)
  const COLOR_TEXT = "111111";      // 主要テキスト: 漆黒のインク
  const COLOR_MUTED_TEXT = "6B7280"; // Mutedテキスト: 薄いインクグレー (gray-500)
  const COLOR_LINE = "D1D5DB";       // 極細境界線: ライトグレー (gray-300)
  const COLOR_DARK_LINE = "4B5563";  // 強調境界線: ダークグレー (gray-600)

  // フォントペア定義 (システム標準で最も美しくミニマルな極細サンセリフ)
  const FONT_TITLE = "Calibri Light"; // 極細モダンサンセリフ
  const FONT_BODY = "Calibri";       // クリーンな標準サンセリフ

  // ----------------------------------------------------
  // Slide 1: タイトルスライド (究極の書物のようなレイアウト)
  // ----------------------------------------------------
  {
    console.log("👉 Slide 1 (Paper Cover) を作成中...");
    const slide = pres.addSlide();
    slide.background = { color: COLOR_BG };

    // 中央を走る極細の横線 (本の一節のような装飾)
    slide.addShape(pres.shapes.LINE, {
      x: 1.0, y: 2.2, w: 8.0, h: 0,
      line: { color: COLOR_DARK_LINE, width: 1 }
    });

    // 縦の極細アクセント (タイトルの左側)
    slide.addShape(pres.shapes.LINE, {
      x: 1.0, y: 1.2, w: 0, h: 0.8,
      line: { color: COLOR_TEXT, width: 1.5 }
    });

    // メインタイトル (Calibri Light で極限までシンプルに)
    slide.addText("アンチ・パワポ", {
      x: 1.2, y: 1.2, w: 7.8, h: 0.8,
      fontSize: 34,
      fontFace: FONT_TITLE,
      color: COLOR_TEXT,
      bold: true,
      margin: 0
    });

    // サブタイトル
    slide.addText("Amazonがプレゼン資料を捨てた真実", {
      x: 1.0, y: 2.5, w: 8.0, h: 0.5,
      fontSize: 16,
      fontFace: FONT_BODY,
      color: COLOR_TEXT,
      margin: 0
    });

    // メタ説明 (「6-Page Memo」の教義)
    slide.addText("THEAmazon WAY / THE DOCTRINE OF NARRATIVE OVER BULLETS", {
      x: 1.0, y: 4.8, w: 8.0, h: 0.3,
      fontSize: 9,
      fontFace: FONT_BODY,
      color: COLOR_MUTED_TEXT,
      margin: 0,
      charSpacing: 3
    });
  }

  // ----------------------------------------------------
  // Slide 2: なぜ箇条書きは邪悪なのか？ (余白率70%の2カラム対比)
  // ----------------------------------------------------
  {
    console.log("👉 Slide 2 (Narrative vs Bullets) を作成中...");
    const slide = pres.addSlide();
    slide.background = { color: COLOR_BG };

    // スライドタイトル
    slide.addText("なぜ、箇条書き（Bullet Points）は邪悪なのか？", {
      x: 0.8, y: 0.6, w: 8.4, h: 0.6,
      fontSize: 24,
      fontFace: FONT_TITLE,
      color: COLOR_TEXT,
      bold: true,
      margin: 0
    });

    const colY = 1.6;
    const colW = 3.6;
    const colH = 3.0;

    // 中央を分割する、極限まで薄い縦の境界線 (0.5pt)
    slide.addShape(pres.shapes.LINE, {
      x: 5.0, y: colY, w: 0, h: colH,
      line: { color: COLOR_LINE, width: 0.5 }
    });

    // 左カラム: 箇条書きの自己欺瞞
    slide.addText("箇条書きの自己欺瞞", {
      x: 0.8, y: colY, w: colW, h: 0.4,
      fontSize: 15,
      fontFace: FONT_TITLE,
      color: COLOR_MUTED_TEXT,
      bold: true,
      margin: 0
    });

    slide.addText([
      { text: "平坦化された論理\n", options: { bold: true, color: COLOR_TEXT, fontSize: 12 } },
      { text: "箇条書きは、物事の複雑な因果関係や優先順位、時間的文脈をすべて一律にフラット化してしまう危険な道具である。\n\n", options: { color: COLOR_MUTED_TEXT, fontSize: 10.5 } },
      { text: "思考放棄の隠れ蓑\n", options: { bold: true, color: COLOR_TEXT, fontSize: 12 } },
      { text: "作成者は箇条書きによって『要点』を並べただけで深い思考を省略し、読む側は都合よく行間を誤読する。これはプレゼンの見映えに隠された真実の希釈である。", options: { color: COLOR_MUTED_TEXT, fontSize: 10.5 } }
    ], {
      x: 0.8, y: colY + 0.5, w: colW, h: colH - 0.5,
      fontFace: FONT_BODY,
      margin: 0
    });

    // 右カラム: ナラティブ（叙述）の力
    slide.addText("ナラティブ（叙述）の力", {
      x: 5.6, y: colY, w: colW, h: 0.4,
      fontSize: 15,
      fontFace: FONT_TITLE,
      color: COLOR_TEXT,
      bold: true,
      margin: 0
    });

    slide.addText([
      { text: "完全な文章による責任の所在\n", options: { bold: true, color: COLOR_TEXT, fontSize: 12 } },
      { text: "主語と述語、そして論理的接続詞を含んだ完全な叙述で語ること。これにより、論理の穴やごまかしが一切通用しなくなる。\n\n", options: { color: "333333", fontSize: 10.5 } },
      { text: "ロジックの強度を暴く\n", options: { bold: true, color: COLOR_TEXT, fontSize: 12 } },
      { text: "Amazonの「6-Page Memo」は、発表者の安易なプレゼン話術や派手な図解を完全に封じる。残されるのは、紙の上に印字された『ロジックの強度』そのものだけだ。", options: { color: "333333", fontSize: 10.5 } }
    ], {
      x: 5.6, y: colY + 0.5, w: colW, h: colH - 0.5,
      fontFace: FONT_BODY,
      margin: 0
    });
  }

  // ----------------------------------------------------
  // Slide 3: 最初の15分間の「沈黙」 (沈黙のビジュアル化・白と黒の対比)
  // ----------------------------------------------------
  {
    console.log("👉 Slide 3 (The Silence) を作成中...");
    const slide = pres.addSlide();
    slide.background = { color: COLOR_BG };

    // スライドタイトル
    slide.addText("会議の始まり。最初の15分間の「沈黙」", {
      x: 0.8, y: 0.6, w: 8.4, h: 0.6,
      fontSize: 26,
      fontFace: FONT_TITLE,
      color: COLOR_TEXT,
      bold: true,
      margin: 0
    });

    // 「6-Page Memo」を象徴する、極限までシンプルな紙の輪郭 (x: 1.0, y: 1.6)
    const paperX = 1.0;
    const paperY = 1.5;
    const paperW = 2.4;
    const paperH = 3.2;

    // 白い紙のアウトライン (極細線 0.75pt)
    slide.addShape(pres.shapes.RECTANGLE, {
      x: paperX, y: paperY, w: paperW, h: paperH,
      fill: { color: COLOR_BG },
      line: { color: COLOR_DARK_LINE, width: 0.75 }
    });

    // 紙に印刷された「沈黙」のテキスト (インクを思わせるミニマルスタンプ風)
    slide.addText("THE\n6-PAGE\nMEMO", {
      x: paperX + 0.2, y: paperY + 0.3, w: paperW - 0.4, h: 1.0,
      fontSize: 14,
      fontFace: FONT_TITLE,
      color: COLOR_MUTED_TEXT,
      bold: true,
      align: "left",
      margin: 0,
      charSpacing: 1
    });

    // 用紙の下部装飾用のダミー極細線 (文字を模したもの)
    for (let i = 0; i < 4; i++) {
      slide.addShape(pres.shapes.LINE, {
        x: paperX + 0.2, y: paperY + 1.6 + (i * 0.3), w: paperW - 0.7, h: 0,
        line: { color: COLOR_LINE, width: 0.5 }
      });
    }

    // --- 右側: 沈黙のプロトコル解説 (圧倒的余白で静寂を強調) ---
    slide.addText([
      { text: "会議の冒頭に、全員でメモを黙読する。\n\n", options: { bold: true, color: COLOR_TEXT, fontSize: 16 } },
      { text: "Amazonの意思決定の場には、スライドを読み上げる無駄な時間も、発表者の巧妙な弁舌も存在しない。\n\n", options: { color: "333333", fontSize: 11.5 } },
      { text: "参加者は最初の15分間、ただインクで印字された完全な文章と向き合う。シンと静まり返った会議室で、各自がメモの余白にペンで疑問や鋭い洞察を書き込んでいく。\n\n", options: { color: "333333", fontSize: 11.5 } },
      { text: "小手先のパフォーマンスを排し、本質的な知性だけがぶつかり合う、極めて理性的で無慈悲な『沈黙の時間』である。", options: { color: COLOR_MUTED_TEXT, fontSize: 11 } }
    ], {
      x: paperX + paperW + 0.6, y: paperY + 0.1, w: 5.0, h: paperH,
      fontFace: FONT_BODY,
      margin: 0
    });
  }

  // PPTXファイルの保存
  const outputFileName = "output.pptx";
  console.log(`💾 スライドを ${outputFileName} に保存します...`);
  pres.writeFile({ fileName: outputFileName });
  console.log("✨ Amazon流ミニマリズム・スライドのビルドが完了しました！");
}

main().catch(err => {
  console.error("❌ エラーが発生しました:", err);
  process.exit(1);
});
```
