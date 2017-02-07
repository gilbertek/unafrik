defmodule Unafrik.SessionController do
  use Unafrik.Web, :controller

  alias Unafrik.Authenticator
  plug :scrub_params, "session" when action in ~w(create)a

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email,
                                  "password" => password}}) do

    Authenticator.login(email, password)
  end

  def delete(conn, %{"id" => id}) do
    conn
    |> Guardian.Plug.sign_out
    |> logout
    |> put_flash(:info, "See you later!")
    |> redirect(to: page_path(conn, :index))
  end
end
