defmodule VisaExTest do
  use ExUnit.Case
  doctest VisaEx

  test "adds a and b" do
    assert VisaEx.add(1, 2) == 3
  end
end
