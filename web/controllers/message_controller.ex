defmodule Unafrik.MessageController do
  use Unafrik.Web, :controller

  alias Unafrik.Message

  def new(conn, _params) do
    changeset = Message.changeset(%Message{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"message" => message_params}) do
    message_params = valide_inquiry_param(message_params)
    changeset = Message.changeset(%Message{}, message_params)

    case Repo.insert(changeset) do
      {:ok, _message} ->
        conn
        |> put_flash(:info, "Message created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp valide_inquiry_param(params) do
    case {:ok, Map.get(params, "inquiry_type", "")} do
      {:ok, type} ->
        params = Map.put(params, "inquiry_type", String.to_integer(type))
      {:ok, ""} -> params
    end
  end
end
