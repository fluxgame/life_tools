defmodule LifeTools.Tasks do
  @moduledoc """
  The Tasks context.
  """

  import Ecto.Query, warn: false
  alias LifeTools.Repo

  alias LifeTools.Tasks.Task
  alias LifeTools.Tasks.Depend

  @doc """
  Returns the list of tasks.

  ## Examples

      iex> list_tasks()
      [%Task{}, ...]

  """
  def list_tasks do
    Repo.all(Task)
  end

  defp task_list_query("all") do
    from(t in Task)
    |> join(:inner, [t], p in assoc(t, :project))
    |> preload([_t, p], project: p)
    |> order_by(asc: :inserted_at)
  end

  defp task_list_query(context) do
    task_list_query("all")
    |> where([_t, p], p.context == ^context)
  end

  def list_todays_tasks(context) do
    task_list_query(context)
    |> where(today: true)
    |> Repo.all()
  end

  def list_next_tasks(context) do
    task_list_query(context)
    |> where(today: false)
    |> where(external: false)
    |> where([t], t.start_date <= ^Date.utc_today())
    |> where([t], is_nil(t.completion_date))
    |> where([t], t.id not in subquery(tasks_with_active_depends()))
    |> Repo.all()
  end

  def list_outstanding_external_tasks(context) do
    task_list_query(context)
    |> where(external: true)
    |> where([t], is_nil(t.completion_date))
    |> Repo.all()
  end

  defp tasks_with_active_depends do
    from td in Depend,
      distinct: true,
      select: td.task_id,
      join: deps in Task,
      on: td.depend_id == deps.id and is_nil(deps.completion_date)
  end

  def mark_complete(id) do
    task = get_task!(id)
    update_task(task, %{completion_date: Date.utc_today()})

    if String.starts_with?(task.description, "order ") do
      delivery_task =
        create_task(%{
          description: String.replace_suffix(task.description, "order", "wait for delivery of "),
          external: true
        })

      Ecto.Adapters.SQL.query!(
        Repo,
        "UPDATE task_dependencies set task_id = $1 where task_id = $2",
        [delivery_task.id, task.id]
      )
    end
  end

  def move_to_today(id) do
    get_task!(id)
    |> update_task(%{today: true})
  end

  def depend_options_for(task) do
    from(t in Task)
    |> order_by(desc: :inserted_at)
    |> where([t], t.project_id == ^task.project_id)
    |> where([t], t.id != ^task.id)
    |> select([t], {t.description, t.id})
    |> Repo.all()
  end

  @doc """
  Gets a single task.

  Raises `Ecto.NoResultsError` if the Task does not exist.

  ## Examples

      iex> get_task!(123)
      %Task{}

      iex> get_task!(456)
      ** (Ecto.NoResultsError)

  """
  def get_task!(id), do: Repo.get!(Task, id)

  def get_task_with_depends!(id) do
    get_task!(id) |> Repo.preload(:depends)
    # from(t in Task)
    # |> where([t], t.id == ^id)
    # |> preload(:depends)
    # |> Repo.get!()
  end

  @doc """
  Creates a task.

  ## Examples

      iex> create_task(%{field: value})
      {:ok, %Task{}}

      iex> create_task(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a task.

  ## Examples

      iex> update_task(task, %{field: new_value})
      {:ok, %Task{}}

      iex> update_task(task, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_task(%Task{} = task, attrs) do
    IO.inspect(attrs)

    Repo.transaction(fn ->
      if Map.has_key?(attrs, "depends") do
        Repo.delete_all(from d in Depend, where: d.task_id == ^task.id)

        for depend <- attrs["depends"] do
          Repo.insert!(%Depend{task_id: task.id, depend_id: String.to_integer(depend)})
        end
      end

      task
      |> Task.changeset(attrs)
      |> Repo.update()
    end)
  end

  @doc """
  Deletes a task.

  ## Examples

      iex> delete_task(task)
      {:ok, %Task{}}

      iex> delete_task(task)
      {:error, %Ecto.Changeset{}}

  """
  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking task changes.

  ## Examples

      iex> change_task(task)
      %Ecto.Changeset{data: %Task{}}

  """
  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end
end
