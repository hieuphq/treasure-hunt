defmodule TreasureHunt.Core.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :answer, :string
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:content, :answer])
    |> validate_required([:content, :answer])
  end
end
