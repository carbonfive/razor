defmodule Razor.CLI do
  def main(args) do
    args |> parse_args |> process
  end

  def process([]) do
    print_usage()
  end
  def process(options) do
    Razor.Zapper.zap(options[:name], options[:dir])
  end

  def parse_args(args) do
    OptionParser.parse(args, switches: [dir: :string, name: :string])
    |> format_args
  end

  defp format_args({[], ["new", name], _}), do: [name: name, dir: "./#{name}"]
  defp format_args({[name: name], ["new"], _}), do: [name: name, dir: "./#{name}"]
  defp format_args({[], [_, _], _}), do: []
  defp format_args({[], [_| _], _}), do: []
  defp format_args({options, [], _}), do: []

  defp print_usage do
    IO.puts "Usage:"
    IO.puts "razor new project_name"
    IO.puts "razor new --name project_name"
  end
end
