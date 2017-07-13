defmodule Razor.CLI do
  @moduledoc """
    Razor.CLI is responsible for parsing allowed CLI arguments
    and triggering the appropriate generator behavior
  """
  alias Razor.Generator

  @version Razor.Mixfile.version()

  def main(args) do
    args |> parse_args |> process
  end

  def process([]) do
    print_usage()
  end
  def process(options) do
    if options[:version] do
      print_version()
    else
      Generator.generate(options[:name], options[:dir])
    end
  end

  def parse_args(args) do
    switches = [dir: :string, name: :string, version: :boolean]
    aliases = [v: :version]
    parsed_args = OptionParser.parse(args, switches: switches, aliases: aliases)

    parsed_args
    |> format_args
  end

  defp format_args({[version: true], _, _}), do: [version: true]
  defp format_args({[], ["new", name], _}), do: [name: name, dir: "./#{name}"]
  defp format_args({[], ["new", name, dir], _}), do: [name: name, dir: dir]
  defp format_args({[dir: dir], ["new", name], _}), do: [name: name, dir: dir]
  defp format_args({[name: name], ["new", dir], _}), do: [name: name, dir: dir]
  defp format_args({[name: name], ["new"], _}), do: [name: name, dir: "./#{name}"]
  defp format_args({[name: name, dir: dir], ["new"], _}), do: [name: name, dir: dir]
  defp format_args({[], [_| _], _}), do: []
  defp format_args({_options, [], _}), do: []

  defp print_usage do
    IO.puts "Razor #{@version}"
    IO.puts "Usage:"
    IO.puts "razor new project_name"
    IO.puts "razor new --name project_name --dir ../some_directory"
  end

  defp print_version do
    IO.puts @version
  end
end
