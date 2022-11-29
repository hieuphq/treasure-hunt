defmodule TreasureHuntWeb.Api.ClueController do
  use TreasureHuntWeb, :controller
  alias TreasureHunt.Team

  action_fallback TreasureHuntWeb.FallbackController

  def answer(conn, %{"clue_id" => clue_id, "answer" => answer}) do
    result = Team.submit_answer(clue_id, answer)

    case result do
      :ok ->
        render(conn, "submit.json", success: true)

      errs ->
        IO.inspect(errs)
        render(conn, "submit.json", success: false)
    end
  end
end
