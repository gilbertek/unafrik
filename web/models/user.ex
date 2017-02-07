defmodule Unafrik.User do
  use Unafrik.Web, :model

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :status, UserStatusEnum, default: 0
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password_hash, :status, :name])
    |> validate_required([:email, :password_hash, :status, :name])
  end
end
