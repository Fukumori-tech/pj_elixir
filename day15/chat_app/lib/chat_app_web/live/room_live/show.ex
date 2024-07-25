defmodule ChatAppWeb.RoomLive.Show do
  use ChatAppWeb, :live_view

  alias ChatApp.Rooms
  alias ChatApp.Rooms.Message
  alias ChatApp.Accounts
#socket keep filetanni indexnonakadake

#"/xounter"mountがさうしょに呼び出される
#mount handle_params, render or templateがレンダリングされてクライアントに渡される、というライフサイクル
  @impl true
  def mount(_params, session, socket) do
    {:ok, socket}
    user = Accounts.get_user_by_session_token(session["user_token"])
    {:ok, assign(socket, :current_user, user)}
  end

  #"/counter"
  #mount, handle_params, render ir template rendering, websocketの接続を確立する, mount, handle_params
  #１回目ではhtmlを返してねとしか言ってないので、二回目でwebsocketの陸を出す
  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    socket =
    if room = Rooms.get_room(id, socket.assigns.current_user.id) do
      #websocket確立されてるか確認
      #1回目のhandle_paramsの時はｆ
      #2回目のhandle_paramsの時はt
      #2回目の時にこのとっぴくに関して購読するよと言う
      if connected?(socket) do
        subscribe(room)
      end
     socket
     |> assign(:page_title, room.room_name)
     |> assign(:room, room)
     |> assign(:messages, Rooms.list_messages(room.id))
     |> assign_form(Rooms.change_message(%Message{}))
    else
      socket
     |> put_flash(:error, "Not join room.")
     |> redirect(to: ~p"/rooms")
    end
    {:noreply, socket}

  end

  @impl true #call back 関数であるという表記みたいなもの、機能はない
  def handle_info({:send_message, message}, socket) do
    {:noreply,
  update(socket, :messages, fn messages -> List.insert_at(messages, -1, message) end)}
  end

  def handle_event("send_message", %{"message" => params}, socket) do
    #params = %{"message" => %{"message" => "test!"}} to paramas =  %{"message" => "test!", "user_id" = 3,  "room_id" = 3}
   # IO.inspect(params)

   params =
    Map.merge(params, %{"user_id" => socket.assigns.current_user.id, "room_id" => socket.assigns.room.id})
#=> %{"message" => "test!",  "user_id" = 3,  "room_id" = 3}

    socket =
      case Rooms.create_message(params) do
        {:ok, message} ->
          #broadcastでほかの人にもリアルタイムでメッセージ表示されるように
          broadcast(message, :send_message)

          assign_form(socket, Rooms.change_message(%Message{message: ""}))
          # socket
          # |> update(:messages, fn messages -> List.insert_at(messages, -1, message) end)
          # |> assign_form(Rooms.change_message(%Message{}))
          {:error, cs} ->
            assign_form(socket, cs)
          end
          {:noreply, socket}
  end

  defp assign_form(socket, cs) do
    assign(socket, :message_form, to_form(cs))
  end

  #購読
  defp subscribe(room) do #rooms table schema receive
    Phoenix.PubSub.subscribe(ChatApp.PubSub, "room_#{room.id}")
  end

  #push的な？
  #show module のhandle_infoが呼ばれる（それがcallback関数）
  #jenserver調べる
  defp broadcast(message, :send_message) do #rooms table schema receive
  Phoenix.PubSub.broadcast(ChatApp.PubSub, "room_#{message.room_id}", {:send_message, message})#第二引数は「どれを」か、第三引数はhandle_infoの第一引数に渡す
end

  defp page_title(:show), do: "Show Room"
  defp page_title(:edit), do: "Edit Room"
end
