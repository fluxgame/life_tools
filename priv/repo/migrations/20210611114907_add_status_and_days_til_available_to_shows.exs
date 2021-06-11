defmodule LifeTools.Repo.Migrations.AddStatusAndDaysTilAvailableToShows do
  use Ecto.Migration

  def change do
    alter table(:shows) do
      add(:status, :text)
      add(:days_til_available, :integer)
    end
  end
end
