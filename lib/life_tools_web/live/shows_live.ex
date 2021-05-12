defmodule LifeToolsWeb.ShowsLive do
  use LifeToolsWeb, :live_view

  alias LifeTools.Episodes

  def mount(_params, _session, socket) do
    recent = Episodes.list_recent_episodes()
    upcoming = Episodes.list_upcoming_episodes()
    {:ok, assign(socket, recent: recent, upcoming: upcoming)}
  end

  def handle_event("acknowledge", %{"id" => id}, socket) do
    Episodes.acknowledge_episode(String.to_integer(id))

    {:noreply, assign(socket, recent: Episodes.list_recent_episodes())}
  end

  def render_episode_table(episodes, allow_acknowledge) do
    assigns = %{episodes: episodes, allow_acknowledge: allow_acknowledge}

    if Enum.empty?(episodes) do
      ~L"""
        <p>Nothing to show.</p>
      """
    else
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
                <td><a target="#new" href="<%= episode.show.url %>"><%= episode.show.title %></a></td>
                <td><%= episode.title %></td>
                <td>
                  <%= episode.air_date %>
                  <%= if @allow_acknowledge do %>
                  <a phx-click="acknowledge" phx-value-id="<%= episode.id %>">❌</a>
                  <% end %>
                </td>
            </tr>
            <% end %>
            </tbody>
        </table>
      """
    end
  end
end
