defmodule CodingLibTest do
  use ExUnit.Case
  doctest CodingLib

  test "greets the world" do
    assert CodingLib.hello() == :world
  end
end
