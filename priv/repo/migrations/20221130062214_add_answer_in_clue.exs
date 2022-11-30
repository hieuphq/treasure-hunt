defmodule TreasureHunt.Repo.Migrations.AddAnswerInClue do
  use Ecto.Migration

  def change do
    alter table(:clues) do
      add :answer, :text, default: nil
    end

    alter table(:questions) do
      modify :content, :text
      modify :answer, :text
    end
  end
end
