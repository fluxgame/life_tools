defmodule LifeTools.Units.Unit do
  use Ecto.Schema
  import Ecto.Changeset

  schema "units" do
    field :abbreviation, :string
    field :liquid_or_solid, :boolean, default: false
    field :name, :string
    field :per_100, :float

    timestamps()
  end

  @doc false
  def changeset(unit, attrs) do
    unit
    |> cast(attrs, [:name, :abbreviation, :liquid_or_solid, :per_100])
    |> validate_required([:name, :abbreviation, :liquid_or_solid, :per_100])
  end
end
