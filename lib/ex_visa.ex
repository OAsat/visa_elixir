defmodule ExVisa do
  def list_resources() do
    ExVisa.Direct.list_resources()
  end

  def write(address, message) do
    ExVisa.Listener.write({address, message})
  end

  def query(address, message) do
    ExVisa.Listener.query({address, message})
  end
end
