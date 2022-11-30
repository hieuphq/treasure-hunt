defmodule TreasureHunt.Repo.Migrations.UpdatePrimaryKey do
  use Ecto.Migration

  def change do
    alter table(:teams) do
      add :code, :string, size: 32
    end

    create unique_index(:teams, [:code])
  end
end
