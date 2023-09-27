---
title: RubyでSlackの絵文字(emoji)を一括エクスポート
tags:
  - Ruby
  - Slack
private: false
updated_at: '2019-06-28T19:59:42+09:00'
id: 49b0e472844fe466a89d
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
# はじめに
- タイトルの通りです。
- Slackのワークスペースを引っ越しするというイベントがございました。
- すでに諸先輩方に書いていただいたものをRubyで書いてみただけです。


# Special Thanks
- [Slackのカスタム絵文字を全てダウンロードする](https://qiita.com/kure/items/7938d92532bb7577d8b8)
- [Slackの絵文字(emoji)を一括エクスポート＆インポートする](https://qiita.com/ne-peer/items/cbdef4f02b1bb6103e51)
- [scivola](https://qiita.com/scivola)様
    - レビューありがとうございます :bow:

# こちらでSlackのAPI(emoji.list)をお試しいただけます
- [slack api](https://api.slack.com/methods/emoji.list/test)

# 作品
```ruby
require 'open-uri'
require 'json'
require 'pathname'

# https://api.slack.com/apps
# |> Create New App
# |> Add features and functionality
# |> Permissions
# |> Scopes
# |> emoji:read
# |> xoxp-****
# |> replace TOKEN
TOKEN = 'とーくん'
URL = "https://slack.com/api/emoji.list?token=#{TOKEN}"
IMAGES_DIR = Pathname('images')

IMAGES_DIR.mkpath

body = open(URL, &:read)
emojis = JSON.parse(body)['emoji']

f = ->(_, url) { url.start_with?('alias') }
size = emojis.reject(&f).size

emojis.reject(&f).each.with_index(1) do |(key, url), i|
  #puts "#{key} => #{url}"
  extention = url.split('.').last

  filepath = IMAGES_DIR + "#{key}.#{extention}"
  filepath.binwrite open(url, &:read)

  print "%3d %%\e[G" % (i*100/size)
end

```

# 動作確認環境
```
$ ruby -v
ruby 2.6.1p33 (2019-01-30 revision 66950) [x86_64-darwin18]
```
- MacBook Pro(13-inch,2017,Two Thunderbolt 3 ports)
- macOS Mojave バージョン 10.14.5
