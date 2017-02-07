defmodule Unafrik.User do
  use Unafrik.Web, :model

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :status, UserStatusEnum, default: 0

    timestamps()
  end

  @required_fields ~w(email password name)a
  @optional_fields ~w(status)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 5)
    |> hash_password
  end

  def registration_changeset(struct, params) do
    struct
    |> changeset(params)
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_length(:password, min: 6, max: 100)
  end

  def update_changeset(user, attributes) do
    user
    |> cast(attributes, @required_fields)
    |> validate_required([:name, :email])
    |> unique_constraint(:email)
  end

  defp hash_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true,
                      changes: %{password: password}} ->
        put_change(changeset,
                   :password_hash,
                   Comeonin.Bcrypt.hashpwsalt(password))
      _ ->
        changeset
    end
  end
end
