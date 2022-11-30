defmodule TreasureHunt.Question do
  alias TreasureHunt.Core.Question
  alias TreasureHunt.Core

  def get_by_code(code) do
    with question = %Question{} <- Core.get_question_by_code!(code) do
      %{question: question}
    else
      errs -> errs
    end
  end
end
