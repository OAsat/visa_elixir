defmodule ExVisa.Application do
  @moduledoc false
  use Application

  @impl Application
  def start(_type, _args) do
    children = [
      ExVisa.ListenerSupervisor,
      {Registry, keys: :unique, name: ExVisa.ListenerRegistry}
    ]

    Supervisor.start_link(children, strategy: :one_for_all, name: ExVisa.Supervisor)
  end
end
