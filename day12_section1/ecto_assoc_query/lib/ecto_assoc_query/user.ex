defmodule EctoAssocQuery.User do
 use Ecto.Schema

 schema "users" do
   field :name, :string
   field :email, :string
   #play_listに関連付けされたので参照できるようにする
    has_many :play_lists, EctoAssocQuery.PlayList

    #すでに関連付けされたplay_listを通して、musicsを参照できるようにする
    has_many :musics, through: [:play_lists, :musics]

    #active_userに関連付けされたので参照できるようにする
    has_one :active_user, EctoAssocQuery.ActiveUser

    #delete_userに関連付けされたので参照できるようにする
    has_one :delete_user, EctoAssocQuery.DeleteUser
 end
end
