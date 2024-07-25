defmodule HouseholdAccountBookApp.Purchases do
  @moduledoc """
  The Purchases context.
  """

  import Ecto.Query, warn: false
  alias HouseholdAccountBookApp.Repo

  alias HouseholdAccountBookApp.Purchases.Category
  alias HouseholdAccountBookApp.Purchases.Purchase

  #[{"水道光熱費", 1},   ]
  def list_categories_with_ids() do
    Category
    |> select([c], {c.category_name, c.id})
    |> Repo.all()
  end

  @doc """
  Returns the list of purchases.

  ## Examples

      iex> list_purchases()
      [%Purchase{}, ...]

  """
  def list_purchases do
    Repo.all(Purchase)
  end

  @doc """
  Gets a single purchase.

  Raises `Ecto.NoResultsError` if the Purchase does not exist.

  ## Examples

      iex> get_purchase!(123)
      %Purchase{}

      iex> get_purchase!(456)
      ** (Ecto.NoResultsError)

  """
  def get_purchase!(id), do: Repo.get!(Purchase, id)

  def get_money_by_categories(%Date{year: year, month: month}) do
    start_date = Date.new!(year, month, 1) # => %Date{year: 2024, month: 7, day:1}
    end_date = Date.end_of_month(start_date)

   # income =
      Purchase
      |> join(:inner, [p], c in assoc(p, :category))
      |> where([p], p.date >= ^start_date and p.date <= ^end_date)
      |> group_by([p, c], c.id)
      |> select([p, c], {c, sum(p.money)}) # p.moneyは　金額をとってきてる（そしてsum関数を使う）
      |> Repo.all()



  end

  #月でとってる
  def get_money_by_date(%Date{year: year, month: month}) do
    start_date = Date.new!(year, month, 1) # => %Date{year: 2024, month: 7, day:1}
    end_date = Date.end_of_month(start_date)

    money_by_date =
      Purchase
      |> where([p], p.date >= ^start_date and p.date <= ^end_date)
      |> group_by([p], p.date)
      |> select([p], {p.date, sum(p.money)}) # p.moneyは　金額をとってきてる（そしてsum関数を使う）
      |> Repo.all()

      start_date
      |> Date.range(end_date) #start_date end_dateの間の「範囲」ができる
      |> Enum.map(fn date ->
        #pattern match
        {_purchase_date, money} =
        Enum.find(money_by_date, {nil, 0}, fn {purchase_date, _money} -> #{仮引数、仮引数}
        purchase_date == date #ここが一致していれば0円ではないのでm_b_dから直でとってこれる
      end)
      {date, money}
  end)
end


  @doc """
  Creates a purchase.

  ## Examples

      iex> create_purchase(%{field: value})
      {:ok, %Purchase{}}

      iex> create_purchase(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_purchase(attrs \\ %{}) do
    %Purchase{}
    |> Purchase.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a purchase.

  ## Examples

      iex> update_purchase(purchase, %{field: new_value})
      {:ok, %Purchase{}}

      iex> update_purchase(purchase, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_purchase(%Purchase{} = purchase, attrs) do
    purchase
    |> Purchase.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a purchase.

  ## Examples

      iex> delete_purchase(purchase)
      {:ok, %Purchase{}}

      iex> delete_purchase(purchase)
      {:error, %Ecto.Changeset{}}

  """
  def delete_purchase(%Purchase{} = purchase) do
    Repo.delete(purchase)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking purchase changes.

  ## Examples

      iex> change_purchase(purchase)
      %Ecto.Changeset{data: %Purchase{}}

  """
  def change_purchase(%Purchase{} = purchase, attrs \\ %{}) do
    Purchase.changeset(purchase, attrs)
  end
end
