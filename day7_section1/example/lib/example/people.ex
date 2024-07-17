#DTOみたいなもの、テーブルのデータ（レコード）をelixirで扱えるようにするためのファイル
#Elixirで使いたい奴だけ
defmodule Example.People do
  use Ecto.Schema
  import Ecto.Changeset

  schema "peoples" do
    field :first_name, :string
    field :last_name, :string
    field :sns_address, :string
    field :tel, :string

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    #変更したり、変更する箇所決めたりして変更後のcs返す
    |> cast(params, [:first_name, :last_name, :sns_address, :tel])
    #なぜ年齢はチェックしない？->null禁止してないから？
    |> validate_required([:first_name, :last_name])
    #自分で作った関数
    |> validate_sns_address()
  end

  defp validate_sns_address(cs) do
    cs
    #null, 空文字チェック
    |> validate_required(:sns_address, message: "Please enter your sns_address")
    #データ登録時にエラー文出す
    |> unique_constraint(:sns_address, message: "already retrieved")
    #呼び出し元の関数実行した時点でエラー文出す
    |> unsafe_validate_unique(:sns_address, Example.Repo, message: "Sns address has
    already been retrieved.")
    #正規表現使ってフォーマットチェック
    |> validate_format(:sns_address, ~r/^[^\s]+@[^\s]+$/, message: "Must
include the @ symbol, do not include spaces.")
  end

  def sample_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name, :age])
    #なぜ年齢はチェックしない？->null禁止してないから？
    |> validate_required(:first_name, message: "Please enter your firstname.")
    |> validate_required(:last_name, message: "Please enter your lastname.")
  end


end
