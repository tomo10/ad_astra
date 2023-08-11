defmodule AdAstraTest do
  use ExUnit.Case
  doctest AdAstra

  import AdAstra.Cli, only: [parse_args: 1]
  import AdAstra.NinjaAPI, only: [extract_key_from_star: 2]

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

  test "get the declination value from the star json list" do
    star_list = [
      %{
        "absolute_magnitude" => "0.58",
        "apparent_magnitude" => "0.03",
        "constellation" => "Lyra",
        "declination" => "+38° 46′ 58.8″",
        "distance_light_year" => "25",
        "name" => "Vega",
        "right_ascension" => "18h 36m 56.19s",
        "spectral_class" => "A0Vvar"
      }
    ]

    assert extract_key_from_star("right_ascension", {:ok, star_list}) == ["18h 36m 56.19s"]
    assert extract_key_from_star("declination", {:ok, star_list}) == ["+38° 46′ 58.8″"]
  end
end
