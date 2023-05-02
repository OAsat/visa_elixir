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

  def register_address(pid, address) do
    GenServer.cast(pid, {:register, address})
  end

  def query(pid, content) do
    GenServer.call(pid, {:query, content})
  end

  def write(pid, content) do
    GenServer.call(pid, {:write, content})
  end

  def list_resources(pid, content) do
    GenServer.call(pid, {:list_resources, content})
  end

  @impl GenServer
  def init(state) do
    {:ok, listener_impl().init_state(state)}
  end

  @impl GenServer
  def handle_call({:query, content}, _from, state) do
    {:reply, listener_impl().query(content, state), state}
  end

  @impl GenServer
  def handle_call({:write, content}, _from, state) do
    {:reply, listener_impl().write(content, state), state}
  end

  @impl GenServer
  def handle_call({:list_resources, content}, _from, state) do
    {:reply, listener_impl().list_resources(content, state), state}
  end

  @impl GenServer
  def handle_cast({:register, address}, state) do
    Registry.register(@registry, address, address)
    {:noreply, state}
  end

  def listener_impl() do
    Application.get_env(:ex_visa, :listener_impl, ExVisa.PythonVisa)
  end
end
