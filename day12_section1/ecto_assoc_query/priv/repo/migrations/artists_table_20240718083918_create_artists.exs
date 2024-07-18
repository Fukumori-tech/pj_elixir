#アーティストを管理するテーブルを作る
#
# artists 対　music_lists 　一対0..他

defmodule EctoAssocQuery.Repo.Migrations.CreateArtists do
  use Ecto.Migration

  def change do
    create table(:artists) do
      add :name, :string, null: false
    end
  end
end
