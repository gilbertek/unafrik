defmodule Unafrik.Subscription do
  use Unafrik.Web, :model

  schema "subscriptions" do
    field :name, :string
    field :email, :string
    field :source, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :source])
    |> validate_required([:name, :email, :source])
  end
end
