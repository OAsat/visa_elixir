defmodule ExVisa.Native do
  use Rustler, otp_app: :ex_visa, crate: "visa_nif"

  def list_resources(_message), do: :erlang.nif_error(:nif_not_loaded)

  def write(_address, _message), do: :erlang.nif_error(:nif_not_loaded)

  def query(_address, _message), do: :erlang.nif_error(:nif_not_loaded)
end
