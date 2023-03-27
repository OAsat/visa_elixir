defmodule ExVisa.Listener do
  @moduledoc """
  """

  use GenServer, restart: :temporary

  @registry ExVisa.ListenerRegistry
  @me __MODULE__

  def registry, do: @registry

  def start_link({port_name, address_list}) do
    name = {:via, Registry, {@registry, port_name}}
    GenServer.start_link(@me, address_list, name: name)
  end

  @impl GenServer
  def init(address_list) when is_list(address_list) do
    list =
      for address <- address_list do
        {:ok, _pid} = Registry.register(@registry, address, address)
      end

    {:ok, list}
  end

  @impl GenServer
  def handle_cast({:query, {address, message}}, state) do
    ExVisa.Direct.query(address, message)
    {:noreply, state}
  end

  @impl GenServer
  def handle_cast({:write, {address, message}}, state) do
    ExVisa.Direct.write(address, message)
    {:noreply, state}
  end
end
