defmodule PhoenixEcommerce.Acceptance.CartTest do
  use ExUnit.Case
  use Hound.Helpers
  hound_session

  alias PhoenixEcommerce.Product
  alias PhoenixEcommerce.LineItem
  alias PhoenixEcommerce.Repo

  @upload %Plug.Upload{ path: Path.relative_to_cwd("test/files/elixir.png"), filename: "elixir.png", content_type: "image/png" }

  setup do
    Repo.delete_all(LineItem)
    Repo.delete_all(Product)
    {:ok, product} =
      Product.changeset(%Product{}, %{
        name: "Some product",
        description: "A very long description for my product",
        price: Decimal.new("25.20"),
        image: @upload
      }) |> Repo.insert

    {:ok, product: product}
  end

  test "/products has a list or products" do
    navigate_to "/products"
    assert find_element(:css, "ul.products")
  end

  test "/products - product details include name, description, price and image", %{product: product} do

    navigate_to "/products"
    product_li  = find_element(:css, "ul.products li")
    name        = find_within_element(product_li, :css, "header")
    price       = find_within_element(product_li, :css, "h4")
    description = find_within_element(product_li, :css, "p")
    image       = find_within_element(product_li, :css, "img")

    assert visible_text(name)        == product.name
    assert visible_text(price)       == "$#{product.price}"
    assert visible_text(description) == product.description
    assert attribute_value(image, "src") =~  ~r/amazon/
  end

  test "/products - click a product to view its details", %{product: product} do
    navigate_to "/products"
    product_li = find_element(:css, "ul.products li")
    link       = find_within_element(product_li, :css, "a")
    click(link)
    assert "/products/#{product.id}" == current_path
  end

  test "/cart shows an empty cart" do
    navigate_to "/cart"

    assert visible_text(heading) == "Your cart"
    assert length(line_items)    == 0
  end

  test "adding product to cart shows product in cart", %{product: product} do
    navigate_to "/products/#{product.id}"
    click(add_to_cart_button)

    navigate_to "/cart"

    assert length(line_items) == 1
    assert visible_text(hd(line_items)) =~ ~r/#{product.name}/
  end

  test "different sessions should have different carts", %{product: product} do
    navigate_to "/products/#{product.id}"
    click(add_to_cart_button)
    assert length(line_items) == 1
    change_session_to("second user")

    navigate_to "/cart"

    assert length(line_items) == 0
  end

  def heading, do: find_element(:css, "h2")
  def cart, do: find_element(:css, ".cart")
  def cart_table, do: find_within_element(cart, :css, "table")
  def cart_tbody, do: find_within_element(cart_table, :css, "tbody")
  def line_items, do: find_all_within_element(cart_tbody, :css, "tr")
  def add_to_cart_button, do: find_element(:css, "input[type=submit].add-to-cart")
end
