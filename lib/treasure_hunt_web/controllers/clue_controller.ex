defmodule TreasureHuntWeb.ClueController do
  use TreasureHuntWeb, :controller

  alias TreasureHunt.Core
  alias TreasureHunt.Core.Clue

  def index(conn, _params) do
    clues = Core.list_clues()
    render(conn, "index.html", clues: clues)
  end

  def new(conn, _params) do
    changeset = Core.change_clue(%Clue{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"clue" => clue_params}) do
    case Core.create_clue(clue_params) do
      {:ok, clue} ->
        conn
        |> put_flash(:info, "Clue created successfully.")
        |> redirect(to: Routes.clue_path(conn, :show, clue))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    clue = Core.get_clue!(id)
    render(conn, "show.html", clue: clue)
  end

  def edit(conn, %{"id" => id}) do
    clue = Core.get_clue!(id)
    changeset = Core.change_clue(clue)
    render(conn, "edit.html", clue: clue, changeset: changeset)
  end

  def update(conn, %{"id" => id, "clue" => clue_params}) do
    clue = Core.get_clue!(id)

    case Core.update_clue(clue, clue_params) do
      {:ok, clue} ->
        conn
        |> put_flash(:info, "Clue updated successfully.")
        |> redirect(to: Routes.clue_path(conn, :show, clue))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", clue: clue, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    clue = Core.get_clue!(id)
    {:ok, _clue} = Core.delete_clue(clue)

    conn
    |> put_flash(:info, "Clue deleted successfully.")
    |> redirect(to: Routes.clue_path(conn, :index))
  end
end
