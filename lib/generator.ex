defmodule Razor.Generator do
  require Logger
  alias Razor.Presenter
  @default_repo "carbonfive/razor-phoenix"
  @moduledoc """
  Razor.Generator downloads the prototype project and
  copies it to the destination directory. Much awesome.
  """

  def generate(name) do
    generate(name, "./")
  end

  def generate(name, dir, prototype_repo \\ @default_repo) do
    Logger.info "Cutting #{name}..."

    with :ok <- check_target(dir),
      :ok <- Presenter.print_plan(dir, name, prototype_repo),
      {:ok, prototype} <- fetch_prototype(prototype_repo),
      {:ok, _} <- copy_prototype(dir, prototype),
      :ok <- rename_app(dir, name),
      :ok <- configure_new_app(dir),
      :ok <- Presenter.print_next_steps(dir)
    do
      Logger.info "Done."
    else
      {:error, message} ->
        Logger.error(message)
    end
  end

  def check_target(nil), do: check_target("./")
  def check_target(dir) do
    :ok = create_dir_if_missing(dir, File.exists?(dir))
    {:ok, files} = File.ls(dir)

    case length(files) do
      0 -> :ok
      _ ->
        error_message = "Misfire! The target directory isn't empty... aim elsewhere."
        {:error, error_message}
    end
  end

  def fetch_prototype(prototype_repo) do
    Logger.info "Checking for the latest application prototype..."

    # Check if we can connect, or fail
    # gracefully and use the latest cached version.

    latest_tag_obj = fetch_latest_tag(prototype_repo)
    latest_tag     = latest_tag_obj["name"]
    tarball_url    = latest_tag_obj["tarball_url"]
    Logger.info " #{latest_tag}."

    cached_prototypes_dir = "#{System.user_home()}/.razor"
    prototype_full_path =
      "#{cached_prototypes_dir}/#{String.replace(prototype_repo, "/", "--")}-#{latest_tag}.tar.gz"

    tarball = get_repo_tarball(prototype_full_path,
                               cached_prototypes_dir,
                               tarball_url,
                               File.exists?(prototype_full_path)
                             )
    {:ok, tarball}
  end

  def rename_app(dir, name) do
    replacements = %{
      "AppPrototype"  => Presenter.convert_string_to_camel(name),
      "app-prototype" => Presenter.convert_string_to_dashed(name),
      "app_prototype" => Presenter.convert_string_to_snake(name),
      "App Prototype" => Presenter.convert_string_to_title(name)
    }

    # rename lib dir
    snake_proto_name = "app_prototype"
    snake_new_name = replacements[snake_proto_name]
    File.rename("#{dir}/lib/#{snake_proto_name}",
                "#{dir}/lib/#{snake_new_name}")
    File.rename("#{dir}/lib/#{snake_proto_name}_web",
                "#{dir}/lib/#{snake_new_name}_web")

      files = get_all_files(dir)

      Enum.each(files, fn(filename) ->
        Enum.each(replacements, fn({proto_name, new_name}) ->
          # change file contents
          {:ok, contents} = File.read(filename)
          updated_contents = String.replace(contents, proto_name, new_name)
          :ok = File.write!(filename, updated_contents)

          # rename files
          new_filename = String.replace(filename, proto_name, new_name)
          File.rename(filename, new_filename)
        end)
      end)
  end

  defp get_all_files(path) do
    cond do
      File.regular?(path) -> [path]
      File.dir?(path) ->
        files = File.ls!(path)

        files
        |> Enum.map(&Path.join(path, &1))
        |> Enum.map(&get_all_files/1)
        |> Enum.concat()
      true -> []
    end
  end

  # Already cached
  defp get_repo_tarball(prototype, _, _, true) do
    Logger.info " Using cached version."
    prototype
  end

  # Missing from filesystem, retrieve & cache
  defp get_repo_tarball(prototype, cached_prototypes_dir, tarball_url, false) do
    Logger.info " No cached version found, downloading..."

    # Download the tarball and install in the cache.
    :ok = create_dir_if_missing(cached_prototypes_dir,
                                File.exists?(cached_prototypes_dir))
    {"", 0} = System.cmd("curl", ["-s", "-L", tarball_url, "-o", prototype])

    Logger.info " done!"

    prototype
  end

  def fetch_latest_tag(repo) do
    url = "https://api.github.com/repos/#{repo}/tags"

    with {:ok, response} <- HTTPoison.get(url, timeout: 1_000_000),
      :ok <- check_response(response)
    do
      response.body
      |> Poison.decode!
      |> List.first
    else
      {:error, %HTTPoison.Error{reason: reason}} ->
        Logger.error("Error retrieving from #{url}: #{reason}")
      {:error, message} ->
        Logger.error("Error retrieving from #{url}: #{message}")
    end
  end

  defp check_response(%{status_code: 200}), do: :ok
  defp check_response(%{status_code: 404}), do: {:error, "File not found."}
  defp check_response(%{status_code: status_code}), do: {:error, "Unhandled status code #{status_code}"}

  defp create_dir_if_missing(_dir, true) do
    :ok
  end
  defp create_dir_if_missing(dir, false) do
    File.mkdir!(dir)
  end

  defp copy_prototype(app_dir, prototype) do
    File.mkdir_p(app_dir)

    tar_args = ["-zxf", prototype, "-C", app_dir, "--strip=1"]
    system_call = System.cmd("tar", tar_args, stderr_to_stdout: true)

    system_call
    |> case do
      {message, 0} -> {:ok, message}
      {reason, 1}  -> {:error, reason}
    end
  end

  # Shell function for parity w/ raygun
  defp configure_new_app(dir) do
    initialize_git(dir)
  end

  defp initialize_git(dir) do
    File.cd!(dir)
    {_, 0} = System.cmd("git", ["init"])
    {_, 0} = System.cmd("git", ["add", "-A", "."])
    {_, 0} = System.cmd("git", ["commit", "-m", "App skeleton cut with Razor."])
    :ok
  end
end
