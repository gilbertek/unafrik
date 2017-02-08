defmodule Unafrik.Authenticator do
  alias Unafrik.{Repo, User}

  def login(email, password) do
    user = Repo.get_by(User, email: String.downcase(email))
    case authenticate(user, password) do
      true -> { :ok, user }
      _    -> :error
    end
  end

  def current_user(conn) do
    id = Plug.Conn.get_session(conn, :current_user)
    if id, do: Unafrik.Repo.get(User, id)
  end

  defp authenticate(user, password) do
    case user do
      nil -> false
      _   -> Comeonin.Bcrypt.checkpw(password, user.password_hash)
    end
  end
end
