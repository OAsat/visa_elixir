defmodule ExVisaTest do
  use ExUnit.Case
  import Mox

  setup :set_mox_from_context
  setup :verify_on_exit!

  doctest ExVisa

  test "query" do
    ExVisa.VisaMock
    |> expect(:query, fn _address, _message -> :mocked end)

    assert ExVisa.query("PORT0::INSTR0", "dummy\n") == :mocked
  end
end
