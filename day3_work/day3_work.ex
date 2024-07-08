defmodule Day3Work do
def question01 (s \\ "stressed") do
String.reverse(s)
|> IO.puts()

end

def question02 (s \\ "パタトクカシーー") do
  String.codepoints(s)
  |> Enum.with_index()
  |> Enum.filter(fn {_char, index} -> rem(index, 2) == 0 end)
|> Enum.map( fn {char, _index} -> char end)
|> Enum.join()
|> IO.puts()
end

def question03() do
 s1 = "パトカー"
 s2 = "タクシー"

 s1 = String.graphemes(s1)
 s2 = String.graphemes(s2)

 Enum.zip(s1, s2)
 |> Enum.map(fn {char1, char2} -> char1 <> char2 end)
 |> Enum.join()
 |> IO.puts()

end

def question04() do
  s = "Now I need a drink, alcoholic of course, after the heavy lectures involving quantum mechanics."

 s_list = ~w(#{s})

#AString.replace(s,[",", "."], "")
Enum.map(s_list, fn x -> String.length(x) end )
#A|> String.split(" ")
#A|> Enum.map(fn word -> String.length(word) end)
|> IO.inspect()
:ok

#test = ~W(hello elixir #{1+1} \n)
end

end
