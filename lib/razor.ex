defmodule Razor.CLI do
  @moduledoc """
    Razor.CLI is responsible for parsing allowed CLI arguments
    and triggering the appropriate generator behavior
  """
  alias Razor.Generator

  @version Razor.Mixfile.version()

  def main(args) do
    args |> Razor.Arguments.parse() |> process
  end

  def process(%{version: true}), do: print_version()

  def process(%{new: true, name: name, dir: dir, repo: repo}) do
    Generator.generate(name, dir, repo)
  end

  def process(%{new: true, name: name, dir: dir}) do
    Generator.generate(name, dir)
  end

  def process(_) do
    print_usage()
  end

  defp print_usage do
    IO.puts("Razor #{@version}")
    IO.puts("Usage:")
    IO.puts("razor new MyApp")
    IO.puts("razor new MyApp2 ~/specific_dir [-r carbonfive/razor-phoenix]")
    IO.puts("razor [-v, --version]")
  end

  defp print_version do
    IO.puts(@version)
  end
end
