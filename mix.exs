defmodule ExVisa.MixProject do
  use Mix.Project

  @version "0.1.2"
  @repo "https://github.com/OAsat/visa_elixir"

  def project do
    [
      app: :ex_visa,
      version: @version,
      elixir: "~> 1.14",
      description: "Use VISA(Virtual Instrument Software Architecture) in Elixir",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExVisa.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:erlport, "~> 0.10.1"},
      {:rustler, "~> 0.27.0", optional: true},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:mox, "~> 1.0", only: :test}
    ]
  end

  defp docs do
    [
      main: "ExVisa",
      source_ref: "v#{@version}",
      source_url: "https://github.com/OAsat/visa_elixir"
    ]
  end

  defp package do
    %{
      files: [
        "lib",
        "native/visa_nif/.cargo",
        "native/visa_nif/src",
        "native/visa_nif/Cargo*",
        "python/pyvisa_ex",
        "python/poetry.toml",
        "python/pyproject.toml",
        "mix.exs",
        "README.md",
        "LICENSE-APACHE",
        "LICENSE-MIT"
      ],
      licenses: ["Apache-2.0", "MIT"],
      maintainers: ["Asato Onishi"],
      links: %{"GitHub" => @repo}
    }
  end
end
