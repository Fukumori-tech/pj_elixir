defmodule EctoAssocQuery.PlayList do
  use Ecto.Schema

  schema "play_lists" do
    field :name, :string

    #artistを管理するスキーマと関連付けをする
  #belongs_to :第２引数で持ってくるレコードたちの任意の名前, 結合で持ってくるスキーマのモジュール名
    belongs_to :user, EctoAssocQuery.User

    #一人のuserがたくさんのplay_listを持っている可能性はある

    #play_list_musicsに関連付けされているので、そこを通してmusicsを参照できる。
    #play_list_musicsそのものは参照しなくてよいのでしない（独自の情報がないから）
    many_to_many :musics, EctoAssocQuery.Music, join_through: "play_list_musics"
  end
 end
