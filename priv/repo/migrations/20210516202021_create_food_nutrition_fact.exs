defmodule LifeTools.Repo.Migrations.CreateFoodNutritionFact do
  use Ecto.Migration

  def change do
    create table(:food_nutrition_fact) do
      add :quantity, :float
      add :nutrition_fact_id, references(:nutrition_facts, on_delete: :nothing)
      add :food_id, references(:foods, on_delete: :nothing)

      timestamps()
    end

    create index(:food_nutrition_fact, [:nutrition_fact_id])
    create index(:food_nutrition_fact, [:food_id])
  end
end
