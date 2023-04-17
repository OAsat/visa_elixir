defmodule ExVisa.ListenerImpl do
  @callback init_state(port_name :: String.t()) :: any()
  @callback write(address :: String.t(), message :: String.t(), state :: any()) :: any()
  @callback query(address :: String.t(), message :: String.t(), state :: any()) :: any()
end
