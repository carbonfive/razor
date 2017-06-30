defmodule RazorCLITest do
  use ExUnit.Case
  doctest Razor.CLI

  alias Razor.CLI

  describe "parse_args" do
    test "with name flags returns formatted keyword list" do
      args = ["new", "--name", "booga"]

      assert [name: "booga", dir: "./booga"] = CLI.parse_args(args)
    end

    test "with new and name, without flags returns keyword list" do
      args = ["new", "booga"]

      assert [name: "booga", dir: "./booga"] = CLI.parse_args(args)
    end

    test "without a name or new, with flags returns empty list" do
      args = ["--name"]

      assert [] = CLI.parse_args(args)
    end

    test "with too many args, without flags returns empty list" do
      args = ["booga", "something", "wtf"]

      assert [] = CLI.parse_args(args)
    end

    test "with a name, without flags, in wrong direction returns empty list" do
      args = ["booga", "new"]

      assert [] = CLI.parse_args(args)
    end
  end
end

