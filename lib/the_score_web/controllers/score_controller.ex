defmodule TheScoreWeb.ScoreController do
  use TheScoreWeb, :controller

  alias TheScore.Stats

  def index(conn, params) do
    filter_criteria = Map.get(params, "filter_criteria")
    sort_criteria = Map.get(params, "sort_criteria")

    params = build_params(filter_criteria, sort_criteria)
    listings = Stats.list_rushings(params)

    render(conn, "index.html",
      rushings: listings.datas,
      page: listings.paginate,
      filter_criteria: filter_criteria,
      sort_criteria: sort_criteria
    )
  end

  def filter(conn, %{"filter" => %{"filter_criteria" => name}} = _params) do
    params = build_filter_params(String.trim(name))
    listings = Stats.filter_rushings(params)

    render(conn, "index.html",
      rushings: listings.datas,
      page: listings.paginate,
      filter_criteria: name
    )
  end

  def sort(conn, %{"sort" => %{"sort_criteria" => criteria_id}} = _params) do
    params = build_sort_params(criteria_id)
    listings = Stats.sort_rushings(params)

    render(conn, "index.html",
      rushings: listings.datas,
      page: listings.paginate,
      sort_criteria: criteria_id
    )
  end

  defp build_params(filter_criteria, sort_criteria) do
    sort_criteria = criteria(sort_criteria)
    %{"q" => %{"name_ilike" => filter_criteria || ""}, "s" => sort_criteria}
  end

  defp build_filter_params(name) do
    %{"q" => %{"name_ilike" => name}}
  end

  defp build_sort_params(criteria_id) do
    %{"s" => criteria(criteria_id)}
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
