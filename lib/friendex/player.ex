defmodule Friendex.Player do

  @enforce_keys [:name, :email, :code]
  defstruct [name: nil, email: nil, code: nil, admin: false]

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
          {:error, "Invalid email"}
        [_] ->
          {:ok, player}
      end
  end


end
