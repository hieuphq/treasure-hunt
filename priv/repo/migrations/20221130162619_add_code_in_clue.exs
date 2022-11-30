defmodule TreasureHunt.Repo.Migrations.AddCodeInClue do
  use Ecto.Migration

  def change do
    alter table(:clues) do
      add :code, :string, size: 32
    end

    alter table(:questions) do
      modify :code, :string, size: 32, default: fragment("md5((random())::text)")
    end
  end
end
