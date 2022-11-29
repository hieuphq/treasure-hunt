defmodule TreasureHunt.Repo.Migrations.CreateClues do
  use Ecto.Migration

  def change do
    create table(:clues) do
      add :status, :string
      add :sort, :integer
      add :done_at, :naive_datetime
      add :team_id, references(:teams, on_delete: :nothing)
      add :location_id, references(:locations, on_delete: :nothing)
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end

    create index(:clues, [:team_id])
    create index(:clues, [:location_id])
    create index(:clues, [:question_id])
  end
end
