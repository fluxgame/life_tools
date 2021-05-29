defmodule LifeTools.Repo.Migrations.CreateFoodLogs do
  use Ecto.Migration

  def change do
    create table(:food_logs) do
      add :consumed_at, :utc_datetime
      add :quantity, :float
      add :food_id, references(:foods, on_delete: :nothing)

      timestamps()
    end

    create index(:food_logs, [:food_id])
  end
end
