defmodule HelloCrawler do
  @moduledoc """
  Documentation for HelloCrawler.
  """

  @doc """
  Hello world.

  ## Examples

      iex> HelloCrawler.hello
      :world

  """

  def handle_response({:ok, %{body: body}}, url) do
    [url | body
    |> Floki.find("a")
    |>Floki.attribute("href")]
  end
  def handle_response(_response, url) do
    [url]
  end

  def get_links(url) do
    headers = []
    options = [follow_redirect: true]
    url
    |> HTTPoison.get(headers, options)
    |> handle_response(url)
  end

#   with {:ok, %{body: body}} <-  HTTPoison.get(url, [], follow_redirect: true),
  #      tags  <- Floki.find(body, "a")
  #      hrefs <- Floki.attribute(tags, "href") do
  #   [url | href]
  # else
  #   _ -> [url]
  # end
end
