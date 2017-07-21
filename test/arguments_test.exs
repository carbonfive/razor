defmodule RazorCLITest do
  use ExUnit.Case
  doctest Razor.Arguments

  alias Razor.Arguments

  describe "parse_args" do
    test "with name flags returns formatted parsed map" do
      args = ["new", "--name", "booga"]

      assert %{new: true, name: "booga", dir: "./booga"} = Arguments.parse(args)
    end

    test "with name and dir flags returns formatted parsed map" do
      args = ["new", "--name", "booga", "--dir", "./my_dir"]

      assert %{new: true, name: "booga", dir: "./my_dir"} = Arguments.parse(args)
    end

    test "with new and name, without flags returns parsed map" do
      args = ["new", "booga"]

      assert %{new: true, name: "booga", dir: "./booga"} = Arguments.parse(args)
    end

    test "with new, name and dir, without flags returns parsed map" do
      args = ["new", "booga", "./my_dir"]

      assert %{new: true, name: "booga", dir: "./my_dir"} = Arguments.parse(args)
    end

    test "with non-flag name and dir flag, returns parsed map" do
      args = ["new", "booga", "--dir", "./my_dir"]

      assert %{new: true, name: "booga", dir: "./my_dir"} = Arguments.parse(args)
    end

    test "with name flags without new returns just name" do
      args = ["--name", "booga"]

      assert %{name: "booga"} = Arguments.parse(args)
    end

    test "without a name or new, with flags returns empty map" do
      args = ["--name"]

      assert %{} = Arguments.parse(args)
    end

    test "with too many args, without flags returns empty map" do
      args = ["booga", "something", "wtf"]

      assert %{} = Arguments.parse(args)
    end

    test "with a name, without flags, in wrong direction returns empty map" do
      args = ["booga", "new"]

      assert %{} = Arguments.parse(args)
    end

    test "with a version, flag the version" do
      args = ["--version"]

      assert %{version: true} = Arguments.parse(args)
    end

    test "with a version and new, flag the version" do
      args = ["--version", "new"]

      assert %{version: true} = Arguments.parse(args)
    end

    test "with a v alias, flag the version" do
      args = ["-v"]

      assert %{version: true} = Arguments.parse(args)
    end
  end
end
