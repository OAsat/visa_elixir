defmodule ExVisa do
  @moduledoc """
  This module provides some simple functions to communicate with instruments via VISA
  (Virtual Instrument Software Architecture).

  You can talk to devices using the `ExVisa` functions,
  while assuring concurrent accesses to the same port don't conflict.

  If you don't need such functionality,
  you can also directly talk to them through `ExVisa.Direct` functions.
  """
  alias ExVisa.Listener
  alias ExVisa.Parser
  @listener_registry ExVisa.ListenerRegistry
  @listener_supervisor ExVisa.ListenerSupervisor

  def start() do
    list_resources()
    |> Enum.group_by(&Parser.port_from_address(&1))
    |> Enum.map(fn v = {_port, _address_list} ->
      {:ok, _child} = DynamicSupervisor.start_child(@listener_supervisor, {ExVisa.Listener, v})
    end)
  end

  @doc """
  Currently, just an alias to `ExVisa.Direct.list_resources/1`.
  """
  def list_resources(message \\ "?*::INSTR"), do: ExVisa.Direct.list_resources(message)

  @doc """
  Writes the message to the given VISA address.
  """
  def write(address, message) do
    Registry.dispatch(
      Listener.registry(),
      address,
      fn {pid, address} -> GenServer.call(pid, {:write, {address, message}}) end
    )
  end

  @doc """
  Queries the message to the given VISA address.
  """
  def query(address, message) do
    Registry.dispatch(
      Listener.registry(),
      address,
      fn {pid, address} -> GenServer.cast(pid, {:query, {address, message}}) end
    )
  end

  @doc """
  Queries device identifier.
  """
  def idn(address), do: query(address, "*IDN?\n")
end
