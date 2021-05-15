defmodule LifeTools.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :description, :string
      add :start_date, :date, null: false, default: fragment("now()")
      add :due_date, :date
      add :completion_date, :date
      add :notes, :string
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :today, :boolean, default: false, null: false
      add :external, :boolean, default: false, null: false
      timestamps()
    end

    create index(:tasks, [:project_id])

    create table(:task_dependencies) do
      add :task_id, references(:tasks, on_delete: :nothing), primary_key: true
      add :depend_id, references(:tasks, on_delete: :nothing), primary_key: true

      timestamps()
    end
  end
end
