defmodule TreasureHuntWeb.Api.QuestionController do
  use TreasureHuntWeb, :controller
  alias TreasureHunt.Core.Question, as: QuestionModel
  alias TreasureHunt.Question

  action_fallback TreasureHuntWeb.FallbackController

  def show(conn, %{"code" => code}) do
    with question = %QuestionModel{} <- Question.get_by_code(code) do
      render(conn, "show.json", question: question)
    else
      errs -> errs
    end
  end
end
