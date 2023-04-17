defmodule ExVisa.PyvisaImpl do
  @behaviour ExVisa.Direct
  use GenServer

  python_src = "./python"
  System.cmd("poetry", ["install"], cd: python_src, into: IO.stream())
  {python_exec, 0} = System.cmd("poetry", ["run", "which", "python"], cd: python_src)

  @python_path to_charlist(python_src)
  @python_exec to_charlist(String.trim(python_exec))

  def start() do
    :python.start(python_path: @python_path, python: @python_exec)
  end

  @me __MODULE__

  @impl ExVisa.Direct
  def write(address, message) do
    GenServer.call(@me, {:write, {address, message}})
  end

  @impl ExVisa.Direct
  def query(address, message) do
    GenServer.call(@me, {:query, {address, message}})
  end

  @impl ExVisa.Direct
  def list_resources(query \\ "?*::INSTR") do
    GenServer.call(@me, {:list_resources, {query}})
  end

  @impl GenServer
  def init(nil) do
    {:ok, pid} = :python.start_link(python_path: @python_path, python: @python_exec)
    {:ok, pid}
  end

  @impl GenServer
  def handle_call({:list_resources, {query}}, _from, pid) do
    answer = :python.call(pid, :"pyvisa_ex.communicate", :list_resources, [to_charlist(query)])
    {:reply, answer, pid}
  end

  @impl GenServer
  def handle_call({:query, {address, message}}, _from, pid) do
    answer = :python.call(pid, :"pyvisa_ex.communicate", :query, [
      to_charlist(address),
      to_charlist(message)
    ])
    {:reply, answer, pid}
  end
end
