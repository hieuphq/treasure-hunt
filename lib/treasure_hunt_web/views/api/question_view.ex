defmodule TreasureHuntWeb.Api.QuestionView do
  use TreasureHuntWeb, :view
  alias TreasureHuntWeb.Api.QuestionView

  def render("index.json", %{question: question}) do
    %{data: render_many(question, QuestionView, "question.json")}
  end

  def render("show.json", %{question: question}) do
    %{data: render_one(question, QuestionView, "question.json")}
  end

  def render("question.json", %{question: question}) do
    %{
      code: question.code,
      content: question.content
    }
  end
end
