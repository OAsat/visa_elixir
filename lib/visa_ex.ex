defmodule VisaEx do
  defmodule Native do
    use Rustler, otp_app: :visa_ex, crate: "visa_ex_nif"

    def list_resources(_query), do: :erlang.nif_error(:nif_not_loaded)
  end

  def list_resources(query \\ "?*::INSTR") do
    Native.list_resources(query)
  end
end
