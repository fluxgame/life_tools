defmodule LifeTools.Repo.Migrations.CreateShows do
  use Ecto.Migration

  def change do
    create table(:shows, primary_key: false) do
      add :id, :bigint, primary_key: true
      add :title, :string
      add :url, :string

      timestamps()
    end
  end
end
