defmodule Unafrik.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :password_hash, :string
      add :status, :integer, default: 0
      add :name, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
