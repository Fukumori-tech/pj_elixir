defmodule Cards do
  def create_deck do

    suits = ["Spade", "Clover", "Diamond", "Heart"]
  numbers = ["Ace", "Two", "Three", "Four", "Fice", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]

   x =  for n <- numbers do
      (for m <- suits do

      n <>"_of_"<> m

    end)

  end

  List.flatten(x)



  end

  def shuffle(deck) do
    Enum.shuffle(deck)

  end

def deal(deck, deal_size)do
  Enum.split(deck, deal_size)



end
def save(deck, file_name) do
  binary = :erlang.term_to_binary(deck)
  File.write(file_name, binary)


end

def load(file_name) do
  {status, binary} = File.read(file_name)


  if status == :error do
    "not exist"
  else
    :erlang.binary_to_term(binary)

  end
end

end
