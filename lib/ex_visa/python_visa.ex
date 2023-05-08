defmodule ExVisa.PythonVisa do
  @behaviour ExVisa.VisaBehaviour

  python_src = "./python"

  {python_exec, 0} =
    case :os.type() do
      {:win32, _} ->
        System.cmd("cmd.exe", ["/c", "poetry", "install"], cd: python_src, into: IO.stream())
        System.cmd("cmd.exe", ["/c", "poetry", "run", "which", "python"], cd: python_src)

      {:unix, _} ->
        System.cmd("poetry", ["install"], cd: python_src, into: IO.stream())
        System.cmd("poetry", ["run", "which", "python"], cd: python_src)
    end

  @python_path to_charlist(python_src)
  @python_exec to_charlist(String.trim(python_exec))

  @impl ExVisa.VisaBehaviour
  def init_state(_port_name) do
    {:ok, pid} = :python.start_link(python_path: @python_path, python: @python_exec)
    pid
  end

  @impl ExVisa.VisaBehaviour
  def list_resources(query, pid) do
    :python.call(pid, :"pyvisa_ex.communicate", :list_resources, [query])
    |> Tuple.to_list()
    |> Enum.map(&to_string/1)
  end

  @impl ExVisa.VisaBehaviour
  def query({address, message}, pid) do
    :python.call(pid, :"pyvisa_ex.communicate", :query, [address, message])
  end

  @impl ExVisa.VisaBehaviour
  def write({address, message}, pid) do
    :python.call(pid, :"pyvisa_ex.communicate", :write, [address, message])
  end
end
