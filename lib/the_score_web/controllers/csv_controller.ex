defmodule TheScoreWeb.CsvController do
  use TheScoreWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
