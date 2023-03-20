defmodule ExVisa.ListenerManager do
  @moduledoc """
  Assigns `ExVisa.Listener` server to each ports.
  """

  @registry ExVisa.ListenerRegistry

  def query(content) when is_tuple(content) do
    communicate(:query, content)
  end

  def write(content) when is_tuple(content) do
    communicate(:write, content)
  end

  defp communicate(type, content = {address, _message}) when is_atom(type) do
    port_name = ExVisa.Parser.port_from_address(address)

    case Registry.lookup(@registry, port_name) do
      [{pid, nil}] ->
        GenServer.call(pid, {type, content})

      [] ->
        {:ok, pid} = ExVisa.ListenerSupervisor.start_child(port_name)
        GenServer.call(pid, {type, content})
    end
  end
end
