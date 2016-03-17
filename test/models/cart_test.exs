defmodule PhoenixEcommerce.CartTest do
  use PhoenixEcommerce.ModelCase

  alias PhoenixEcommerce.Cart

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Cart.changeset(%Cart{}, @valid_attrs)
    assert changeset.valid?
  end
end
