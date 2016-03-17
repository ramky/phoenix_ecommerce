defmodule PhoenixEcommerce.LineItemTest do
  use PhoenixEcommerce.ModelCase

  alias PhoenixEcommerce.LineItem
  alias PhoenixEcommerce.Product

  @product Product.changeset(%Product{}, %{
    name: "foo",
    price: Decimal.new("20.00"),
    description: "some foo"
  }) |> Repo.insert!

  @valid_attrs %{quantity: 42, product_id: @product.id}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LineItem.changeset(%LineItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LineItem.changeset(%LineItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
