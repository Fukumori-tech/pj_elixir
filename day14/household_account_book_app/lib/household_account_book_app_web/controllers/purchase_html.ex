defmodule HouseholdAccountBookAppWeb.PurchaseHTML do
  use HouseholdAccountBookAppWeb, :html
#controlerのテンプレートがこの中に入っている
  embed_templates "purchase_html/*"

  @doc """
  Renders a purchase form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true
  attr :categories, :any, required: true
  def purchase_form(assigns)
end
