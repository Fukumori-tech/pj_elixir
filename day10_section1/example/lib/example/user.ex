#DTOみたいなもの、テーブルのデータ（レコード）をelixirで扱えるようにするためのファイル
#Elixirで使いたい奴だけ
defmodule Example.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :age, :integer
    field :email, :string

    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    #変更したり、変更する箇所決めたりして変更後のcs返す
    |> cast(params, [:first_name, :last_name, :age,  :email])
    #なぜ年齢はチェックしない？->null禁止してないから？
    |> validate_required([:first_name, :last_name])
    #自分で作った関数
    |> validate_email()
    |> validate_last_name()
  end

  defp validate_email(cs) do
    cs
    #null, 空文字チェック
    |> validate_required(:email, message: "Please enter your email")
    #データ登録時にエラー文出す
    |> unique_constraint(:email, message: "already retrieved")
    #呼び出し元の関数実行した時点でエラー文出す
    |> unsafe_validate_unique(:email, Example.Repo, message: "Email has
    already been retrieved.")
    #正規表現使ってフォーマットチェック
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "Must
include the @ symbol, do not include spaces.")
  end

  defp validate_last_name(cs) do
    last_name = get_field(cs, :last_name)

    if last_name in ~w(Sato Suzuki Takasi Tanaka Ito) do
      cs
    else
      add_error(cs, :last_name, "Please use the last name specified.")
    end
  end

  def sample_changeset(user, params \\ %{}) do
    user
    |> cast(params, [:first_name, :last_name, :age])
    #なぜ年齢はチェックしない？->null禁止してないから？
    |> validate_required(:first_name, message: "Please enter your firstname.")
    |> validate_required(:last_name, message: "Please enter your lastname.")
  end


end
