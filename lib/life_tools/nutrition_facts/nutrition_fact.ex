defmodule LifeTools.NutritionFacts.NutritionFact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nutrition_facts" do
    field :name, :string
    field :unit_id, :id

    timestamps()
  end

  @doc false
  def changeset(nutrition_fact, attrs) do
    nutrition_fact
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
