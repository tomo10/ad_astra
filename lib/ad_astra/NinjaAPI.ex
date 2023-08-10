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

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end

  def handle_response({:_, %{status_code: _}, body: body}) do
    {:error, body}
  end
end
