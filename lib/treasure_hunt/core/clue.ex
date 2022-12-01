defmodule TreasureHunt.Core.Clue do
  alias TreasureHunt.Core.Question
  alias TreasureHunt.Core.Team
  alias TreasureHunt.Core.Location
  use Ecto.Schema
  import Ecto.Changeset

  schema "clues" do
    field :done_at, :naive_datetime
    field :sort, :integer
    field :status, :string
    field :answer_1, :string
    field :answer_2, :string
    field :answer_3, :string
    field :code, :string
    field :hashed_code, :string

    belongs_to :location, Location
    belongs_to :team, Team
    belongs_to :question_1, Question
    belongs_to :question_2, Question
    belongs_to :question_3, Question

    timestamps()
  end

  @doc false
  def changeset(clue, attrs) do
    clue
    |> cast(attrs, [:status, :sort, :done_at, :answer_1, :answer_2, :answer_3])
    |> validate_required([:status, :sort, :done_at])
  end
end
