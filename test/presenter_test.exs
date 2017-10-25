defmodule RazorPresenterTest do
  use ExUnit.Case
  doctest Razor.Presenter

  alias Razor.Presenter

  describe "convert_string_to_title" do
    test "with a bunch of punctuation" do
      assert "A B C D 123" = Presenter.convert_string_to_title("a-b.c+d----123  ")
    end
    test "with something that already looks like a title" do
      assert "My Application" = Presenter.convert_string_to_title("My Application")
    end
    test "with camel case" do
      assert "My Application" = Presenter.convert_string_to_title("  myApplication")
    end
    test "with snake case" do
      assert "My Application" = Presenter.convert_string_to_title("my_application")
    end
    test "with dashed" do
      assert "My Application" = Presenter.convert_string_to_title("my-application")
    end
    test "with snake case and mixed capitalization" do
      assert "My A P Plication" = Presenter.convert_string_to_title("MY_aPPlication")
    end
    test "with all caps" do
      assert "Myapplication" = Presenter.convert_string_to_title("MYAPPLICATION")
    end
  end

  describe "convert_string_to_camel" do
    test "with a bunch of punctuation" do
      assert "ABCD123" = Presenter.convert_string_to_camel("a-b.c+d----123  ")
    end
    test "with something that already looks like a camel" do
      assert "MyApplication" = Presenter.convert_string_to_camel("My Application")
    end
    test "with camel case" do
      assert "MyApplication" = Presenter.convert_string_to_camel("  myApplication")
    end
    test "with snake case" do
      assert "MyApplication" = Presenter.convert_string_to_camel("my_application")
    end
    test "with dashed" do
      assert "MyApplication" = Presenter.convert_string_to_camel("my-application")
    end
    test "with snake case and mixed capitalization" do
      assert "MYAPPlication" = Presenter.convert_string_to_camel("MY_aPPlication")
    end
    test "with all caps" do
      assert "MYAPPLICATION" = Presenter.convert_string_to_camel("MYAPPLICATION")
    end
  end

  describe "convert_string_to_dashed" do
    test "with a bunch of punctuation" do
      assert "a-b-c-d-123" = Presenter.convert_string_to_dashed("a-b.c+d----123  ")
    end
    test "with something that already looks like a camel" do
      assert "my-application" = Presenter.convert_string_to_dashed("My Application")
    end
    test "with camel case" do
      assert "myapplication" = Presenter.convert_string_to_dashed("  myApplication")
    end
    test "with snake case" do
      assert "my-application" = Presenter.convert_string_to_dashed("my_application")
    end
    test "with dashed" do
      assert "my-application" = Presenter.convert_string_to_dashed("my-application")
    end
    test "with snake case and mixed capitalization" do
      assert "my-application" = Presenter.convert_string_to_dashed("MY_aPPlication")
    end
    test "with all caps" do
      assert "myapplication" = Presenter.convert_string_to_dashed("MYAPPLICATION")
    end
  end

  describe "convert_string_to_snake" do
    test "with a bunch of punctuation" do
      assert "a_b_c_d_123" = Presenter.convert_string_to_snake("a-b.c+d----123  ")
    end
    test "with something that already looks like a camel" do
      assert "my_application" = Presenter.convert_string_to_snake("My Application")
    end
    test "with camel case" do
      assert "my_application" = Presenter.convert_string_to_snake("  myApplication")
    end
    test "with snake case" do
      assert "my_application" = Presenter.convert_string_to_snake("my_application")
    end
    test "with dashed" do
      assert "my_application" = Presenter.convert_string_to_snake("my-application")
    end
    test "with snake case and mixed capitalization" do
      assert "my_a_p_plication" = Presenter.convert_string_to_snake("MY_aPPlication")
    end
    test "with all caps" do
      assert "myapplication" = Presenter.convert_string_to_snake("MYAPPLICATION")
    end
  end

end
