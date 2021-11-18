defmodule GeneradorTest do
  use ExUnit.Case
  doctest Generador

  test "greets the world" do
    assert Generador.hello() == :world
  end
end
