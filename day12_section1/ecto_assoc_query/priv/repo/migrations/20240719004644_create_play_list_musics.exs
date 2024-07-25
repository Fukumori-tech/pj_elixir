#play_listの中のmusicを管理するテーブルを作る
#
# play_list_musics 対　musics 　0..他対1
# play_list_musics 対　play_lists 　他対1

defmodule EctoAssocQuery.Repo.Migrations.CreatePlayListMusics do
  use Ecto.Migration

  def change do
    create table(:play_list_musics) do
      add :play_list_id, references(:play_lists), null: false
      add :music_id, references(:musics), null: false
    end
  end
end
