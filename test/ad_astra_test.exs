defmodule AdAstraTest do
  use ExUnit.Case
  doctest AdAstra

  import AdAstra.Cli, only: [parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "2 args returned in two given" do
    assert parse_args(["star", "constellation"]) == {"star", "constellation"}
  end

  test "greets the world" do
    assert AdAstra.hello() == :world
  end
end
