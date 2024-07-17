defmodule EctoAssoc.User do
  use Ecto.Schema

  schema "users" do
    field :name, :string
    field :email, :string
      has_one :avator, EctoAssoc.Avator
      has_many :posts, EctoAssoc.Post
      has_many :likes, EctoAssoc.Like
      has_many :like_posts, through: [:likes, :post]
  end
end
