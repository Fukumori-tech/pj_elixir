defmodule TodoAppWeb.HelloHTML do
  use TodoAppWeb, :html

  embed_templates "hello_html/*" #追加
  #指定のdirectoryにある全テンプレが読み込める
end
