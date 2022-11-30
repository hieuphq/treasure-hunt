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
    field :answer, :string
    field :code, :string

    belongs_to :location, Location
    belongs_to :team, Team
    belongs_to :question, Question

    timestamps()
  end

  @doc false
  def changeset(clue, attrs) do
    clue
    |> cast(attrs, [:status, :sort, :done_at, :answer])
    |> validate_required([:status, :sort, :done_at])
  end
end
