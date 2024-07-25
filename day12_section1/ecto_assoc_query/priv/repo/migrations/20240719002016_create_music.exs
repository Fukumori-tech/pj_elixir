#musicを管理するテーブルを作る
#
# musics 対　music_lists 　他対一
# musics 対　play_list_musics 　１対0..他

defmodule EctoAssocQuery.Repo.Migrations.CreateMusic do
  use Ecto.Migration

  def change do
    create table(:musics) do
      add :name, :string, null: false
      add :music_list_id, references(:music_lists), null: false
    end
  end
end
