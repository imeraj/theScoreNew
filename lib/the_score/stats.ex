defmodule TheScore.Stats do
  @moduledoc """
  The Stats context.
  """

  import Ecto.Query, warn: false
  alias TheScore.Repo

  alias TheScore.Stats.Rushing

  @doc """
  Returns the list of rushings.

  ## Examples

      iex> list_rushings()
      [%Rushing{}, ...]

  """
  def list_rushings(params) do
    Turbo.Ecto.turbo(from(r in Rushing), params)
  end

  @doc """
  Gets a single rushing.

  Raises `Ecto.NoResultsError` if the Rushing does not exist.

  ## Examples

      iex> get_rushing!(123)
      %Rushing{}

      iex> get_rushing!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rushing!(id), do: Repo.get!(Rushing, id)

  @doc """
  Creates a rushing.

  ## Examples

      iex> create_rushing(%{field: value})
      {:ok, %Rushing{}}

      iex> create_rushing(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rushing(attrs \\ %{}) do
    %Rushing{}
    |> Rushing.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Updates a rushing.

  ## Examples

      iex> update_rushing(rushing, %{field: new_value})
      {:ok, %Rushing{}}

      iex> update_rushing(rushing, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rushing(%Rushing{} = rushing, attrs) do
    rushing
    |> Rushing.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rushing.

  ## Examples

      iex> delete_rushing(rushing)
      {:ok, %Rushing{}}

      iex> delete_rushing(rushing)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rushing(%Rushing{} = rushing) do
    Repo.delete(rushing)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rushing changes.

  ## Examples

      iex> change_rushing(rushing)
      %Ecto.Changeset{data: %Rushing{}}

  """
  def change_rushing(%Rushing{} = rushing, attrs \\ %{}) do
    Rushing.changeset(rushing, attrs)
  end

  def filter_rushings(params) do
    Turbo.Ecto.turbo(from(r in Rushing), params)
  end

  def sort_rushings(params) do
    Turbo.Ecto.turbo(from(r in Rushing), params)
  end

  def total_rushings() do
    Repo.aggregate(Rushing, :count, :id)
  end
end
