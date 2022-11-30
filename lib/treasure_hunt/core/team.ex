defmodule TreasureHunt.Core.Team do
  use Ecto.Schema
  import Ecto.Changeset
  alias TreasureHunt.Util

  schema "teams" do
    field :name, :string
    field :code, :string

    timestamps()
  end

  @doc false
  def changeset(team, attrs) do
    team
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> update_code()
  end

  def update_code(%{valid?: false} = t), do: t

  def update_code(team) do
    put_change(team, :code, Util.generate_code(6))
  end
end
