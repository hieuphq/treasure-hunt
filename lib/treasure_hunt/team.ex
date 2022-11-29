defmodule TreasureHunt.Team do
  alias TreasureHunt.Core.Question
  alias TreasureHunt.Core.Clue
  alias TreasureHunt.Core.Team
  alias TreasureHunt.Core

  def get_by_id(id) do
    with %Team{} <- Core.get_team!(id) do
      clues = Core.list_clues_by_team_id(id)

      clues_total = length(clues)

      filtered_clues =
        clues
        |> Enum.filter(fn c = %Clue{} -> c.done_at == nil end)
        |> Enum.sort(&(&1.sort < &2.sort))

      filtered_clues_count = length(filtered_clues)

      status =
        cond do
          filtered_clues_count == 0 ->
            :completed

          filtered_clues_count < clues_total ->
            :playing

          true ->
            :new
        end

      clue = List.first(filtered_clues, nil)

      %{status: status, clue: clue}
    else
      errs -> errs
    end
  end

  def submit_answer(clue_id, answer) do
    with c = %Clue{question: %Question{answer: origin_answer}} <- Core.get_clue!(clue_id),
         {:completed, nil} <- {:completed, c.done_at} do
      if String.downcase(answer) == String.downcase(origin_answer) do
        Core.update_clue(c, %{done_at: DateTime.utc_now()})
        :ok
      else
        {:error, :wrong}
      end
    else
      {:completed, _done_at} ->
        {:error, :question_finished}

      errs ->
        errs
    end
  end
end
