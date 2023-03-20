defmodule ExVisa.Parser do
  @moduledoc """
  Utility functions.
  """

  @doc """
  Extracts port name from the given address string: `"{port name}::***"`.
  ## Example
      iex> "XXXX::YYYY::ZZZZ" |> ExVisa.Parser.port_from_address()
      "XXXX"
  """
  @spec port_from_address(String.t()) :: String.t()
  def port_from_address(address) do
    address |> String.split("::") |> List.first()
  end
end
