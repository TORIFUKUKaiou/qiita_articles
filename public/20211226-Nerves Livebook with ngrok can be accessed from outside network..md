---
title: Nerves Livebook with ngrok can be accessed from outside network.
tags:
  - RaspberryPi
  - Elixir
  - Nerves
  - autoracex
  - Livebook
private: false
updated_at: '2022-01-08T13:56:28+09:00'
id: 4aa0f916e42e720169d0
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
https://qiita.com/advent-calendar/2021/raspberrypi

12/04, 2021

# Introduction

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
Enjoy [Nerves](https://www.nerves-project.org/):bangbang::bangbang::bangbang:

Yesterday, I posted an article.

https://qiita.com/torifukukaiou/items/8393fb3deb2448163b07

I think that [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook) with [ngrok](https://ngrok.com/) can be accessed from outside network.

I try it.
Of course, I can do it!!!

# [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook) Setup

Would you please refer the article?

https://qiita.com/torifukukaiou/items/27abc5b84f6f55f85d71#nerves-livebook-setup

# Diagram

![スクリーンショット 2021-12-26 22.52.11.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/1e380ccd-f43e-c9d1-5f28-f5a26a8bf486.png)


I use Raspberry Pi 4.
[Nerves Livebook](https://github.com/livebook-dev/nerves_livebook) runs on Raspberry Pi 4.

We can access [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook) from outside network with [ngrok](https://ngrok.com/).
Yes we can.
Success!!! L-chika :tada::tada::tada:

# Note

:::note alert
Chrome browser on outside network PC shows alert.
:::


![スクリーンショット 2021-12-26 22.01.08.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/c1a71798-d5df-9d9c-1091-58296b211f42.png)

Click **詳細を表示**

![スクリーンショット 2021-12-26 22.01.19.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/3e8b49f0-3667-1568-65ad-aef7144c5f9e.png)

Click **安全でないこのサイトにアクセス**



# Wrapping up :lgtm::lgtm::lgtm::lgtm::lgtm:

We can access [Nerves Livebook](https://github.com/livebook-dev/nerves_livebook) from outside network with [ngrok](https://ngrok.com/).

Enjoy [Elixir](https://elixir-lang.org/):bangbang::bangbang::bangbang:
Enjoy [Nerves](https://www.nerves-project.org/):bangbang::bangbang::bangbang:

---

I organize [autoracex](https://autoracex.connpass.com/).
And I belong to [NervesJP](https://nerves-jp.connpass.com/).
I hope someday you'll join us.

[We Are The Alchemists, my friends!](https://www.youtube.com/watch?v=04854XqcfCY)

![https___qiita-user-contents.imgix.net_https%3A%2F%2Fqiita-image-store.s3.ap-northeast-1.amazonaws.com%2F0%2F240349%2F5ef22bb9-f357-778c-1bff-b018cce54948.png_ixlib=rb-1.2.png](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/447253f9-3060-8bb7-7132-7754ef4aead5.png)
