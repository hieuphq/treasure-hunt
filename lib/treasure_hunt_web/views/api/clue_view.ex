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
      question_code: clue.code
    }
  end

  def render("clue-final.json", %{clue: clue}) do
    %{
      id: clue.id,
      location: clue.location.plus_code,
      location_name: clue.location.name,
      location_address: clue.location.address,
      question_1: clue.question_1.content,
      question_2: clue.question_2.content,
      question_3: clue.question_3.content,
      question_code: clue.code,
      question_answer_1: clue.question_1.answer,
      question_answer_2: clue.question_2.answer,
      question_answer_3: clue.question_3.answer,
      answer_1: clue.answer_1,
      answer_2: clue.answer_2,
      answer_3: clue.answer_3,
      question_type: "text"
    }
  end

  def render("submit.json", %{success: success}) do
    %{
      success: success
    }
  end
end
