defmodule LifeToolsWeb.TodoLive do
  use LifeToolsWeb, :live_view

  alias LifeTools.Projects
  alias LifeTools.Projects.Project
  alias LifeTools.Tasks
  alias LifeTools.Tasks.Task

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_current_context("all")
      |> assign_context_options()
    {:ok, socket}
  end

  def handle_event("set-context", %{"contexts" => context}, socket) do
    {:noreply, assign_current_context(socket, context)}
  end

  def handle_event("mark-complete", %{"task_ids" => ids}, socket) do
    for id <- ids do
      Tasks.mark_complete(String.to_integer(id))
    end

    {:noreply, assign_current_tasks(socket)}
  end

  def handle_event("move-to-today", %{"task_ids" => ids}, socket) do
    for id <- ids do
      Tasks.move_to_today(String.to_integer(id))
    end

    {:noreply, assign_current_tasks(socket)}
  end

  def handle_event("edit-project", %{"id" => id}, socket) do
    project =
      if id == "new" do
        %Project{}
      else
        Projects.get_project!(String.to_integer(id))
      end

    project_changeset = Projects.change_project(project, %{})
    {:noreply, assign(socket, project_changeset: project_changeset)}
  end

  def handle_event("cancel-edit-project", _, socket) do
    {:noreply, clear_edit_project_form_from(socket)}
  end

  def handle_event("save-project", %{"project" => params}, socket) do
    case Projects.create_project(params) do
      {:ok, _} ->
        {:noreply, clear_edit_project_form_from(socket) |> assign_context_options()}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, "task_changeset", changeset)}
    end
  end

  def handle_event("edit-task", %{"id" => id}, socket) do
    task =
      if id == "new" do
        %Task{}
      else
        Tasks.get_task_with_depends!(String.to_integer(id))
      end

    task_changeset = Tasks.change_task(task, %{})
    depend_options = if task.id == nil, do: nil, else: Tasks.depend_options_for(task)

    socket =
      assign(socket,
        task_changeset: task_changeset,
        depend_options: depend_options,
        projects: Projects.list_projects_for_select()
      )

    {:noreply, socket}
  end

  def handle_event("save-task", %{"task_id" => id, "task" => params}, socket) do
    task = Tasks.get_task!(id)

    case Tasks.update_task(task, params) do
      {:ok, _} ->
        {:noreply, clear_edit_task_form_from(socket) |> assign_current_tasks()}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, "task_changeset", changeset)}
    end
  end

  def handle_event("save-task", %{"task" => params}, socket) do
    case Tasks.create_task(params) do
      {:ok, _} ->
        {:noreply, clear_edit_task_form_from(socket) |> assign_current_tasks()}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, "task_changeset", changeset)}
    end
  end

  def handle_event("cancel-edit-task", _, socket) do
    {:noreply, clear_edit_task_form_from(socket)}
  end

  defp clear_edit_task_form_from(socket) do
    clear_assigns(socket, [:task_changeset, :depend_options, :projects])
  end

  defp clear_edit_project_form_from(socket) do
    clear_assigns(socket, [:project_changeset])
  end

  defp clear_assigns(socket, assigns_to_clear) do
    new_assigns = Map.drop(socket.assigns, assigns_to_clear)

    new_changed =
      Enum.reduce(assigns_to_clear, socket.changed, fn assign, acc ->
        Map.put_new(acc, assign, true)
      end)

    %{socket | assigns: new_assigns, changed: new_changed}
  end

  defp assign_context_options(socket) do
    assign(socket, contexts: ["all"] ++ Projects.project_context_options())
  end

  defp assign_current_context(socket, context) do
    socket
    |> assign(current_context: context)
    |> assign_current_tasks()
  end

  defp assign_current_tasks(socket) do
    context = socket.assigns.current_context
    today = Tasks.list_todays_tasks(context)
    next = Tasks.list_next_tasks(context)
    waiting = Tasks.list_outstanding_external_tasks(context)
    assign(socket, today: today, next: next, waiting: waiting)
  end
end
