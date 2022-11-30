defmodule TreasureHuntWeb.Api.QuestionController do
  use TreasureHuntWeb, :controller
  alias TreasureHunt.Question

  action_fallback TreasureHuntWeb.FallbackController

  def show(conn, %{"code" => code}) do
    question = Question.get_by_code(code)
    render(conn, "show.json", question: question.question)
  end
end
