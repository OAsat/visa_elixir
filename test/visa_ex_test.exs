defmodule VisaExTest do
  use ExUnit.Case
  doctest VisaEx

  test "list_instr runs" do
    VisaEx.list_resources()
  end
end
