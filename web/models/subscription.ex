defmodule Unafrik.Subscription do
  use Unafrik.Web, :model

  schema "subscriptions" do
    field :name, :string
    field :email, :string
    field :source, :string

    timestamps()
  end

  @required_fields ~w(name email)
  @optional_fields ~w(source)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [@required_fields ++ @optional_fields])
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 1)
    |> validate_format(:name, ~r/\S+/)
    |> unique_constraint(:email)
  end
end
