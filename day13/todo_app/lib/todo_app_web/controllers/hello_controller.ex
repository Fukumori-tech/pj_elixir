defmodule TodoAppWeb.HelloController do
  use TodoAppWeb, :controller # <- これは何？

  #action
  # conn = 構造体, params = リクエストパラメーター
  def hello(conn, _params) do
    #「第二引数名のテンプレをレンダリングしろ」という意味
    render(conn, :hello)
  end
end
