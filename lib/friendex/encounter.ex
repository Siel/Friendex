defmodule Friendex.Encounter do

  @enforce_keys [:date, :name]
  defstruct [date: nil, name: nil, description: nil]

  @doc ~S"""
    The Enconter.new function create a new encounter using year, month, day
    hour, name and description as parameters

    ## Examples

      iex> Friendex.Encounter.new(2020, 12, 5, 12, "test", "desc test")
      {:ok,
          %Friendex.Encounter{
            date: ~N[2020-12-05 12:00:00],
            description: "desc test",
            name: "test"
        }}

    An invalid date would return an error

      iex> Friendex.Encounter.new(2020, 13, 4, 12, "test", "doc test")
      {:error, :invalid_datetime}
  """
  def new(year, month, day, hour, name, description\\nil ) do
    case encounter = %__MODULE__{date: create_datetime(year, month, day, hour), name: name, description: description} do
      %__MODULE__{date: :invalid_date} ->
        {:error, :invalid_datetime}
      _ ->
        {:ok, encounter}
    end

  end

  defp create_datetime(year, month, day, hour) do
    case NaiveDateTime.new(year, month, day, hour, 0, 0) do
      {:ok, date} ->
        date
      {:error, _invalid_date} ->
        :invalid_date
    end
  end

end
