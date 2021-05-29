defmodule LifeTools.Repo.Migrations.CreateFoods do
  use Ecto.Migration

  def change do
    create table(:foods) do
      add :name, :string
      add :friendly_name, :string
      add :density, :float
      add :standard_unit_id, references(:units, on_delete: :nothing)

      timestamps()
    end

    create index(:foods, [:standard_unit_id])
  end
end
