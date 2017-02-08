defmodule Unafrik.SessionController do
  use Unafrik.Web, :controller

  alias Unafrik.Authenticator

  plug :redirect_if_logged_in when not action in [ :delete ]
  plug :scrub_params, "session" when action in ~w(create)a

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, conn, %{"session" => %{"email" => "", "password" => ""}}) do
    conn
    |> put_flash(:error, "Please fill in an email address and password")
    |> render("new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Authenticator.login(email,  password) do
      { :ok, user } ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_flash(:info, "You are now logged in")
        |> redirect(to: page_path(conn, :index))
      :error ->
        conn
        |> put_flash(:error, "Wrong email or password")
        |> render("new.html")
    end
  end

  def delete(conn, _params) do
    Guardian.Plug.sign_out(conn)
    |> put_flash(:info, "Signed out successfully!")
    |> redirect(to: page_path(conn, :index))
  end

  defp redirect_if_logged_in(conn, _) do
    if(conn.assigns[:current_user]) do
      conn
      |> redirect(to: page_path(conn, :index))
      |> halt
    else
      conn
    end
  end
end
