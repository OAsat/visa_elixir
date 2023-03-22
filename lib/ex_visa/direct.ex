defmodule ExVisa.Direct do
  @moduledoc """
  Simply directs to Rustler functions.

  You can mock these functions by using the `Mox` package.
  """
  @callback list_resources(String.t()) :: any
  @callback write(String.t(), String.t()) :: any
  @callback query(String.t(), String.t()) :: any

  def list_resources(message \\ "?*::INSTR"), do: visa_impl().list_resources(message)

  def write(address, message), do: visa_impl().write(address, message)

  def query(address, message), do: visa_impl().query(address, message)

  @spec idn(String.t()) :: any
  def idn(address), do: query(address, "*IDN?\n")

  defp visa_impl do
    Application.get_env(:ex_visa, :visa_impl, ExVisa.Native)
  end
end
