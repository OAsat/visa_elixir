defmodule VisaEx do
  use Rustler, otp_app: :visa_ex, crate: "visa_ex_nif"

  def list_resources(), do: :erlang.nif_error(:nif_not_loaded)
end
