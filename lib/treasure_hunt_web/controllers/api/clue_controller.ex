defmodule TreasureHuntWeb.Api.ClueController do
  use TreasureHuntWeb, :controller
  alias TreasureHunt.Team

  action_fallback TreasureHuntWeb.FallbackController

  def answer(conn, %{"clue_id" => clue_id, "answers" => answers}) do
    result = Team.submit_answers(clue_id, answers)

    case result do
      :ok ->
        render(conn, "submit.json", success: true)

      errs ->
        IO.inspect(errs)
        render(conn, "submit.json", success: false)
    end
  end
end
