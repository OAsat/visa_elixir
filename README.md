# VisaEx

This library provides a small set of simple Elixir functions to communicate with lab instruments via VISA.

## Requirements
You need [NI-VISA](https://www.ni.com/en-us/support/downloads/drivers/download.ni-visa.html#460225) (or another visa library) installed in the default location or `LIB_VISA_PATH` (See [visa-rs](https://github.com/TsuITOAR/visa-rs)).

## Installation

Add `visa_ex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:visa_ex, git: "https://github.com/OAsat/visa_ex.git"}
  ]
end
```

## Examples
```
iex(1)> VisaEx.list_resources()
["ASRL1::INSTR", "ASRL3::INSTR", "GPIB0::27::INSTR", "GPIB1::8::INSTR"]
iex(2)> VisaEx.idn("GPIB1::8::INSTR")
"KEITHLEY INSTRUMENTS INC.,MODEL 6221,4559777,D04  /700x \n"
iex(3)> VisaEx.write("GPIB1::8::INSTR", "SOUR:DELT:ARM\n")
{}
iex(4)> VisaEx.write("GPIB1::8::INSTR", "INIT:IMM\n")
{}
iex(5)> VisaEx.query("GPIB1::8::INSTR", "SENS:DATA?\n")
"+9.9E37,+5.248E+01\n"
```

## Development
Communication to VISA is implemented using [visa-rs](https://github.com/TsuITOAR/visa-rs).