defmodule ExVisa.Application do
  @moduledoc false
  use Application
  @listener_registry ExVisa.ListenerRegistry
  @listener_supervisor ExVisa.ListenerSupervisor

  @impl Application
  def start(_type, _args) do
    children = [
      {DynamicSupervisor, name: @listener_supervisor, strategy: :one_for_one},
      {Registry, keys: :unique, name: @listener_registry}
    ]

    Supervisor.start_link(children, strategy: :one_for_all, name: ExVisa.Supervisor)
  end
end
