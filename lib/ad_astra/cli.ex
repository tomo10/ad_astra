defmodule AdAstra.Cli do
  @default_count 4
  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions that end up generating a table of the last _n_ starts fromt the api
  """

  def run(argv) do
    argv
    |> parse_args()
    |> process()
  end

  @doc """
  'argv' can be -h or --help which returns :help
  Otherwise it is a star name, constellation (optionally) the number of stars to return (not implemented)
  """

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parse do
      {[help: true], _, _} ->
        :help

      {_, [star, constellation], _} ->
        {star, constellation}

      _ ->
        :help
    end
  end

  def process(:help) do
    IO.puts("""
      usage: stars
    """)

    System.halt(0)
  end

  def process({star, constellation}) do
    AdAstra.NinjaAPI.fetch(star)
    |> decode_response()
  end

  def decode_response({:ok, body}), do: body

  def decode_response({:error, error}) do
    IO.puts("Error fetching from ninja stars api: #{error["message"]}")
    System.halt(2)
  end
end
