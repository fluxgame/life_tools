defmodule LifeTools.Repo.Migrations.AirDateAndShowIdNotNullOnEpisodes do
  use Ecto.Migration

  def up do
    alter table(:episodes) do
      modify :air_date, :date, null: false
      modify :show_id, :integer, null: false
    end
  end

  def down do
    alter table(:episodes) do
      modify :air_date, :date, null: true
      modify :show_id, :integer, null: true
    end
  end
end
