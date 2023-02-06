defmodule SimpleVISATest do
  use ExUnit.Case
  doctest SimpleVISA

  test "list_resources runs" do
    SimpleVISA.list_resources()
  end
end
