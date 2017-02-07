defmodule Unafrik.Subscription do
  use Unafrik.Web, :model

  schema "subscriptions" do
    field :name, :string
    field :email, :string
    field :source, :string
    field :status, SubscriptionStatusEnum, default: 0
    field :disabled_at, Ecto.DateTime

    timestamps()
  end

  @required_fields ~w(name email)a
  @optional_fields ~w(source)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 1)
    |> validate_format(:name, ~r/\S+/)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end
end
