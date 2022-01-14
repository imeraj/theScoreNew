defmodule TheScoreWeb.CsvController do
  use TheScoreWeb, :controller

  alias TheScore.Stats

  @columns ~w(name
        team
        pos
        att_per_game
        att
        total_rush
        rush_per_yard
        rush_per_game
        rush_td
        long_rush
        rush_1st_down
        rush_1st_down_per
        rush_20_yards
        rush_40_yards
        fumble)

  def export(conn, params) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"thescore.csv\"")
    |> send_resp(200, csv_content(params))
  end

  defp csv_content(params) do
    filter_criteria = params["filter_criteria"]
    sort_criteria = params["sort_criteria"]
    params = build_params(filter_criteria, sort_criteria)

    [
      [
        "Player",
        "Team",
        "Pos",
        "Att/G",
        "Att",
        "Yrds",
        "Avg",
        "Yrds/G",
        "TD",
        "Lng",
        "1st",
        "1st%",
        "20+",
        "40+",
        "FUM"
      ]
    ]
    |> Stream.concat(
      Stats.list_rushings(params)
      |> Map.get(:datas)
      |> Stream.map(&parse_line/1)
    )
    |> CSV.encode()
    |> Enum.to_list()
    |> to_string()
  end

  defp parse_line(rushing) do
    rushing = Map.from_struct(rushing) |> Map.drop([:__meta__])
    Enum.map(@columns, &Map.get(rushing, String.to_atom(&1)))
  end

  defp build_params(filter_criteria, sort_criteria) do
    sort_criteria = criteria(sort_criteria)
    count = Stats.total_rushings()

    %{"q" => %{"name_ilike" => filter_criteria || ""}, "s" => sort_criteria, "per_page" => count}
  end

  defp criteria(criteria_id) do
    criteria =
      case criteria_id do
        "1" ->
          "total_rush"

        "2" ->
          "long_rush"

        "3" ->
          "rush_td"

        _ ->
          ""
      end

    case criteria do
      "" -> ""
      _ -> criteria <> "+asc"
    end
  end
end
