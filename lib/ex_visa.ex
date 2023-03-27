defmodule ExVisa do
  @moduledoc """
  This module provides some simple functions to communicate with instruments via VISA
  (Virtual Instrument Software Architecture).

  You can talk to devices using the `ExVisa` functions,
  while assuring concurrent accesses to the same port don't conflict.

  If you don't need such functionality,
  you can also directly talk to them through `ExVisa.Direct` functions.
  """
  alias ExVisa.Parser
  alias ExVisa.Listener
  @listener_registry ExVisa.ListenerRegistry
  @listener_supervisor ExVisa.ListenerSupervisor

  @doc """
  Currently, just an alias to `ExVisa.Direct.list_resources/1`.
  """
  def list_resources(message \\ "?*::INSTR"), do: ExVisa.Direct.list_resources(message)

  def exists?(address) do
    [address] == list_resources(address)
  end

  @doc """
  Writes the message to the given VISA address.
  """
  def write(address, message) do
    communicate(:write, {address, message})
  end

  @doc """
  Queries the message to the given VISA address.
  """
  def query(address, message) do
    communicate(:query, {address, message})
  end

  defp communicate(type, content = {address, _message}) when is_atom(type) do
    port_name = Parser.port_from_address(address)

    with [] <- Registry.lookup(@listener_registry, address),
         true <- exists?(address),
         [] <- Registry.lookup(@listener_registry, port_name) do
      DynamicSupervisor.start_child(@listener_supervisor, {Listener, port_name})
    else
      [{pid, _value}] ->
        GenServer.cast(pid, {:register, address})
        GenServer.call(pid, {type, content})
      false -> {:error, :invalid_address}
    end
  end

  @doc """
  Queries device identifier.
  """
  def idn(address), do: query(address, "*IDN?\n")
end
