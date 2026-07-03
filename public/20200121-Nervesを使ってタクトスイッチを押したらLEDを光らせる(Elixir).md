---
title: Nervesを使ってタクトスイッチを押したらLEDを光らせる(Elixir)
tags:
  - Elixir
  - Nerves
private: false
updated_at: '2020-01-22T08:00:34+09:00'
id: ad3eee31dea0dc1cbcbd
organization_url_name: fukuokaex
slide: false
ignorePublish: false
posting_campaign_uuid: null
agreed_posting_campaign_term: false
---
# はじめに
- タクトスイッチが押されたら、LEDを光らせてみます
- もちろん[Nerves](https://nerves-project.org/)を使います
    - [NervesはElixirのIoTでナウでヤングなcoolなすごいヤツです🚀](https://twitter.com/torifukukaiou/status/1201266889990623233)
- 今回は、タクトスイッチがおされたことをGPIO 24で読み取ったら、GPIO 18をHighにしてLEDを光らせてみます
- **押された** ということを検知するために待つところは、[NervesJP](https://nerves-jp.connpass.com/)でちらっと聞いた[GenServer](https://hexdocs.pm/elixir/GenServer.html)を使ってみます
    - @inachi さんの[Elixir超初心者が Nerves で心拍数測定アプリを作ってみる](https://qiita.com/inachi/items/ff006fd20246f0a0a358)
    - 参考にしました！　ありがとうございます！

![VID_20200121_220615.gif](https://firebase.torifuku-kaiou.tokyo/VID_20200121_220615.gif)


# 作品
[TORIFUKUKaiou/hello_nerves](https://github.com/TORIFUKUKaiou/hello_nerves)
- [Nervesを使ってRaspberry pi2からTwitterの投稿を行う](https://qiita.com/torifukukaiou/items/6096c201fbb013e65baa)
- こちらの記事で作り始めたごった煮プロジェクトに追加しています

# ソースコード抜粋
- [関連コミット](https://github.com/TORIFUKUKaiou/hello_nerves/commit/58196ac0bab9fc37c1601b30a3e917936dd166e6)
- [circuits_gpio](https://hexdocs.pm/circuits_gpio/readme.html)を使っています

```Elixir:lib/hello_nerves/observer.ex
defmodule HelloNerves.Observer do
  use GenServer

  require Logger

  @input_pin HelloNerves.Util.input_pin()

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_info({:circuits_gpio, @input_pin, _timestamp, 1}, state) do
    Logger.debug("Received rising event on pin #{@input_pin}")
    HelloNerves.Blinker.enable()
    {:noreply, state ++ [1]}
  end

  @impl true
  def handle_info({:circuits_gpio, @input_pin, _timestamp, 0}, state) do
    Logger.debug("Received falling event on pin #{@input_pin}")
    HelloNerves.Blinker.disable()
    {:noreply, state ++ [0]}
  end
end
```
- タクトスイッチが押されたり、離されたりすると、[handle_info/2](https://hexdocs.pm/elixir/GenServer.html#c:handle_info/2)がコールバックされます
- タクトスイッチが押されたら、`HelloNerves.Blinker.enable()`をコールして、LEDを点灯させています
- 反対に、タクトスイッチの押し込みが離れたら、`HelloNerves.Blinker.disable()`をコールして、LEDを消灯させています

```Elixir:lib/hello_nerves/set_interrupter.ex
defmodule HelloNerves.SetInterrupter do
  use GenServer

  require Logger

  alias Circuits.GPIO

  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    GPIO.set_interrupts(HelloNerves.Util.input_gpio(), :both, receiver: HelloNerves.Observer)
    {:ok, state}
  end
end
```
- [Circuits.GPIO.set_interrupts/3](https://hexdocs.pm/circuits_gpio/Circuits.GPIO.html#set_interrupts/3)は、`:receive`オプションで`HelloNerves.Observer`を指定することで、GPIOの状態変化(スイッチON/OFF)があったときに、`HelloNerves.Observer.handle_info/2`が呼び出されるようにしています
    - `HelloNerves.Observer.init/1` で、[Circuits.GPIO.set_interrupts/3](https://hexdocs.pm/circuits_gpio/Circuits.GPIO.html#set_interrupts/3)を呼び出しておけばよさそうで、はじめはそうしていたのですが、数回のスイッチON/OFFにしか反応しないので、別のモジュールをつくりました
    - こうすると私のRaspberry Pi 2ではうまくいっています
    - [Nerves](https://nerves-project.org/)起動後に立ち上がるIExで、`GPIO.set_interrupts(HelloNerves.Util.input_gpio(), :both, receiver: HelloNerves.Observer)` するとうまくいったので、こうしてみました
    - 真因がわかりましたら更新します

```Elixir:lib/hello_nerves/application.ex
  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: HelloNerves.Worker.start_link(arg)
      # {HelloNerves.Worker, arg},
      {HelloNerves.Blinker, name: HelloNerves.Blinker},
      {HelloNerves.Observer, name: HelloNerves.Observer},
      {HelloNerves.SetInterrupter, name: HelloNerves.SetInterrupter}
    ]
  end
```
- `List all child processes to be supervised`しています
    - supervisedされる子プロセスを列挙しています
    - 雑に言うと、hello_nervesというアプリケーション with [Nerves](https://nerves-project.org/) が起動するときに、自動的に子プロセスが開始される感じです
- `HelloNerves.Blinker`はここには載せていません
    - https://elixirschool.com/ja/lessons/advanced/nerves/
    - の記事にインスパイアされました
    - ありがとうございます！

# 回路
![IMG_20200121_230205.jpg](https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/131808/849a6699-8754-494f-3248-2340dd252bcb.jpeg)

- [Raspberry Piで学ぶ電子工作 超小型コンピュータで電子回路を制御する (ブルーバックス) ](https://www.amazon.co.jp/dp/4062578913) 
- こちらの本を参考にしました
    - ありがとうございます！

# 説明というか感想というか
- [nerves_examples/hello_gpio/lib/hello_gpio.ex](https://github.com/nerves-project/nerves_examples/blob/ad70fa328599cd45d95961a969c24f3825cbfb50/hello_gpio/lib/hello_gpio.ex) は再帰を使った無限ループで書かれています
- `Circuits.GPIO.set_interrupts(input_gpio, :both)` を呼び出して、[receive](https://hexdocs.pm/elixir/Kernel.SpecialForms.html#receive/1)でmessageがくるのを待っています
    - [Processes](https://elixir-lang.org/getting-started/processes.html)もあわせて読んでみると、なんとなくわかるとおもいます
- こういう構造って、[GenServer](https://hexdocs.pm/elixir/GenServer.html)でできるということを、[NervesJP](https://nerves-jp.connpass.com/)で聞いたので使ってみました
- 自分が実現したいことがあったので、[プログラミングElixir](https://www.amazon.co.jp/dp/4274219151)(本)に書いてある内容がすんなり入ってきました

