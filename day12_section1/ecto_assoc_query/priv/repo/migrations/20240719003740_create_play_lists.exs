#play_list（ユーザー側のリスト）を管理するテーブルを作る
#
# users 対　play_lists 　一対0..他
# play_lists 対　play_list_musics 　一対1..他
defmodule EctoAssocQuery.Repo.Migrations.CreatePlayLists do
  use Ecto.Migration

  def change do
    create table(:play_lists) do
      add :name, :string, null: false
      add :user_id, references(:users), null: false
    end
  end
end
