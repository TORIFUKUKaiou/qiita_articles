---
title: Xcode Command Line Toolsを何度もインストールしろといわれたら一度Xcodeを立ち上げてみるといいかもしれません
tags:
  - Elixir
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-09-16T11:14:27+09:00'
id: 1b5dd6a7e5aa365c7f9d
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに

いつものように[Elixir](https://elixir-lang.org/)を楽しんでいました。
`mix deps.get`という、Alchemistたちにはおなじみのコマンドで依存関係を解決しておりますと、「`make`コマンドが見つからないから実行できません。 Command Line Toolsをインストールしてください」というようなメッセージが表示されました。
ご丁寧にGUIでインストール操作ができたのでその指示のままインストールをして、完了したところで喜び勇んで再度`mix deps.get`をしてみたところまた同じく「`make`コマンドが見つからない」だなんだと言われたことがありました。

結論から言うと、Xcodeを一度起動して設定画面まで表示させたら、その次からはうまくいきました。

ちなみにAlchemistとは、錬金術師のことで、[Elixir](https://elixir-lang.org/)の使い手のことをそう言います。
決して決して自分自身のことをAlchemistと言っているわけではありません。そこはお間違えなきよう。

# 直近にあったさまざまなこと

- macOSのアップデート
- Xcodeのアップデート

# 試してみたこと

- Command Line Toolsのアンインストール、再インストール
    - 「[brew upgrade でのエラー対処からCommand Line Toolsについてまとめてみる](https://techracho.bpsinc.jp/wingdoor/2021_04_09/104821)」を参考にしました
        - `sudo rm -rf /Library/Developer/CommandLineTools`
        - `xcode-select --install`
    - この方法は他の方も紹介されています
    - 私の場合はこの方法では解決できず、再インストール後、再度`make`が必要になる操作をしたところ再び「Command Line Toolsをインストールしてください」というようなことを言われました
- Command Line Toolsの再インストールを、 https://developer.apple.com/download/more/?=command%20line%20tools からインストーラをダウンロードしてインストーラからインストールする
    - この方法でも現象は変わりませんでした

ターミナルを一度落として、再度起動してみました。
するとなんだか不穏なエラーがでていました。


# ターミナルを立ち上げたときにでていたエラー

このエラー内容が一般的な内容かどうかわかりません。
たまたま私のmacOSではこういうエラーがでていましたというだけで、他の環境の場合にはまた異なるエラーとなるものかもしれません。
同じエラーが出た人の助けになるかもしれませんのでさらしておきます。

```
2022-09-15 13:37:42.326 xcodebuild[89303:640720] [MT] DVTPlugInLoading: Failed to load code for plug-in com.apple.dt.IDESimulatorAvailability (/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin), error = Error Domain=NSCocoaErrorDomain Code=3588 "dlopen(/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin/Contents/MacOS/IDESimulatorAvailability, 0x0109): Symbol not found: (_OBJC_CLASS_$_SimDiskImage)
  Referenced from: '/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin/Contents/MacOS/IDESimulatorAvailability'
  Expected in: '/Library/Developer/PrivateFrameworks/CoreSimulator.framework/Versions/A/CoreSimulator'" UserInfo={NSLocalizedFailureReason=The bundle couldn’t be loaded., NSLocalizedRecoverySuggestion=Try reinstalling the bundle., NSFilePath=/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin/Contents/MacOS/IDESimulatorAvailability, NSDebugDescription=dlopen(/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin/Contents/MacOS/IDESimulatorAvailability, 0x0109): Symbol not found: (_OBJC_CLASS_$_SimDiskImage)
  Referenced from: '/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin/Contents/MacOS/IDESimulatorAvailability'
  Expected in: '/Library/Developer/PrivateFrameworks/CoreSimulator.framework/Versions/A/CoreSimulator', NSBundlePath=/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin, NSLocalizedDescription=The bundle “IDESimulatorAvailability” couldn’t be loaded.}, dyldError = dlopen(/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin/Contents/MacOS/IDESimulatorAvailability, 0x0000): Symbol not found: (_OBJC_CLASS_$_SimDiskImage)
  Referenced from: '/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin/Contents/MacOS/IDESimulatorAvailability'
  Expected in: '/Library/Developer/PrivateFrameworks/CoreSimulator.framework/Versions/A/CoreSimulator'
2022-09-15 13:37:42.411 xcodebuild[89303:640720] [MT] DVTAssertions: ASSERTION FAILURE in /System/Volumes/Data/SWE/Apps/DT/BuildRoots/BuildRoot2/ActiveBuildRoot/Library/Caches/com.apple.xbs/Sources/DVTFrameworks/DVTFrameworks-21303/DVTFoundation/PlugInArchitecture/DataModel/DVTPlugIn.m:374
Details:  Failed to load code for plug-in com.apple.dt.IDESimulatorAvailability (/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin)
Please ensure Xcode packages are up-to-date — try running 'xcodebuild -runFirstLaunch'.

NSBundle error: Error Domain=NSCocoaErrorDomain Code=3588 "dlopen(/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin/Contents/MacOS/IDESimulatorAvailability, 0x0109): Symbol not found: (_OBJC_CLASS_$_SimDiskImage)
  Referenced from: '/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin/Contents/MacOS/IDESimulatorAvailability'
  Expected in: '/Library/Developer/PrivateFrameworks/CoreSimulator.framework/Versions/A/CoreSimulator'" UserInfo={NSLocalizedFailureReason=The bundle couldn’t be loaded., NSLocalizedRecoverySuggestion=Try reinstalling the bundle., NSFilePath=/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin/Contents/MacOS/IDESimulatorAvailability, NSDebugDescription=dlopen(/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin/Contents/MacOS/IDESimulatorAvailability, 0x0109): Symbol not found: (_OBJC_CLASS_$_SimDiskImage)
  Referenced from: '/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin/Contents/MacOS/IDESimulatorAvailability'
  Expected in: '/Library/Developer/PrivateFrameworks/CoreSimulator.framework/Versions/A/CoreSimulator', NSBundlePath=/Applications/Xcode.app/Contents/PlugIns/IDESimulatorAvailability.ideplugin, NSLocalizedDescription=The bundle “IDESimulatorAvailability” couldn’t be loaded.}
Object:   <DVTPlugIn: 0x600003624be0>
Method:   -loadAssertingOnError:error:
Thread:   <_NSMainThread: 0x600001268500>{number = 1, name = main}
Hints: 

Backtrace:
  0  0x000000010a7b1f81
  1  0x000000010a7b14b5
  2  0x000000010a7b16c1
  3  0x000000010a6283ba
  4  0x000000010a5e3c73
  5  0x000000010a5e1a1f
  6  0x00007ff801609317
  7  0x00007ff8016167ee
  8  0x000000010a8005a1
  9  0x000000010a7d60d8
 10  0x000000010a5e18a3
 11  0x000000010a5e1af5
 12  0x000000010b6c6f66
 13  0x000000010b6c6526
 14  0x000000010b6c5919
 15  0x000000010904e9a4
 16  0x0000000108dd120a
```

# おわりに

**Please ensure Xcode packages are up-to-date — try running 'xcodebuild -runFirstLaunch'.**

記事を書くにあたり、あらためてエラー内容をよく読んでみました。
書いてありました。
まず立ち上げよ、と。

あらためていま`xcodebuild -runFirstLaunch`を実行してみましたがすでに手動でXcodeを立ち上げたあとだったのでうんともすんとも言いませんでした。

**教訓**
エラーログはよく読もう。
英語をちゃんと読もう。
そこに答えは書いてある。
(いつも初学の人に言っていることです。自戒の念を込めてこの記事を書いておきます)
