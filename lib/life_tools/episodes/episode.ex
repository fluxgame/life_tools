defmodule LifeTools.Episodes.Episode do
  use Ecto.Schema
  import Ecto.Changeset

  schema "episodes" do
    field :air_date, :date
    field :title, :string
    belongs_to :show, LifeTools.Shows.Show
    field :acknowledged, :boolean

    timestamps()
  end

  @doc false
  def changeset(episode, attrs) do
    episode
    |> cast(attrs, [:title, :air_date])
    |> validate_required([:title, :air_date])
  end
end
