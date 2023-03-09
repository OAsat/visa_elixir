defmodule ExVISA.MixProject do
  use Mix.Project

  @version "0.0.2"
  @repo "https://github.com/OAsat/visa_elixir"

  def project do
    [
      app: :ex_visa,
      version: @version,
      elixir: "~> 1.14",
      description: "Use VISA(Virtual Instrument Software Architecture) in Elixir",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:rustler_precompiled, "~> 0.6"},
      {:rustler, ">= 0.0.0", optional: true},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
    ]
  end

  defp package do
    %{
      files: [
      "lib",
      "native/visa_nif/.cargo",
      "native/visa_nif/src",
      "native/visa_nif/Cargo*",
      "mix.exs",
      "README.md",
      "LICENSE-APACHE",
      "LICENSE-MIT",
    ],
      licenses: ["Apache-2.0", "MIT"],
      maintainers: ["Asato Onishi"],
      links: %{"GitHub" => @repo}
    }
  end
end
