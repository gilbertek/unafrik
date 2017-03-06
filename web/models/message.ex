defmodule Unafrik.Message do
  use Unafrik.Web, :model

  schema "messages" do
    field :name, :string
    field :email, :string
    field :company_name, :string
    field :message_body, :string
    field :inquiry_type, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :email, :company_name, :message_body, :inquiry_type])
    |> validate_required([:name, :email, :company_name, :message_body, :inquiry_type])
  end
end
