defmodule TreasureHuntWeb.ClueControllerTest do
  use TreasureHuntWeb.ConnCase

  import TreasureHunt.CoreFixtures

  @create_attrs %{done_at: ~N[2022-11-28 09:00:00], sort: 42, status: "some status"}
  @update_attrs %{done_at: ~N[2022-11-29 09:00:00], sort: 43, status: "some updated status"}
  @invalid_attrs %{done_at: nil, sort: nil, status: nil}

  describe "index" do
    test "lists all clues", %{conn: conn} do
      conn = get(conn, Routes.clue_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Clues"
    end
  end

  describe "new clue" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.clue_path(conn, :new))
      assert html_response(conn, 200) =~ "New Clue"
    end
  end

  describe "create clue" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.clue_path(conn, :create), clue: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.clue_path(conn, :show, id)

      conn = get(conn, Routes.clue_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Clue"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.clue_path(conn, :create), clue: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Clue"
    end
  end

  describe "edit clue" do
    setup [:create_clue]

    test "renders form for editing chosen clue", %{conn: conn, clue: clue} do
      conn = get(conn, Routes.clue_path(conn, :edit, clue))
      assert html_response(conn, 200) =~ "Edit Clue"
    end
  end

  describe "update clue" do
    setup [:create_clue]

    test "redirects when data is valid", %{conn: conn, clue: clue} do
      conn = put(conn, Routes.clue_path(conn, :update, clue), clue: @update_attrs)
      assert redirected_to(conn) == Routes.clue_path(conn, :show, clue)

      conn = get(conn, Routes.clue_path(conn, :show, clue))
      assert html_response(conn, 200) =~ "some updated status"
    end

    test "renders errors when data is invalid", %{conn: conn, clue: clue} do
      conn = put(conn, Routes.clue_path(conn, :update, clue), clue: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Clue"
    end
  end

  describe "delete clue" do
    setup [:create_clue]

    test "deletes chosen clue", %{conn: conn, clue: clue} do
      conn = delete(conn, Routes.clue_path(conn, :delete, clue))
      assert redirected_to(conn) == Routes.clue_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.clue_path(conn, :show, clue))
      end
    end
  end

  defp create_clue(_) do
    clue = clue_fixture()
    %{clue: clue}
  end
end
