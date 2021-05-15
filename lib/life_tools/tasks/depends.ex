defmodule LifeTools.Tasks.Depend do
  use Ecto.Schema
  alias LifeTools.Tasks.Task

  schema "task_dependencies" do
    belongs_to :task, Task
    belongs_to :depend, Task

    timestamps()
  end
end
