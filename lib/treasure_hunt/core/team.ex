defmodule TreasureHunt.Core.Team do
  use Ecto.Schema
  import Ecto.Changeset

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

  @alphabet "123456789abcdefghjkmnpqrstuvwxyzABCDEFGHJKMNPQRSTUVWXYZ"
  def update_code(team) do
    put_change(team, :code, Nanoid.generate(6, @alphabet))
  end
end
