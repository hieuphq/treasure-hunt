defmodule TreasureHuntWeb.ApiTeamController do
  use TreasureHuntWeb, :controller
  alias TreasureHunt.Team

  action_fallback TreasureHuntWeb.FallbackController

  def show(conn, %{"id" => team_id}) do
    team = Team.get_by_id(team_id)

    case team do
      %{status: _} ->
        render(conn, "show.json", team: team)

      errs ->
        errs
    end
  end
end
