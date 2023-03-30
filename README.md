# ExVisa

This library provides a small set of Elixir functions to communicate with lab instruments via VISA.

Documentation is available [here](https://hexdocs.pm/ex_visa/ExVisa.html).
## Requirements
You need [NI-VISA](https://www.ni.com/en-us/support/downloads/drivers/download.ni-visa.html#460225) (or other visa libraries) installed in the default location or `LIB_VISA_PATH` (See [visa-rs](https://github.com/TsuITOAR/visa-rs)).

You also need to install the [Rust](https://www.rust-lang.org/tools/install) toolchain if you don't have one.

## Installation

Add `simple_visa` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_visa, "~> 0.1.2"}
  ]
end
```

## Usage
```
iex(1)> ExVisa.list_resources()
["ASRL1::INSTR", "ASRL3::INSTR", "GPIB0::27::INSTR", "GPIB1::8::INSTR"]
iex(2)> ExVisa.idn("GPIB1::8::INSTR")
"KEITHLEY INSTRUMENTS INC.,MODEL 6221,4559777,D04  /700x \n"
iex(3)> ExVisa.write("GPIB1::8::INSTR", "SOUR:DELT:ARM\n")
{}
iex(4)> ExVisa.write("GPIB1::8::INSTR", "INIT:IMM\n")
{}
iex(5)> ExVisa.query("GPIB1::8::INSTR", "SENS:DATA?\n")
"+9.9E37,+5.248E+01\n"
```

## Internals
Communication to VISA is implemented using [visa-rs](https://github.com/TsuITOAR/visa-rs).