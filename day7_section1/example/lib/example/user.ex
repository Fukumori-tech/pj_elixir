#DTOみたいなもの、テーブルのデータ（レコード）をelixirで扱えるようにするためのファイル
#Elixirで使いたい奴だけ
defmodule Example.User do
  use Ecto.Schema

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :age, :integer

    timestamps()
  end
end
