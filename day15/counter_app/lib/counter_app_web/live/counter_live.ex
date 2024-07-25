defmodule CounterAppWeb.CounterLive  do
  use CounterAppWeb, :live_view

  def render(assigns) do
    ~H"""
    <h1>This is : <%= @value %></h1>
    <%!-- click →event発生 --%>
    <.button type="button" phx-click="dec">-</.button>
    <.button type="button" phx-click="inc">+</.button>


    """
  end

  #counterというルートにアクセスがあるとまずこのmountが呼ばれる
  #mountはかならず定義する
  #mountは必ず{:ok, socket}を返すようにする
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :value, 0)}#実質戻り値socket(後ろは初期値)
    #render(conn, :summary, value: 0)
  end
  #phx-clickのイベントを受け取る関数
  #第一引数にイベント名を受け取る
  #handle_eventは戻り値は必ず{:noreply, socket}を返すようにする
  def handle_event("dec", _params, socket) do
    socket = update(socket, :value, fn value -> value - 1 end)
    {:noreply, socket}

  end

  def handle_event("inc", _params, socket) do
    socket = update(socket, :value, fn value -> value + 1 end)
    {:noreply, socket}

  end
end
