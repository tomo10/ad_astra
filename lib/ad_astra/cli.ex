defmodule AdAstra.Cli do
  @default_count 4
  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions that end up generating a table of the last _n_ starts fromt the api
  """

  def run(argv), do: parse_args(argv)

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
end
