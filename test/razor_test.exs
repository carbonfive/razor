defmodule RazorCLITest do
  use ExUnit.Case
  doctest Razor.CLI

  alias Razor.CLI

  describe "parse_args" do
    test "with name flags returns formatted keyword list" do
      args = ["new", "--name", "booga"]

      assert [name: "booga", dir: "./booga"] = CLI.parse_args(args)
    end

    test "with name and dir flags returns formatted keyword list" do
      args = ["new", "--name", "booga", "--dir", "./my_dir"]

      assert [name: "booga", dir: "./my_dir"] = CLI.parse_args(args)
    end

    test "with new and name, without flags returns keyword list" do
      args = ["new", "booga"]

      assert [name: "booga", dir: "./booga"] = CLI.parse_args(args)
    end

    test "with new, name and dir, without flags returns keyword list" do
      args = ["new", "booga", "./my_dir"]

      assert [name: "booga", dir: "./my_dir"] = CLI.parse_args(args)
    end

    test "with non-flag name and dir flag, returns keyword list" do
      args = ["new", "booga", "--dir", "./my_dir"]

      assert [name: "booga", dir: "./my_dir"] = CLI.parse_args(args)
    end

    test "with non-flag dir and name flag, returns keyword list" do
      args = ["new", "--name", "booga", "./my_dir"]

      assert [name: "booga", dir: "./my_dir"] = CLI.parse_args(args)
    end

    test "with name flags without new returns empty list" do
      args = ["--name", "booga"]

      assert [] = CLI.parse_args(args)
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

    test "with a version, flag the version" do
      args = ["--version"]

      assert [version: true] = CLI.parse_args(args)
    end

    test "with a version and new, flag the version" do
      args = ["--version", "new"]

      assert [version: true] = CLI.parse_args(args)
    end

    test "with a v alias, flag the version" do
      args = ["-v"]

      assert [version: true] = CLI.parse_args(args)
    end
  end
end
