defmodule MockDirectTest do
  use ExUnit.Case
  import Mox

  setup :verify_on_exit!

  test "query" do
    ExVisa.VisaMock
    |> expect(:query, fn _address, _message -> :mocked end)

    assert ExVisa.Direct.query("PORT0::INSTR", "dummy\n") == :mocked
  end

  test "write" do
    ExVisa.VisaMock
    |> expect(:write, fn _address, _message -> {} end)

    assert ExVisa.Direct.write("PORT0::INSTR", "dummy\n") == {}
  end
end
