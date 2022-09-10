defmodule ElixirDev.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_dev,
      version: "0.1.0",
      elixir: System.fetch_env!("ELIXIR_VERSION") |> String.trim(),
      start_permanent: Mix.env() == :prod,
      description: "Example Elixir Dev Environment",
      deps: deps(),
      package: package()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package() do
    %{
      licenses: ["Apache-2.0"],
      maintainers: ["Max Wilson"],
      links: %{}
    }
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end
end
