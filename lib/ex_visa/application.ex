defmodule ExVisa.Application do
  @moduledoc false
  use Application

  @impl Application
  def start(_type, _args) do
    children = [
      {DynamicSupervisor, name: ExVisa.ListenerSupervisor, strategy: :one_for_one},
      {Registry, keys: :unique, name: ExVisa.ListenerRegistry}
    ]

    Supervisor.start_link(children, strategy: :one_for_all, name: ExVisa.Supervisor)
  end
end
