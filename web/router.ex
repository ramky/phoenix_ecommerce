defmodule PhoenixEcommerce.Router do
  use PhoenixEcommerce.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixEcommerce do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/products", ProductController
    get "/cart", CartController, :show
    post "/cart/add", CartController, :add, as: :add_to_cart
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixEcommerce do
  #   pipe_through :api
  # end
end
