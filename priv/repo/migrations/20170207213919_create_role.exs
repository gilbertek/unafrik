defmodule Unafrik.Repo.Migrations.CreateRole do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :slug, :string
      add :status, :integer
      add :disabled_at, :utc_datetime

      timestamps()
    end

    create unique_index(:roles, [:slug, :name])
  end
end
