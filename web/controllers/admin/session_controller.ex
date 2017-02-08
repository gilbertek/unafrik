defmodule Unafrik.Admin.SessionController do
  use Unafrik.Web, :controller

  require IEx

  alias Unafrik.User
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
    case Authenticator.admin_login(email,  password) do
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

  def delete(conn, _params, _current_user) do
    IEx.pry
    conn
    |> Guardian.Plug.sign_out(:admin)
    |> put_flash(:info, "admin signed out")
    |> redirect(to: "/")
  end
end
