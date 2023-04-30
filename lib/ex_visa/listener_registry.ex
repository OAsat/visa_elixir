defmodule ExVisa.ListenerRegistry do

  @me __MODULE__

  def lookup(key) do
    case Registry.lookup(@me, key) do
      [] -> :listener_not_found
      [{pid, _value}] -> {:ok, pid}
    end
  end

  def get_listener_pid(address) do
    case lookup(address) do
      :listener_not_found -> start_or_get_pid(address)
      {:ok, pid} -> {:ok, pid}
    end
  end

  def start_or_get_pid(address) do
    port_name = case address do
      :no_address -> :no_address
      _ -> ExVisa.Parser.port_from_address(address)
    end
    case ExVisa.ListenerSupervisor.start_child(port_name) do
      {:ok, pid} -> {:ok, pid}
      {:error, {:already_started, pid}} -> {:ok, pid}
    end
  end
end
