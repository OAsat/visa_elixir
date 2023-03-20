defmodule ListenerManagerTest do
  use ExUnit.Case
  import Mox

  setup :set_mox_from_context
  setup :verify_on_exit!

  test "new listener generation" do
    ExVisa.VisaMock
    |> expect(:query, fn "PORT0::INSTR0", "dummy\n" -> "dummy instr0" end)
    |> expect(:query, fn "PORT0::INSTR1", "dummy\n" -> "dummy instr1" end)
    |> expect(:query, fn "PORT1::INSTR2", "dummy\n" -> "dummy instr2" end)

    assert Registry.count(ExVisa.ListenerRegistry) == 0
    assert ExVisa.ListenerManager.query({"PORT0::INSTR0", "dummy\n"}) == "dummy instr0"
    assert Registry.count(ExVisa.ListenerRegistry) == 1
    assert ExVisa.ListenerManager.query({"PORT0::INSTR1", "dummy\n"}) == "dummy instr1"
    assert Registry.count(ExVisa.ListenerRegistry) == 1
    assert ExVisa.ListenerManager.query({"PORT1::INSTR2", "dummy\n"}) == "dummy instr2"
    assert Registry.count(ExVisa.ListenerRegistry) == 2
  end
end
