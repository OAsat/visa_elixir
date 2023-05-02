defmodule ExVisaTest do
  # TODO:: appropriate use of Mox
  use ExUnit.Case
  import Mox

  setup :set_mox_from_context
  setup :verify_on_exit!

  doctest ExVisa

  test "list_resources" do
    dummies = ["DUMMY::INSTR1", "DUMMY::INSTR2"]

    ExVisa.VisaMock
    |> stub(:init_state, fn state -> state end)
    |> expect(:list_resources, fn "?*::INSTR", :no_address -> dummies end)

    assert ExVisa.list_resources() == dummies
  end

  test "exists" do
    dummy1 = "DUMMY::INSTR1"
    dummy2 = "DUMMY::INSTR2"

    ExVisa.VisaMock
    |> stub(:init_state, fn state -> state end)
    |> expect(:list_resources, fn ^dummy1, :no_address -> [dummy1] end)
    |> expect(:list_resources, fn ^dummy2, :no_address -> [dummy2] end)

    assert ExVisa.exists?(dummy1) == true
    assert ExVisa.exists?(dummy2) == true
  end

  test "query" do
    address = "DUMMY::INSTR"
    port = ExVisa.Parser.port_from_address(address)
    message = "dummy\n"

    ExVisa.VisaMock
    |> stub(:init_state, fn state -> state end)
    |> expect(:query, fn {^address, ^message}, ^port -> :dummy_answer end)

    assert ExVisa.query(address, message) == :dummy_answer
  end

  test "idn" do
    address = "DUMMY::INSTR"
    port = ExVisa.Parser.port_from_address(address)

    ExVisa.VisaMock
    |> stub(:init_state, fn state -> state end)
    |> expect(:query, fn {^address, "*IDN?\n"}, ^port -> :dummy_answer end)

    assert ExVisa.idn(address) == :dummy_answer
  end

  test "write" do
    address = "DUMMY::INSTR"
    port = ExVisa.Parser.port_from_address(address)
    message = "dummy\n"

    ExVisa.VisaMock
    |> stub(:init_state, fn state -> state end)
    |> expect(:write, fn {^address, ^message}, ^port -> :ok end)

    assert ExVisa.write(address, message) == :ok
  end
end
