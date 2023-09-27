---
title: Phoenix x Tailwind CSS x daisyUIでthemeChange
tags:
  - Elixir
  - Phoenix
  - 40代駆け出しエンジニア
  - AdventCalendar2022
private: false
updated_at: '2022-08-03T23:54:48+09:00'
id: 4112f18ef516150da641
organization_url_name: fukuokaex
slide: false
ignorePublish: false
---
![output.gif](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/ff449a4f-90fc-4530-db05-beb5a24b7448.gif)

[Phoenix](https://www.phoenixframework.org/)のアプリを[作ります](https://hexdocs.pm/phoenix/up_and_running.html)。

https://hexdocs.pm/phoenix/up_and_running.html

---

次に
[Tailwind CSS](https://tailwindcss.com/)と[daisyUI](https://daisyui.com/)の設定をします。

https://tailwindcss.com/docs/guides/phoenix

https://daisyui.com/docs/install/

上記が公式の案内です。
@nako_9h_sleep さんの記事が詳しいです :tada::tada::tada: 

https://qiita.com/nako_9h_sleep/items/9cd2343d19abee7a59e9

---

さらに以下の変更を加えます。

コマンドで
```
cd assets
npm i theme-change
```
を行います。
`package.json`と`package-lock.json`が書き換わります。

---
さらにさらに編集を続けます。
チョ〜　楽しい！！！


```js:hello/assets/tailwind.config.js
module.exports = {

  daisyui: {
    themes: ["light", "dark", "cupcake", "bumblebee", "emerald", "corporate", "synthwave", "retro", "cyberpunk", "valentine", "halloween", "garden", "forest", "aqua", "lofi", "pastel", "fantasy", "wireframe", "black", "luxury", "dracula", "cmyk", "autumn", "business", "acid", "lemonade", "night", "coffee", "winter"],
  },
}
```

```js:assets/js/app.js
import { themeChange } from "theme-change";
console.log("themeChange")
themeChange();
```

```html:lib/hello_web/templates/page/index.html.heex
<div class="container w-full">
  <div class="flex justify-center">
    <div class="badge mx-3">neutral</div>
    <div class="badge badge-primary mx-3">primary</div>
    <div class="badge badge-secondary mx-3">secondary</div>
    <div class="badge badge-accent mx-3">accent</div>
    <div class="badge badge-ghost mx-3">ghost</div>
  </div>

  <div class="flex justify-center mt-6">
  <div class="form-control">
    <select data-choose-theme class="input input-bordered">
      <%= options_for_select(theme_options(), "cupcake") %>
    </select>
  </div>
  </div>
</div>
```

```elixir:lib/hello_web/views/page_view.ex
defmodule HelloWeb.PageView do
  use HelloWeb, :view

  def theme_options() do
    [
      "light",
      "dark",
      "cupcake",
      "bumblebee",
      "emerald",
      "corporate",
      "synthwave",
      "retro",
      "cyberpunk",
      "valentine",
      "halloween",
      "garden",
      "forest",
      "aqua",
      "lofi",
      "pastel",
      "fantasy",
      "wireframe",
      "black",
      "luxury",
      "dracula",
      "cmyk",
      "autumn",
      "business",
      "acid",
      "lemonade",
      "night",
      "coffee",
      "winter"
    ]
    |> Enum.map(fn theme -> {String.capitalize(theme) |> String.to_atom(), theme} end)
  end
end
```

---

できあがり。
たぶんこれでイケるとおもいます。

この通りにやって、できなかったらそれは君への宿題だ！
編集リクエストをお待ちしております。
どうぞ編集リクエストをお送りください。
そして私の承認にて、[Contibution数 1](https://help.qiita.com/ja/articles/qiita-contribution)を獲得してください！
