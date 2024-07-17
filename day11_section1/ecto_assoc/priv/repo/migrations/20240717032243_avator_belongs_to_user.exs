defmodule EctoAssoc.Repo.Migrations.AvatorBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:avators) do
      add :user_id, references(:users)
    end
  end
end
