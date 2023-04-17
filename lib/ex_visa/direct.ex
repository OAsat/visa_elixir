defmodule ExVisa.Direct do
  @moduledoc """
  Simply directs to Rustler functions.

  You can mock these functions by using the `Mox` package.
  """
  @callback list_resources(message :: String.t()) :: any
  @callback write(address :: String.t(), message :: String.t()) :: any
  @callback query(address :: String.t(), message :: String.t()) :: any

  @spec list_resources(String.t()) :: any
  def list_resources(message \\ "?*::INSTR"), do: visa_impl().list_resources(message)

  @spec write(String.t(), String.t()) :: any
  def write(address, message), do: visa_impl().write(address, message)

  @spec query(String.t(), String.t()) :: any
  def query(address, message), do: visa_impl().query(address, message)

  @spec idn(String.t()) :: any
  def idn(address), do: query(address, "*IDN?\n")

  defp visa_impl do
    Application.get_env(:ex_visa, :visa_impl, ExVisa.Native)
  end
end
