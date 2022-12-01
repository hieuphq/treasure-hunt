defmodule TreasureHunt.Team do
  alias TreasureHunt.Core.Question
  alias TreasureHunt.Core.Clue
  alias TreasureHunt.Core.Team
  alias TreasureHunt.Core

  def get_by_code(code) do
    with %Team{id: team_id} <- Core.get_team_by_code(code) do
      clues = Core.list_clues_by_team_id(team_id)

      clues_total = length(clues)

      finished_clues =
        clues
        |> Enum.filter(fn c = %Clue{} -> c.done_at != nil end)
        |> Enum.sort(&(&1.sort < &2.sort))

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

      %{status: status, clue: clue, finished: finished_clues}
    else
      errs -> errs
    end
  end

  def submit_answers(clue_id, answers) do
    with c = %Clue{
           question_1: %Question{answer: origin_answer_1},
           question_2: %Question{answer: origin_answer_2},
           question_3: %Question{answer: origin_answer_3}
         } <- Core.get_clue!(clue_id),
         {:completed, nil} <- {:completed, c.done_at} do
      origin_answers = [origin_answer_1, origin_answer_2, origin_answer_3]
      len = length(origin_answers)

      %{rs: answer_origins} =
        Enum.reduce(1..len, %{answers: answers, origin_answers: origin_answers, rs: []}, fn _,
                                                                                            %{
                                                                                              answers:
                                                                                                [
                                                                                                  a
                                                                                                  | remain_answers
                                                                                                ],
                                                                                              origin_answers:
                                                                                                [
                                                                                                  o
                                                                                                  | remain_origins
                                                                                                ],
                                                                                              rs:
                                                                                                rs
                                                                                            } ->
          %{answers: remain_answers, origin_answers: remain_origins, rs: [{a, o} | rs]}
        end)

      IO.inspect(answer_origins)

      final_answer_rs =
        Enum.map(answer_origins, fn {a, o} ->
          if is_nil(a) || a == "" do
            false
          else
            distance = String.jaro_distance(String.downcase(o), String.downcase(a))
            distance2 = FuzzyCompare.similarity(String.downcase(o), String.downcase(a))
            final = (distance + distance2) / 2
            final >= 0.8
          end
        end)
        |> Enum.all?()

      if final_answer_rs == true do
        raw = %{done_at: DateTime.utc_now()}

        raw =
          Enum.with_index(answers, 1)
          |> Enum.reduce(raw, fn {a, idx}, acc ->
            Map.put(acc, String.to_atom("answer_#{idx}"), a)
          end)

        Core.update_clue(c, raw)
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
