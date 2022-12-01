defmodule TreasureHunt.Question do
  alias TreasureHunt.Core

  def get_list_by_code(code) do
    with questions when is_list(questions) and questions != [] <-
           Core.get_question_by_hashed_code!(code) do
      questions
    else
      errs -> errs
    end
  end
end
