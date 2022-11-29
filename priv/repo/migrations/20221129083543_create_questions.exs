defmodule TreasureHunt.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :content, :string
      add :answer, :string

      timestamps()
    end
  end
end
