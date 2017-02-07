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

  pipeline :with_session do
    plug Guardian.Plug.EnsureAuthenticated,
       handler: Unafrik.GuardianErrorHandler
  end

  pipeline :admin do
    plug :put_layout, {Unafrik.LayoutView, :admin}
  end

  scope "/", Unafrik do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController, only: [:show, :new, :create]
    resources "/sessions", SessionController, only: [:new, :create,
                                                   :delete]

    resources "/subscriptions", SubscriptionController, only: [:new, :create]
  end

  scope "/admin", Unafrik.Admin do
    pipe_through [:browser, :admin, :with_session]

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Unafrik do
  #   pipe_through :api
  # end
end
