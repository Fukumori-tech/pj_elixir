defmodule BlogAppWeb.UserPageLive do
  use BlogAppWeb, :live_view
  alias BlogApp.Accounts
  alias BlogApp.Articles
#iroironajyouhouwomotteeakusesu,iroironajyouhou,burauzadehyoujisurutameno
#websarver(client)toyaritorisurutamrnoinfo = socketgamotteru
#assignshasocketkaratoridasitayatu
#assigns requestscopenosugoiyatu, map, nanndemoirerukaimonokago
  def render(assigns) do
    ~H"""

    <div><%=@user.name%></div>
    <div><%= @user.email %></div>
    <div><%= @user.introduction %></div>
    <div>Articles count : <%= @articles_count %></div>
    <div :if={@user.id == @current_user_id}>
    <.link href={~p"/users/settings"}>Edit profile</.link>
    </div>

    <div>
     <div >
      <.link href={~p"/users/profile/#{@user}"}>Articles</.link>
    </div>

    <div >
      <%= if length(@articles) > 0 do%>
        <div :for={article <- @articles} class="mt-2">
    <.link href={~p"/users/profile/#{article.user_id}"}><%= article.user.name%></.link>
    <.link href={~p"/articles/show/#{article}"}>
    <div><%= article.submit_date%></div>
    <h2><%= article.title%></h2>
    </.link>
    </div>
    <% else %>
    <div>
    No articles.
    </div>
    <% end %>
    </div>
    </div>


    """
  end
#socketclientとやりとりするためのidとかもってる、ブラウザの譲歩？
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def handle_params(%{"user_id" => user_id}, _uri, socket) do
    socket =
      socket
      #@userでusocketから取り出したやつテンプレート使える
      |> assign(:user, Accounts.get_user!(user_id))
      #socketにassignされたlive_actionをとってきて引数にする
      |> apply_action(socket.assigns.live_action)

      {:noreply, socket}
  end
#actionごとに関数作っていく
  defp apply_action(socket, :info) do
    user=socket.assigns.user
    current_user=socket.assigns.current_user
    current_user_id=get_current_user_id(current_user)

    articles=
      Articles.list_articles_for_user(user.id, current_user_id)

      socket
      |> assign(:articles, articles)
      |> assign(:articles_count, Enum.count(articles))
      |> assign(:current_user_id, current_user_id)
      |> assign(:page_title, user.name)
  end

  defp get_current_user_id(current_user) do
    #なければ（未登録ユーザなら）ニルが帰る
    Map.get(current_user || %{}, :id)
  end





end
