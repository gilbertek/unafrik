defmodule Unafrik.Plug.AuthAdmin do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts \\ []) do
    opts
  end

  def call(conn, _default) do
    # admin?(conn, conn.assigns[:current_user])
  end

  # defp admin?(conn, %Unafrik.User{admin: false}), do: forbidden(conn)
  #
  # defp admin?(conn, %Unafrik.User{admin: true}), do: conn
  #
  # defp admin?(conn, _), do: forbidden(conn)

  defp forbidden(conn) do
    conn
      |> put_status(403)
      |> render(Unafrik.ErrorView, "403.html")
      |> halt
  end
end
