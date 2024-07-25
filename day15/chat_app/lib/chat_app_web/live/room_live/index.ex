defmodule ChatAppWeb.RoomLive.Index do
  use ChatAppWeb, :live_view

  alias ChatApp.Rooms
  alias ChatApp.Rooms.Room
  alias ChatApp.Accounts

  @impl true
  def mount(_params, session, socket) do #sessionからloginしてる人の infoとる
  #IO.inspect(session)
#   # session = %{
#   "_csrf_token" => "mRIwz_GexETfFJvhtaNOiKDN",
#   "live_socket_id" => "users_sessions:5CfE5sQRcpOTQEg-WdYkOnhSM2lumrJCVGRUAkWBRPg=",
#   "user_token" => <<228, 39, 196, 230, 196, 17, 114, 147, 147, 64, 72, 62, 89,
#     214, 36, 58, 120, 82, 51, 105, 110, 154, 178, 66, 84, 100, 84, 2, 69, 129,
#     68, 248>>
# }
session["user_token"] #=> <<123, 123,...>>
user = Accounts.get_user_by_session_token(session["user_token"])
    {:ok,
    stream(socket, :rooms, Rooms.list_rooms())
    #current_userで渡せばUser使えるようにする
  |> assign(:current_user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Room")
    |> assign(:room, Rooms.get_room(id, socket.assigns.current_user.id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Room")
    |> assign(:room, %Room{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Rooms")
    |> assign(:room, nil)
  end

  @impl true
  def handle_info({ChatAppWeb.RoomLive.FormComponent, {:saved, room}}, socket) do
    {:noreply, stream_insert(socket, :rooms, room)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    room = Rooms.get_room!(id)
    {:ok, _} = Rooms.delete_room(room)

    {:noreply, stream_delete(socket, :rooms, room)}
  end

  def handle_event("join", %{"id" => room_id}, socket) do
    Rooms.create_member(socket.assigns.current_user.id, room_id)

    socket =
      socket
      |> put_flash(:info, "join room.")
      |> redirect(to: ~p"/rooms/#{room_id}")

      {:noreply, socket}
  end
end
