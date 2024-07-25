defmodule EctoAssocQuery.Artist do
  use Ecto.Schema

  schema "artists" do
    field :name, :string
    #music_lists（アーティストの音楽リスト）に関連付けされたので参照できるようにする
      has_many :music_lists, EctoAssocQuery.MusicList

      #musics に関連付けされたので参照できるようにする
      #すでに関連付けられているmusic_listsからmusicsを参照できるように設定？
      has_many :musics, through: [:music_lists, :musics]
  end
 end
