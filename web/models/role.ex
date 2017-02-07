defmodule Unafrik.Role do
  use Unafrik.Web, :model

  schema "roles" do
    field :name, :string
    field :slug, :string
    field :status, DefaultStatusEnum, default: 0
    field :disabled_at, Ecto.DateTime

    timestamps()
  end

  @required_fields ~w(name)a
  @optional_fields ~w(status)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> slugify_name
    |> validate_required(@required_fields)
  end

  defp slugify_name(changeset) do
    if name = get_change(changeset, :name) do
      put_change(changeset, :slug, Slugger.slugify_downcase(name))
    else
      changeset
    end
  end
end
