# VisaEx

The library provides some simple Elixir functions to communicate with lab instruments via VISA.

The implementation depends on
- [visa-rs](https://github.com/TsuITOAR/visa-rs)
- [rustler](https://github.com/rusterlium/rustler)

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
"+9.9E37,+5.248E+01\n"iex(1)> VisaEx.list_resources()
["ASRL1::INSTR", "ASRL2::INSTR"]
```
