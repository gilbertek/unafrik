defmodule Unafrik.Repo.Migrations.CreateMessage do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :name, :string
      add :email, :string
      add :company_name, :string
      add :message_body, :text
      add :inquiry_type, :integer

      timestamps()
    end

  end
end
