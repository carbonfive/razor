defmodule Mix.Tasks.Razor.New do
  require Logger
  
  use Mix.Task

  def run(args) do
    {:ok, _started} = Application.ensure_all_started(:razor)

    dir = List.first(args)
    name = List.last(String.split(dir, "/"))

    Logger.info("razor.new dir: #{dir}; name: #{name}")

    Razor.Zapper.zap(name, dir)
  end
end
