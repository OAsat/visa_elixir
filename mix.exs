defmodule ExVISA.MixProject do
  use Mix.Project

  @version "0.0.1"
  @repo "https://github.com/OAsat/visa_elixir"

  def project do
    [
      app: :ex_visa,
      version: @version,
      elixir: "~> 1.14",
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
      {:rustler, "~> 0.27.0"}
    ]
  end

  defp package do
    %{
      licenses: ["Apache-2.0", "MIT"],
      maintainers: ["Asato Onishi"],
      links: %{"GitHub" => @repo}
    }
  end
end
