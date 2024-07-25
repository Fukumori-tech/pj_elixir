defmodule ChatApp.Repo.Migrations.CreateMembers do
  use Ecto.Migration

  def change do
    create table(:members) do
      add :user_id, references(:users, on_delete: :delete_all), null: false #usersのレコードが削除されても紐づいてるmemのレコードは削除されない(nothing<=> delete_all)
      add :room_id, references(:rooms, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime, updated_at: false)
      #inserted_at
      #updated_at <- 作らないでと指示
    end

    create index(:members, [:user_id])
    create index(:members, [:room_id])
  end
end
