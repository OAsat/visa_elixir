defmodule VisaEx do
  defmodule Native do
    use Rustler, otp_app: :visa_ex, crate: "visa_ex_nif"

    def list_resources(_message), do: :erlang.nif_error(:nif_not_loaded)

    def query(_address, _message), do: :erlang.nif_error(:nif_not_loaded)
  end

  def list_resources(message \\ "?*::INSTR") do
    Native.list_resources(message)
  end

  def query(address, message) do
    Native.query(address, message)
  end

  def idn(address) do
    query(address, "*IDN?\n")
  end
end
