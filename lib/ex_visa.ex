defmodule ExVISA do
  defmodule Native do
    version = Mix.Project.config()[:version]

    use RustlerPrecompiled,
    otp_app: :ex_visa,
    crate: "visa_nif",
    base_url: "https://https://github.com/OAsat/visa_elixir/releases/download/v#{version}",
    force_build: System.get_env("RUSTLER_PRECOMPILATION_EXAMPLE_BUILD") in ["1", "true"],
    targets:
      Enum.uniq(["aarch64-unknown-linux-musl" | RustlerPrecompiled.Config.default_targets()]),
    version: version

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
