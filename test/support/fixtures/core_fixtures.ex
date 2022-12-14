defmodule TreasureHunt.CoreFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TreasureHunt.Core` context.
  """

  @doc """
  Generate a team.
  """
  def team_fixture(attrs \\ %{}) do
    {:ok, team} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> TreasureHunt.Core.create_team()

    team
  end

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        answer: "some answer",
        content: "some content"
      })
      |> TreasureHunt.Core.create_question()

    question
  end

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        address: "some address",
        name: "some name",
        plus_code: "some plus_code"
      })
      |> TreasureHunt.Core.create_location()

    location
  end

  @doc """
  Generate a clue.
  """
  def clue_fixture(attrs \\ %{}) do
    {:ok, clue} =
      attrs
      |> Enum.into(%{
        done_at: ~N[2022-11-28 09:00:00],
        sort: 42,
        status: "some status"
      })
      |> TreasureHunt.Core.create_clue()

    clue
  end
end
