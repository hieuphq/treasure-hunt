defmodule TreasureHunt.Repo.Migrations.AddMoreQuestionInClue do
  use Ecto.Migration

  def change do
    rename table(:clues), :question_id, to: :question_1_id
    rename table(:clues), :answer, to: :answer_1

    alter table(:clues) do
      add :question_2_id, references(:questions, on_delete: :nothing)
      add :question_3_id, references(:questions, on_delete: :nothing)
      add :answer_2, :text, default: nil
      add :answer_3, :text, default: nil
      modify :code, :string, size: 32, default: fragment("md5((random())::text)")
      add :hashed_code, :string, size: 32
    end
  end
end
