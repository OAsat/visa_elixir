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
  alias ExVisa.ListenerRegistry

  @doc """
  Currently, just an alias to `ExVisa.Direct.list_resources/1`.
  """
  def list_resources(message \\ "?*::INSTR") do
    {:ok, pid} = ListenerRegistry.get_listener_pid(:no_address)
    Listener.list_resources(pid, message)
  end

  def exists?(address) do
    [address] == list_resources(address)
  end

  @doc """
  Writes the message to the given VISA address.
  """
  def write(address, message) do
    {:ok, pid} = ListenerRegistry.get_listener_pid(address)
    Listener.write(pid, {address, message})
  end

  @doc """
  Queries the message to the given VISA address.
  """
  def query(address, message) do
    {:ok, pid} = ListenerRegistry.get_listener_pid(address)
    Listener.query(pid, {address, message})
  end

  @doc """
  Queries device identifier.
  """
  def idn(address), do: query(address, "*IDN?\n")
end
