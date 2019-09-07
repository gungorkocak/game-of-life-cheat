defmodule GameOfLifeCheatWeb.PageController do
  use GameOfLifeCheatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
