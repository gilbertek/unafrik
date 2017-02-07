defmodule Unafrik.Authenticator do
  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  alias SimpleAuth.{Repo, User}

  def login(email, password) do
    user = Repo.get_by(User, email: email)

    result = cond do
      user && checkpw(password, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw
        {:error, :not_found, conn}
    end
  end
end
