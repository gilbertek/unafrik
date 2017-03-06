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

  pipeline :with_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Unafrik.Plug.CurrentUser
  end

  pipeline :required_login do
    plug Guardian.Plug.EnsureAuthenticated,
       handler: Unafrik.GuardianErrorHandler
  end

  pipeline :admin do
    plug :put_layout, {Unafrik.LayoutView, :admin_two}
  end

  scope "/", Unafrik do
    pipe_through [:browser, :with_session] # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create,
                                                   :delete]

    resources "/subscriptions", SubscriptionController, only: [:new, :create]

    get "/contact_us", MessageController, :new
    post "/contact_us", MessageController, :create
  end

  scope "/admin", Unafrik.Admin, as: :admin do
    pipe_through [:browser, :admin, :with_session, :required_login]

    resources "/sessions", SessionController, only: [:new, :create,
                                                   :delete]
    resources "/users", UserController

    get "/", PageController, :index
  end

  # Other scopes may usce custom stacks.
  # scope "/api", Unafrik do
  #   pipe_through :api
  # end
end
