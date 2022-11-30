defmodule TreasureHuntWeb.Api.ClueView do
  use TreasureHuntWeb, :view
  alias TreasureHuntWeb.Api.ClueView

  def render("index.json", %{clue: clue}) do
    %{data: render_many(clue, ClueView, "clue.json")}
  end

  def render("show.json", %{clue: clue}) do
    %{data: render_one(clue, ClueView, "clue.json")}
  end

  def render("clue.json", %{clue: clue}) do
    %{
      id: clue.id,
      location: clue.location.plus_code,
      location_name: clue.location.name,
      location_address: clue.location.address,
      question: clue.question.content,
      question_type: "text"
    }
  end

  def render("clue-final.json", %{clue: clue}) do
    %{
      id: clue.id,
      location: clue.location.plus_code,
      location_name: clue.location.name,
      location_address: clue.location.address,
      question: clue.question.content,
      question_answer: clue.question.answer,
      answer: clue.answer,
      question_type: "text"
    }
  end

  def render("submit.json", %{success: success}) do
    %{
      success: success
    }
  end
end
