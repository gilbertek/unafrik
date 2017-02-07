defmodule Unafrik.SessionController do
  use Unafrik.Web, :controller

  alias Unafrik.Session

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => session_params}) do
    changeset = Session.changeset(%Session{}, session_params)

    case Repo.insert(changeset) do
      {:ok, _session} ->
        conn
        |> put_flash(:info, "Session created successfully.")
        |> redirect(to: session_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    session = Repo.get!(Session, id)
    changeset = Session.changeset(session)
    render(conn, "edit.html", session: session, changeset: changeset)
  end

  def delete(conn, %{"id" => id}) do
    session = Repo.get!(Session, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(session)

    conn
    |> put_flash(:info, "Session deleted successfully.")
    |> redirect(to: session_path(conn, :index))
  end
end
