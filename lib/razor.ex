defmodule Razor do
  def main(args) do
    args |> parse_args |> process
  end

  def process([]) do
    print_usage()
  end

  def process(options) do
    Razor.Zapper.zap(options[:name], options[:dir])
  end

  defp parse_args(args) do
    {options, _, _} = OptionParser.parse(
      args,
      switches: [dir: :string, name: :string]
    )
    options
  end

  defp print_usage do
    IO.puts "Usage: razor --name AppName --dir dir_name"
  end
  
end
