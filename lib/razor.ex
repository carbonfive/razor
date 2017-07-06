defmodule Razor.CLI do
  @moduledoc """
    Razor.CLI is responsible for parsing allowed CLI arguments
    and triggering the appropriate Zapper behavior
  """
  alias Razor.Zapper

  def main(args) do
    args |> parse_args |> process
  end

  def process([]) do
    print_usage()
  end
  def process(options) do
    Zapper.zap(options[:name], options[:dir])
  end

  def parse_args(args) do
    switches = [dir: :string, name: :string]
    parsed_args = OptionParser.parse(args, switches: switches)

    parsed_args
    |> format_args
  end

  defp format_args({[], ["new", name], _}), do: [name: name, dir: "./#{name}"]
  defp format_args({[], ["new", name, dir], _}), do: [name: name, dir: dir]
  defp format_args({[dir: dir], ["new", name], _}), do: [name: name, dir: dir]
  defp format_args({[name: name], ["new", dir], _}), do: [name: name, dir: dir]
  defp format_args({[name: name], ["new"], _}), do: [name: name, dir: "./#{name}"]
  defp format_args({[name: name, dir: dir], ["new"], _}), do: [name: name, dir: dir]
  defp format_args({[], [_| _], _}), do: []
  defp format_args({_options, [], _}), do: []

  defp print_usage do
    IO.puts "Usage:"
    IO.puts "razor new project_name"
    IO.puts "razor new --name project_name --dir ../some_directory"
  end
end
