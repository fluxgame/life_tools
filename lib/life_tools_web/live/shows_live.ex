defmodule LifeToolsWeb.ShowsLive do
  use LifeToolsWeb, :live_view

  alias LifeTools.Episodes

  def mount(_params, _session, socket) do
    recent = Episodes.list_recent_episodes()
    upcoming = Episodes.list_upcoming_episodes()
#    IO.inspect recent
    {:ok, assign(socket, recent: recent, upcoming: upcoming)}
  end


  def render_episode_table(episodes) do
    assigns = %{episodes: episodes}
    ~L"""
      <table>
          <thead>
          <tr>
              <th>Show Name</th>
              <th>Episode Name</th>
              <th>Air Date</th>
          </tr>
          </thead>
          <tbody>
          <%= for episode <- episodes do %>
          <tr>
              <td><a href="<%= episode.show.url %>"><%= episode.show.title %></a></td>
              <td><%= episode.title %></td>
              <td><%= episode.air_date %></td>
          </tr>
          <% end %>
          </tbody>
      </table>
    """
  end
end