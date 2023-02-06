defmodule VisaEx do
  defmodule Native do
    use Rustler, otp_app: :visa_ex, crate: "visa_ex_nif"

    def list_resources(_message), do: :erlang.nif_error(:nif_not_loaded)
    def write(_address, _message), do: :erlang.nif_error(:nif_not_loaded)
    def query(_address, _message), do: :erlang.nif_error(:nif_not_loaded)
  end

  @spec list_resources(String.t()) :: any
  def list_resources(message \\ "?*::INSTR") do
    Native.list_resources(message)
  end

  @spec write(String.t(), String.t()) :: any
  def write(address, message) do
    Native.write(address, message)
  end

  @spec query(String.t(), String.t()) :: any
  def query(address, message) do
    Native.query(address, message)
  end

  @spec idn(String.t()) :: any
  def idn(address) do
    query(address, "*IDN?\n")
  end
end
