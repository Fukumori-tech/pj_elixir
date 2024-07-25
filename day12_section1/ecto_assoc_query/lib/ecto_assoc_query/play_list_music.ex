defmodule EctoAssocQuery.PlayListMusic do
  use Ecto.Schema

  schema "play_list_musics" do
    belongs_to :play_list, EctoAssocQuery.PlayList
    belongs_to :music, EctoAssocQuery.Music
    #play_list, musicに関連付けする

  end
 end
