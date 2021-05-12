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
    |> cast(attrs, [:id, :title, :air_date, :show_id, :acknowledged])
    |> validate_required([:id, :title, :air_date, :show_id])
  end
end
