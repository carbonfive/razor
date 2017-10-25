defmodule Razor.Presenter do
  require Logger
  @moduledoc """
  Razor.Presenter displays information about the generated project
  """

  def print_plan(target_dir, title_name, prototype_repo) do
    art = ~S"""

    __________
    \______   \_____  ___________________
     |       _/\__  \ \___   /  _ \_  __ \
     |    |   \ / __ \_/    (  <_> )  | \/
     |____|_  /(____  /_____ \____/|__|
            \/      \/      \/
    """

    Logger.info art
    Logger.info "Razor will create your new phoenix app in directory: #{target_dir}"
    Logger.info "- Application Name: #{title_name}"
    Logger.info "- Project Template: #{prototype_repo}"
    Logger.info "- Elixir Version:    Not yet determined."
    :ok
  end

  def print_next_steps(dir) do
    IO.puts """
    // Your new application has been cut! Next steps... //

    $ cd #{dir}

    # Resolve application dependencies
    $ mix deps.get

    # Set up your database, named after the application
    $ mix ecto.setup

    # Install your javascript dependencies (you'll need yarn installed and in your path)
    $ yarn install

    # Build your javascript dependencies (you'll need brunch installed and in your path)
    # For a local copy, install brunch from here and add node_modules/.bin to your path
    $ brunch build

    # Run the initial tests (they should all pass)
    $ mix test

    # Generate a secret key base, which you'll use to run your server
    $ mix phoenix.gen.secret

    # Run your server (use the key you generated as the value for SECRET_KEY_BASE)
    $ MIX_ENV=dev SECRET_KEY_BASE= mix phoenix.server

    $ open http://127.0.0.1:4000

    For more detailed instructions, visit https://github.com/carbonfive/razor.
    Enjoy your Carbon Five flavored Phoenix application!
    """
  end

  def print_next_steps(_, _) do
    IO.puts """
    // Your new application has been cut by Razor! //

    Enjoy your Carbon Five-flavored application.
    """
  end

  def convert_string_to_camel(string) do
    string
    |> Inflex.camelize
  end

  def convert_string_to_dashed(string) do
    string
    |> Inflex.parameterize
  end

  def convert_string_to_snake(string) do
    string
    |> Inflex.underscore
  end

  def convert_string_to_title(string) do
    string
    |> convert_string_to_snake()
    |> String.replace("_", " ")
    |> String.split()
    |> Enum.map(&(String.capitalize(&1)))
    |> Enum.join(" ")
  end

end
