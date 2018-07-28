defmodule Friendex.Player do

  @enforce_keys [:name, :email, :code]
  defstruct [name: nil, email: nil, code: nil, admin: false]

  @doc ~S"""
    The Player.new function create a new player using name and email, the code is random and admin can be true or false.

    ## Examples

    A new player with two parameters
      iex>
      Friendex.Player.new("Julián", "juliand347@gmail.com")
          {:ok,
                %Friendex.Player{
                  name: "Julián",
                  email: "juliand347@gmail.com",
                  code: _,
                  admin: false
                }}

    A new player with three parameters
      iex>
      Friendex.Player.new("Julián", "juliand347@gmail.com", :admin)
           {:ok,
                %Friendex.Player{
                  name: "Julián",
                  email: "juliand347@gmail.com",
                  code: _,
                  admin: true
                }}


    An invalid email would return an error

      iex> Friendex.Player.new("Julián", "juliand347")
      {:error, :invalid_email}

  """
  def new(name, email, :admin) do
    _new(name, email)
    |> Map.put(:admin, true)
    |> validate_email()
  end

  def new(name, email) do
    _new(name, email)
    |> validate_email()
  end

  defp _new(name, email) do
    %__MODULE__{name: name, email: email, code: random_string(5)}
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  defp validate_email(player = %__MODULE__{email: email}) when is_binary(email) do
      case Regex.run(~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]+$/, email) do
        nil ->
          {:error, :invalid_email}
        [_] ->
          {:ok, player}
      end
  end


end
