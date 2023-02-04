defmodule VisaEx do
  use Rustler, otp_app: :visa_ex, crate: "visa_ex_nif"

  # When your NIF is loaded, it will override this function.
  def add(_a, _b), do: :erlang.nif_error(:nif_not_loaded)

  def list_instr(), do: :erlang.nif_error(:nif_not_loaded)
end
