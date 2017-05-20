defmodule Mix.Tasks.Razor.New do
  require Logger
  
  use Mix.Task

  def run(args) do

    dir = List.first(args)
    name = List.last(String.split(dir, "/"))

    Logger.info("razor.new dir: #{dir}; name: #{name}")

    # FIXME: Why doesn't this work?
    # Razor.Zapper.zap(name, dir)

    razor_cmd = "#{File.cwd!}/razor"    
    Logger.info("Running with #{razor_cmd}.")   
    {_, 0} = System.cmd(razor_cmd, ["--name", name, "--dir", dir])
  end
end
