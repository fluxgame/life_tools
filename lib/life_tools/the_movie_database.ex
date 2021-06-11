defmodule LifeTools.TheMovieDatabase do
  use Tesla

  alias LifeTools.Shows
  alias LifeTools.Episodes

  plug Tesla.Middleware.BaseUrl, Application.fetch_env!(:life_tools, :tmdb_base_url)
  plug Tesla.Middleware.JSON

  def add_show(show_id, days_til_available \\ 1) do
    case fetch_show(show_id) do
      nil ->
        nil

      response ->
        {:ok, show} =
          Shows.create_show(%{
            id: response["id"],
            title: response["name"],
            url: response["homepage"],
            status: response["status"],
            days_til_available: days_til_available
          })

        update_last_and_next(show, response)
    end
  end

  def update_shows(force \\ false) do
    Enum.each(Shows.list_shows(), fn show ->
      if show.status != "Ended", do: update_show(show, force)
    end)
  end

  def update_show(show, force \\ false) do
    last_episode = Episodes.get_last_episode(show)

    if force or !last_episode or before_today?(last_episode.air_date) do
      case fetch_show(show.id) do
        nil ->
          nil

        response ->
          show = Shows.update_show(show, %{title: response["name"], status: response["status"]})
          update_last_and_next(show, response)
      end
    end
  end

  def fetch_show(show_id) do
    case api_call("/tv/" <> Integer.to_string(show_id)) do
      {:ok, response} -> response.body
      {:error, _} -> nil
    end
  end

  defp before_today?(date), do: Date.compare(date, Date.utc_today()) == :lt

  defp update_last_and_next(show, response) do
    Episodes.create_or_update_episode(gen_episode_attrs(show, response["last_episode_to_air"]))
    Episodes.create_or_update_episode(gen_episode_attrs(show, response["next_episode_to_air"]))
  end

  defp gen_episode_attrs(_, nil), do: nil

  defp gen_episode_attrs(show, episode) do
    %{
      id: episode["id"],
      title: parse_title(episode),
      air_date: Date.add(parse_date(episode["air_date"]), show.days_til_available),
      show_id: show.id
    }
  end

  def api_call(query) do
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
