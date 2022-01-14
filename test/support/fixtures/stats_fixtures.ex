defmodule TheScore.StatsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TheScore.Stats` context.
  """

  @doc """
  Generate a rushing.
  """
  def rushing_fixture(attrs \\ %{}) do
    {:ok, rushing} =
      attrs
      |> Enum.into(%{})
      |> TheScore.Stats.create_rushing()

    rushing
  end
end
