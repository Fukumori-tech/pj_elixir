defmodule EctoAssoc.Avator do
  use Ecto.Schema

  schema "avators" do
    field :nick_name, :string
    field :pic_url, :string
      belongs_to :user, EctoAssoc.User
  end
end
