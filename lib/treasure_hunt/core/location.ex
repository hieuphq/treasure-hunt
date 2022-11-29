defmodule TreasureHunt.Core.Location do
  use Ecto.Schema
  import Ecto.Changeset

  schema "locations" do
    field :address, :string
    field :name, :string
    field :plus_code, :string

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :address, :plus_code])
    |> validate_required([:name, :address, :plus_code])
  end
end
