defmodule AdAstra.NinjaAPI do
  use HTTPoison.Base

  @api_key [{"X-Api-Key", "IZUmKgtnaQNAGgJdGrdQ3w==fYQue8KWKENTnuh9"}]

  def fetch(star) do
    ninja_url(star)
    |> HTTPoison.get(@api_key)
    |> handle_response()
  end

  def ninja_url(star) do
    "https://api.api-ninjas.com/v1/stars?name=#{star}"
  end

  def handle_response({_, %{status_code: status_code, body: body}}) do
    {
      status_code |> check_for_error(),
      body |> Poison.Parser.parse!()
    }
  end

  defp check_for_error(200), do: :ok
  defp check_for_error(_), do: :error
end
