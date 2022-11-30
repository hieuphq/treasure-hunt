defmodule TreasureHuntWeb.Api.TeamView do
  use TreasureHuntWeb, :view
  alias TreasureHuntWeb.Api.TeamView
  alias TreasureHuntWeb.Api.ClueView

  def render("index.json", %{team: team}) do
    %{data: render_many(team, TeamView, "team.json")}
  end

  def render("show.json", %{team: team}) do
    %{data: render_one(team, TeamView, "team.json")}
  end

  def render("team.json", %{team: team = %{clue: clue, finished: finished_clues}}) do
    %{
      clue: render_one(clue, ClueView, "clue.json"),
      finished: render_many(finished_clues, ClueView, "clue.json"),
      status: team.status
    }
  end
end
