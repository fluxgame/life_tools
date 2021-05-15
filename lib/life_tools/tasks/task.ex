defmodule LifeTools.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias LifeTools.Tasks.Depend

  schema "tasks" do
    field :completion_date, :date
    field :description, :string
    field :notes, :string
    field :start_date, :date
    field :due_date, :date
    field :today, :boolean
    field :external, :boolean
    belongs_to :project, LifeTools.Projects.Project
    has_many :_depends, Depend
    has_many :depends, through: [:_depends, :depend]
    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [
      :description,
      :start_date,
      :due_date,
      :completion_date,
      :today,
      :project_id,
      :external,
      :notes
    ])
    |> validate_required([:description, :project_id])
  end
end
