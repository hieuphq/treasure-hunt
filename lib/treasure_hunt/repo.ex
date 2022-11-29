defmodule TreasureHunt.Repo do
  use Ecto.Repo,
    otp_app: :treasure_hunt,
    adapter: Ecto.Adapters.Postgres
end
