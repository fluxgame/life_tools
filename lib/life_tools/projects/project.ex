defmodule LifeTools.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :context, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :context])
    |> validate_required([:name, :context])
  end
end
