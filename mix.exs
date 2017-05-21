defmodule Razor.Mixfile do
  use Mix.Project

  @version "0.0.2"
  
  def project do
    [app: :razor,
     version: @version,
     elixir: "~> 1.4.2",
     escript: [main_module: Razor],
     deps: deps(),
     aliases: aliases()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.11.1"},
      {:poison, "~> 3.1"},
      {:inflex, "~> 1.8"}      
    ]
  end

  defp build_releases(_) do
    Mix.Tasks.Compile.run([])
    Mix.Tasks.Archive.Build.run([])
    Mix.Tasks.Archive.Build.run(["--output=razor.ez"])
    File.rename("razor.ez", "./razor-archives/razor.ez")
    File.rename("razor-#{@version}.ez", "./razor-archives/razor-#{@version}.ez")
  end

  defp aliases do
    [
      build: [ &build_releases/1]
    ]
  end
end
