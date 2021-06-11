defmodule LifeTools.Shows.Show do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shows" do
    field :title, :string
    field :url, :string
    field :status, :string
    field :days_til_available, :integer

    timestamps()
  end

  @doc false
  def changeset(show, attrs) do
    show
    |> cast(attrs, [:id, :title, :url, :status, :days_til_available])
    |> validate_required([:id, :title, :status, :days_til_available])
  end
end
