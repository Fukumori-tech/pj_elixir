defmodule EctoTransaction.Repo.Migrations.CreateGetItems do
  use Ecto.Migration

  def change do
    create table(:#table の中身いじるところから再開　ｐ９) do
      add :name, :string, null: false
      add :price, :integer, null: false, default: 0
    end
  end
end
