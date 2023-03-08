# ExVISA

This library provides a small set of Elixir functions to communicate with lab instruments via VISA.

## Requirements
You need [NI-VISA](https://www.ni.com/en-us/support/downloads/drivers/download.ni-visa.html#460225) (or other visa libraries) installed in the default location or `LIB_VISA_PATH` (See [visa-rs](https://github.com/TsuITOAR/visa-rs)).

## Installation

Add `simple_visa` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_visa, "~> 0.0.1"}
  ]
end
```

## Usage
```
iex(1)> ExVISA.list_resources()
["ASRL1::INSTR", "ASRL3::INSTR", "GPIB0::27::INSTR", "GPIB1::8::INSTR"]
iex(2)> ExVISA.idn("GPIB1::8::INSTR")
"KEITHLEY INSTRUMENTS INC.,MODEL 6221,4559777,D04  /700x \n"
iex(3)> ExVISA.write("GPIB1::8::INSTR", "SOUR:DELT:ARM\n")
{}
iex(4)> ExVISA.write("GPIB1::8::INSTR", "INIT:IMM\n")
{}
iex(5)> ExVISA.query("GPIB1::8::INSTR", "SENS:DATA?\n")
"+9.9E37,+5.248E+01\n"
```

## Details
Communication to VISA is implemented using [visa-rs](https://github.com/TsuITOAR/visa-rs).