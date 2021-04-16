defmodule TMDB do
  use Tesla

  alias LifeTools.Shows.Show
  alias LifeTools.Episodes.Episode
  alias LifeTools.Repo

  plug Tesla.Middleware.BaseUrl, Application.fetch_env!(:life_tools, :tmdb_base_url)
  plug Tesla.Middleware.JSON

  def add_show(show_id) do
    case fetch_show(show_id) do
      nil -> nil
      response ->
        show = Repo.insert!(%Show{
          id: response["id"],
          title: response["name"],
          url: response["homepage"]
        })
        update_last_and_next(show, response)
    end
  end

  def update_show(show) do
    case fetch_show(show.id) do
      nil -> nil
      response -> update_last_and_next(show, response)
    end
  end

  defp fetch_show(show_id) do
    response = case api_call("/tv/" <> Integer.to_string(show_id)) do
      {:ok, response} -> response.body
      {:error, _} -> nil
    end
  end

  defp update_last_and_next(show, response) do
    last = create_episode(show.id, response["last_episode_to_air"])
    if last, do: Repo.insert!(last)
    next = create_episode(show.id, response["next_episode_to_air"])
    if next, do: Repo.insert!(next)
  end

  defp create_episode(_, nil), do: nil
  defp create_episode(show_id, episode) do
    %Episode{
      id: episode["id"],
      title: parse_title(episode),
      air_date: parse_date(episode["air_date"]),
      show_id: show_id
    }
  end

  defp api_call(query) do
    get(query <> "?api_key=" <> Application.fetch_env!(:life_tools, :tmdb_api_key))
  end

  defp parse_date(date_string) do
    case Date.from_iso8601(date_string) do
      {:ok, date} -> date
      {:error, _} -> nil
    end
  end

  defp parse_title(e) do
    prefix = "S#{two_digit_pad(e["season_number"])}E#{two_digit_pad(e["episode_number"])}"
    if e["name"] == "" do
      prefix
    else
      "#{prefix}: #{e["name"]}"
    end
  end

  defp two_digit_pad(number), do: String.pad_leading(Integer.to_string(number), 2, "0")
end