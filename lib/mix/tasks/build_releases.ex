defmodule Mix.Tasks.BuildReleases do
  use Mix.Task

  @version Mix.Project.config[:version]
  
  @shortdoc "Builds releases called razor and razor-<version> in razor_archives/"
  def run(_) do
    Mix.Tasks.Compile.run([])
    Mix.Tasks.Escript.Build.run([])
    File.rename("#{build_path()}/razor.ez", "#{build_path()}/razor")
    File.cp("#{build_path()}/razor.ez", "#{build_path()}/razor-#{version()}")
    success_message()
  end

  defp version(), do: @version

  defp success_message() do
    IO.puts "Generated escript razor_archives/razor-#{version()} with MIX_ENV=#{Mix.env}"
  end
  
  def build_path(), do: Razor.Mixfile.build_path()
end

