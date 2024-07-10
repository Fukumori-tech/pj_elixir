defmodule Test do
  def listen do
    receive do
      {:ok, msg} -> IO.puts(msg)
      _ -> raise "Error"
    end
  end
  {:ok, pid} = spawn(Test, listen, [])

  send(pid, {:ok, "Hello"})

end
