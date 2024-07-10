# 2. Hello関数が呼び出される
defmodule Hello do
  def greet do
    # 3.親プロセスからのメッセージをreceive/1で待ち受ける
    # 5.マッチするメッセージ（ここでは親のPID, "World"）を受信した場合、親のプロセスに{:ok, "Hello, World"}を送信する
    receive do
      {sender, name} ->
        #子プロセスから親にメッセージを送信
        send(sender, {:ok, "Hello, #{name}"})
        IO.inspect(binding(), label: "Hello.greet receive message")
        #再帰処理
        #greet()
    end
  end
end

# 1. 親が、子プロセスを生成
pid = spawn(Hello, :greet, [])
IO.inspect(binding(), label: "After the child process is called")

#selfでiexのPID取得（親プロセス）
send(pid, {self(), "TheWaggle"})
receive do
  {:ok, message} -> IO.puts(message)
end
# 4. 子プロセスにメッセージを送信。子プロセスに対し、self（）で親が親自身のPIDを送ることでどこに返事すればいいかわかる
send(pid, {self(), "world"})
IO.inspect(binding(), label: "After Send/2 sent to self process")

# 3秒待つ
# :timer.sleep(3000)

# 6.子プロセスからのメッセージをreceive/1で待ち受ける
# 5.マッチするメッセージ（ここでは{:ok,  "Hello, World"}）を受信した場合、IO.putsで受け取ったメッセージ”helloworld”を出力する
receive do
  {:ok, message} -> IO.puts(message)
  IO.inspect(binding(), label: "receive message")
  # after ミリ秒でタイムアウトする時間を指定できる
after
  3000 ->
    IO.puts("Nothing happened.")
end
