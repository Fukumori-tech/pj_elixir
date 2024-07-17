defmodule EctoTransaction.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :name, :string
    field :price, :integer, default: 0
  end

  def changeset(item, params) do
    item
    |> cast(params, [:name, :price])
    |> validate_required(:name, message: "Please enter your item name.")
    |> validate_required(:name, message: "Please enter your item price.")

  end
end
