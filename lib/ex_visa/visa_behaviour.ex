defmodule ExVisa.VisaBehaviour do
  @callback init_state(port_name :: String.t()) :: any()
  @callback write(content :: any(), state :: any()) :: any()
  @callback query(content :: any(), state :: any()) :: any()
  @callback list_resources(content :: any(), state :: any()) :: any
end
