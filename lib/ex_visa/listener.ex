defmodule ExVisa.Listener do
  @moduledoc """
  """

  use GenServer, restart: :temporary

  @registry ExVisa.ListenerRegistry
  @me __MODULE__

  def registry, do: @registry

  def start_link(port_name) do
    name = {:via, Registry, {@registry, port_name}}
    GenServer.start_link(@me, port_name, name: name)
  end

  @impl GenServer
  def init(port_name) do
    {:ok, port_name}
  end

  @impl GenServer
  def handle_call({:query, {address, message}}, _from, state) do
    {:reply, ExVisa.Direct.query(address, message), state}
  end

  @impl GenServer
  def handle_call({:write, {address, message}}, _from, state) do
    {:reply, ExVisa.Direct.write(address, message), state}
  end

  @impl GenServer
  def handle_cast({:register, address}, state) do
    Registry.register(@registry, address, address)
    {:noreply, state}
  end
end
