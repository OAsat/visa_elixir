defmodule ExVisa.ListenerSupervisor do
  alias ExVisa.Listener

  @me __MODULE__

  def start_child(port_name) do
    DynamicSupervisor.start_child(@me, {Listener, port_name})
  end
end
