defmodule Unafrik.SubscriptionController do
  use Unafrik.Web, :controller

  alias Unafrik.Subscription

  def new(conn, _params) do
    changeset = Subscription.changeset(%Subscription{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"subscription" => subscription_params}) do
    changeset = Subscription.changeset(%Subscription{}, subscription_params)

    case Repo.insert(changeset) do
      {:ok, _subscription} ->
        conn
        |> put_flash(:info, "Subscription created successfully.")
        |> redirect(to: page_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    subscription = Repo.get!(Subscription, id)
    render(conn, "show.html", subscription: subscription)
  end

  def delete(conn, %{"id" => id}) do
    subscription = Repo.get!(Subscription, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(subscription)

    conn
    |> put_flash(:info, "Subscription deleted successfully.")
    |> redirect(to: subscription_path(conn, :index))
  end
end
