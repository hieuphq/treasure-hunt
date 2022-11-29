defmodule TreasureHunt.CoreTest do
  use TreasureHunt.DataCase

  alias TreasureHunt.Core

  describe "teams" do
    alias TreasureHunt.Core.Team

    import TreasureHunt.CoreFixtures

    @invalid_attrs %{name: nil}

    test "list_teams/0 returns all teams" do
      team = team_fixture()
      assert Core.list_teams() == [team]
    end

    test "get_team!/1 returns the team with given id" do
      team = team_fixture()
      assert Core.get_team!(team.id) == team
    end

    test "create_team/1 with valid data creates a team" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Team{} = team} = Core.create_team(valid_attrs)
      assert team.name == "some name"
    end

    test "create_team/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_team(@invalid_attrs)
    end

    test "update_team/2 with valid data updates the team" do
      team = team_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Team{} = team} = Core.update_team(team, update_attrs)
      assert team.name == "some updated name"
    end

    test "update_team/2 with invalid data returns error changeset" do
      team = team_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_team(team, @invalid_attrs)
      assert team == Core.get_team!(team.id)
    end

    test "delete_team/1 deletes the team" do
      team = team_fixture()
      assert {:ok, %Team{}} = Core.delete_team(team)
      assert_raise Ecto.NoResultsError, fn -> Core.get_team!(team.id) end
    end

    test "change_team/1 returns a team changeset" do
      team = team_fixture()
      assert %Ecto.Changeset{} = Core.change_team(team)
    end
  end

  describe "questions" do
    alias TreasureHunt.Core.Question

    import TreasureHunt.CoreFixtures

    @invalid_attrs %{answer: nil, content: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Core.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Core.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{answer: "some answer", content: "some content"}

      assert {:ok, %Question{} = question} = Core.create_question(valid_attrs)
      assert question.answer == "some answer"
      assert question.content == "some content"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{answer: "some updated answer", content: "some updated content"}

      assert {:ok, %Question{} = question} = Core.update_question(question, update_attrs)
      assert question.answer == "some updated answer"
      assert question.content == "some updated content"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_question(question, @invalid_attrs)
      assert question == Core.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Core.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Core.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Core.change_question(question)
    end
  end

  describe "locations" do
    alias TreasureHunt.Core.Location

    import TreasureHunt.CoreFixtures

    @invalid_attrs %{address: nil, name: nil, plus_code: nil}

    test "list_locations/0 returns all locations" do
      location = location_fixture()
      assert Core.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Core.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      valid_attrs = %{address: "some address", name: "some name", plus_code: "some plus_code"}

      assert {:ok, %Location{} = location} = Core.create_location(valid_attrs)
      assert location.address == "some address"
      assert location.name == "some name"
      assert location.plus_code == "some plus_code"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()

      update_attrs = %{
        address: "some updated address",
        name: "some updated name",
        plus_code: "some updated plus_code"
      }

      assert {:ok, %Location{} = location} = Core.update_location(location, update_attrs)
      assert location.address == "some updated address"
      assert location.name == "some updated name"
      assert location.plus_code == "some updated plus_code"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_location(location, @invalid_attrs)
      assert location == Core.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Core.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Core.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Core.change_location(location)
    end
  end
end
