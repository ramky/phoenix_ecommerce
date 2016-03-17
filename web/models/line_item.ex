defmodule PhoenixEcommerce.LineItem do
  use PhoenixEcommerce.Web, :model

  schema "line_items" do
    field :quantity, :integer
    belongs_to :product, PhoenixEcommerce.Product

    timestamps
  end

  @required_fields ~w(quantity product_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
