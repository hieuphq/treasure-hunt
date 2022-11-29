defmodule TreasureHuntWeb.PageController do
  use TreasureHuntWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
