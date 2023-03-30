defmodule ExVisaTest do
  alias ExVisa.Listener
  use ExUnit.Case, async: false
  import Mox

  setup :set_mox_from_context
  setup :verify_on_exit!

  doctest ExVisa
end
