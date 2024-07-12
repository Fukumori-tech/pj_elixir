#migration file
#DBに対してtableを定義する
#tableの数だけ作る
defmodule Example.Repo.Migrations.CreateUsers do
  use Ecto.Migration
#user定義の関数だけどフォーマット作ってくれてるから色々あるので関数名変えてはいけない
  def change do
    create table(:users) do
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :age, :integer
      add :email, :string, null: false

      timestamps()
    end
    create unique_index(:users, [:email])
  end
end
