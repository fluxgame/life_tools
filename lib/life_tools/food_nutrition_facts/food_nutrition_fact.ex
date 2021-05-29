defmodule LifeTools.FoodNutritionFacts.FoodNutritionFact do
  use Ecto.Schema
  import Ecto.Changeset

  schema "food_nutrition_fact" do
    field :quantity, :float
    field :nutrition_fact_id, :id
    field :food_id, :id

    timestamps()
  end

  @doc false
  def changeset(food_nutrition_fact, attrs) do
    food_nutrition_fact
    |> cast(attrs, [:quantity])
    |> validate_required([:quantity])
  end
end
