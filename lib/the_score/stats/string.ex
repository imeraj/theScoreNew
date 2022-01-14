defmodule TheScore.Stats.String do
  use Ecto.Type
  def type, do: :float

  def cast(string) when is_bitstring(string), do: {:ok, elem(Float.parse(string), 0)}
  def cast(integer) when is_integer(integer), do: {:ok, integer}
  def cast(float) when is_float(float), do: {:ok, float}
  def cast(_), do: :error

  def load(float) when is_float(float), do: {:ok, float}
  def load(integer) when is_integer(integer), do: {:ok, integer}

  def dump(float) when is_float(float), do: {:ok, float}
  def dump(integer) when is_integer(integer), do: {:ok, integer}
  def dump(_), do: :error
end
