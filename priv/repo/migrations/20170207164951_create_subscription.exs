defmodule Unafrik.Repo.Migrations.CreateSubscription do
  use Ecto.Migration

  def change do
    create table(:subscriptions) do
      add :name, :string
      add :email, :string
      add :source, :string
      add :status, :integer
      add :disabled_at, :utc_datetime

      timestamps()
    end

    create unique_index(:subscriptions, [:email])
  end
end
