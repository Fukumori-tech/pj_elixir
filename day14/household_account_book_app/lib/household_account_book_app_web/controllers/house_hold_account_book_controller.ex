defmodule HouseholdAccountBookAppWeb.HouseHoldAccountBookController do
  use HouseholdAccountBookAppWeb, :controller
  alias HouseholdAccountBookApp.Purchases
  alias HouseholdAccountBookApp.Incomes

  def summary(conn, %{"date" => date}) do
    #params = %{"date" -> "2024-03"}
    #date = "2024-03" => %Date{year: 2024, month: 3, day:1}
    #date = Date.utc_today()
      #IO.inspect(params) #urlの？の後ろ、map型でパラメーターが送られる

    [year, month] =
      date
      |> String.split("-") #{"2024", "03"}
      |> Enum.map(& String.to_integer/1) #[2024, 3]

      date = Date.new!(year, month, 1)
    sum_incomes = Incomes.sum_incomes_by_month(date)
    money_by_categories = date |> Purchases.get_money_by_categories() |> set_balance(sum_incomes)

    #どの情報を渡すかという情報を渡す、テンプレート名summary
    render(
      conn,
      :summary,
      money_by_categories: money_by_categories,
      date: date,
      pie_chart_data: create_pie_chart_data(money_by_categories),
      bar_chart_data: create_bar_chart_data(date)
      )
  end

 # @specsummary(PlugConn.t(),any())::Plug.Conn.t()
  def summary(conn, _params) do
    date = Date.utc_today()

    sum_incomes = Incomes.sum_incomes_by_month(date)
    money_by_categories = date |> Purchases.get_money_by_categories() |> set_balance(sum_incomes)

    #どの情報を渡すかという情報を渡す、テンプレート名summary
    render(
      conn,
      :summary,
      money_by_categories: money_by_categories,
      date: date,
      pie_chart_data: create_pie_chart_data(money_by_categories),
      bar_chart_data: create_bar_chart_data(date)
      )
  end

  defp set_balance(money_by_categories, sum_incomes) do
    sum_puerchases = money_by_categories |> Enum.map(fn {_category, money} -> money end)
    |> Enum.sum()

    balance =
      then(sum_incomes - sum_puerchases, fn balance -> if balance > 0, do: balance, else: 0 end)
    List.insert_at(money_by_categories, -1, {%{category_name: "残高", color_code: "#d3d3d3"}, balance})
  end

  defp create_pie_chart_data(money_by_categories) do
    categories = Enum.map(money_by_categories, fn{category, _money} -> category.category_name end)
    color_code = Enum.map(money_by_categories, fn{category, _money} -> category.color_code end)
    money = Enum.map(money_by_categories, fn{_category, money} -> money end)
    Jason.encode!(%{categories: categories, color_code: color_code, money: money})
  end

  defp create_bar_chart_data(data) do
    money_by_date = Purchases.get_money_by_date(data)
    date = Enum.map(money_by_date, fn{date, _money} -> date end)
    money = Enum.map(money_by_date, fn{_date, money} -> money end)
    Jason.encode!(%{date: date, money: money})
  end
end
