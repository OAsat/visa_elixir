defmodule ExVisa.Listener do
  use GenServer, restart: :temporary
  alias ExVisa.ListenerSupervisor

  @registry ExVisa.ListenerRegistry
  @me __MODULE__

  @spec start_link(String.t()) :: :ignore | {:error, any} | {:ok, pid}
  def start_link(port_name) do
    name = via_name(port_name)
    GenServer.start_link(@me, port_name, name: name)
  end

  def via_name(key) do
    {:via, Registry, {@registry, key}}
  end

  def get_port_name(address) do
    address |> String.split("::") |> List.first()
  end

  defp communicate(type, content = {address, _message}) when is_atom(type) do
    port_name = get_port_name(address)

    case Registry.lookup(@registry, port_name) do
      [{pid, nil}] ->
        GenServer.call(pid, {type, content})

      [] ->
        {:ok, pid} = ListenerSupervisor.start_child(port_name)
        GenServer.call(pid, {type, content})
    end
  end

  @spec query(tuple()) :: any
  def query(content) when is_tuple(content) do
    communicate(:query, content)
  end

  @spec write(tuple()) :: any
  def write(content) when is_tuple(content) do
    communicate(:write, content)
  end

  @impl GenServer
  @spec init(String.t()) :: {:ok, String.t()}
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
end
