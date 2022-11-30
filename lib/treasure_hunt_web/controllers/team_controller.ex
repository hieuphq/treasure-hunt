defmodule TreasureHuntWeb.TeamController do
  use TreasureHuntWeb, :controller

  alias TreasureHunt.Core
  alias TreasureHunt.Core.Team

  def index(conn, _params) do
    teams = Core.list_teams()
    render(conn, "index.html", teams: teams)
  end

  def new(conn, _params) do
    changeset = Core.change_team(%Team{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"team" => team_params}) do
    case Core.generate_team(team_params) do
      {:ok, team} ->
        conn
        |> put_flash(:info, "Team created successfully.")
        |> redirect(to: Routes.team_path(conn, :show, team))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    team = Core.get_team!(id)
    render(conn, "show.html", team: team)
  end
end
