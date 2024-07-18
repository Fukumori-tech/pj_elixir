#ユーザーを管理するテーブルを作る
#メールアドレスにはユニーク制約付ける
#
# users 対　play_lists 　一対他
# users 対　active_users 　一対0,1
# users 対　delete_users 　一対0,1

defmodule EctoAssocQuery.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
    end

    create unique_index(:users, :email)
  end
end
