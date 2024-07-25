defmodule EctoAssocQuery.MusicList do
  use Ecto.Schema

  schema "music_lists" do
    field :name, :string
    field :category, :string
    field :music_category, :string

    #artistを管理するスキーマと関連付けをする
  #belongs_to :第２引数で持ってくるレコードたちの任意の名前, 結合で持ってくるスキーマのモジュール名
    belongs_to :artist, EctoAssocQuery.Artist

    #一人のアーティストがたくさんのmusic_listを持っている可能性はある


    #musicsに関連付けされたので参照できるようにする
    has_many :musics, EctoAssocQuery.Music
  end
 end
