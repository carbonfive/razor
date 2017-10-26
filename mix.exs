defmodule Razor.Mixfile do
  use Mix.Project

  @build_path "razor_archives"

  @version "0.3.1"

  def project do
    [app: :razor,
     version: @version,
     elixir: "~> 1.5.1",
     build_embedded: true,
     start_permanent: true,
     escript: escript(),
     deps: deps(),
    ]
  end

  def application do
    [applications: [:logger, :poison, :httpoison, :inflex]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.12"},
      {:poison, "~> 3.1"},
      {:inflex, "~> 1.9"},
      {:arguments, "~> 0.1"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
    ]
  end

  defp escript do
    [main_module: Razor.CLI,
     path: "#{build_path()}/razor.ez",
    ]
  end

  def build_path(), do: @build_path

  def version(), do: @version

end
