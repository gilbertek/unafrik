defmodule Unafrik.Router do
  use Unafrik.Web, :router

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

  pipeline :admin do
    plug :put_layout, {Unafrik.LayoutView, :admin}
  end

  scope "/", Unafrik do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/subscriptions", SubscriptionController, only: [:new]
  end

  scope "/admin", Unafrik.Admin do
    pipe_through [:browser, :admin]

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Unafrik do
  #   pipe_through :api
  # end
end
