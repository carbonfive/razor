defmodule Razor.Mixfile do
  use Mix.Project

  def project do
    [app: :razor,
     version: version(),
     elixir: "~> 1.4.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,     
     escript: [main_module: Razor],
     deps: deps(),
     aliases: aliases(),
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :httpoison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.11.1"},
      {:poison, "~> 3.1"},
      {:inflex, "~> 1.8"}      
    ]
  end

  defp version() do
    System.get_env("VERSION")
      || raise "Version environment variable is required, i.e. VERSION=1.0.0 mix build"
  end

  defp aliases() do
    [
      build: [ &build_releases/1],
    ]
  end

  defp build_releases(_) do
    Mix.Tasks.Compile.run([])
    Mix.Tasks.Archive.Build.run([])
    Mix.Tasks.Archive.Build.run(["--output=razor.ez"])
    File.rename("razor.ez", "./razor_archives/razor.ez")
    File.rename("razor-#{version()}.ez", "./razor_archives/razor-#{version()}.ez")
  end  
  
end
