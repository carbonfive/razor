defmodule ZapperTest do
  use ExUnit.Case
  doctest Razor.Zapper

  alias Razor.Zapper

  test "check_target passes for empty dirs" do
    test_path = "/tmp/razor-test"
    File.rmdir! test_path
    File.mkdir! test_path
    result = Zapper.check_target(test_path)
    assert result === :ok
  end
  test "check_target fails for full dirs" do
    Zapper.check_target("./")
    {:error, _result} = Zapper.check_target("./")
  end
  
end
