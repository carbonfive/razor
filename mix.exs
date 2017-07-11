defmodule Razor.Mixfile do
  use Mix.Project

  @build_path "razor_archives"
  
  def project do
    [app: :razor,
     version: "0.0.1",
     elixir: "~> 1.4.5",
     build_embedded: true,
     start_permanent: true,
     escript: escript(),
     deps: deps(),
    ]
  end

  def application do
    [applications: [:logger, :httpoison, :inflex]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.12"},
      {:poison, "~> 3.1"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:inflex, "~> 1.8"}    
    ]
  end

  defp escript do
    [main_module: Razor.CLI,
     path: "#{build_path()}/razor.ez",
    ]
  end

  def build_path(), do: @build_path

end
