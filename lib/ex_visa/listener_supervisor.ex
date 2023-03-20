defmodule ExVisa.ListenerSupervisor do
  @moduledoc false

  use DynamicSupervisor

  @me __MODULE__

  def start_link(_) do
    DynamicSupervisor.start_link(@me, :no_args, name: @me)
  end

  @impl DynamicSupervisor
  def init(:no_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child(port_name) do
    DynamicSupervisor.start_child(@me, {ExVisa.Listener, port_name})
  end
end
