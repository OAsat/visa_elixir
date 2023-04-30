defmodule ExVisa.RustlerVisa do
  @behaviour ExVisa.VisaBehaviour
  alias ExVisa.Native

  @impl ExVisa.VisaBehaviour
  def init_state(port_name) do
    {:ok, port_name}
  end

  @impl ExVisa.VisaBehaviour
  def query({address, message}, _state) do
    Native.query(address, message)
  end

  @impl ExVisa.VisaBehaviour
  def write({address, message}, _state) do
    Native.write(address, message)
  end

  @impl ExVisa.VisaBehaviour
  def list_resources(message \\ "?*::INSTR", _state) do
    Native.list_resources(message)
  end
end
