defmodule LifeTools.Repo.Migrations.CreateNutritionFacts do
  use Ecto.Migration

  def change do
    create table(:nutrition_facts) do
      add :name, :string
      add :unit_id, references(:units, on_delete: :nothing)

      timestamps()
    end

    create index(:nutrition_facts, [:unit_id])
  end
end
