defmodule LifeTools.Shows.Show do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shows" do
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(show, attrs) do
    show
    |> cast(attrs, [:id, :title, :url])
    |> validate_required([:id, :title])
  end
end
