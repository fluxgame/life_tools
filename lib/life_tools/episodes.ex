defmodule LifeTools.Episodes do
  @moduledoc """
  The Episodes context.
  """

  import Ecto.Query, warn: false
  alias LifeTools.Repo

  alias LifeTools.Episodes.Episode
  alias LifeTools.IMDB

  @doc """
  Returns the list of episodes.

  ## Examples

      iex> list_episodes()
      [%Episode{}, ...]

  """
  def list_episodes do
    Repo.all(Episode)
  end

  def list_recent_episodes do
    unacknowledged_episodes()
    |> where([e], e.air_date < from_now(0, "day"))
    |> Repo.all()
  end

  def list_upcoming_episodes do
    unacknowledged_episodes()
    |> where([e], e.air_date >= from_now(0, "day"))
    |> Repo.all()
  end

  defp unacknowledged_episodes do
    from(e in Episode)
    |> where([acknowledged: false])
    |> order_by(asc: :air_date)
    |> preload(:show)
  end

  @doc """
  Gets a single episode.

  Raises `Ecto.NoResultsError` if the Episode does not exist.

  ## Examples

      iex> get_episode!(123)
      %Episode{}

      iex> get_episode!(456)
      ** (Ecto.NoResultsError)

  """
  def get_episode!(id), do: Repo.get!(Episode, id)

  @doc """
  Gets the episode with the latest air date for a given show.
  """
  def get_last_episode(show) do
    from(Episode)
    |> where([show_id: ^show.id])
    |> order_by(desc: :air_date)
    |> first()
    |> Repo.one()
  end

  @doc """
  Creates a episode.

  ## Examples

      iex> create_episode(%{field: value})
      {:ok, %Episode{}}

      iex> create_episode(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_episode(attrs \\ %{}) do
    %Episode{}
    |> Episode.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a episode.

  ## Examples

      iex> update_episode(episode, %{field: new_value})
      {:ok, %Episode{}}

      iex> update_episode(episode, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_episode(%Episode{} = episode, attrs) do
    episode
    |> Episode.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a episode.

  ## Examples

      iex> delete_episode(episode)
      {:ok, %Episode{}}

      iex> delete_episode(episode)
      {:error, %Ecto.Changeset{}}

  """
  def delete_episode(%Episode{} = episode) do
    Repo.delete(episode)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking episode changes.

  ## Examples

      iex> change_episode(episode)
      %Ecto.Changeset{data: %Episode{}}

  """
  def change_episode(%Episode{} = episode, attrs \\ %{}) do
    Episode.changeset(episode, attrs)
  end
end
