defmodule EctoAssoc.Repo.Migrations.CreateAvators do
  use Ecto.Migration

  def change do
create table(:avators) do
  add :nick_name, :string
  add :pic_url, :string
end
  end
end
