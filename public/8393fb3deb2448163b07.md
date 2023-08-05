---
title: "Run LINE bot on Raspberry Pi with Nerves \U0001F680"
tags:
  - Elixir
  - Nerves
  - autoracex
private: false
updated_at: '2021-12-26T22:47:13+09:00'
id: 8393fb3deb2448163b07
organization_url_name: fukuokaex
slide: false
---
https://qiita.com/advent-calendar/2021/nervesjp

12/25, 2021

# Introduction
Hey!

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
Enjoy [Nerves](https://www.nerves-project.org/):bangbang::bangbang::bangbang:

I run [LINE](https://line.me/ja/) bot on [Nerves](https://www.nerves-project.org/).
[LINE](https://line.me/ja/) is one of the most popular messaging app in Japan.

This bot does to parrot.
I use [Nerves](https://www.nerves-project.org/) and [Bandit](https://github.com/mtrudel/bandit).
Thanks a lot!!!

# Source code

https://github.com/TORIFUKUKaiou/hello_nerves_poncho

# Documentations

https://developers.line.biz/en/docs/messaging-api/

https://qiita.com/torifukukaiou/items/05255dc857ddd5a695ee

# Architecture

![スクリーンショット 2021-12-26 8.14.04.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/f4b536a7-4255-e674-ec79-fc863e5716e9.png)




# Run

Would you please refer [README](https://github.com/TORIFUKUKaiou/hello_nerves_poncho/blob/main/README.md)?


# ngrok

https://ngrok.com/

> Spend more time programming. One command for an instant, secure URL to your localhost server through any NAT or firewall.

## Usage on PC

`192.168.1.9` is example.
Set your Nerves IP address.

```bash
$ ngrok http 192.168.1.9:4000

ngrok by @inconshreveable                                                                                         (Ctrl+C to quit)
                                                                                                                                  
Session Status                online                                                                                              
Account                       TORIFUKUKaiou (Plan: Free)                                                                          
Version                       2.3.40                                                                                              
Region                        United States (us)                                                                                  
Web Interface                 http://127.0.0.1:4040                                                                               
Forwarding                    http://dad0-133-218-30-187.ngrok.io -> http://192.168.1.9:4000                                      
Forwarding                    https://dad0-133-218-30-187.ngrok.io -> http://192.168.1.9:4000                                     
                                                                                                                                  
Connections                   ttl     opn     rt1     rt5     p50     p90                                                         
                              3       0       0.00    0.00    246.76  340.47
```


Set Webhook URL on LINE Developers Console.

![スクリーンショット 2021-12-25 19.32.54.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/2bb999d4-5a63-f4be-63de-d4e1e4e219f6.png)


# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
Enjoy [Nerves](https://www.nerves-project.org/):bangbang::bangbang::bangbang:

We can make [Slack](https://slack.com/) app as same!!!

https://qiita.com/torifukukaiou/items/7c203891144e9ec02d13

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/447253f9-3060-8bb7-7132-7754ef4aead5.png)


# bonous ーー making

<iframe width="738" height="415" src="https://www.youtube.com/embed/XIksWaGcnyE" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



