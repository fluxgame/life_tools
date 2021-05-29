defmodule LifeTools.Repo.Migrations.CreateUnits do
  use Ecto.Migration

  def change do
    create table(:units) do
      add :name, :string
      add :abbreviation, :string
      add :liquid_or_solid, :boolean, default: false, null: false
      add :per_100, :float

      timestamps()
    end

  end
end
