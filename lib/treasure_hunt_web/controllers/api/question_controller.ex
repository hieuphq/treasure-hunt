defmodule TreasureHuntWeb.Api.QuestionController do
  use TreasureHuntWeb, :controller
  alias TreasureHunt.Question

  action_fallback TreasureHuntWeb.FallbackController

  def show(conn, %{"code" => code}) do
    with questions when is_list(questions) <- Question.get_list_by_code(code) do
      render(conn, "index.json", question: questions)
    else
      errs -> errs
    end
  end
end
