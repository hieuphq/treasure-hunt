defmodule TreasureHunt.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :name, :string
      add :address, :string
      add :plus_code, :string

      timestamps()
    end
  end
end
