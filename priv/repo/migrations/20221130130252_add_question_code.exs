defmodule TreasureHunt.Repo.Migrations.AddQuestionCode do
  use Ecto.Migration

  def change do
    alter table(:questions) do
      add :code, :string
    end
  end
end
