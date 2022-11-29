defmodule TreasureHuntWeb.QuestionController do
  use TreasureHuntWeb, :controller

  alias TreasureHunt.Core
  alias TreasureHunt.Core.Question

  def index(conn, _params) do
    questions = Core.list_questions()
    render(conn, "index.html", questions: questions)
  end

  def new(conn, _params) do
    changeset = Core.change_question(%Question{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"question" => question_params}) do
    case Core.create_question(question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question created successfully.")
        |> redirect(to: Routes.question_path(conn, :show, question))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    question = Core.get_question!(id)
    render(conn, "show.html", question: question)
  end

  def edit(conn, %{"id" => id}) do
    question = Core.get_question!(id)
    changeset = Core.change_question(question)
    render(conn, "edit.html", question: question, changeset: changeset)
  end

  def update(conn, %{"id" => id, "question" => question_params}) do
    question = Core.get_question!(id)

    case Core.update_question(question, question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, "Question updated successfully.")
        |> redirect(to: Routes.question_path(conn, :show, question))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", question: question, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    question = Core.get_question!(id)
    {:ok, _question} = Core.delete_question(question)

    conn
    |> put_flash(:info, "Question deleted successfully.")
    |> redirect(to: Routes.question_path(conn, :index))
  end
end
