defmodule TreasureHunt.Core do
  @moduledoc """
  The Core context.
  """

  import Ecto.Query, warn: false
  alias TreasureHunt.Util
  alias TreasureHunt.Repo
  alias TreasureHunt.Core.Team
  alias TreasureHunt.Core.Clue

  @doc """
  Returns the list of teams.

  ## Examples

      iex> list_teams()
      [%Team{}, ...]

  """
  def list_teams do
    Repo.all(Team)
  end

  @doc """
  Gets a single team.

  Raises `Ecto.NoResultsError` if the Team does not exist.

  ## Examples

      iex> get_team!(123)
      %Team{}

      iex> get_team!(456)
      ** (Ecto.NoResultsError)

  """
  def get_team!(id), do: Repo.get!(Team, id)

  def get_team_by_code(id), do: Repo.get_by(Team, code: id)

  @doc """
  Creates a team.

  ## Examples

      iex> create_team(%{field: value})
      {:ok, %Team{}}

      iex> create_team(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_team(attrs \\ %{}) do
    %Team{}
    |> Team.changeset(attrs)
    |> Repo.insert()
  end

  def generate_team(attrs \\ %{}) do
    rs =
      %Team{}
      |> Team.changeset(attrs)
      |> Repo.insert()

    case rs do
      {:ok, team} ->
        generate_clue(team.id, team.code)
    end

    rs
  end

  defp generate_clue(team_id, team_code) do
    locations = list_locations()
    questions = list_questions()

    intitial_data = %{locations: locations, questions: questions, result: []}

    pre_data =
      Enum.reduce(1..4, intitial_data, fn idx, %{locations: locs, questions: ques, result: rs} ->
        random_loc = Enum.random(locs)

        filtered_locs =
          if length(locs) <= 1 do
            locs
          else
            Enum.filter(locs, fn l -> l.id != random_loc.id end)
          end

        random_question = Enum.random(ques)

        filtered_ques =
          if length(ques) <= 1 do
            ques
          else
            Enum.filter(ques, fn l -> l.id != random_question.id end)
          end

        raw_code = "#{random_question.code}#{team_code}"
        hashed_code = :crypto.hash(:md5, raw_code) |> Base.encode16(case: :lower)

        raw = %{
          location_id: random_loc.id,
          question_id: random_question.id,
          sort: idx,
          code: hashed_code
        }

        %{
          locations: filtered_locs,
          questions: filtered_ques,
          result: [raw | rs]
        }
      end)

    Enum.map(pre_data.result, fn %{
                                   location_id: location_id,
                                   question_id: question_id,
                                   sort: sort,
                                   code: code
                                 } ->
      %TreasureHunt.Core.Clue{
        location_id: location_id,
        question_id: question_id,
        team_id: team_id,
        done_at: nil,
        sort: sort,
        status: "new",
        code: code
      }
      |> TreasureHunt.Repo.insert!()
    end)
  end

  @doc """
  Updates a team.

  ## Examples

      iex> update_team(team, %{field: new_value})
      {:ok, %Team{}}

      iex> update_team(team, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_team(%Team{} = team, attrs) do
    team
    |> Team.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a team.

  ## Examples

      iex> delete_team(team)
      {:ok, %Team{}}

      iex> delete_team(team)
      {:error, %Ecto.Changeset{}}

  """
  def delete_team(%Team{} = team) do
    Repo.delete(team)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking team changes.

  ## Examples

      iex> change_team(team)
      %Ecto.Changeset{data: %Team{}}

  """
  def change_team(%Team{} = team, attrs \\ %{}) do
    Team.changeset(team, attrs)
  end

  alias TreasureHunt.Core.Question

  @doc """
  Returns the list of questions.

  ## Examples

      iex> list_questions()
      [%Question{}, ...]

  """
  def list_questions do
    Repo.all(Question)
  end

  @doc """
  Gets a single question.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question!(123)
      %Question{}

      iex> get_question!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question!(id), do: Repo.get!(Question, id)

  @doc """
  Gets a single question by code.

  Raises `Ecto.NoResultsError` if the Question does not exist.

  ## Examples

      iex> get_question_by_code!(123)
      %Question{}

      iex> get_question_by_code!(456)
      ** (Ecto.NoResultsError)

  """
  def get_question_by_hashed_code!(code) do
    Repo.get_by(Clue, code: code)
    |> case do
      nil ->
        {:error, :not_found}

      %Clue{question_id: question_id} ->
        Repo.get!(Question, question_id)
    end
  end

  @doc """
  Creates a question.

  ## Examples

      iex> create_question(%{field: value})
      {:ok, %Question{}}

      iex> create_question(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a question.

  ## Examples

      iex> update_question(question, %{field: new_value})
      {:ok, %Question{}}

      iex> update_question(question, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a question.

  ## Examples

      iex> delete_question(question)
      {:ok, %Question{}}

      iex> delete_question(question)
      {:error, %Ecto.Changeset{}}

  """
  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking question changes.

  ## Examples

      iex> change_question(question)
      %Ecto.Changeset{data: %Question{}}

  """
  def change_question(%Question{} = question, attrs \\ %{}) do
    Question.changeset(question, attrs)
  end

  alias TreasureHunt.Core.Location

  @doc """
  Returns the list of locations.

  ## Examples

      iex> list_locations()
      [%Location{}, ...]

  """
  def list_locations do
    Repo.all(Location)
  end

  @doc """
  Gets a single location.

  Raises `Ecto.NoResultsError` if the Location does not exist.

  ## Examples

      iex> get_location!(123)
      %Location{}

      iex> get_location!(456)
      ** (Ecto.NoResultsError)

  """
  def get_location!(id), do: Repo.get!(Location, id)

  @doc """
  Creates a location.

  ## Examples

      iex> create_location(%{field: value})
      {:ok, %Location{}}

      iex> create_location(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_location(attrs \\ %{}) do
    %Location{}
    |> Location.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a location.

  ## Examples

      iex> update_location(location, %{field: new_value})
      {:ok, %Location{}}

      iex> update_location(location, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_location(%Location{} = location, attrs) do
    location
    |> Location.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a location.

  ## Examples

      iex> delete_location(location)
      {:ok, %Location{}}

      iex> delete_location(location)
      {:error, %Ecto.Changeset{}}

  """
  def delete_location(%Location{} = location) do
    query =
      from c in Clue,
        where: c.location_id == ^location.id

    Repo.delete_all(query)

    Repo.delete(location)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking location changes.

  ## Examples

      iex> change_location(location)
      %Ecto.Changeset{data: %Location{}}

  """
  def change_location(%Location{} = location, attrs \\ %{}) do
    Location.changeset(location, attrs)
  end

  @doc """
  Returns the list of clues.

  ## Examples

      iex> list_clues()
      [%Clue{}, ...]

  """
  def list_clues do
    Repo.all(Clue)
  end

  def list_clues_by_team_id(team_id) do
    query =
      from c in Clue,
        where: c.team_id == ^team_id,
        preload: [:question, :location]

    Repo.all(query)
  end

  @doc """
  Gets a single clue.

  Raises `Ecto.NoResultsError` if the Clue does not exist.

  ## Examples

      iex> get_clue!(123)
      %Clue{}

      iex> get_clue!(456)
      ** (Ecto.NoResultsError)

  """
  def get_clue!(id) do
    Repo.get!(Clue, id)
    |> Repo.preload([:question, :location])
  end

  @doc """
  Creates a clue.

  ## Examples

      iex> create_clue(%{field: value})
      {:ok, %Clue{}}

      iex> create_clue(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_clue(attrs \\ %{}) do
    %Clue{}
    |> Clue.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a clue.

  ## Examples

      iex> update_clue(clue, %{field: new_value})
      {:ok, %Clue{}}

      iex> update_clue(clue, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_clue(%Clue{} = clue, attrs) do
    clue
    |> Clue.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a clue.

  ## Examples

      iex> delete_clue(clue)
      {:ok, %Clue{}}

      iex> delete_clue(clue)
      {:error, %Ecto.Changeset{}}

  """
  def delete_clue(%Clue{} = clue) do
    Repo.delete(clue)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking clue changes.

  ## Examples

      iex> change_clue(clue)
      %Ecto.Changeset{data: %Clue{}}

  """
  def change_clue(%Clue{} = clue, attrs \\ %{}) do
    Clue.changeset(clue, attrs)
  end
end
