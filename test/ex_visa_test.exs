defmodule ExVisaTest do
  alias ExVisa.Listener
  use ExUnit.Case, async: false
  import Mox

  setup :set_mox_from_context
  setup :verify_on_exit!

  doctest ExVisa

  test "start" do
    ExVisa.VisaMock
    |> expect(
      :list_resources,
      fn _message -> ["GPIB0::1::INSTR", "GPIB0::2::INSTR", "GPIB1::1::INSTR"] end
    )
    ExVisa.start()

    [{pid1, _value}] = Registry.lookup(Listener.registry(), "GPIB0")
    assert Registry.keys(Listener.registry(), pid1) |> Enum.sort() == ["GPIB0", "GPIB0::1::INSTR", "GPIB0::2::INSTR"]
  end

  test "query" do
    ExVisa.VisaMock
    |> expect(:list_resources, fn _message -> ["GPIB0::1::INSTR"] end)
    |> expect(:query, fn "GPIB0::1::INSTR", "dummy\n" -> :mocked end)

    ExVisa.start()
    assert ExVisa.query("PORT0::INSTR0", "dummy\n") == :mocked
  end
end
