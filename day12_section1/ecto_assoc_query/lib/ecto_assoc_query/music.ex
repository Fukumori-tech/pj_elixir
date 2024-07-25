defmodule EctoAssocQuery.Music do
  use Ecto.Schema

  schema "musics" do
    field :name, :string
    belongs_to :music_list, EctoAssocQuery.MusicList

    #music_listを管理するスキーマと関連付けをする
  #belongs_to :第２引数で持ってくるレコードたちの任意の名前, 結合で持ってくるスキーマのモジュール名


    #一つのmusic_listがたくさんのmusicを持っている可能性はある

    #play_list_musicsに関連付けされているので、そこを通してplay_listsを参照できる。
    #play_list_musicsそのものは参照しなくてよいのでしない（独自の情報がないから）
    many_to_many :play_lists, EctoAssocQuery.PlayList, join_through: "play_list_musics"
  end
 end
