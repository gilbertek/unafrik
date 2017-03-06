defmodule Unafrik.Message do
  use Unafrik.Web, :model

  schema "messages" do
    field :name, :string
    field :email, :string
    field :company_name, :string
    field :message_body, :string
    field :inquiry_type, InquiryTypeEnum, default: 5

    timestamps()
  end

  @required_fields ~w(name email inquiry_type message_body)a
  @optional_fields ~w(company_name)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
  end
end
