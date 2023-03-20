defmodule ExVisa.Direct do
  @callback list_resources(String.t()) :: any
  @callback write(String.t(), String.t()) :: any
  @callback query(String.t(), String.t()) :: any

  def list_resources(message \\ "?*::INSTR"), do: nif_visa().list_resources(message)

  def write(address, message), do: nif_visa().write(address, message)

  def query(address, message), do: nif_visa().query(address, message)

  @spec idn(String.t()) :: any
  def idn(address) do
    query(address, "*IDN?\n")
  end

  defp nif_visa do
    Application.get_env(:ex_visa, :nif_visa, ExVisa.Native)
  end
end
