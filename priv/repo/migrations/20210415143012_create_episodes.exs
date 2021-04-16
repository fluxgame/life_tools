defmodule LifeTools.Repo.Migrations.CreateEpisodes do
  use Ecto.Migration

  def change do
    create table(:episodes, primary_key: false) do
      add :id, :bigint, primary_key: true
      add :title, :string
      add :air_date, :date
      add :show_id, references(:shows, on_delete: :nothing)
      add :acknowledged, :boolean, default: false, null: false

      timestamps()
    end

    create index(:episodes, [:show_id])
  end
end
