defmodule BlogAppWeb.ArticleLive.Show do
  use BlogAppWeb, :live_view

  alias BlogApp.Articles

  def render(assigns) do
    ~H"""
    <div :if={@article.status == 2}>
    This is a limited article.
    </div>

    <div>
    <a><%=@article.user.name%></a>
    <div><%=@article.submit_date%></div>
    <h2><%=@article.title%></h2>
    <div><%=@article.body%></div>
    </div>

    """
  end

#renderはliveviewで使うかgxのファイルで使う

  def mount(_params, _session, socket) do
    # socket =
    #   socket
    #   |> assign(:articles, Articles.list_articles)
    #   |> assign(:page_title, "blog")

      {:ok, socket}
  end

  def handle_params(%{"article_id" => article_id}, _url, socket) do
    article = Articles.get_article!(article_id)

    socket =
      if article.status in [1, 2] do
        socket
         |> assign(:article, article)
         |> assign(:page_title, article.title)
      else
        redirect(socket, to: ~p"/")
      end

      {:noreply, socket}
      #   socket
      #   |> assign(:articles, Articles.list_articles)
      #   |> assign(:page_title, "blog")

  end
end
