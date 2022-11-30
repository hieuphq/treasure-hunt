defmodule TreasureHuntWeb.Api.TeamController do
  use TreasureHuntWeb, :controller
  alias TreasureHunt.Team

  action_fallback TreasureHuntWeb.FallbackController

  def show(conn, %{"id" => team_code}) do
    team = Team.get_by_code(team_code)

    case team do
      %{status: _} ->
        render(conn, "show.json", team: team)

      errs ->
        errs
    end
  end
end
