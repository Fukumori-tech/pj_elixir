defmodule Parallel do
  def pmap(collection, fun) do
  me = self()
  collection
  |> Enum.map(fn elem ->
  spawn_link(fn -> send(me, {self() |> IO.inspect(label: elem) , fun.(elem)}) end)|> IO.inspect(label: "spawn #{elem}")
  end)
  #|> IO.inspect()
  |> Enum.map(fn pid ->
   IO.inspect(pid, label: "beforesleep")
  :timer.sleep(round(:rand.uniform * 5000)|> IO.inspect(label: "beforesleep"))
  receive do
  {pid, result} -> result
  |> IO.inspect(label: "result")
  end
  end)
  end
  end
