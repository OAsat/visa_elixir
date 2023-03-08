defmodule ExVISATest do
  use ExUnit.Case
  doctest ExVISA

  test "list_resources runs" do
    ExVISA.list_resources()
  end
end
