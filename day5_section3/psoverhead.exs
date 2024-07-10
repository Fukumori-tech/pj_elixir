defmodule Psoverhead do
  def counter(next_pid) do
    receive do
      #spawnした段階で待機してるnext_pid
      n -> send(next_pid, n + 1)

      end
    end

  #この関数には生成するプロセスの数が渡される
  def create_processes(n) do
      #code_to_run =
        fn (_, pid) ->
          spawn(Psoverhead, :counter, [pid])
        end

        last_pid = Enum.reduce(1..n, self(), fn num,
        #pid は前のsupawnの戻り値（新しいpid）
        pid ->
          spawn(Psoverhead, :counter, [pid]) end )

        #最後に作ったプロセスに０を送り、カウントを開始(counterのnに送る)
        send(last_pid, 0)

        receive do
          final_answer ->
            "Result is #{inspect(final_answer)}"

        end
  end
  def run(n) do
      IO.inspect(:timer.tc(Psoverhead, :create_processes, [n]))
  end

end
